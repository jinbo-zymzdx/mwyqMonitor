package com.mwyq.service;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;





import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;




/** 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @Date:    2017年1月15日 
 * @author:  luoshao
 * @Copyright (c) 2017, www.panyixia.cn , 792435323@qq.com All Rights Reserved.     
 */

@Service
public class DoSearchServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	Logger logger = Logger.getLogger(DoSearchServlet.class.getName());

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String key = req.getParameter("key");
		System.out.println("key:    " + key);
//		String currentPage = req.getParameter("currentPage");
//		
		//key = new String(key.getBytes("iso8859-1"),"utf-8");   //本地开发需要这句 ，线上不需要这句
//		
//		// 过滤html标签 ， 空格变成+ 支持多词 搜索
//		key = key.replaceAll("<(S*?)[^>]*>.*?|<.*? />", "");
//		key = key.replaceAll(" ", "+");
//		
//		if (currentPage == null || "".equals(currentPage))
//			currentPage = "1";
//		int first = (Integer.parseInt(currentPage) - 1) * 10 + 1;
//		
//		String url = "http://cn.bing.com/search?q=site%3Apan.baidu.com+" + key + "&first=" + first;
//	
//		Spider spider = new Spider();
//		List<Message> list = spider.getList(url);
//		for (Message msg:list) {
//			System.out.println(msg.getUrl());
//			System.out.println(msg.getTitle());
//			System.out.println(msg.getContent());
//			System.out.println("==========================");
//		}
		
		DocQuery docQuery = new DocQuery();
		List<SolrDocRes> docSolrDocRes = docQuery.query(key, "cn", "0", 1, 10);
		for (SolrDocRes docRes:docSolrDocRes) {
	            System.out.println(docRes.getNewsId());
	            System.out.println(docRes.getCrawlSource());
	            System.out.println(docRes.getNewsContent());
	            System.out.println("========================");
	        }

//		req.setAttribute("list", list);
//		req.setAttribute("key", key);
//		
		
		req.setAttribute("list", docSolrDocRes);
		req.setAttribute("key", key);
		
		
		req.getRequestDispatcher("/content_zhong.jsp").forward(req, resp);
		
		return;
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
} 