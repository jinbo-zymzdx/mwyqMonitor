package com.mwyq.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.alibaba.fastjson.JSON;

import net.sf.json.JSONObject;

/*
 * Author:liwei
 * 实现HashMap按值排序
 * */

public class mapSorted {
	public static JSONObject mapSorted(Map<String, Integer> map) {
        
        List<Map.Entry<String,Integer>> list = new ArrayList<Map.Entry<String,Integer>>(map.entrySet());
        Collections.sort(list,new Comparator<Map.Entry<String,Integer>>() {
            //升序排序
            public int compare(Entry<String, Integer> o1,
                    Entry<String, Integer> o2) {
                return o1.getValue().compareTo(o2.getValue());
            }
            
        });
   
		JSONObject jsonObj = new JSONObject();
        
        for(Map.Entry<String,Integer> mapping:list){ 
        		jsonObj.put(mapping.getKey(), mapping.getValue());
               
          } 
        return jsonObj;
	}
}
