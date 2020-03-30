package com.mwyq.util;

import java.util.HashMap;

/*
 * liwei
 * 2018/8/6
 * 传入维文
 * 输出拉丁
 * */

public class weiTola {
	public static String zhuanLatin(String content) {
		// TODO Auto-generated method stub
		String result = "";
		
		HashMap<String, String> weiAlph = new HashMap<String,String>();
		weiAlph.put("ا", "a");
		weiAlph.put("ئ", "a");
		weiAlph.put("ە", "e");
		weiAlph.put("ئە", "e");
		weiAlph.put("ب", "b");
		weiAlph.put("پ", "p");
		weiAlph.put("ت", "t");
		weiAlph.put("ج", "j");
		weiAlph.put("چ", "ch");
		weiAlph.put("خ", "x");
		weiAlph.put("د", "d");
		weiAlph.put("ر", "r");
		weiAlph.put("ز", "z");
		weiAlph.put("ژ", "zh");
		weiAlph.put("س", "s");
		weiAlph.put("ش", "sh");
		weiAlph.put("غ", "gh");
		weiAlph.put("ف", "f");
		weiAlph.put("ق", "q");
		weiAlph.put("ك", "k");
		weiAlph.put("گ", "g");
		weiAlph.put("ڭ", "ng");
		weiAlph.put("ل", "l");
		weiAlph.put("م", "m");
		weiAlph.put("ن", "n");
		weiAlph.put("ھ", "h");
		weiAlph.put("و", "o");
		weiAlph.put("ئو", "o");
		weiAlph.put("ۇ", "u");
		weiAlph.put("ئۇ", "u");
		weiAlph.put("ۆ", "ö");
		weiAlph.put("ئۆ", "ö");
		weiAlph.put("ۈ", "ü");
		weiAlph.put("ئۈ", "ü");
		weiAlph.put("ۋ", "w");
		weiAlph.put("ې", "ë");
		weiAlph.put("ئې", "ë");
		weiAlph.put("ى", "i");
		weiAlph.put("ئى", "i");
		weiAlph.put("ي", "y");
		
		for(int x = 0; x < content.length(); x++){
			char c = content.charAt(x);
			String s1 = c + "";
			
			String temp = weiAlph.get(s1);
			
			if(temp==null){
				result = result + c;
			}	
			else{
				result = result + temp;
			}
		}
		return result;
		
	}
}
