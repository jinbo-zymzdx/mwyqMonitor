package com.mwyq.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.github.abel533.echarts.Option;
import com.mwyq.model.Entity;

import com.mwyq.model.Topic;
import com.mwyq.service.ECharsService;
import com.mwyq.service.EntityService;
import com.mwyq.util.PageUtil;

import net.sf.json.JSON;
import net.sf.json.JSONObject;
@RestController
@RequestMapping("/entity")
public class EnitiyController {

	@Autowired
	public ECharsService ecService;
	
	@Autowired
	private EntityService entityService;
		
	
//	EcharsService ecService = new EcharsService();
	  
	@RequestMapping(value="/getOption")
	public String getOption(){
		
		Option option = ecService.getOption();
		JSON json = JSONObject.fromObject(option);
//		String opt=JSON.toJSONString(option);
//		System.out.println("==============================" + json.toString());
		
		return json.toString();
	}
}
