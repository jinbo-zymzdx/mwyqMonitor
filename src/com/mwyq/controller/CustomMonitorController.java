package com.mwyq.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.CustomMonitor;
import com.mwyq.model.Entity;
import com.mwyq.model.News;
import com.mwyq.model.Topic;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.service.TopicService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//@Controller
@RestController
@RequestMapping("custom")
public class CustomMonitorController {
	
	
	@Autowired
	private TopicService topicService;

	@Autowired
	private NewsService newsService;
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping(value = "/",method=RequestMethod.GET)
	public void listMain(){
		System.out.println("custome生效");
		
		

	}
	
	
	/*
	 * 初始化所有定制节点*/
	@RequestMapping(value = "/listAll",method=RequestMethod.GET)
	public String listCustomMonitor(){
		System.out.println("list生效");
		
		 JSONArray jsonCustom = new JSONArray();
		 List<CustomMonitor> listCustom = newsService.getAllCustom();
		 
		 
//         for(ProgramLog pLog : list){
//             JSONObject jo = new JSONObject();
//             jo.put("id", pLog.getId());
//             jo.put("time", pLog.getBeginTime());
//              
//             json.put(jo);
//         }
		 
       for(CustomMonitor cm : listCustom){
    	   JSONObject jo = new JSONObject();
    	   jo.put("word", cm.getKeyWord());
    	   jo.put("id", cm.getId());
    	   jo.put("lang_Type", cm.getLangType());
    	   jo.put("isPause", 1);
    	   jo.put("word_Type", cm.getType());
    	   jo.put("describe", cm.getDescription());
   
    	   jsonCustom.add(jo); 	   
    	   
//       jo.put("id", pLog.getId());
//       jo.put("time", pLog.getBeginTime());    
//       json.put(jo);
       
       
       }
       
       System.out.println(jsonCustom.toString());
       
       return jsonCustom.toString();
		 
	}
	
	
	/*
	 * 定制功能插入节点
	 * */
	@RequestMapping(value = "/saveMonitor",method=RequestMethod.POST,produces ="text/html;charset=UTF-8")
	public void saveMonitor(HttpServletRequest request){
			//JSONObject json = new JSONObject();
//			System.out.println(request.getParameter("key_word"));
//			System.out.println(request.getParameter("type"));
//			System.out.println(request.getParameter("lang_type"));
//			System.out.println(request.getParameter("description"));
			
			String key_word = request.getParameter("key_word");
			String type = request.getParameter("type");
			String lang_type = request.getParameter("lang_type");
			String description = request.getParameter("description");
			
			CustomMonitor insertCustomMonitor = new CustomMonitor();
			
			
			if(lang_type.equals("zh-CN")){lang_type = "cn";}
			else if(lang_type.equals("ko")){lang_type="meng";}
			else if(lang_type.equals("ui")){lang_type="wei";}
			else if(lang_type.equals("bo")){lang_type="zang";}
			
			if(type.equals("")){
				type="OTH";
			}
			
			System.out.println(key_word);
			System.out.println(type);
			System.out.println(lang_type);
			System.out.println(description);
			
			
			insertCustomMonitor.setDescription(description);
			insertCustomMonitor.setKeyWord(key_word);
			insertCustomMonitor.setLangType(lang_type);
			insertCustomMonitor.setType(type);
			insertCustomMonitor.setStatus(1);
			
			newsService.insertCustom(insertCustomMonitor);
			
	}
	
	
	/*
	 * 定制功能删除节点
	 * */
	@RequestMapping(value = "/deleteMonitor",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public void deleteMonitor(HttpServletRequest request) throws UnsupportedEncodingException{
			String deleteKeyWord = request.getParameter("keyWord");
			deleteKeyWord = URLDecoder.decode(deleteKeyWord,"UTF-8");
			
			System.out.println("即将删除的元素为："+deleteKeyWord);
			newsService.deleteCustom(deleteKeyWord);	
	}
	
	/*
	 * 定制功能显示页面
	 * */
	@RequestMapping(value = "/displayMonitor/{word}",method=RequestMethod.GET,produces ="text/html;charset=UTF-8")
	public ModelAndView displayMonitor(HttpServletRequest request,@PathVariable("word") String word) throws UnsupportedEncodingException{	
		
		
		//String word = request.getParameter("word");
		//String word = URLDecoder.decode(request.getParameter("word"),"UTF-8");
		request.setCharacterEncoding("utf-8");		
		System.out.println("映射成功");		
		//System.out.println(word+"=="+new String(word.getBytes("ISO-8859-1"),"utf-8"));
		
		//获取关键词解码
//		word =new String(word.getBytes("ISO-8859-1"),"utf-8");
		System.out.println("搜索的关键词为："+word);
		//获取关键词语言
		String wordLang = newsService.getCustomLang(word);
		System.out.println("搜索关键词的语言为："+wordLang);
		
		Entity entity = entityService.getByKey(word.toString());
		
		if(entity.getEntity_id()==0){
			ModelAndView view1 = new ModelAndView("searchNotFound");
			view1.addObject("word",word.toString());
			return view1;
		}
		
		
		Integer entity_id = entity.getEntity_id();
		
		List<News> allNews = newsService.getNewsByEntityID(entity_id);
		List<Topic> allTopic = topicService.getTopicByEntityID(entity_id);
		
		if(allNews.size()==0||allTopic.size()==0){
			ModelAndView view1 = new ModelAndView("searchNotFound");
			view1.addObject("word",word.toString());
			return view1;
		}
		
//		List<Topic> allCustomTopic = newsService.getCustomTopic(word.toString(),wordLang.toString());
		
		
		
//		if(allCustomTopic.isEmpty()){
//			ModelAndView view1 = new ModelAndView("searchNotFound");
//			view1.addObject("word",word.toString());
//			return view1;
//		}
		
//		if(!allCustomTopic.isEmpty())
//		for(Topic custom : allCustomTopic){
//			System.out.println(custom.getTopic_name());
//		}
//		
//		JSONObject jsonPer = new JSONObject();
//		JSONObject jsonLoc = new JSONObject();
//		JSONObject jsonOrg = new JSONObject();
//		
//		if(!allCustomTopic.isEmpty())
//		for(Topic custom : allCustomTopic){
//			String topicID = custom.getTopic_id();
//			
//			JSONObject jsonPer1 = JSONObject.fromObject(getTopicPer(topicID));
//			JSONObject jsonLoc1 = JSONObject.fromObject(getTopicLoc(topicID));
//			JSONObject jsonOrg1 = JSONObject.fromObject(getTopicOrg(topicID));
//			
//			jsonPer.putAll(jsonPer1);
//			jsonLoc.putAll(jsonLoc1);
//			jsonOrg.putAll(jsonOrg1);
//		}
//		
//		System.out.println(jsonPer.toString());
//		System.out.println(jsonLoc.toString());
//		System.out.println(jsonOrg.toString());
//		
//		
//		String  key;
//		String value;
//		int num = 0;
//		
//		Iterator iteratorPer = jsonPer.keys();
////		JSONArray jsonArrayPer = new JSONArray(); 
//		JSONObject jsonPreResult = new JSONObject();
//		if(jsonPer.isNullObject()){
//			jsonPreResult = jsonPer;
//			System.out.println("json人为空");
//		}
//		else{
//			while(iteratorPer.hasNext()){
//				num++;
//				if(num>=11)
//					break;
//	            key = (String) iteratorPer.next();
//	            value =jsonPer.getString(key);
//	            if(value.length()>=5){
//	            	value = value.substring(0, 5);
//	            }
////	            JSONObject jsonobj = new JSONObject();
//	            jsonPreResult.put(key, value);
////	            jsonArrayPer.add(jsonobj);
//	       }
//			
////			for(int i=0;i<jsonArrayPer.size();i++){
////				jsonPreResult=jsonArrayPer.getJSONObject(i);
////			}
//		}
//		System.out.println(jsonPreResult.toString());
//		
//		
//		Iterator iteratorLoc = jsonLoc.keys();
//		JSONObject jsonLocResult = new JSONObject();
//		num = 0;
//		if(jsonLoc.isNullObject()){
//			jsonLocResult = jsonLoc;
//			System.out.println("json地点为空");
//		}
//		else{
//			while(iteratorLoc.hasNext()){
//				num++;
//				if(num>=11)
//					break;
//	            key = (String) iteratorLoc.next();
//	            value =jsonLoc.getString(key);
//	            if(value.length()>=5){
//	            	value = value.substring(0, 5);
//	            }
//	            jsonLocResult.put(key, value);
//	       }
//		}
//		System.out.println(jsonLocResult.toString());
//		
//		Iterator iteratorOrg = jsonOrg.keys();
//		JSONObject jsonOrgResult = new JSONObject();
//		num = 0;
//		if(jsonOrg.isNullObject()){
//			jsonOrgResult = jsonOrg;
//			System.out.println("json组织机构为空");
//		}
//		else{
//			while(iteratorOrg.hasNext()){
//				num++;
//				if(num>=11)
//					break;
//	            key = (String) iteratorOrg.next();
//	            value =jsonOrg.getString(key);
//	            if(value.length()>=5){
//	            	value = value.substring(0, 5);
//	            }
//	            jsonOrgResult.put(key, value);
//	       }
//		}	
		
		
		ModelAndView view = new ModelAndView("CustomDisplay");
		
		for(News news:allNews){
			news.setNews_title(news.getNews_title().replaceAll(word,"<span style=\"color:red;\">"+word+"</span>"));
		}
		
		for(Topic topic:allTopic){
			topic.setTopic_name(topic.getTopic_name().replaceAll(word,"<span style=\"color:red;\">"+word+"</sapn>"));
		}
		
		
//		view.addObject("resultPer",jsonPreResult);
//		view.addObject("resultLoc",jsonLocResult);
//		view.addObject("resultOrg",jsonOrgResult);
		
		view.addObject("keyWord",word);
//		view.addObject("customTopic",allCustomTopic);
		view.addObject("allNews",allNews);
		view.addObject("allTopic",allTopic);
		return view;
	}
	/*
	 * 得到人物实体
	 * */
	public String getTopicPer(String id){

	//	List<Entity> orgIndex = new ArrayList<Entity>();
	//	orgIndex=entityService.getTopOrg();
		
		HashMap<String,Double> topic_per=new HashMap<String,Double>();
	
		topic_per=topicService.getEntityPer(id);
		
		List<Map.Entry<String,Double>> list = new ArrayList<Map.Entry<String,Double>>(topic_per.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String,Double>>(){
			@Override
			public int compare(Map.Entry<String,Double> arg0, Map.Entry<String,Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				
				if(dateStr2.compareTo(dateStr1)>0){
					return -1;
				}else if(dateStr2.compareTo(dateStr1)<0){
					return 1;
				}else{
					return 0;
				}
			}
			
		});
		LinkedHashMap<String, Double> finalResult = new LinkedHashMap<String,Double>();
		if(list.size()>15){
			list = list.subList(list.size()-15, list.size());
		}
	
		for(int i = 0;i<list.size();i++){
			Map.Entry<String,Double> entry = list.get(i);
			finalResult.put(entry.getKey(),entry.getValue());
		}
		
		JSONObject json = JSONObject.fromObject(finalResult);
//		System.out.println(json.toString());
		
		return json.toString();
		
//        JSONArray newjsonArray = new JSONArray();
//        if (json != null && json.size() > 10) {
//            for (int i = 0; i < 10; i++) {
//                newjsonArray.add(json.get(i));
//            }
//            System.out.println("11111");
//            return newjsonArray.toString();
//        }
//        System.out.println("22222");
//		String result = json.toString();
//		if(result.length()<6)
//			return json.toString();
//		String[] jsonArr = result.split(",");
//		for(int i = 0 ; i<jsonArr.length&&i<10 ; i++){
//			result = result + jsonArr[i];
//		}
//		if(result.substring(result.length()-1).equals("}")){
//			return result;
//		}
//		result = result + "}";
//		return result;
	}
	
	
	/*
	 * 得到地点实体
	 * */
	public String getTopicLoc(String id){
		
		HashMap<String,Double> topic_loc=new HashMap<String,Double>();
	
		topic_loc=topicService.getEntityLoc(id);
		
		List<Map.Entry<String,Double>> list = new ArrayList<Map.Entry<String,Double>>(topic_loc.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String,Double>>(){
			@Override
			public int compare(Map.Entry<String,Double> arg0, Map.Entry<String,Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if(dateStr2.compareTo(dateStr1)>0){
					return -1;
				}else if(dateStr2.compareTo(dateStr1)<0){
					return 1;
				}else{
					return 0;
				}
			}
			
		});
		LinkedHashMap<String, Double> finalResult = new LinkedHashMap<String,Double>();
		if(list.size()>15){
			list = list.subList(list.size()-15, list.size());
		}
		for(int i = 0;i<list.size();i++){
			Map.Entry<String,Double> entry = list.get(i);
			finalResult.put(entry.getKey(),entry.getValue());
		}
		
		JSONObject json = JSONObject.fromObject(finalResult);
		return json.toString();
	
	}
	
	
	
	/*
	 * 得到组织机构实体
	 * */
	public String getTopicOrg(String id){
		
		HashMap<String,Double> topic_org=new HashMap<String,Double>();
	
		topic_org=topicService.getEntityOrg(id);
		
		List<Map.Entry<String,Double>> list = new ArrayList<Map.Entry<String,Double>>(topic_org.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<String,Double>>(){
			@Override
			public int compare(Map.Entry<String,Double> arg0, Map.Entry<String,Double> arg1) {
				Double dateStr1 = arg0.getValue();
				Double dateStr2 = arg1.getValue();
				if(dateStr2.compareTo(dateStr1)>0){
					return -1;
				}else if(dateStr2.compareTo(dateStr1)<0){
					return 1;
				}else{
					return 0;
				}
			}
			
		});
		LinkedHashMap<String, Double> finalResult = new LinkedHashMap<String,Double>();
		
		if(list.size()>15){
			list = list.subList(list.size()-15, list.size());
		}
		
		for(int i = 0;i<list.size();i++){
			Map.Entry<String,Double> entry = list.get(i);
			finalResult.put(entry.getKey(),entry.getValue());
		}
		
		
		JSONObject json = JSONObject.fromObject(finalResult);
		return json.toString();
		
	}
	
	
}
