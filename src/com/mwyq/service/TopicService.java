package com.mwyq.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;
import com.mwyq.controller.AnalysisController;
import com.mwyq.dao.EntityMapper;
import com.mwyq.dao.EntityNewsRelationMapper;
import com.mwyq.dao.EntityTopicRelationMapper;
import com.mwyq.dao.NewsMapper;
import com.mwyq.dao.TopicDocumentRelationMapper;
import com.mwyq.dao.TopicMapper;
import com.mwyq.dao.TopicminingdistributionMapper;
import com.mwyq.model.Entity;
import com.mwyq.model.EntityNewsRelation;
import com.mwyq.model.EntityNewsRelationExample;
import com.mwyq.model.EntityTopicRelation;
import com.mwyq.model.EntityTopicRelationExample;
import com.mwyq.model.News;
import com.mwyq.model.NewsExample;
import com.mwyq.model.Page;
import com.mwyq.model.StatisticEntity;
import com.mwyq.model.Topic;
import com.mwyq.model.TopicAndEntity;
import com.mwyq.model.TopicDocumentRelation;
import com.mwyq.model.TopicDocumentRelationExample;
import com.mwyq.model.TopicExample;
import com.mwyq.model.Topicminingdistribution;
import com.mwyq.model.TopicminingdistributionExample;
import com.mwyq.model.topicEntity;
import com.mwyq.model.topicNumModel;
import com.mwyq.model.typeWord;
import com.mwyq.util.mapSorted;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class TopicService {
	
	private static Logger logger = LoggerFactory.getLogger(TopicService.class);

	@Autowired
	public TopicMapper topicMapper;

	@Resource
	public TopicDocumentRelationMapper documentRelationMapper;

	@Resource
	public NewsMapper newsMapper;

	@Resource
	public EntityMapper entityMapper;

	@Resource
	public EntityTopicRelationMapper entityTopicRelationMapper;

	@Resource
	public EntityNewsRelationMapper entityNewsRelationMapper;

	@Resource
	public TopicminingdistributionMapper topicminingdistributionMapper;

	/**
	 * 显示所有话题,无时间，无热度
	 */
	public List<Topic> getAllTopic() {
		TopicExample topic = new TopicExample();

		List<Topic> topic2 = topicMapper.selectByExample(topic);

		return topic2;
	}
	
	public List<TopicAndEntity> getAllTopicAndEntityData() {
		return topicMapper.getAllTopicAndEntityData();
	}

	/**
	 * 首页显示时间排序的话题
	 */
	public List<Topic> getHotTopics() {
		// TODO Auto-generated method stub
		return topicMapper.getHotTopics();
	}

	/**
	 * 统计分析中 话题历史排行
	 * 
	 * @return
	 */
	public List<Topic> getHistoryHotTopics(String lang) {
		return topicMapper.getHistoryTopics(30, lang);
	}
	
	public List<Topic> getHistoryTopicByRange(String lang,String range){
		List<Topic> historyTopicList = new ArrayList<Topic>();
		if(range.equals("year")) {
			historyTopicList = topicMapper.getHistoryTopicByYear(lang);
		}else if(range.equals("month")){
			historyTopicList = topicMapper.getHistoryTopicByMonth(lang);
		}else if(range.equals("week")) {
			historyTopicList = topicMapper.getHistoryTopicByWeek(lang);
		}else {
			historyTopicList = topicMapper.getHistoryTopics(30,lang);
		}
		return historyTopicList;
	}

	/*
	 * 统计分析历史排行一周话题
	 */
	public List<Topic> getHistoryWeekHotTopics(String lang) {
		TopicExample example = new TopicExample();
		TopicExample.Criteria criteria = example.createCriteria();
		example.setOrderByClause("news_count desc");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.WEEK_OF_MONTH, -1);
		Date yesDay = calendar.getTime();
		criteria.andNews_timeBetween(yesDay, new Date());
		criteria.andLang_typeEqualTo(lang);
		List<Topic> topiclist = new ArrayList<Topic>();
		topiclist = topicMapper.selectByExample(example);
		if (topiclist.size() > 15) {
			topiclist = topiclist.subList(0, 15);
		}
		return topiclist;
	}

	/*
	 * 统计分析历史排行一个月话题
	 */
	public List<Topic> getHistoryMonthHotTopics(String lang) {
		TopicExample example = new TopicExample();
		TopicExample.Criteria criteria = example.createCriteria();
		example.setOrderByClause("news_count desc");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.MONTH, -1);
		Date yesDay = calendar.getTime();
		criteria.andNews_timeBetween(yesDay, new Date());
		criteria.andLang_typeEqualTo(lang);
		List<Topic> topiclist = new ArrayList<Topic>();
		topiclist = topicMapper.selectByExample(example);
		if (topiclist.size() > 15) {
			topiclist = topiclist.subList(0, 15);
		}
		return topiclist;
	}

	/*
	 * 统计分析历史排行一年话题
	 */
	public List<Topic> getHistoryYearHotTopics(String lang) {
		TopicExample example = new TopicExample();
		TopicExample.Criteria criteria = example.createCriteria();
		example.setOrderByClause("news_count desc");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.YEAR, -1);
		Date yesDay = calendar.getTime();
		criteria.andNews_timeBetween(yesDay, new Date());
		criteria.andLang_typeEqualTo(lang);
		List<Topic> topiclist = new ArrayList<Topic>();
		topiclist = topicMapper.selectByExample(example);
		if (topiclist.size() > 15) {
			topiclist = topiclist.subList(0, 15);
		}
		return topiclist;
	}

	/**
	 * 获取每页的数量
	 */
	public List<Topic> getTopicByPage(Page page, String lang) {
		// TODO Auto-generated method stub
		return topicMapper.getTopics(page.getBeginIndex(), page.getPageSize(), lang);
	}

	public Topic getTopic(String topic_id) {
		// TODO Auto-generated method stub
		return topicMapper.selectByPrimaryKey(topic_id);
	}

	public int getTopicNum() {
		// TODO Auto-generated method stub
		return topicMapper.selectCount();
	}

	/**
	 * 获取话题对应新闻数量
	 */
	public int getNewsNumByTopicid(String topicid) {
		TopicDocumentRelationExample example = new TopicDocumentRelationExample();
		TopicDocumentRelationExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicid);
		documentRelationMapper.selectByExample(example);
		int num = documentRelationMapper.countByExample(example);
		// System.out.println("TopicNewsNum---"+num);
		return num;
	}

	/**
	 * 获取话题对应relation最大的新闻newsid
	 */
	public int getNewsidByTopicid(String topicid) {
		TopicDocumentRelationExample example = new TopicDocumentRelationExample();
		TopicDocumentRelationExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicid);
		example.setOrderByClause(String.valueOf("relation"));// 对relation进行排序
		// System.out.println("example---"+example);
		documentRelationMapper.selectByExample(example);
		// 获取所有的topicid对应用的条目信息
		List<TopicDocumentRelation> topicNewsRelation = documentRelationMapper.selectByExample(example);
		// System.out.println("topicNewsRelation---"+topicNewsRelation);
		while (topicNewsRelation.size() != 0) {
			TopicDocumentRelation first = topicNewsRelation.get(topicNewsRelation.size() - 1);// 取最后一条数据，最大relation
			int newsid = first.getNews_id();// 得到第一条数据的newsid
			// System.out.println("newsid---"+newsid);
			return newsid;
		}
		return 0;
	}

	/**
	 * 获取topic相关性最大对应的新闻
	 **/
	public List<News> getTopicNews(String topicid) {
		int newsid = getNewsidByTopicid(topicid);
		while (newsid != 0) {
			NewsExample newsExample = new NewsExample();
			NewsExample.Criteria criteria = newsExample.createCriteria();
			criteria.andNews_idEqualTo(newsid);
			List<News> news = newsMapper.selectByExample(newsExample);
			return news;
		}
		return null;
	}

	/**
	 * 获取topic对应的news列表
	 **/
	public List<News> getTopicAllNews(String topicid) {
		List<News> news = new ArrayList<News>();
		TopicDocumentRelationExample example = new TopicDocumentRelationExample();
		TopicDocumentRelationExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicid);
		// 获取所有的新闻id
		List<TopicDocumentRelation> topicNewsRelation = documentRelationMapper.selectByExample(example);
		// System.out.println(topicNewsRelation);
		Iterator<TopicDocumentRelation> TopicNews = topicNewsRelation.iterator();
		// 得到每一条新闻的详情
		while (TopicNews.hasNext()) {
			TopicDocumentRelation topicDocumentRelation = TopicNews.next();
			int newsid = topicDocumentRelation.getNews_id();
			NewsExample newsExample = new NewsExample();
			NewsExample.Criteria criteriaNews = newsExample.createCriteria();
			criteriaNews.andNews_idEqualTo(newsid);
			example.setOrderByClause("news_time");
			List<News> temp = newsMapper.selectByExample(newsExample);
			news.addAll(temp);
		}
		return news;
	}

	// 获取话题下各种实体的数量
	public HashMap<String, Integer> getEntityNum(String topicId) {
		HashMap<String, Integer> entityMap = new HashMap<String, Integer>();
		HashMap<String, String> entityMapPer = new HashMap<String, String>();
		EntityTopicRelationExample example = new EntityTopicRelationExample();
		EntityTopicRelationExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicId);
		List<EntityTopicRelation> list = entityTopicRelationMapper.selectByExample(example);
		//System.out.println("list====" + list);
		Iterator<EntityTopicRelation> it = list.iterator();
		while (it.hasNext()) {
			EntityTopicRelation etr = it.next();
			int entityId = etr.getEntity_id();
			Entity entity = entityMapper.selectByPrimaryKey(entityId);
			if (entity != null) {
				String type = entity.getEntity_type();
				String key = entity.getEntity_key();
				entityMapPer.put(type, key);
				Integer temp = entityMap.get(type);
				if (temp == null) {
					temp = 1;
				} else {
					temp++;
				}
				entityMap.put(type, temp);
			}

		}
		//System.out.println("entityMap=======" + entityMap);
		return entityMap;
	}
	
	/**
	 * jinbo
	 * 按话题id和类型获取实体
	 * */
	public HashMap<String, Double> getEntityByTopicAndType(String topicId,String entityType){
		HashMap<String, Double> entityMap = new HashMap<String, Double>();
		TopicminingdistributionExample example = new TopicminingdistributionExample();
		TopicminingdistributionExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicId);
		criteria.andEntity_typeEqualTo(entityType);
		List<Topicminingdistribution> entityList = topicminingdistributionMapper.selectByTopicAndType(example);
		for (int i = 0; i < entityList.size(); i++) {
			Topicminingdistribution topicMinEntity = entityList.get(i);
			Entity entity = entityMapper.selectByPrimaryKey(topicMinEntity.getEntity_id());
			String entityKey = LatinToUnicodeRuleList.getUtf8String(entity.getEntity_key());
			Double entityCount = topicMinEntity.getDistribution();
			entityMap.put(entityKey, entityCount);
		}
		return entityMap;
	}

	public HashMap<String, Double> getEntityPer(String topicId) {
		HashMap<String, Double> entityMapPer = new HashMap<String, Double>();
		TopicminingdistributionExample example = new TopicminingdistributionExample();
		TopicminingdistributionExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicId);
		List<Topicminingdistribution> peopleEntityList = topicminingdistributionMapper.getPeopleStatData(example);
		for (int i = 0; i < peopleEntityList.size(); i++) {
			Topicminingdistribution entity = peopleEntityList.get(i);
			entityMapPer.put(entity.getName(), Double.valueOf(entity.getCount()));
		}
		return entityMapPer;
	}

	public HashMap<String, Double> getEntityLoc(String topicId) {
		HashMap<String, Double> entityMapLoc = new HashMap<String, Double>();
		TopicminingdistributionExample example = new TopicminingdistributionExample();
		TopicminingdistributionExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicId);
		List<Topicminingdistribution> locationEntityList = topicminingdistributionMapper.getLocationStatData(example);
		for (int i = 0; i < locationEntityList.size(); i++) {
			Topicminingdistribution entity = locationEntityList.get(i);
			entityMapLoc.put(entity.getName(), Double.valueOf(entity.getCount()));
		}
		return entityMapLoc;
	}
	
	public HashMap<String, Double> getEntityOrg(String topicId) {
		HashMap<String, Double> entityMapOrg = new HashMap<String, Double>();
		TopicminingdistributionExample example = new TopicminingdistributionExample();
		TopicminingdistributionExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicId);
		List<Topicminingdistribution> organizeEntityList = topicminingdistributionMapper.getOrganizeStatData(example);
		for (int i = 0; i < organizeEntityList.size(); i++) {
			Topicminingdistribution entity = organizeEntityList.get(i);
			entityMapOrg.put(entity.getName(), Double.valueOf(entity.getCount()));
		}
		return entityMapOrg;
	}

	public HashMap<String, String> getEntityKey(String topicId) {
		HashMap<String, String> entityKey = new HashMap<String, String>();
		TopicminingdistributionExample example = new TopicminingdistributionExample();
		TopicminingdistributionExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicId);
		List<Topicminingdistribution> list = topicminingdistributionMapper.selectByExample(example);
		Iterator<Topicminingdistribution> it = list.iterator();
		while (it.hasNext()) {
			Topicminingdistribution etr = it.next();
			int entityId = etr.getEntity_id();
			Entity entity = entityMapper.selectByPrimaryKey(entityId);
			String key = LatinToUnicodeRuleList.getUtf8String(entity.getEntity_key());
			entityKey.put(key,String.valueOf(entity.getCount()));
		}
		return entityKey;
	}

	// 获取实体关系
	public String getNewsEntityRelation(String topicID) {
		TopicDocumentRelationExample example = new TopicDocumentRelationExample();
		TopicDocumentRelationExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicID);
		List<TopicDocumentRelation> topicDocumentList = documentRelationMapper.selectByExample(example);
		List<Integer> newIdList = new ArrayList<Integer>();
		for (TopicDocumentRelation t : topicDocumentList) {
			newIdList.add(t.getNews_id());
		}
		List<EntityNewsRelation> entityNewsList = new ArrayList<EntityNewsRelation>();
		for (Integer newId : newIdList) {
			EntityNewsRelationExample example2 = new EntityNewsRelationExample();
			EntityNewsRelationExample.Criteria criteria2 = example2.createCriteria();
			criteria2.andNews_idEqualTo(newId);
			entityNewsList.addAll(entityNewsRelationMapper.selectByExample(example2));
		}
		JSONArray jsonArray = new JSONArray();
		int count = 0;
		for (EntityNewsRelation entityNews : entityNewsList) {
			JSONObject json = new JSONObject();
			if(count++ > 50) {
				break;
			}
			try {
				int entityId = entityNews.getEntity_id();
				int newsId = entityNews.getNews_id();
				String type = entityNews.getEntity_type();
				String entity = entityMapper.selectByPrimaryKey(entityId).getEntity_key();
				String title = newsMapper.selectByPrimaryKey(newsId).getNews_title();
				if (type.equals("PER")) {
					json.put("type", 1);
				} else if (type.equals("LOC")) {
					json.put("type", 2);
				} else {
					json.put("type", 3);
				}
				json.put("entity", entity);
				json.put("title", title);
				jsonArray.add(json);
			} catch (Exception e2) {
				continue;
			}
		}
		System.out.println("##实体关系:"+jsonArray.size()+":"+jsonArray.toString());
		return jsonArray.toString();
	}

	public HashMap<String, Integer> getTopicTendency(String lang) {

		HashMap<String, Integer> topicTenMap = new HashMap<String, Integer>();

		for (int i = 0; i < 7; i++) {
			TopicExample example = new TopicExample();
			TopicExample.Criteria criteria = example.createCriteria();
			SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");

			// Date beginDate = smf.parse(dataBegin);
			Topic topic = topicMapper.getLastTopic(lang);
			Date lastDate = topic.getNews_time();
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(lastDate);
			calendar.add(Calendar.DAY_OF_MONTH, -1 * i);
			Date endDate = calendar.getTime();

			calendar.setTime(lastDate);
			calendar.add(Calendar.DAY_OF_MONTH, -1 * (i + 1));
			Date beginDate = calendar.getTime();

			criteria.andNews_timeBetween(beginDate, endDate);
			criteria.andLang_typeEqualTo(lang);

			int count = topicMapper.countByExample(example);

			String formatDate = smf.format(beginDate);

			topicTenMap.put(formatDate, count);
		}

		return topicTenMap;
	}

	// 根据话题获取相关新闻
	public String getTopicToEntity(String topicId) {
		HashMap<String, Integer> topic_entity = new HashMap<String, Integer>();
		HashMap<String, Integer> topic_name_news = new HashMap<String, Integer>();
		TopicminingdistributionExample example = new TopicminingdistributionExample();
		TopicminingdistributionExample.Criteria criteria = example.createCriteria();
		criteria.andTopic_idEqualTo(topicId);

		List<Topicminingdistribution> list = topicminingdistributionMapper.selectByExample(example);
		System.out.println("list的长度为:");
		System.out.println(list.size());

		int a = 0;

		for (int i = 0; i < list.size(); i++) {
			Topicminingdistribution etr = list.get(i);
			int entityId = etr.getEntity_id();
			String topic_id = etr.getTopic_id();
			Topic topic = topicMapper.selectByPrimaryKey(topic_id);
			String topic_name = topic.getTopic_name();
			Entity entity = entityMapper.selectByPrimaryKey(entityId);
			topic_name_news.put(topic_name, 0);
			String entity_key = entity.getEntity_key();
			String entity_key_meng = LatinToUnicodeRuleList.getUtf8String(entity_key);
			String entity_type_key = entity.getEntity_type();
			if (entity_type_key.equals("PER")) {
				a++;
				topic_entity.put(entity_key_meng, 1);
			} else if (entity_type_key.equals("LOC")) {
				a++;
				topic_entity.put(entity_key_meng, 2);
			} else {
				topic_entity.put(entity_key_meng, 3);
				a++;
			}
		}
		topic_entity.putAll(topic_name_news);
		System.out.println("实体总共数量为：");
		System.out.println(topic_entity.toString());
		JSONObject json = mapSorted.mapSorted(topic_entity);
		return json.toString();
	}

	public Topic getTopicByID(String topic_id) {
		Topic topic = topicMapper.selectByPrimaryKey(topic_id);
		return topic;
	}

	// 根据实体获取所有相关话题
	public List<Topic> getTopicByEntityID(Integer entity_id) {
		EntityTopicRelationExample example = new EntityTopicRelationExample();
		EntityTopicRelationExample.Criteria criteria = example.createCriteria();
		criteria.andEntity_idEqualTo(entity_id);
		List<EntityTopicRelation> list = entityTopicRelationMapper.selectByExample(example);
		List<Topic> topicList = new ArrayList<Topic>();
		for (EntityTopicRelation et : list) {
			String topic_id = et.getTopic_id();
			topicList.add(getTopicByID(topic_id));
		}
		return topicList;
	}

	// 获取话题趋势-优化过后
	public TreeMap<String, Integer> getTopicTendencyNum(String lang) {

		TreeMap<String, Integer> result = new TreeMap<String, Integer>();

		List<topicNumModel> topicNumModels = topicMapper.getTopicNum(lang);

		for (topicNumModel t : topicNumModels) {

			result.put(t.getDataTime(), t.getNum());

		}
		return result;
	}

	// 根据话题获取十个实体
	public List<typeWord> getTenEntity(String topicID) {
		List<topicEntity> topicEntities = topicMapper.getTopicEntity(topicID);
		List<typeWord> array = new ArrayList<typeWord>();
		for (topicEntity t : topicEntities) {
			typeWord temp = new typeWord();
			Integer entityID = t.getEntity_id();
			int relation = (int) t.getRelation();
			String entity = entityMapper.selectByPrimaryKey(entityID).getEntity_key();
			temp.setName(entity);
			temp.setValue(relation);
			array.add(temp);
		}
		return array;
	}
	
	public void insertLocStat(List<StatisticEntity> locStatList) {
		topicMapper.turncateLocStat();
		topicMapper.insertLocStat(locStatList);
	}
	public void insertOrgStat(List<StatisticEntity> orgStatList) {
		topicMapper.turncateOrgStat();
		topicMapper.insertOrgStat(orgStatList);
	}
	public void insertPerStat(List<StatisticEntity> perStatList) {
		topicMapper.turncatePerStat();
		topicMapper.insertPerStat(perStatList);
	}
}
