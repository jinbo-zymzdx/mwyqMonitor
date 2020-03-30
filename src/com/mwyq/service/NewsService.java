/**
 * NewsService.java 
 */

package com.mwyq.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.stream.Collectors;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;
import com.github.abel533.echarts.Data;
import com.github.abel533.echarts.series.Map;
import com.mwyq.controller.TopController;
import com.mwyq.dao.CustomMonitorMapper;
import com.mwyq.dao.EntityMapper;
import com.mwyq.dao.EntityNewsRelationMapper;
import com.mwyq.dao.NewsMapper;
import com.mwyq.dao.TopicMapper;
import com.mwyq.dao.TwitterMapper;
import com.mwyq.dao.UserMapper;
import com.mwyq.dao.displayTableMapper;
import com.mwyq.dao.religionEntityMapper;
import com.mwyq.dao.weiBoMapper;
import com.mwyq.dao.weiboFensiMapper;
import com.mwyq.model.CustomMonitor;
import com.mwyq.model.Entity;
import com.mwyq.model.EntityNewsRelation;
import com.mwyq.model.EntityNewsRelationExample;
import com.mwyq.model.News;
import com.mwyq.model.NewsExample;
import com.mwyq.model.NewsExample.Criteria;
import com.mwyq.model.Topic;
import com.mwyq.model.TopicExample;
import com.mwyq.model.Twitter;
import com.mwyq.model.TwitterGroup;
import com.mwyq.model.User;
import com.mwyq.model.displayTable;
import com.mwyq.model.displayTableExample;
import com.mwyq.model.fensi;
import com.mwyq.model.newsNumStatic;
import com.mwyq.model.religionEntity;
import com.mwyq.model.religionEntityExample;
import com.mwyq.model.sensitiveTendency;
import com.mwyq.model.topicEntity;
import com.mwyq.model.TwitterAuthor;
import com.mwyq.model.TwitterExample;
import com.mwyq.model.typeCategory;
import com.mwyq.model.typeQuery;
import com.mwyq.model.typeSensitive;
import com.mwyq.model.typeWord;
import com.mwyq.model.weiBo;
import com.mwyq.model.weiBoExample;
import com.mwyq.model.weiboEmotion;
import com.mwyq.model.weiboFensi;
import com.mwyq.model.weiboFensiExample;
import com.mwyq.model.weiboGroup;
import com.mwyq.util.CommonUtils;

import net.sf.json.JSONObject;

@Service
public class NewsService {

	private static Logger logger = LoggerFactory.getLogger(NewsService.class);

	@Resource
	private TopicMapper topicMapper;

	@Resource
	private CustomMonitorMapper customMonitorMapper;

	@Resource
	private NewsMapper newsMapper;

	@Resource
	public EntityNewsRelationMapper entityNewsRelationMapper;

	@Resource
	private UserMapper userMapper;

	@Resource
	public EntityMapper entityMapper;

	@Resource
	public weiBoMapper weiBoMapper;

	@Resource
	public displayTableMapper disTableMapper;

	@Resource
	public weiboFensiMapper weiboFensiMapper;

	@Resource
	public religionEntityMapper rEntityMapper;

	@Resource
	public TwitterMapper twitterMapper;

	public List<weiBo> getWeiBo(String lang) {
		List<weiBo> wei = weiBoMapper.getWeiBoNews(lang);
		return wei;
	}

	public List<weiBo> getWeiBoByEmotion(String lang, String emotion) {
		return weiBoMapper.getWeiBoByEmotion(lang, CommonUtils.WeiBo_Emotion_Map.get(emotion));
	}

	public String tranWeibo(Integer weibo_id) {
		weiBo wei = weiBoMapper.selectByPrimaryKey(weibo_id);
		String content = wei.getContent();
		String lang = wei.getLang();
		if (lang.equals("cn")) {
			return null;
		}
		return content;
	}

	public List<News> getAllNews() {
		NewsExample example = new NewsExample();
		List<News> newsAll = newsMapper.selectByExample(example);
		return newsAll;
	}

	public List<News> getSenNewsByRange(String lang, String range, String sensitive) {
		List<News> sensitiveNews = new ArrayList<News>();
		if (range.equals("all")) {
			sensitiveNews =newsMapper.getSensitiveNews(lang);
		}else {
			sensitiveNews = getSenNewsByRangeTime(lang, range, Integer.parseInt(sensitive));
		}
		return sensitiveNews;
	}

	public List<News> getSenNewsByRangeTime(String lang, String range, Integer sensitive) {
		List<News> sensitiveNews = new ArrayList<News>();
		if (range.equals("week")) {
			sensitiveNews = newsMapper.getSenNewsByWeek(lang, sensitive);
		} else if (range.equals("month")) {
			sensitiveNews = newsMapper.getSenNewsByMonth(lang, sensitive);
		} else if (range.equals("year")) {
			sensitiveNews = newsMapper.getSenNewsByYear(lang, sensitive);
		}
		return sensitiveNews;
	}

	public List<News> getSensitiveNews(String lang) {
		return newsMapper.getSensitiveNews(lang);
	}

	public boolean getUser(String name, String passwd) {
		int user = 0;
		user = userMapper.getUser(name, passwd);
		System.out.println(user);
		if (user == 0) {
			System.out.println("鐢ㄦ埛涓嶅瓨鍦�");
			return false;
		}
		System.out.println("鐢ㄦ埛瀛樺湪");
		return true;
	}

	/**
	 * 
	 */
	public TreeMap<String, TreeMap<String, Integer>> sevenDayNews() {
		String[] langSet = { "cn", "meng", "wei", "zang" };
		int j;
		SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = findLatestNewsDate();
		Calendar calendar = Calendar.getInstance();
		TreeMap<String, TreeMap<String, Integer>> ssiMap = new TreeMap<String, TreeMap<String, Integer>>();
		for (int i = 0; i < 7; i++) {
			calendar.setTime(date);
			calendar.add(Calendar.DATE, -1 * i);
			String lastestTime = smf.format(calendar.getTime());
			TreeMap<String, Integer> siMap = new TreeMap<String, Integer>();
			for (String lang : langSet) {
				j = newsMapper.getCountByTime(lastestTime, lang);
				siMap.put(lang, j);
			}
			ssiMap.put(lastestTime, siMap);
		}

		return ssiMap;
	}

	// 按类型获取新闻
	public List<News> getSenNewsByType(String lang, String type) {
		return newsMapper.getSenNewsByType(lang, type);
	}

	/**
	 * 鑾峰彇鏈�鏂颁竴鏉℃晱鎰熸柊闂�
	 */

	public News getLastestSensitiveNews(String lang) {
		News lastestSensitiveNews = newsMapper.getLastestSensitiveNews(lang);
		return lastestSensitiveNews;

	}

	// public int getSensitiveCount(String lang){
	// int sensitiveCount = newsMapper.getSensitiveNewsCount(lang);
	//
	// System.out.println("寰楀埌鏁忔劅淇℃伅鏁伴噺涓猴細"+sensitiveCount);
	//
	// return sensitiveCount;
	// }

	/**
	 * 
	 */
	public Date findLatestNewsDate() {
		String[] langSet = { "cn", "wei", "zang", "meng" };
		SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();

		News lastestNews = newsMapper.getLastestOneNews("cn");
		date = lastestNews.getNews_time();
		for (String lang : langSet) {
			News lastestNews2 = newsMapper.getLastestOneNews(lang);
			if (date.before(lastestNews2.getNews_time())) {
				date = lastestNews2.getNews_time();
			}
		}

		System.out.println(smf.format(date));
		return date;
	}

	public String getDateByLang(String lang) {
		Date date = newsMapper.getNewsTimeByLang(lang);
		SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
		String result = smf.format(date);
		return result;
	}

	/**
	 * 鑾峰彇鏂伴椈鏁伴噺
	 */
	public int getChinese() {
		// int ch = newsMapper.getChineseCount();
		String date = getDateByLang("cn");
		System.out.println("涓枃鏈�鏂版棩鏈熶负锛�" + date);
		int count = newsMapper.getNewsCountByData(date, "cn");
		System.out.println("鏍规嵁璇鑾峰彇鏃堕棿涓猴細");
		System.out.println(count);
		return count;
	}

	/**
	 * 
	 */
	public int getMeng() {
		// int meng = newsMapper.getMengCount();
		String date = getDateByLang("meng");
		System.out.println("钂欐枃鏈�鏂版棩鏈熶负锛�" + date);
		int count = newsMapper.getNewsCountByData(date, "meng");
		System.out.println("鏍规嵁璇鑾峰彇鏃堕棿涓猴細");
		System.out.println(count);
		return count;
	}

	/**
	 * 
	 */
	public int getZang() {
		// int zang = newsMapper.getZangCount();
		String date = getDateByLang("zang");
		System.out.println("钘忔枃鏈�鏂版棩鏈熶负锛�" + date);
		int count = newsMapper.getNewsCountByData(date, "zang");
		System.out.println("鏍规嵁璇鑾峰彇鏃堕棿涓猴細");
		System.out.println(count);
		return count;
	}

	/**
	 * 
	 */
	public int getWei() {
		// int wei = newsMapper.getWeiCount();
		String date = getDateByLang("wei");
		System.out.println("缁存枃鏈�鏂版棩鏈熶负锛�" + date);
		int count = newsMapper.getNewsCountByData(date, "wei");
		System.out.println("鏍规嵁璇鑾峰彇鏃堕棿涓猴細");
		System.out.println(count);
		return count;
	}

	/**
	 * 
	 */
	public int getLastestNewsCount() {
		int newsCount = newsMapper.getLastestNewsCount();
		return newsCount;
	}

	/**
	 * 
	 */
	public News getLastOneNews(String lang) {
		News lastestOneNews = newsMapper.getLastestOneNews(lang);
		return lastestOneNews;
	}

	/*
	 * 鎻掑叆custom淇℃伅
	 */
	public void insertCustom(CustomMonitor record) {
		// System.out.println("鎻掑叆鍏抽敭璇嶄负"+record.getKeyWord()+"鐨勬暟鎹�");
		int a = customMonitorMapper.insert(record);
		// System.out.println("涓嶇煡鍚嶇殑鏁版嵁涓猴細"+a);
	}

	/*
	 * 鍒犻櫎custom淇℃伅
	 */
	public void deleteCustom(String keyWord) {
		int a = customMonitorMapper.deleteByKeyWord(keyWord);
	}

	/*
	 * 鑾峰彇鎵�鏈塩ustom淇℃伅
	 */
	public List<CustomMonitor> getAllCustom() {
		return customMonitorMapper.getAllCustomMonitor();
	}

	/*
	 * 鏍规嵁鍏抽敭璇嶆煡璇㈣瑷�
	 */
	public String getCustomLang(String keyWord) {
		CustomMonitor customLang = customMonitorMapper.getCustomByWord(keyWord);
		String customMonitorLang = customLang.getLangType();
		return customMonitorLang;
	}

	/*
	 * 鏌ヨ瀹氬埗鐩稿叧鎵�鏈塼opic
	 */
	public List<Topic> getCustomTopic(String keyWord, String langType) {

		System.out.println("service锛氭悳绱㈢殑鍏抽敭璇�" + keyWord);
		System.out.println("service锛氭悳绱㈢殑璇█" + langType);

		List<Topic> allCustomTopic = topicMapper.getCustomTopic(keyWord, langType);

		System.out.println("鎼滅储鍑烘潵鐨勬潯鐩�" + allCustomTopic.size());

		return allCustomTopic;
	}

	public String getSourse() {
		HashMap<String, Integer> resultSource = new HashMap<String, Integer>();
		int count = 0;

		List<String> sourse = newsMapper.getSourse();
		for (int i = 0; i < sourse.size(); i++) {
			// System.out.println(sourse.get(i));
			count = newsMapper.getSourseCount(sourse.get(i));
			// System.out.println(count);
			resultSource.put(sourse.get(i), count);
		}

		return resultSource.toString();
	}

	/**
	 * 
	 */
	public String getClickTime(String clickID) {
		Date day = newsMapper.getTimeByID(clickID);
		// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(sdf.format(day));
		return sdf.format(day);
	}

	/**
	 * 鑾峰彇鏂伴椈鍒楄〃
	 **/
	public List<News> getLatestNews(String lang) {
		NewsExample example = new NewsExample();
		example.setOrderByClause("news_time");

		List<News> latestNews = newsMapper.getLastestNews(lang);
		// for (int i = 0; i < latestNews.size(); ++i) {
		// System.out.println(i + " : " + latestNews.get(i).getNews_title() + " : " +
		// latestNews.get(i).getNews_content());
		// }
		// System.out.println(latestNews);
		// Collections.sort(latestNews,Collections.reverseOrder());
		return latestNews;
	}

	/**
	 * 鑾峰彇鏂伴椈鐨勫唴瀹�
	 **/
	public List<News> getNewsContent(int newsid) {
		NewsExample example = new NewsExample();
		NewsExample.Criteria criteria = example.createCriteria();
		criteria.andNews_idEqualTo(newsid);
		List<News> newsContent = newsMapper.selectByExample(example);

		System.out.println(newsContent.toString());

		return newsContent;
	}

	public String getOnlyNewsContent(int newsid) {

		String newsContent = "";
		News news = newsMapper.selectByPrimaryKey(newsid);
		newsContent = news.getNews_content();

		System.out.println("sdsdsdsdsdsdsdsdsdsdsdsd");
		System.out.println(newsContent);

		return newsContent;
	}

	// HashMap<String, Integer> newsTenMap = new HashMap<String, Integer>();
	//
	// for (int i = 0; i < 7; i++) {
	// NewsExample example = new NewsExample();
	// NewsExample.Criteria criteria = example.createCriteria();
	// SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
	//
	// // Date beginDate = smf.parse(dataBegin);
	//
	// Calendar calendar = Calendar.getInstance();
	// News lastNews = newsMapper.getLastestOneNews(lang);
	//
	// Date lastNewsDate;
	// if(lastNews!=null){
	// lastNewsDate= lastNews.getNews_time();}
	// else{
	// lastNewsDate=new Date();
	// }
	//
	//
	// calendar.setTime(lastNewsDate);
	// calendar.add(Calendar.DATE, -1 * i);
	// Date endDate = calendar.getTime();
	//
	// calendar.setTime(lastNewsDate);
	// calendar.add(Calendar.DATE, -1 * (i + 1));
	// Date beginDate = calendar.getTime();
	//
	// criteria.andNews_timeBetween(beginDate, endDate);
	// criteria.andLang_typeEqualTo(lang);
	//
	// int count = newsMapper.countByExample(example);
	//
	// String formatDate = smf.format(beginDate);

	/*
	 * 鑾峰彇鏁忔劅璇嶈秼鍔�
	 */
	public TreeMap<String, TreeMap<String, Integer>> getSensitiveTendency(String lang) {
		Date LastestSensitiveDate = newsMapper.getSensitiveLastestTime(lang);
		TreeMap<String, TreeMap<String, Integer>> sensitiveCount = new TreeMap<String, TreeMap<String, Integer>>();

		SimpleDateFormat sensitiveDate = new SimpleDateFormat("yyyy-MM");
		// SimpleDateFormat sensitiveDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat BG = new SimpleDateFormat("yyyy-MM-dd");

		Calendar lastestCalendar = Calendar.getInstance();
		lastestCalendar.setTime(LastestSensitiveDate);

		lastestCalendar.set(Calendar.DAY_OF_MONTH, 1);
		String beginDay = BG.format(lastestCalendar.getTime());
		lastestCalendar.add(Calendar.MONTH, 1);
		lastestCalendar.set(Calendar.DAY_OF_MONTH, 1);
		String endDay = BG.format(lastestCalendar.getTime());
		lastestCalendar.add(Calendar.MONTH, -1);

		int sensitiveNewsOne = newsMapper.getMonthSensitive1Count(lang, beginDay, endDay);
		int sensitiveNewsTwo = newsMapper.getMonthSensitive2Count(lang, beginDay, endDay);

		Date temp = lastestCalendar.getTime();
		TreeMap<String, Integer> sensitiveMonth = new TreeMap<String, Integer>();
		sensitiveMonth.put("one", sensitiveNewsOne);
		sensitiveMonth.put("two", sensitiveNewsTwo);

		sensitiveCount.put(sensitiveDate.format(temp), sensitiveMonth);

		for (int i = 0; i < 6; i++) {
			lastestCalendar.add(Calendar.MONTH, -1);

			lastestCalendar.set(Calendar.DAY_OF_MONTH, 1);
			beginDay = BG.format(lastestCalendar.getTime());
			lastestCalendar.add(Calendar.MONTH, 1);
			lastestCalendar.set(Calendar.DAY_OF_MONTH, 1);
			endDay = BG.format(lastestCalendar.getTime());
			lastestCalendar.add(Calendar.MONTH, -1);

			sensitiveNewsOne = newsMapper.getMonthSensitive1Count(lang, beginDay, endDay);
			sensitiveNewsTwo = newsMapper.getMonthSensitive2Count(lang, beginDay, endDay);

			TreeMap<String, Integer> sensitiveMonth1 = new TreeMap<String, Integer>();

			sensitiveMonth1.put("one", sensitiveNewsOne);
			sensitiveMonth1.put("two", sensitiveNewsTwo);

			temp = lastestCalendar.getTime();
			sensitiveCount.put(sensitiveDate.format(temp), sensitiveMonth1);
		}

		////////////////////////////////////////
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		JSONObject json = new JSONObject();
		NewsExample example = new NewsExample();
		NewsExample.Criteria criteria = example.createCriteria();
		criteria.andNews_timeBetween(LastestSensitiveDate, LastestSensitiveDate);
		newsMapper.selectByExample(example);
		////////////////////////////////////////

		return sensitiveCount;
	}

	public HashMap<String, Integer> getNewsTendency(String lang) {

		if (lang == null) {
			lang = "cn";
		}

		HashMap<String, Integer> newsTenMap = new HashMap<String, Integer>();

		for (int i = 0; i < 7; i++) {
			NewsExample example = new NewsExample();
			NewsExample.Criteria criteria = example.createCriteria();
			SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");

			// Date beginDate = smf.parse(dataBegin);

			Calendar calendar = Calendar.getInstance();
			News lastNews = newsMapper.getLastestOneNews(lang);

			Date lastNewsDate;
			if (lastNews != null) {
				lastNewsDate = lastNews.getNews_time();
			} else {
				lastNewsDate = new Date();
			}

			calendar.setTime(lastNewsDate);
			calendar.add(Calendar.DATE, -1 * i);
			Date endDate = calendar.getTime();

			calendar.setTime(lastNewsDate);
			calendar.add(Calendar.DATE, -1 * (i + 1));
			Date beginDate = calendar.getTime();

			criteria.andNews_timeBetween(beginDate, endDate);
			criteria.andLang_typeEqualTo(lang);

			int count = newsMapper.countByExample(example);

			String formatDate = smf.format(beginDate);

			newsTenMap.put(formatDate, count);
		}

		return newsTenMap;
	}

	/**
	 * 
	 */
	public HashMap<String, String> getEntityPerKey(Integer newsId) {

		HashMap<String, String> entityPerKey = new HashMap<String, String>();
		EntityNewsRelationExample example = new EntityNewsRelationExample();
		EntityNewsRelationExample.Criteria criteria = example.createCriteria();
		criteria.andNews_idEqualTo(newsId);
		List<EntityNewsRelation> list = entityNewsRelationMapper.selectByExample(example);
		Iterator<EntityNewsRelation> it = list.iterator();
		while (it.hasNext()) {
			EntityNewsRelation enr = it.next();
			int entityId = enr.getEntity_id();
			Entity entity = entityMapper.selectByPrimaryKey(entityId);
			String entity_typeKey = entity.getEntity_type();
			if (entity_typeKey.equals("PER")) {
				String key = entity.getEntity_key();
				String key_meng = LatinToUnicodeRuleList.getUtf8String(key);
				String key_count = entity.getCount().toString();
				entityPerKey.put(key_meng, key_count);
			}
		}
		System.out.println("entityPerKey=" + entityPerKey.toString());
		return entityPerKey;
	}

	/**
	 * 
	 */
	public HashMap<String, String> getEntityLocKey(Integer newsId) {

		HashMap<String, String> entityLocKey = new HashMap<String, String>();
		EntityNewsRelationExample example = new EntityNewsRelationExample();
		EntityNewsRelationExample.Criteria criteria = example.createCriteria();
		criteria.andNews_idEqualTo(newsId);
		List<EntityNewsRelation> list = entityNewsRelationMapper.selectByExample(example);
		Iterator<EntityNewsRelation> it = list.iterator();
		while (it.hasNext()) {
			EntityNewsRelation enr = it.next();
			int entityId = enr.getEntity_id();
			Entity entity = entityMapper.selectByPrimaryKey(entityId);
			String entity_typeKey = entity.getEntity_type();
			if (entity_typeKey.equals("LOC")) {
				String key = entity.getEntity_key();
				String key_meng = LatinToUnicodeRuleList.getUtf8String(key);
				String key_count = entity.getCount().toString();
				entityLocKey.put(key_meng, key_count);
			}
		}
		System.out.println("entityLocKey=" + entityLocKey.toString());
		return entityLocKey;
	}

	/**
	 * 
	 */
	public HashMap<String, String> getEntityOrgKey(Integer newsId) {

		HashMap<String, String> entityOrgKey = new HashMap<String, String>();
		EntityNewsRelationExample example = new EntityNewsRelationExample();
		EntityNewsRelationExample.Criteria criteria = example.createCriteria();
		criteria.andNews_idEqualTo(newsId);
		List<EntityNewsRelation> list = entityNewsRelationMapper.selectByExample(example);
		Iterator<EntityNewsRelation> it = list.iterator();
		while (it.hasNext()) {
			EntityNewsRelation enr = it.next();
			int entityId = enr.getEntity_id();
			Entity entity = entityMapper.selectByPrimaryKey(entityId);
			String entity_typeKey = entity.getEntity_type();
			if (entity_typeKey.equals("ORG")) {
				String key = entity.getEntity_key();
				String key_meng = LatinToUnicodeRuleList.getUtf8String(key);
				String key_count = entity.getCount().toString();
				entityOrgKey.put(key_meng, key_count);
			}
		}
		System.out.println("entityOrgKey=" + entityOrgKey.toString());
		return entityOrgKey;
	}

	// 根据newsId获取新闻实体对应关键字
	public List<typeWord> getNewsKeyword(Integer newsId) {
		List<EntityNewsRelation> entityNewsList = entityNewsRelationMapper.getEntityNewsRelByNewId(newsId);
		List<typeWord> newsKeywords = new ArrayList<typeWord>();
		for (EntityNewsRelation entityNews : entityNewsList) {
			typeWord temp = new typeWord();
			Integer entityID = entityNews.getEntity_id();
			int relation = (int) entityNews.getRelation();
			String entity = entityMapper.selectByPrimaryKey(entityID).getEntity_key();
			temp.setName(entity);
			temp.setValue(relation);
			newsKeywords.add(temp);
		}
		if (newsKeywords.size() > 0) {
			newsKeywords = newsKeywords.stream().sorted(Comparator.comparing(typeWord::getValue).reversed())
					.collect(Collectors.toList());
		}
		return newsKeywords;
	}

	public News getNewsById(Integer news_id) {
		News news = newsMapper.selectByPrimaryKey(news_id);
		return news;
	}

	// 鏍规嵁瀹炰綋鑾峰彇鎵�鏈夋柊闂�
	public List<News> getNewsByEntityID(Integer entity_id) {
		EntityNewsRelationExample example = new EntityNewsRelationExample();
		EntityNewsRelationExample.Criteria criteria = example.createCriteria();
		criteria.andEntity_idEqualTo(entity_id);
		List<EntityNewsRelation> list = entityNewsRelationMapper.selectByExample(example);
		List<News> newsList = new ArrayList<News>();
		for (EntityNewsRelation en : list) {
			Integer news_id = en.getNews_id();
			newsList.add(getNewsById(news_id));
		}
		return newsList;
	}

	// 鏍规嵁璇█鑾峰彇缃戠珯浠ュ強瀵瑰簲鏁伴噺锛屽彇鍓嶅崄鍚�
	public List<typeQuery> geTypeQuery(String lang) {
		List<typeQuery> result = newsMapper.getSourseAndCount(lang);
		return result;
	}

	// 鑾峰彇鏁忔劅璇嶈秼鍔�
	public List<typeSensitive> getTypeSensitive() {
		List<typeSensitive> result = newsMapper.getSebsitiveTrend();
		return result;
	}

	// 鑾峰彇褰撳ぉ鏇存柊鐨勬墍鏈夎绉嶆暟閲�
	public HashMap<String, Integer> getNewsCount() {

		HashMap<String, Integer> result = new HashMap<String, Integer>();
		result.put("cn", 26);
		result.put("zang", 11);
		result.put("meng", 73);
		result.put("wei", 23);

		displayTableExample example = new displayTableExample();
		displayTableExample.Criteria criteria = example.createCriteria();
		criteria.andDescriptionEqualTo("newsCount");
		List<displayTable> list = disTableMapper.selectByExample(example);
		if (!list.isEmpty()) {
			displayTable dis = list.get(0);
			String count = dis.getData();
			String[] langCount = count.split(" ");
			// for(int i=0;i<langCount.length;i++){
			// System.out.println("璇█鏁伴噺涓猴細");
			// System.out.println(langCount[i]);
			// }
			result.put("cn", Integer.parseInt(langCount[0]));
			result.put("zang", Integer.parseInt(langCount[1]));
			result.put("wei", Integer.parseInt(langCount[2]));
			result.put("meng", Integer.parseInt(langCount[3]));
		}
		return result;
	}

	// 鑾峰彇瀹炰綋-缁熻鍒嗘瀽楗肩姸鍥�
	public JSONObject getStaticEntity(String lang) {
		JSONObject json = new JSONObject();

		displayTableExample example = new displayTableExample();
		displayTableExample.Criteria criteria = example.createCriteria();
		if (lang.equals("cn")) {
			criteria.andDescriptionEqualTo("cnEntity");
		} else if (lang.equals("zang")) {
			criteria.andDescriptionEqualTo("zangEntity");
		} else if (lang.equals("wei")) {
			criteria.andDescriptionEqualTo("weiEntity");
		} else {
			criteria.andDescriptionEqualTo("mengEntity");
		}

		List<displayTable> list = disTableMapper.selectByExample(example);

		if (!list.isEmpty()) {
			String result = list.get(0).getData();
			String[] temp = result.split(" ");
			json.put("人物", temp[0]);
			json.put("地点", temp[1]);
			json.put("组织机构", temp[2]);
		}

		return json;
	}

	// 鑾峰彇鑱氱被鍚庢晱鎰熻瘝瓒嬪娍
	public List<sensitiveTendency> getSensitiveTendencyByLang(String lang) {
		List<sensitiveTendency> result = newsMapper.getSensitiveTrency(lang);
		return result;
	}

	// 鑾峰彇鍥涚璇█鏁伴噺
	public JSONObject getAllNewsNum() {
		JSONObject json = new JSONObject();
		List<newsNumStatic> result = newsMapper.getAllNewsCount();
		// for(newsNumStatic n:result){
		// int[] num = new int[4];
		// num[0] = n.getCn();
		// num[1] = n.getZang();
		// num[2] = n.getWei();
		// num[3] = n.getMeng();
		// json.put(n.getData_time(), num);
		// }

		for (int i = result.size() - 1; i >= 0; i--) {
			int[] num = new int[4];
			num[0] = result.get(i).getCn();
			num[1] = result.get(i).getZang();
			num[2] = result.get(i).getWei();
			num[3] = result.get(i).getMeng();
			json.put(result.get(i).getData_time(), num);
		}

		return json;
	}

	// 鑾峰彇寰崥浣滆�呮暟閲�
	public List<weiboGroup> getWeiboAuthor(String lang) {
		List<weiboGroup> result = weiBoMapper.getAuthorGroup(lang);
		return result;
	}

	// 鑾峰彇寰崥鎯呮劅淇℃伅
	public JSONObject getWeiboEmotion(String lang) {
		JSONObject json = new JSONObject();
		List<weiboEmotion> result = weiBoMapper.getWeiboEmotion(lang);
		for (weiboEmotion we : result) {
			json.put(we.getEmotion(), we.getNum());
		}
		// System.out.println("nullllll");
		// System.out.println(json.toString());
		return json;
	}

	// 鑾峰彇鏂伴椈绫诲埆
	public JSONObject getNewsCategory(String lang) {
		JSONObject json = new JSONObject();
		List<typeCategory> result = newsMapper.getNewsCategory(lang);
		for (typeCategory t : result) {
			json.put(t.getCategory(), t.getNum());
		}
		System.out.println(json.toString());
		return json;
	}

	public String getNewsTitle(Integer id) {
		System.out.println("鏌ヨ鏂伴椈ID涓簊");
		System.out.println(id);
		String title = newsMapper.selectByPrimaryKey(id).getNews_title();
		System.out.println(title);
		return title;
	}

	// 鑾峰彇寰崥绮変笣鏁伴噺
	public JSONObject getWeiboFens(String lang) {
		// weiboFensiExample example = new weiboFensiExample();
		// weiboFensiExample.Criteria criteria = example.createCriteria();
		// criteria.andLangEqualTo(lang);
		// List<weiboFensi> result = weiboFensiMapper.selectByExample(example);
		// if(result.size()>=9){
		// result = result.subList(0, 9);
		// }
		//
		// while (result.size()>0) {
		//
		// }
		//
		// JSONObject json = new JSONObject();
		//
		// Iterator<weiboFensi> iterable = result.iterator();
		// while (iterable.hasNext()) {
		// weiboFensi temp = iterable.next();
		// json.put(temp.getName(), temp.getFansCount());
		// }
		// return json;

		List<fensi> result = weiboFensiMapper.getWeiFensi(lang);
		JSONObject json = new JSONObject();

		Iterator<fensi> iterable = result.iterator();
		while (iterable.hasNext()) {
			fensi temp = iterable.next();
			json.put(temp.getName(), temp.getCount());
		}
		return json;

	}

	// 鏍规嵁寰崥鍗氫富鑾峰彇鍏跺井鍗�
	public List<weiBo> getAuthorWeibo(String name) {
		List<weiBo> result = weiBoMapper.getAuthorWeibo(name);
		return result;
	}

	// 鏇存柊-鍏虫敞鍗氫富
	public void upYesFollow(String username, String passwd, String bozhu) {
		List<User> list = userMapper.getSelectedUser(username, passwd);
		User user = list.get(0);
		String follow_name = user.getDesc();

		String result = "";

		System.out.println("uuuuuuuu");
		if (follow_name == null || follow_name == "") {
			result = result + bozhu + "*";
		} else {
			result = follow_name;
			System.out.println(result);
			result = result.replace(bozhu + "*", "");
			result = result + bozhu + "*";
		}

		System.out.println(result);

		user.setDesc(result);
		userMapper.updateByPrimaryKeySelective(user);
	}

	// 鏇存柊-鍙栨秷鍏虫敞鍗氫富
	public void upNoFollow(String username, String passwd, String bozhu) {
		List<User> list = userMapper.getSelectedUser(username, passwd);
		User user = list.get(0);
		String follow_name = user.getDesc();

		System.out.println("vvvvvvvv");
		String result = "";
		if (follow_name == null || follow_name == "") {
			result = result + bozhu + "*";
		} else {
			result = follow_name;
			System.out.println(result);
			result = result.replace(bozhu + "*", "");
		}

		System.out.println(result);

		user.setDesc(result);
		userMapper.updateByPrimaryKeySelective(user);
	}

	// 鑾峰彇鐢ㄦ埛鍏虫敞鍒楄〃
	public String getGuanzhu(String username, String passwd) {
		User user = userMapper.getSelectedUser(username, passwd).get(0);
		String result = user.getDesc();
		return result;
	}

	// 鑾峰彇鎺ㄩ�佸井鍗�
	public List<weiBo> getTuisong(String bozhu) {
		List<String> guanzhu = Arrays.asList(bozhu.split(" "));

		List<weiBo> weiBos = new ArrayList<weiBo>();

		weiBoExample example = new weiBoExample();

		for (String author : guanzhu) {
			System.out.println(author);
			weiBoExample.Criteria criteria = example.createCriteria();
			criteria.andAuthorEqualTo(author);
			example.or(criteria);
		}

		example.setOrderByClause("time DESC");
		List<weiBo> result = weiBoMapper.selectByExample(example);
		System.out.println("qwwwwqqwqwq");
		System.out.println(result.toString());

		if (result.size() > 30)
			return result.subList(0, 30);
		else {
			return result;
		}
	}

	// 瀹楁暀鏂伴椈鑾峰彇
	public List<News> getReligionNews(String lang) {
		List<News> result = new ArrayList<News>();

		religionEntityExample example = new religionEntityExample();
		religionEntityExample.Criteria criteria = example.createCriteria();
		criteria.andLangEqualTo(lang);
		List<religionEntity> entities = rEntityMapper.selectByExample(example);

		EntityNewsRelationExample example2 = new EntityNewsRelationExample();

		for (religionEntity r : entities) {
			Integer id = r.getEntityId();
			example2.or().andEntity_idEqualTo(id);
		}

		example2.setOrderByClause("news_id DESC");
		List<EntityNewsRelation> list = entityNewsRelationMapper.selectByExample(example2);

		List<Integer> idList = new ArrayList<Integer>();

		for (EntityNewsRelation l : list) {
			if (idList.contains(l.getNews_id()))
				continue;
			idList.add(l.getNews_id());
			Integer newsID = l.getNews_id();
			result.add(newsMapper.selectByPrimaryKey(newsID));
		}

		System.out.println(result);
		return result;
	}

	// twitter处理

	// 展示Twitter
	public List<Twitter> getTwitter() {
		List<Twitter> result = twitterMapper.getTwitterNews();
		return result;
	}

	// 获取正负向比例
	public List<TwitterGroup> getTwitterGroup() {
		List<TwitterGroup> result = twitterMapper.getTwitterGroup();
		return result;
	}

	// 获取推特作者
	public List<TwitterAuthor> getTwitterAuthor() {
		List<TwitterAuthor> result = twitterMapper.getTwitterAuthor();
		return result;
	}

	// 根据ID获取推特内容
	public String getTwitterContent(Integer id) {
		Twitter twitter = twitterMapper.selectByPrimaryKey(id);
		String content = twitter.getContent();
		return content;
	}

	// 根据作者获取其推特
	public List<Twitter> getTwitterByAuthor(String author) {
		List<Twitter> result = new ArrayList<Twitter>();
		TwitterExample example = new TwitterExample();
		TwitterExample.Criteria criteria = example.createCriteria();
		criteria.andNameEqualTo(author);
		result = twitterMapper.selectByExample(example);
		return result;
	}
}
