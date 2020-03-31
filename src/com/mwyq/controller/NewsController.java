package com.mwyq.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.Entity;
import com.mwyq.model.News;
import com.mwyq.model.typeQuery;
import com.mwyq.service.NewsService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("news")
public class NewsController {
	@Autowired
	private NewsService newsService;
	
	/**
	 * 显示新闻列表
	 * **/
	
	
	@RequestMapping(value = "/",method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,HttpSession session){
		
		/*
		 * 首页模块
		 * 1、新闻列表
		 * 2、对应新闻内容
		 * 3、.....
		 * */
		ModelAndView view = new ModelAndView("/WEB-INF/latestNews/latestNews");
	
		Object lang = session.getAttribute("lang");
		if(lang==null){
			session.setAttribute("lang", "meng");
			lang = "meng";
		}
		
		/**
		 * 得到所有新闻，以时间排序
		 * */
		allNews(view,lang.toString());
		return view;
	}
	
	public void allNews(ModelAndView view,String lang) {
		List<News> latestNews = newsService.getLatestNews(lang);
		view.addObject("latestNews",latestNews);
	}
	
	//每条新闻对应的新闻内容
	@RequestMapping(value = "/{id}/newsContent", method=RequestMethod.GET)
	public ModelAndView listtopNew(HttpServletRequest request,@PathVariable("id") int id){
		
		System.out.println("newsid:"+id);
		ModelAndView view = new ModelAndView("/WEB-INF/topic/topic_newsContent");
		List<News> newsContent = newsService.getNewsContent(id);
//		System.out.println(newsContent);
		view.addObject("topicNewsContent",newsContent);
		
		return view;
	}
	
	@RequestMapping(value="/getNewsTime",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getNewsTime(HttpServletRequest request){
		String lang = request.getParameter("lang");
		
		if(lang.equals(null)){
			lang="cn";
		}
		
		HashMap<String,Integer> news_time_t = new HashMap<String,Integer>();
		
		
		news_time_t=newsService.getNewsTendency(lang.toString());
		List<Map.Entry<String,Integer>> list = new ArrayList<Map.Entry<String,Integer>>(news_time_t.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String,Integer>>(){
			@Override
			public int compare(Map.Entry<String,Integer> arg0, Map.Entry<String,Integer> arg1) {
				String dateStr1 = arg0.getKey();
				String dateStr2 = arg1.getKey();
				return dateStr1.compareTo(dateStr2);
			}
			
		});
		TreeMap<String, Integer> finalResult = new TreeMap<String,Integer>();
		
		for(Map.Entry<String,Integer> entry : list){
			finalResult.put(entry.getKey(),entry.getValue());
		}
		
		JSONObject json = JSONObject.fromObject(finalResult);
		
		return json.toString();
	}
	
	//得到新闻来源
	@RequestMapping(value="/getNewsSource",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public String getNewsSource(HttpServletRequest request,HttpSession session){
		
		
		String lang = session.getAttribute("lang").toString();
		
//		TreeMap<String, Integer> resultSource = new TreeMap<String,Integer>();
		
		JSONObject json=new JSONObject();
		
		List<typeQuery> listtype = newsService.geTypeQuery(lang);
		for(typeQuery t:listtype){
//			resultSource.put(t.getWebName(), t.getWebCount());
			if(t.getWebName()!=null){
				json.put(t.getWebName(), t.getWebCount());
			}
			
		}
//		JSONObject json = JSONObject.fromObject(resultSource);
//		System.out.println(json.toString());
		
		return json.toString();
	}
}
