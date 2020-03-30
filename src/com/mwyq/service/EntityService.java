package com.mwyq.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;
import com.github.abel533.echarts.Option;
import com.mwyq.dao.EntityMapper;
import com.mwyq.dao.weiBoMapper;
import com.mwyq.model.Entity;
import com.mwyq.model.EntityExample;
import com.mwyq.model.Topic;
import com.mwyq.model.TopicExample;
import com.mwyq.model.weiBoExample;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class EntityService {

	@Autowired
	private EntityMapper entityMapper;
	
	@Autowired
	private weiBoMapper WeiBoMapper;
	
	public Entity getByKey(String key){
		List<Entity> entityList = new ArrayList<Entity>();
		EntityExample example = new EntityExample();
		EntityExample.Criteria criteria = example.createCriteria();
		criteria.andEntity_keyEqualTo(key);
		entityList=entityMapper.selectByExample(example);
		if(entityList.size()!=0){
			return entityList.get(0);
		}
		
		Entity entity = new Entity();
		entity.setEntity_id(0);
		return entity;
	}
	
	
	/**
	 * 显示前10条人名
	 * */
	public List<Entity> getTopPer(String lang){

		List<Entity> per=entityMapper.getTopPer(lang);
	//	List<Entity> per2=entityMapper.getTopPer();
    //  per2=LatinToUnicodeRuleList.getUtf8String(per.);
	//	String[] str_per = (String[])per.toArray();
	//	System.out.println(str_per);
		for(int i=0;i<per.size();i++){
			String temp_per = per.get(i).getEntity_key().toString();
			String tempMeng_per = LatinToUnicodeRuleList.getUtf8String(temp_per);
		//	per.set(index, element)
			per.get(i).setEntity_key(tempMeng_per);
//			System.out.println("+++++++++++++++++++++++++++++++++" + per.get(i).getEntity_key().toString());
		}

		return per;
	}
	
	public List<Entity> getTopLoc(String lang){
		List<Entity> loc=entityMapper.getTopLoc(lang);
		for(int i=0;i<loc.size();i++){
			String temp_per=loc.get(i).getEntity_key().toString();
			String tempMeng_loc = LatinToUnicodeRuleList.getUtf8String(temp_per);
			loc.get(i).setEntity_key(tempMeng_loc);
		}
		return loc;
	}
	
	public List<Entity> getTopOrg(String lang){
		List<Entity> org=entityMapper.getTopOrg(lang);
		for(int i=0;i<org.size();i++){
			String temp_org=org.get(i).getEntity_key().toString();
			String tempMeng_org = LatinToUnicodeRuleList.getUtf8String(temp_org);
			org.get(i).setEntity_key(tempMeng_org);
		}
		return org;
	}
	
	public List<Entity> getTopAll(String lang){
		List<Entity> all=entityMapper.getTopAll(lang);
		for(int i=0;i<all.size();i++){
			String temp_all=all.get(i).getEntity_key().toString();
			String tempall= LatinToUnicodeRuleList.getUtf8String(temp_all);
			all.get(i).setEntity_key(tempall);
		}
		return all;
	}
	
	/**
	 * 获取首页展示数据
	 * */
	public Map<String, Integer> getIndexEntity(String lang){  
	    
		Map<String, Integer> map = new HashMap<String,Integer>();
		
		EntityExample examplePer = new EntityExample();
	    EntityExample.Criteria criteriaPer = examplePer.createCriteria();
	    criteriaPer.andLang_typeEqualTo(lang);
	    criteriaPer.andEntity_typeEqualTo("PER");
	    int perNum = entityMapper.countByExample(examplePer);
	    map.put("人物", perNum);
	    
	    EntityExample exampleLoc = new EntityExample();
	    EntityExample.Criteria criteriaLoc = exampleLoc.createCriteria();
	    criteriaLoc.andEntity_typeEqualTo("LOC");
	    criteriaLoc.andLang_typeEqualTo(lang);
	    int locNum = entityMapper.countByExample(exampleLoc);
	    map.put("地点", locNum);
	    
	    
	    EntityExample exampleOrg = new EntityExample();
	    EntityExample.Criteria criteria = exampleOrg.createCriteria();
	    criteria.andEntity_typeEqualTo("ORG");
	    criteria.andLang_typeEqualTo(lang);
	    int orgNum = entityMapper.countByExample(exampleOrg);
	    map.put("组织机构", orgNum);
		
		return map;
	}

	public String getWeiBoTendency(String lang){
		weiBoExample example = new weiBoExample();
		weiBoExample.Criteria criteria = example.createCriteria();
		criteria.andLangEqualTo(lang);
		criteria.andEmotionEqualTo("Positive");
		
		int zheng = WeiBoMapper.countByExample(example);
		
		weiBoExample example1 = new weiBoExample();
		weiBoExample.Criteria criteria1 = example1.createCriteria();
		criteria1.andLangEqualTo(lang);
		criteria1.andEmotionEqualTo("negative");
		
		int fu = WeiBoMapper.countByExample(example1);
		
		JSONObject json = new JSONObject();
		json.put("正面",zheng);
		json.put("负面",fu);
		
		return json.toString();
	}
	
	public String getEntity(Integer id){
		System.out.println("查询ID为");
		System.out.println(id);
		
		Entity entity = entityMapper.selectByPrimaryKey(id);
		System.out.println(entity.getEntity_key());
		
//		EntityExample example = new EntityExample();
//		EntityExample.Criteria criteria = example.createCriteria();
//		criteria.andEntity_idEqualTo(id);
//		List<Entity> entities = entityMapper.selectByExample(example);
//		System.out.println(entities.get(0).getEntity_key());
		
		return entity.getEntity_key();
	}
}
