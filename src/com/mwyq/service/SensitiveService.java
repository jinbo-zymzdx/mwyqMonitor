package com.mwyq.service;
/*
 * 该service没有被调用
 * */


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;
import com.github.abel533.echarts.series.Map;
import com.mwyq.dao.CustomMonitorMapper;
import com.mwyq.dao.EntityMapper;
import com.mwyq.dao.EntityNewsRelationMapper;
import com.mwyq.dao.NewsMapper;
import com.mwyq.model.Entity;
import com.mwyq.model.EntityNewsRelation;
import com.mwyq.model.EntityNewsRelationExample;
import com.mwyq.model.News;
import com.mwyq.model.NewsExample;
@Service
public class SensitiveService {


	@Resource
	private NewsMapper newsMapper;
	
	@Resource
	public EntityNewsRelationMapper entityNewsRelationMapper;
	
	@Resource
	public EntityMapper entityMapper;
	
	public List<News> getAllNews(){
		NewsExample example = new NewsExample();
		List<News> newsAll = newsMapper.selectByExample(example);
		
		return newsAll;
	}
		/*
		 * 获取敏感新闻列表
		 * */
		public List<News> getSensitiveNews(String lang){
			
			//System.out.println("调用service了");
			if(lang==null){
				lang="zang";
			}
			List<News> sensitivenews = newsMapper.getSensitiveNews(lang);
			
			if(sensitivenews.isEmpty()){
				//System.out.println("可以为空");
				return null;
			}
			
			return sensitivenews;
		}
		
		public void debug(){
			
	
			
			System.out.println("测试");
			//List<News> sensitivenews = newsMapper.getSensitiveNews("zang");
			//System.out.println(sensitivenews.size());
			
			List<News> latestNews = newsMapper.getSensitiveNews("zang");
			System.out.println(latestNews.size());
		}	
}
