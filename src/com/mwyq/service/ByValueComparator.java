package com.mwyq.service;

import java.util.Comparator;
import java.util.HashMap;

public class ByValueComparator implements Comparator<String>{
	HashMap<String,Integer> base_map;
	public ByValueComparator(HashMap<String,Integer> base_map){
		this.base_map = base_map;
	}
	public int compare(String arg0,String arg1){
		if(!base_map.containsKey(arg0)||!base_map.containsKey(arg1)){
			return 0;
		}
		if(base_map.get(arg0)<base_map.get(arg1)){
			return 1;
		}else if(base_map.get(arg0)==base_map.get(arg1)){
			return 0;
		}else{
			return -1;
		}
	}

}