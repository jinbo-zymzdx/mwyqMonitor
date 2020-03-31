/**
 * 
 */
package com.mwyq.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSON;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.mwyq.model.Entity;
import com.mwyq.model.News;
import com.mwyq.model.Page;
import com.mwyq.model.Topic;
import com.mwyq.model.typeWord;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.service.TopicService;
import com.mwyq.util.PageUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/topic")
public class TopController {

	private static Logger logger = LoggerFactory.getLogger(TopController.class);

	@Autowired
	private TopicService topicService;
	@Autowired
	private EntityService entityService;
	@Autowired
	private NewsService newsService;
	
	Map<String,ModelAndView> topicCacheMap = new HashMap<String,ModelAndView>();
	
	private static final Cache<String, Object> localCache = CacheBuilder.newBuilder()
	            .maximumSize(1000).expireAfterWrite(30, TimeUnit.MINUTES).recordStats().build();

	//热门话题基本内容（标题、关键词、话题包括、话题相关新闻、话题内容、关键词TOP10）
	@RequestMapping(value = "/{id}/newtopic", method = RequestMethod.GET)
	public ModelAndView newListtopNews(HttpServletRequest request, HttpSession session,@PathVariable("id") String topicId) {
		logger.info("热门话题基本内容,topicId={}",topicId);
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "new_topic_"+topicId+":"+lang;
		
		ModelAndView view = (ModelAndView)localCache.getIfPresent(cacheKey);
		if(view != null) {
			return view;
		}
		Topic topic = topicService.getTopic(topicId);
		List<News> topicAllNews = topicService.getTopicAllNews(topicId);
		List<News> topicNews = topicService.getTopicNews(topicId);
		HashMap<String, Integer> entityMap = topicService.getEntityNum(topicId);
		List<typeWord> tenWord = topicService.getTenEntity(topicId);
		String keywords = topic.getTopwords();
		if(StringUtils.isNotBlank(keywords)) {
			keywords = keywords.substring(1, keywords.length()-1);
		}
		view = new ModelAndView("newtopic_news");
		view.addObject("topicId", topicId);
		view.addObject("title", topic.getTopic_name());
		view.addObject("keyword", keywords);
		view.addObject("newsCount", topicAllNews.size());
		view.addObject("locNum", entityMap.get("LOC")==null?0:entityMap.get("LOC"));
		view.addObject("perNum", entityMap.get("PER")==null?0:entityMap.get("PER"));
		view.addObject("orgNum", entityMap.get("ORG")==null?0:entityMap.get("ORG"));
		view.addObject("topicNews", topicNews);// 话题内容
		view.addObject("topicAllNews", topicAllNews);// 话题相关新闻
		view.addObject("tenWord", tenWord);// 关键词TOP10
		localCache.put(cacheKey, view);
		return view;
	}

	// 词云数据
	@RequestMapping(value = "/{id}/getEntityKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityKey(HttpServletRequest request, HttpSession session, @PathVariable("id") String topicId) {
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "ciyu:"+topicId+":"+lang;
		String jsonString = (String) localCache.getIfPresent(cacheKey);
		if (!StringUtils.isBlank(jsonString)) {
			return jsonString;
		}
		Map<String, String> entityKey = topicService.getEntityKey(topicId);
		String ciyunJson = JSON.toJSONString(entityKey);
		localCache.put(cacheKey, ciyunJson);
		logger.info("词云数据,ciyunJson={}",ciyunJson);
		return ciyunJson;
	}

	// 实体关系
	@RequestMapping(value = "/{id}/getEntityRe", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityRelation(HttpServletRequest request,HttpSession session, @PathVariable("id") String topicId) {
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "relation:"+topicId+":"+lang;
		String jsonString = (String) localCache.getIfPresent(cacheKey);
		if (!StringUtils.isBlank(jsonString)) {
			return jsonString;
		}
		String newsEntityRelation = topicService.getNewsEntityRelation(topicId);
		logger.info("实体关系,newsEntityRelation={}",newsEntityRelation);
		localCache.put(cacheKey, newsEntityRelation);
		return newsEntityRelation;
	}

	// 人物统计
	@RequestMapping(value = "/{id}/getTopicPer", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicPer(HttpServletRequest request,HttpSession session, @PathVariable("id") String topicId) {
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "people:"+topicId+":"+lang;
		String jsonString = (String) localCache.getIfPresent(cacheKey);
		if (!StringUtils.isBlank(jsonString)) {
			return jsonString;
		}
		Map<String, Double> peopleStat = topicService.getEntityPer(topicId);
		List<Map.Entry<String, Double>> list = new ArrayList<Map.Entry<String, Double>>(peopleStat.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Double>>() {
			@Override
			public int compare(Map.Entry<String, Double> arg0, Map.Entry<String, Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if (dateStr2.compareTo(dateStr1) > 0) {
					return -1;
				} else if (dateStr2.compareTo(dateStr1) < 0) {
					return 1;
				} else {
					return 0;
				}
			}
		});
		LinkedHashMap<String, Integer> finalResult = new LinkedHashMap<String, Integer>();
		if (list.size() > 15) {
			list = list.subList(list.size() - 15, list.size());
		}
		for (int i = 0; i < list.size(); i++) {
			Map.Entry<String, Double> entry = list.get(i);
			finalResult.put(entry.getKey(), entry.getValue().intValue());
		}
		String peopleJson = JSON.toJSONString(finalResult);
		logger.info("人物统计,peopleJson={}",peopleJson);
		localCache.put(cacheKey, peopleJson);
		return peopleJson;
	}

	// 地点统计
	@RequestMapping(value = "/{id}/getTopicLoc", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicLoc(HttpServletRequest request,HttpSession session, @PathVariable("id") String topicId) {
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "location"+topicId+":"+lang;
		String jsonString = (String) localCache.getIfPresent(cacheKey);
		if (!StringUtils.isBlank(jsonString)) {
			return jsonString;
		}
		Map<String, Double> locStat = topicService.getEntityLoc(topicId);
		List<Map.Entry<String, Double>> list = new ArrayList<Map.Entry<String, Double>>(locStat.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Double>>() {
			@Override
			public int compare(Map.Entry<String, Double> arg0, Map.Entry<String, Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if (dateStr2.compareTo(dateStr1) > 0) {
					return -1;
				} else if (dateStr2.compareTo(dateStr1) < 0) {
					return 1;
				} else {
					return 0;
				}
			}
		});
		LinkedHashMap<String, Integer> finalResult = new LinkedHashMap<String, Integer>();
		if (list.size() > 15) {
			list = list.subList(list.size() - 15, list.size());
		}
		for (int i = 0; i < list.size(); i++) {
			Map.Entry<String, Double> entry = list.get(i);
			finalResult.put(entry.getKey(), entry.getValue().intValue());
		}
		String locationJson = JSON.toJSONString(finalResult);
		localCache.put(cacheKey, locationJson);
		logger.info("地点统计,locationJson={}",locationJson);
		return locationJson;
	}

	// 组织机构统计
	@RequestMapping(value = "/{id}/getTopicOrg", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicOrg(HttpServletRequest request,HttpSession session, @PathVariable("id") String topicId) {
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "organize"+topicId+":"+lang;
		String jsonString = (String) localCache.getIfPresent(cacheKey);
		if (!StringUtils.isBlank(jsonString)) {
			return jsonString;
		}
		Map<String, Double> orgStat = topicService.getEntityOrg(topicId);
		List<Map.Entry<String, Double>> list = new ArrayList<Map.Entry<String, Double>>(orgStat.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String, Double>>() {
			@Override
			public int compare(Map.Entry<String, Double> arg0, Map.Entry<String, Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if (dateStr2.compareTo(dateStr1) > 0) {
					return -1;
				} else if (dateStr2.compareTo(dateStr1) < 0) {
					return 1;
				} else {
					return 0;
				}
			}
		});
		LinkedHashMap<String, Integer> finalResult = new LinkedHashMap<String, Integer>();
		if (list.size() > 15) {
			list = list.subList(list.size() - 15, list.size());
		}
		for (int i = 0; i < list.size(); i++) {
			Map.Entry<String, Double> entry = list.get(i);
			finalResult.put(entry.getKey(), entry.getValue().intValue());
		}
		String organizeJson = JSON.toJSONString(finalResult);
		localCache.put(cacheKey, organizeJson);
		logger.info("组织机构统计,organizeJson={}",organizeJson);
		return organizeJson;
	}
	
	/**
	 * 新页面获取话题新闻列表的单条新闻的新闻内容
	 **/
	@RequestMapping(value = "/{id}/newsDisplay", method = RequestMethod.GET)
	public ModelAndView topicNewsdisplay(HttpServletRequest request,HttpSession session, @PathVariable("id") int newsId) {
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "newsDisplay"+newsId+":"+lang;
		ModelAndView view = (ModelAndView) localCache.getIfPresent(cacheKey);
		if(view != null) {
			return view;
		}
		view = new ModelAndView("newsdisplay");
		List<News> topicNewsContent = newsService.getNewsContent(newsId);
		News displayNew = topicNewsContent.get(0);//取第一条新闻
		List<typeWord> newsKeywords = new ArrayList<typeWord>();
		if(StringUtils.isNotBlank(lang) && lang.equals("cn")) {
			newsKeywords = newsService.getNewsKeyword(newsId);
		}
		view.addObject("displayNew", displayNew);//新闻内容
		view.addObject("newsId", newsId);
		view.addObject("lang", lang);
		view.addObject("newsKeywords", newsKeywords);
		localCache.put(cacheKey, view);
		return view;
	}

	/**
	 * 得到话题下的新闻数量
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {
		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "meng");
			lang = "meng";
		}
		ModelAndView view = new ModelAndView("0711index");
		int total = topicService.getTopicNum();
		int pageSize = 30;
		int pageIndex = 1;
		Page p = PageUtil.createPage(pageSize, total, pageIndex);
		List<Topic> topics = topicService.getTopicByPage(p, lang.toString());
		view.addObject("topicList", topics);
		List<Topic> hoTopics = topicService.getHotTopics();
		view.addObject("hot", hoTopics);
		Map<String, Integer> indexEntity = entityService.getIndexEntity(lang.toString());
		view.addObject("indexEntity", indexEntity);
		return view;
	}

	@RequestMapping(value = "/chooselang", method = RequestMethod.POST)
	public ModelAndView chooseLang(HttpServletRequest request, HttpSession session) {
		String lang = request.getParameter("langtype");
		ModelAndView view = new ModelAndView("redirect:/main/");
		session.setAttribute("lang", lang);
		if (lang.toString().equals("cn"))
			session.setAttribute("lang", "cn");
		else if (lang.toString().equals("wei"))
			session.setAttribute("lang", "wei");
		else if (lang.toString().equals("zang"))
			session.setAttribute("lang", "zang");
		else {
			ModelAndView viewmeng = new ModelAndView("redirect:/topic/");
			return viewmeng;
		}

		return view;
	}

	@RequestMapping(value = "/chooselangType", method = RequestMethod.POST)
	public ModelAndView chooseLangType(HttpServletRequest request, HttpSession session) {
		String lang = request.getParameter("langtype");
		ModelAndView view = new ModelAndView("redirect:/topic/");
		session.setAttribute("lang", lang);
		return view;
	}

	@RequestMapping(value = "/getPer", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getPer(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		List<Entity> perIndex = new ArrayList<Entity>();
		perIndex = entityService.getTopPer(lang);
		JSONArray json = JSONArray.fromObject(perIndex);
		return json.toString();
	}

	@RequestMapping(value = "/getLoc", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getLoc(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		List<Entity> locIndex = new ArrayList<Entity>();
		locIndex = entityService.getTopLoc(lang);
		JSONArray json = JSONArray.fromObject(locIndex);
		return json.toString();
	}

	@RequestMapping(value = "/getOrg", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getOrg(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		List<Entity> orgIndex = new ArrayList<Entity>();
		orgIndex = entityService.getTopOrg(lang);
		JSONArray json = JSONArray.fromObject(orgIndex);
		return json.toString();
	}

	@RequestMapping(value = "/getEntityNum", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityNum(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		Map<String, Integer> entityNum = new HashMap<String, Integer>();
		entityNum = entityService.getIndexEntity(lang);
		JSONObject json = JSONObject.fromObject(entityNum);
		return json.toString();
	}

	/*
	 * 获取实体数量经过优化
	 */
	@RequestMapping(value = "/getStaticEntity", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getStaticEntity(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		JSONObject json = newsService.getStaticEntity(lang);
		// System.out.println(json.toString());
		return json.toString();
	}

	/*
	 * 获取新闻类别
	 */
	@RequestMapping(value = "/getNewsCategory", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getNEwsCategory(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		JSONObject json = newsService.getNewsCategory(lang);
		JSONObject result = new JSONObject();
		Iterator it = json.keys();

		if (lang.equals("cn")) {
			result.put("国内", 0);
			result.put("国际", 0);
			result.put("军事", 0);
			result.put("文化", 0);
			result.put("体育", 0);
			result.put("经济", 0);
			result.put("社会", 0);
			result.put("港澳台", 0);
			result.put("娱乐", 0);
			//result.put("其他", 0);
		}

		while (it.hasNext() && lang.equals("cn")) {
			String key = (String) it.next();
			int value = (int) json.get(key);
			System.out.println(key);
			if (key.equals("国内")) {
				result.put("国内", value + (int) result.get("国内"));
			} else if (key.equals("国际")) {
				result.put("国际", value + (int) result.get("国际"));
			} else if (key.equals("军事") || key.equals("强国社区")) {
				result.put("军事", value + (int) result.get("军事"));
			} else if (key.equals("文化")) {
				result.put("文化", value + (int) result.get("文化"));
			} else if (key.equals("体育")) {
				result.put("体育", value + (int) result.get("体育"));
			} else if (key.equals("经济") || key.equals("财经中心") || key.equals("产经中心")) {
				result.put("经济", value + (int) result.get("经济"));
			} else if (key.equals("社会")) {
				result.put("社会", value + (int) result.get("社会"));
			} else if (key.equals("娱乐")) {
				result.put("娱乐", value + (int) result.get("娱乐"));
			} else if (key.equals("港澳台") || key.equals("台湾") || key.equals("港澳")) {
				result.put("港澳台", value + (int) result.get("港澳台"));
			} else {
				//result.put("其他", value + (int) result.get("其他"));
			}
		}

		if (lang.equals("cn")) {
			return result.toString();
		}

		if (lang.equals("zang")) {
			result.put("རྒྱལ་ནང་དུ་", 0);
			result.put("རྒྱལ་སྤྱི་", 0);
			result.put("དམག་དོན་", 0);
			result.put("སློབ་གསོ་བྱེད་པ་", 0);
			result.put("ཆོས་ལུགས་", 0);
			result.put("དཔལ་འབྱོར་", 0);
			result.put("སྤྱི་ཚོགས་", 0);
			result.put("རོལ་རྩེད་", 0);
			result.put("རིག་གནས་", 0);
			//result.put("དེ་མིན་", 0);
		}

		while (it.hasNext() && lang.equals("zang")) {
			String key = (String) it.next();
			int value = (int) json.get(key);
			System.out.println(key);
			if (key.equals("རྒྱལ་ནང་དུ་") || key.equals("གལ་ཆེའི་གསར་འགྱུར།") || key.equals("འགོ་ཁྲིད་བྱེད་སྒོ།")) {
				result.put("རྒྱལ་ནང་དུ་", value + (int) result.get("རྒྱལ་ནང་དུ་"));
			} else if (key.equals("རྒྱལ་སྤྱི་")) {
				result.put("རྒྱལ་སྤྱི་་", value + (int) result.get("རྒྱལ་སྤྱི་་"));
			} else if (key.equals("དམག་དོན་")) {
				result.put("དམག་དོན་", value + (int) result.get("དམག་དོན་"));
			} else if (key.equals("སློབ་གསོ་བྱེད་པ་") || key.equals("བྱིས་པའི་སློབ་གསོ།")
					|| key.equals("མི་རིགས་སློབ་གསོ།")) {
				result.put("སློབ་གསོ་བྱེད་པ་", value + (int) result.get("སློབ་གསོ་བྱེད་པ་"));
			} else if (key.equals("ཆོས་ལུགས་") || key.equals("ཆོས་ལུགས་གསར་འགྱུར།")) {
				result.put("ཆོས་ལུགས་", value + (int) result.get("ཆོས་ལུགས་"));
			} else if (key.equals("དཔལ་འབྱོར་")) {
				result.put("དཔལ་འབྱོར་", value + (int) result.get("དཔལ་འབྱོར་"));
			} else if (key.equals("སྤྱི་ཚོགས་") || key.equals("བོད་ཁུལ་གསར་འགྱུར།") || key.equals("དམངས་འཚོ།")
					|| key.equals("དམངས་ཕན་སྲིད་ཇུས།")) {
				result.put("སྤྱི་ཚོགས་", value + (int) result.get("སྤྱི་ཚོགས་"));
			} else if (key.equals("རོལ་རྩེད་") || key.equals("གངས་རིའི་སྐར་རྒྱན།")
					|| key.equals("ལྗོངས་ཕྱིའི་ཡུལ་སྐོར།")) {
				result.put("རོལ་རྩེད་", value + (int) result.get("རོལ་རྩེད་"));
			} else if (key.equals("རིག་གནས་") || key.equals("སྔོན་བྱོན་མཁས་པ།") || key.equals("ལོ་རྒྱུས་ཤེས་བྱ།")
					|| key.equals("སྙན་རྩོམ།") || key.equals("བོད་ལྗོངས་སྒྱུ་རྩལ།")
					|| key.equals("བོད་ལྗོངས་སྒྱུ་རྩལ།")) {
				result.put("རིག་གནས་", value + (int) result.get("རིག་གནས་"));
			} else {
				//result.put("དེ་མིན་", value + (int) result.get("དེ་མིན་"));
			}
		}

		if (lang.equals("zang")) {
			return result.toString();
		}

		return json.toString();
	}

	/**
	 * 获取话题的新闻并分页显示
	 **/
	@RequestMapping(value = "/newsPage", params = "page", method = RequestMethod.GET)
	public ModelAndView newsPage(HttpServletRequest request, @Param("page") String page, HttpSession session) {

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news");

		int total = topicService.getTopicNum();

		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "meng");
			lang = "meng";
		}

		Page p = PageUtil.createPage(13, total, Integer.valueOf(page));

		List<Topic> topics = topicService.getTopicByPage(p, lang.toString());

		view.addObject("page", p);
		view.addObject("topics", topics);
		return view;
	}

	/**
	 * 获取单条热门话题详情
	 */
	@RequestMapping(value = "/{id}/news", method = RequestMethod.GET)
	public ModelAndView listtopNews(HttpServletRequest request, @PathVariable("id") String id) {

		System.out.println("topicid:" + id);

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news");

		List<News> topicAllNews = topicService.getTopicAllNews(id);
		List<News> topicNews = topicService.getTopicNews(id);

		int newsCount = topicAllNews.size();
		HashMap<String, Integer> entityMap = topicService.getEntityNum(id);
		Integer perNum = entityMap.get("PER");
		Integer locNum = entityMap.get("LOC");
		Integer orgNum = entityMap.get("ORG");
		if (perNum == null) {
			perNum = 0;
		}
		if (locNum == null) {
			locNum = 0;
		}
		if (orgNum == null) {
			orgNum = 0;
		}

		view.addObject("topicId", id);
		view.addObject("newsCount", newsCount);
		view.addObject("perNum", perNum);
		view.addObject("locNum", locNum);
		view.addObject("orgNum", orgNum);

		view.addObject("topicNews", topicNews);

		view.addObject("topicAllNews", topicAllNews);

		return view;
	}

	/**
	 * 获取单条热门话题详情
	 */
	@RequestMapping(value = "/entityrelation", method = RequestMethod.GET)
	public ModelAndView EntityRelationShow(HttpServletRequest request) {

		String id = "67b71614-a4fd-4f32-8450-a52799981ec3";

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_news_entityrelation");

		List<News> topicAllNews = topicService.getTopicAllNews(id);
		List<News> topicNews = topicService.getTopicNews(id);

		// System.out.println(topicNews);

		int newsCount = topicAllNews.size();
		HashMap<String, Integer> entityMap = topicService.getEntityNum(id);
		Integer perNum = entityMap.get("PER");
		Integer locNum = entityMap.get("LOC");
		Integer orgNum = entityMap.get("ORG");
		if (perNum == null) {
			perNum = 0;
		}
		if (locNum == null) {
			locNum = 0;
		}
		if (orgNum == null) {
			orgNum = 0;
		}

		view.addObject("topicId", id);
		view.addObject("newsCount", newsCount);
		view.addObject("perNum", perNum);
		view.addObject("locNum", locNum);
		view.addObject("orgNum", orgNum);

		view.addObject("topicNews", topicNews);

		view.addObject("topicAllNews", topicAllNews);

		return view;
	}

	/**
	 * 获取话题新闻列表的单条新闻的新闻内容
	 **/
	@RequestMapping(value = "/{id}/newsContent", method = RequestMethod.GET)
	public ModelAndView topicNewsContent(HttpServletRequest request, @PathVariable("id") int id) {

		System.out.println("newsid-----:" + id);

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_newsContent");

		List<News> topicNewsContent = newsService.getNewsContent(id);
		view.addObject("topicNewsContent", topicNewsContent);
		view.addObject("newsId", id);
		return view;
	}

	/**
	 * 新页面获取话题新闻列表的单条新闻的新闻内容
	 **/
	@RequestMapping(value = "/{id}/newsDisplay2/{word}", method = RequestMethod.GET)
	public ModelAndView topicNewsdisplay2(HttpServletRequest request, @PathVariable("id") int id,
			@PathVariable("word") String word) {

		System.out.println("newsid-----:" + id);
		System.out.println("news_word---" + word);

		ModelAndView view = new ModelAndView("newsdisplay");

		List<News> topicNewsContent = newsService.getNewsContent(id);

		News displayNew = topicNewsContent.get(0);

		displayNew.setNews_content(
				displayNew.getNews_content().replaceAll(word, "<span style=\"color:red;\">" + word + "</span>"));
		displayNew.setNews_title(
				displayNew.getNews_title().replaceAll(word, "<span style=\"color:red;\">" + word + "</span>"));

		view.addObject("displayNew", displayNew);

		view.addObject("topicNewsContent", topicNewsContent);
		view.addObject("newsId", id);
		return view;
	}

	/**
	 * 获取话题新闻列表的单条新闻的新闻内容
	 **/
	@RequestMapping(value = "/{id}/newsContentEntityRelation", method = RequestMethod.GET)
	public ModelAndView topicNewsContentEntityRelation(HttpServletRequest request, @PathVariable("id") int id) {

		System.out.println("newsid-----:" + id);

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_newsContent_entityRelation");

		List<News> topicNewsContent = newsService.getNewsContent(id);
		view.addObject("topicNewsContent", topicNewsContent);
		view.addObject("newsId", id);
		return view;
	}

	/**
	 * 话题的分页显示
	 */
	@RequestMapping(value = "/topicPage", params = "page", method = RequestMethod.GET)
	public ModelAndView topicsPage(HttpServletRequest request, @Param("page") String page, HttpSession session) {

		ModelAndView view = new ModelAndView("/WEB-INF/topic/topics");

		int total = topicService.getTopicNum();

		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "meng");
			lang = "meng";
		}

		Page p = PageUtil.createPage(13, total, Integer.valueOf(page));

		List<Topic> topics = topicService.getTopicByPage(p, lang.toString());

		view.addObject("page", p);
		view.addObject("topics", topics);
		return view;
	}

	@RequestMapping(value = "/getTopicTime", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getNewsTime(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		HashMap<String, Integer> topic_time_t = new HashMap<String, Integer>();
		topic_time_t = topicService.getTopicTendency(lang);
		TreeMap<String, Integer> finalResult = new TreeMap<String, Integer>();
		List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(topic_time_t.entrySet());
		for (Map.Entry<String, Integer> entry : list) {
			finalResult.put(entry.getKey(), entry.getValue());
		}
		JSONObject json = JSONObject.fromObject(finalResult);
		return json.toString();
	}

	// 获取话题数量-优化之后
	@RequestMapping(value = "/getTopicNum", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicNum(HttpServletRequest request) {
		String lang = request.getParameter("lang");
		TreeMap<String, Integer> result = topicService.getTopicTendencyNum(lang);
		JSONObject json = JSONObject.fromObject(result);
		return json.toString();
	}

	@RequestMapping(value = "/{id}/getTopicToEntity", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTopicToEntity(HttpServletRequest request, @PathVariable("id") String id) {
		String topic_entity = topicService.getTopicToEntity(id);
		return JSONObject.fromObject(topic_entity).toString();
	}

	@RequestMapping(value = "/{id}/getEntityPerKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityPerKey(HttpServletRequest request, @PathVariable("id") int id) {
		HashMap<String, String> newPer = new HashMap<String, String>();
		String cacheKey = "per_key_"+id;
		String perKey = (String) localCache.getIfPresent(cacheKey);
		if(perKey != null) {
			return perKey;
		}
		newPer = newsService.getEntityLocKey(id);
		perKey = JSON.toJSONString(newPer);
		localCache.put(cacheKey, perKey);
		return perKey;
	}

	@RequestMapping(value = "/{id}/getEntityLocKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityLocKey(HttpServletRequest request,HttpSession session,  @PathVariable("id") int id) {
		HashMap<String, String> newLoc = new HashMap<String, String>();
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "loc_key_"+id+"_"+lang;
		String locKey = (String) localCache.getIfPresent(cacheKey);
		if(locKey != null) {
			return locKey;
		}
		newLoc = newsService.getEntityLocKey(id);
		locKey = JSON.toJSONString(newLoc);
		localCache.put(cacheKey, locKey);
		return locKey;
	}

	@RequestMapping(value = "/{id}/getEntityOrgKey", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getEntityOrgKey(HttpServletRequest request,HttpSession session, @PathVariable("id") int id) {
		HashMap<String, String> newOrg = new HashMap<String, String>();
		String lang = (String) session.getAttribute("lang");
		String cacheKey = "org_key_"+id+"_"+lang;
		String orgKey = (String) localCache.getIfPresent(cacheKey);
		if(orgKey != null) {
			return orgKey;
		}
		newOrg = newsService.getEntityOrgKey(id);
		orgKey = JSON.toJSONString(newOrg);
		localCache.put(cacheKey, orgKey);
		return orgKey;
	}
}
