package com.mwyq.util;

import java.util.HashMap;
import java.util.Map;

public class CommonUtils {
	
	public final static Map<String, String> New_Sensitive_Map = new HashMap<String,String>() {{
		put("0","正向新闻");
		put("1","中性新闻");
		put("2","敏感新闻");
	}};
	
	public final static Map<String, String> New_Range_Map = new HashMap<String,String>() {{
		put("all","全部新闻");
		put("year","过去一年");
		put("month","过去一月");
		put("week","过去一周");
	}};
	
	public final static Map<String, String> WeiBo_Emotion_Map = new HashMap<String,String>() {{
		put("0","全部");
		put("1","负面");
		put("2","中性");
		put("3","正面");
	}};
	
	public final static Map<String, String> WeiBo_Emotion_Color = new HashMap<String,String>() {{
		put("负面","red");
		put("中性","blue");
		put("正面","green");
	}};

}
