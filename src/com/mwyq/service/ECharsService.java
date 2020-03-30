package com.mwyq.service;

//import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.echarts.Option;
import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.Trigger;
//import com.github.abel533.echarts.data.PieData;
import com.github.abel533.echarts.series.Bar;
//import com.github.abel533.echarts.series.Map;
import com.github.abel533.echarts.series.Pie;
import com.mwyq.dao.EntityMapper;
import com.mwyq.dao.TopicMapper;
import com.mwyq.model.EntityExample;

@Service
public class ECharsService {

	@Autowired
	public TopicMapper topicMapper;
	@Autowired
	private EntityMapper entityMapper;
	
	
	/**
	 * 获取首页展示数据
	 * */
	public Option getOption(){  
	    
		/*
		//查询前20  
	    PageHelper.startPage(1, 10, false);  
	    //数据库查询获取统计数据  
	    List<Map<String, Object>> list = kc22Mapper.selectRemoveCauses();  
	    //为了数据从大到小排列，这里需要倒叙  
	    Collections.sort(list, new Comparator<Map<String, Object>>() {  
	        @Override  
	        public int compare(Map<String, Object> o1, Map<String, Object> o2) {  
	            return -1;  
	        }  
	    }); 
	    */
	    
		EntityExample examplePer = new EntityExample();
	    EntityExample.Criteria criteriaPer = examplePer.createCriteria();
	    criteriaPer.andEntity_typeEqualTo("PER");
	    int perNum = entityMapper.countByExample(examplePer);
	    
	    EntityExample exampleLoc = new EntityExample();
	    EntityExample.Criteria criteriaLoc = exampleLoc.createCriteria();
	    criteriaLoc.andEntity_typeEqualTo("LOC");
	    int locNum = entityMapper.countByExample(exampleLoc);
	    
	    EntityExample exampleOrg = new EntityExample();
	    EntityExample.Criteria criteria = exampleOrg.createCriteria();
	    criteria.andEntity_typeEqualTo("ORG");
	    int orgNum = entityMapper.countByExample(exampleOrg);
	    //System.out.println("perNum:"+perNum+" locNum:"+locNum +" orgNum:"+orgNum);
	    
	    //创建Option  
	     
	    Option option = new Option(); 
	    
	    option.title("话题").tooltip(Trigger.axis).legend("2016年");
	    //横轴为值轴  
	    option.xAxis(new ValueAxis().boundaryGap(0d, 0.01));  
	    //创建类目轴  
	    CategoryAxis category = new CategoryAxis();  
	    //柱状数据  
	    Bar bar = new Bar("2016年");  
	    //饼图数据  
	    Pie pie = new Pie("2016年");  
	    //循环数据  
	    
	    category.data("person");
	    bar.data(perNum);
	    pie.data("person",perNum);
	    
	    category.data("location");
	    bar.data(locNum);
	    pie.data("location",locNum);
	    
	    category.data("orgation");
	    bar.data(orgNum);
	    pie.data("orgation",orgNum);
	    
	    /*
	    for(Map<String,Object> objectMap : list){
	    	category.data(objectMap.get("NAME"));
	    	bar.data(objectMap.get("TOTAL"));
	    	pie.data(new PieData(objectMap.get("NAME").toString(),objectMap.get("TOTAL")));
	    }
	    */
	    
	    
	    //设置类目轴  
	    option.yAxis(category);  
	    //饼图的圆心和半径  
	    pie.center(900,380).radius(100);  
	    //设置数据  
	    option.series(bar, pie);  
	    //由于药品名字过长，图表距离左侧距离设置180，关于grid可以看ECharts的官方文档  
	    option.grid().x(180);  
	    //返回Option  
	    return option;  
	    
	    
	}  
	
}
