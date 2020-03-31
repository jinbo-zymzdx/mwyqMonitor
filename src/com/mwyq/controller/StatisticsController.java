package com.mwyq.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.Page;
import com.mwyq.model.Topic;
import com.mwyq.model.sensitiveTendency;
import com.mwyq.service.NewsService;
import com.mwyq.service.TopicService;
import com.mwyq.util.PageUtil;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("/statis")
public class StatisticsController {
	@Autowired
	private TopicService topicService;
	
	@Autowired
	private NewsService newsService;
	
	@RequestMapping(value="/",method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,HttpSession session){
		ModelAndView view = new ModelAndView("/topic_count");
		Object lang = session.getAttribute("lang");
		if(lang==null){
			session.setAttribute("lang", "meng");
			lang = "meng";
		}
//		int total = topicService.getTopicNum();		
//		int pageSize = 30;
//		int pageIndex = 1;
//		Page p = PageUtil.createPage(pageSize, total, pageIndex);	
		List<Topic> topics = topicService.getHistoryHotTopics(lang.toString());
		view.addObject("topicList",topics);
		

		
		
//		System.out.println("666666666666666666666");
		return view;
	} 
	

	
}
