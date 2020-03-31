package com.mwyq.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.text.View;

import org.apache.commons.lang.StringUtils;
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
import com.mwyq.model.News;
import com.mwyq.model.Topic;
import com.mwyq.service.NewsService;
import com.mwyq.util.CommonUtils;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("sensite")
public class SensitiveController {
	@Autowired
	private NewsService newsService;
	
	private static Logger logger = LoggerFactory.getLogger(TopController.class);
	
	private static final Cache<String, Object> localCache = CacheBuilder.newBuilder()
            .maximumSize(1000).expireAfterWrite(30, TimeUnit.MINUTES).recordStats().build();
	
	//显示敏感新闻列表
	@RequestMapping(value = "/",method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,HttpSession session){
		ModelAndView view = new ModelAndView("sensitive");
		String lang = (String) session.getAttribute("lang");
		String range = (String) session.getAttribute("range");
		String sensitiveType = (String)session.getAttribute("sensitiveType");
		lang = lang == null ? "cn" : lang;
		range = range == null ? "all" : range;
		sensitiveType = sensitiveType == null ? "2" : sensitiveType;
		List<News> sensitiveNews = newsService.getSenNewsByRange(lang,range,sensitiveType);
		News lastestSenNew =null;
		String firstContent = null;
		String firstWord = null;
		if(sensitiveNews.size() > 0) {
			lastestSenNew = sensitiveNews.get(0);
			String senWords = lastestSenNew.getSensitive_words();
			firstContent = getContentResult(lastestSenNew.getNews_content(),senWords);
			firstWord = getTableResult(senWords);
		}
		view.addObject("lang", lang);
		view.addObject("sensitiveNews",sensitiveNews);
		view.addObject("lastestSensitiveNews",lastestSenNew);
		view.addObject("lastestSensitiveType",CommonUtils.New_Sensitive_Map.get(sensitiveType));
		view.addObject("selectedTime",CommonUtils.New_Range_Map.get(range));
		view.addObject("firstContent", firstContent);
		view.addObject("firstWord", firstWord);
		view.addObject("lastestOneNews", newsService.getLastOneNews(lang));
		return view;
	}
	
	//按时间和敏感类型获取新闻列表
	@RequestMapping(value = "/sennews/{sensitiveType}/{range}",method=RequestMethod.GET)
	public ModelAndView sensitiveNews(HttpServletRequest request,HttpSession session, @PathVariable("sensitiveType") String sensitiveType,@PathVariable("range") String range){
		ModelAndView view = new ModelAndView("redirect:/sensite/");
		session.setAttribute("sensitiveType", sensitiveType);
		session.setAttribute("range", range);
		return view;
	}
	
	//切换语言
	@RequestMapping(value = "/sensitiveSwitchlang", method = RequestMethod.POST)
	public ModelAndView chooseLang(HttpServletRequest request, HttpSession session) {
		String lang = request.getParameter("langtype");
		session.setAttribute("lang", lang);
		ModelAndView view = new ModelAndView("redirect:/sensite/");
		if(!StringUtils.isEmpty(lang) && lang.equals("meng")){
			ModelAndView view1 = new ModelAndView("redirect:/topic/");
			return view1;
		}
		return view;
	}
	
	public String getTableResult(String Word) {
		if(StringUtils.isNotBlank(Word)) {
			String[] word = Word.split("\\*");
			String first,last;
			String result="";
			for(String w:word){
				first = w.substring(0, w.indexOf(":"));
				last = w.substring(w.indexOf(":")+1,w.length());
				result = result + "<p>" + "<span style=\"color:red\">"+first+"</span>&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp"+last+"</p>";
			}
			return result;
		}
		return null;
	}
	
	public String getContentResult(String Content, String Word) {
		if(StringUtils.isNotBlank(Word)) {
			String[] word = Word.split("\\*");
			String first,last;
			String lastestContent;
			for(String w:word){
				first = w.substring(0, w.indexOf(":"));
				Content = Content.replaceAll(first, "<span style=\"color:red\">" + first +"</span>");
				last = w.substring(w.indexOf(":")+1,w.length());
			}
		}
		return Content;
	}

	/*语言选择 */
	@RequestMapping(value = "actionhotspots",method=RequestMethod.GET)
	public ModelAndView actiontest(HttpServletRequest request,HttpSession session){
		String s = request.getParameter("cbLanguage");
		switch(s)
		{
		case "cn":
			session.setAttribute("lang","cn");
			break;
		case "meng":
			session.setAttribute("lang","meng");
			break;
		case "zang":
			session.setAttribute("lang","zang");
			break;
		case "wei":
			session.setAttribute("lang","wei");
			break;
		}
		System.out.println(s);
		if(s.equals("meng")){
			ModelAndView view = new ModelAndView("redirect:http://210.31.0.145:8080/mwyqMonitor/topic/");
			return view;
		}
		ModelAndView view = new ModelAndView("redirect:/sensite/");
		return view;		
	}
	
	@RequestMapping(value ="/getSensitiveWord", method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getSensitiveContent(HttpServletRequest request){
		System.out.println("获取映射敏感词页面成功");
		Integer news_id = new Integer(request.getParameter("news_id"));
		List<News> newsSensitive = newsService.getNewsContent(news_id);
		News clickSensitiveNew = newsSensitive.get(0);
		String clickSensitiveContent = clickSensitiveNew.getNews_content();
		String clickSensitiveWord = clickSensitiveNew.getSensitive_words();
		String langType = clickSensitiveNew.getLang_type();
		String sensitiveResult;
		System.out.println(langType.toString());
		sensitiveResult = getZangWord(langType,clickSensitiveContent,clickSensitiveWord);
		return sensitiveResult;
	}
	
	public String getZangWord(String lang,String content,String wordList){
		HashMap<String,String> sencitiveWord = new HashMap<String,String>();
		if(StringUtils.isNotBlank(wordList)) {
			String[] word = wordList.split("\\*");
			String first,last;
			for(String w:word){
				first = w.substring(0, w.indexOf(":"));
				last = w.substring(w.indexOf(":")+1,w.length());
				sencitiveWord.put(first, last);
			}
			JSONObject json = JSONObject.fromObject(sencitiveWord);
			return json.toString();
		}
		return null;
		
	} 
	
	public String getWord(String lang,String content,String wordList){
		HashMap<String,String> sencitiveWord = new HashMap<String,String>();
		String[] word = wordList.split("\\*");
		int count=0;
		String[] sensitiveWordList;
		for(String w:word){
			sensitiveWordList = content.split(w);
			count = sensitiveWordList.length-1;
			sencitiveWord.put(w, String.valueOf(count));
		}
		JSONObject json = JSONObject.fromObject(sencitiveWord);
		return json.toString();
	} 
	
	
	@RequestMapping(value = "/getSensitive", method = RequestMethod.GET)
	public String getSensitiveTendency(HttpServletRequest request){
		System.out.println("映射敏感词模块成功");
		String lang = request.getParameter("lang");
		if(lang==null){
			lang = "cn";
		}
		TreeMap<String,TreeMap<String,Integer>> sensitiveCount = newsService.getSensitiveTendency(lang.toString());
		JSONObject json = JSONObject.fromObject(sensitiveCount);
		System.out.println(json.toString());
		return json.toString();
	}
}
