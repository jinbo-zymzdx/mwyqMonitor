package com.mwyq.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mwyq.model.Twitter;
import com.mwyq.model.TwitterGroup;
import com.mwyq.model.TwitterAuthor;
import com.mwyq.model.weiBo;
import com.mwyq.service.EntityService;
import com.mwyq.service.NewsService;
import com.mwyq.util.HttpUtils;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("twitter")
public class twitterController {
	@Autowired
	private NewsService newsService;


	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpSession session) {

		Object lang = session.getAttribute("lang");
		if (lang == null) {
			session.setAttribute("lang", "cn");
			lang = "cn";
		}
		
		List<Twitter> twitter = newsService.getTwitter();
		
		ModelAndView view = new ModelAndView("twitter");
		view.addObject("twitter", twitter);
		return view;
	}

	@RequestMapping(value = "/getTwitterAuthor", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTwitter(){
		
		List<TwitterAuthor> twitterAuthors = newsService.getTwitterAuthor();
		JSONObject json = new JSONObject();
		for(TwitterAuthor t:twitterAuthors){
			json.put(t.getName(), t.getCount());
		}
		return json.toString();
	}
	
	@RequestMapping(value = "/getTwitterEmotion", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getTwitterEmotion(){
		
		List<TwitterGroup> twitterGroups = newsService.getTwitterGroup();
		JSONObject json = new JSONObject();
		for(TwitterGroup t:twitterGroups){
			if(t.getSentiment()==0){
				json.put("负向", t.getCount());
			}
			if(t.getSentiment()==1){
				json.put("正向", t.getCount());
				
			}
		}
		return json.toString();
	}
	
	@RequestMapping(value = "/getTwitterContent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	public String getWeiContent(HttpServletRequest request) {

		Integer id = new Integer(request.getParameter("twitter_id"));
		
		String content = newsService.getTwitterContent(id);

		if(content!=""){
			content = translation(content, "en");
		}
		
		return content;
	}
	
	public String translation(String src_text, String lang) {

		String host = "http://niutrans1.market.alicloudapi.com";
		String path = "/NiuTransServer/translation";
		String method = "GET";
		String appcode = "90bd536854b7411d9ed3baeeac40d9d0";

		// 85c31fdfe77c4c7790e97755a046055c
		// e5c8983ce0824ce09b5e3c1dd7a54f33
		Map<String, String> headers = new HashMap<String, String>();
		//最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
		headers.put("Authorization", "APPCODE " + appcode);
		Map<String, String> querys = new HashMap<String, String>();


		querys.put("from", lang);
		querys.put("src_text", src_text);
		querys.put("to", "zh");
		String transResult = "";

		try {
	    	/**
	    	* 重要提示如下:
	    	* HttpUtils请从
	    	* https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
	    	* 下载
	    	*
	    	* 相应的依赖请参照
	    	* https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
	    	*/
			HttpResponse response = HttpUtils.doGet(host, path, method, headers, querys);
			System.out.println(response.toString());
	    	//获取response的body
	    	//System.out.println(EntityUtils.toString(response.getEntity()));
			String responseEntity = EntityUtils.toString(response.getEntity());
			System.out.println(responseEntity);
			JSONObject json = JSONObject.fromObject(responseEntity);
			System.out.println(json.getString("tgt_text"));
			transResult = json.getString("tgt_text");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return transResult;
	}
	
	@RequestMapping(value = "/TwitterSearch", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public ModelAndView TwitterSearch(HttpServletRequest request) {
		String author = request.getParameter("author");
		System.out.println("搜索的twitter主为："+author);
		List<Twitter> twitters = newsService.getTwitterByAuthor(author);
		if(twitters.size()==0){
			ModelAndView view = new ModelAndView("twitterNotFound");
			view.addObject("word", author);
			return view;
		}
		ModelAndView view = new ModelAndView("twitterSearch");
		
		
		
		view.addObject("keyWord", author);
		view.addObject("twitter", twitters);
		
		return view;
	}

}
