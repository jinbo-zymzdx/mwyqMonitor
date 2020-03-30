package com.mwyq.schedule;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import com.mwyq.model.StatisticEntity;
import com.mwyq.model.TopicAndEntity;
import com.mwyq.service.TopicService;

@Lazy(false)  
@EnableScheduling
@Component
public class DataSchedule {
	
	@Autowired
	private TopicService topicService;
	
	private static Logger logger = LoggerFactory.getLogger(DataSchedule.class);
	
	//@Scheduled(cron="0/5 * * * * ?")
	@Scheduled(cron="0 0 0/1 * * ?")
	@Transactional
	public void dataSynchronize() {
		
		List<TopicAndEntity> topicAndEntity = topicService.getAllTopicAndEntityData();
		List<StatisticEntity> locStatList = new ArrayList<StatisticEntity>();
		List<StatisticEntity> perStatList = new ArrayList<StatisticEntity>();
		List<StatisticEntity> orgStatList = new ArrayList<StatisticEntity>();
		
		for(TopicAndEntity te:topicAndEntity) {
			StatisticEntity statEntity = new StatisticEntity();
			statEntity.setName(te.getEntity_key());
			statEntity.setEntity_id(te.getEntity_id());
			statEntity.setTopic_id(te.getTopic_id());
			statEntity.setCount(new Double(te.getDistribution()).intValue());
			String type = te.getEntity_type();
			
			if(type.equals("LOC")) {
				locStatList.add(statEntity);
			}else if(type.equals("ORG")) {
				orgStatList.add(statEntity);
			}else if(type.equals("PER")) {
				perStatList.add(statEntity);
			}
		}
		
		logger.info("dataSynchronize ## locStatList={},orgStatList={},perStatList={}",locStatList,orgStatList,perStatList);
		
		if(orgStatList.size()>0) {
			topicService.insertOrgStat(orgStatList);
		}
		if(locStatList.size()>0) {
			topicService.insertLocStat(locStatList);
		}
		if(perStatList.size()>0) {
			topicService.insertPerStat(perStatList);
		}
	}
}
