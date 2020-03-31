/**
 * AnalysisController.java
 */

package com.mwyq.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.mwyq.model.Page;
import com.mwyq.model.Topic;
import com.mwyq.model.sensitiveTendency;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.service.TopicService;
import com.mwyq.util.CommonUtils;
import com.mwyq.util.PageUtil;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/mystat")
public class AnalysisController {
	
	private static Logger logger = LoggerFactory.getLogger(AnalysisController.class);

	@Autowired
	private TopicService topicService;
	@Autowired
	private NewsService newsService;
	
	Map<String,ModelAndView> statCacheMap = new HashMap<String,ModelAndView>();
	private static final Cache<String, Object> localCache = CacheBuilder.newBuilder()
            .maximumSize(1000).expireAfterWrite(30, TimeUnit.MINUTES).recordStats().build();

	public void allTop(ModelAndView view, String lang) {
		int total = topicService.getTopicNum();
		int pageSize = 30;
		int pageIndex = 1;
		Page p = PageUtil.createPage(pageSize, total, pageIndex);
		List<Topic> topics = topicService.getTopicByPage(p, lang);
	}

	public void dealTop(ModelAndView view) {
		List<Topic> hoTopics = topicService.getHotTopics();
		view.addObject("hot", hoTopics);
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {
		ModelAndView view = new ModelAndView("analysis");
		String lang = (String) session.getAttribute("lang");
		String range = (String) session.getAttribute("range");
		if (lang == null) {
			lang = "cn";
			session.setAttribute("lang", lang);
		}
		if(range == null) {
			range = "all";
			session.setAttribute("range", range);
		}
		List<Topic> historyTopicList = topicService.getHistoryTopicByRange(lang,range);
		view.addObject("range", CommonUtils.New_Range_Map.get(range));
		view.addObject("topicList", historyTopicList);
		return view;
	}
	
	@RequestMapping(value = "/statSwitchlang", method = RequestMethod.POST)
	public ModelAndView chooseLang(HttpServletRequest request, HttpSession session) {
		String lang = request.getParameter("langtype");
		session.setAttribute("lang", lang);
		String cacheKey = "stat_switch_"+lang;
		ModelAndView view = (ModelAndView) localCache.getIfPresent(cacheKey);
		if(view!=null) {
			return view;
		}
		view = new ModelAndView("redirect:/mystat/");
		if(!StringUtils.isEmpty(lang) && lang.equals("meng")){
			ModelAndView view1 = new ModelAndView("redirect:/topic/");
			return view1;
		}
		localCache.put(cacheKey, view);
		return view;
	}
	
	@RequestMapping(value = "/getSelect/{range}",method = RequestMethod.GET)
	public ModelAndView getSelect(HttpServletRequest request, HttpSession session,@PathVariable("range") String range) {
		ModelAndView view = new ModelAndView("redirect:/mystat/");
		session.setAttribute("range", range);
		return view;
	}
	
	@RequestMapping(value = "getLangStat", method = RequestMethod.GET)
	public String langStat(HttpServletRequest request, HttpSession session) {
		TreeMap<String, TreeMap<String, Integer>> ssiMap = new TreeMap<String, TreeMap<String, Integer>>();
		ssiMap = newsService.sevenDayNews();
		JSONObject json = JSONObject.fromObject(ssiMap);
		return json.toString();
	}
	
	@RequestMapping(value = "actionanalysis", method = RequestMethod.GET)
	public ModelAndView action(HttpServletRequest request, HttpSession session) {
		String s = request.getParameter("cbLanguage");
		switch (s) {
		case "cn":
			session.setAttribute("lang", "cn");
			break;
		case "meng":
			session.setAttribute("lang", "meng");
			break;
		case "wei":
			session.setAttribute("lang", "wei");
			break;
		case "zang":
//			System.out.println("统计分析语言选择---藏语");
			session.setAttribute("lang", "zang");
			break;
		}

		if (s.equals("meng")) {
			ModelAndView view = new ModelAndView("redirect:http://210.31.0.145:8080/mwyqMonitor/topic/");
			return view;
		}

		ModelAndView view = new ModelAndView("redirect:/mystat/");
		return view;
	}
	
	
	@RequestMapping(value = "/getSensitiveByLang", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getSensitiveByLang(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		JSONObject sensitiveJson = new JSONObject();
		List<sensitiveTendency> result = newsService.getSensitiveTendencyByLang(lang);
		for(int i=result.size()-1;i>=0;i--)
		{
			int[] value = new int[3];
			value[0] = result.get(i).getTotal();
			value[1] = result.get(i).getSensitive1();
			value[2] = result.get(i).getSensitive2();
			sensitiveJson.put(result.get(i).getData_time(),value);
		}
		logger.info("AnalysisController ## sensitiveJson={}",sensitiveJson.toString());
		return sensitiveJson.toString();
	}
}

