package com.mwyq.util;

import java.awt.Stroke;

public class Utilities {
	/**
	 * 如果中文或者类似中文需要分词的话返回前80个文字，如果是不需要分词，本身由空格隔开的话返回前n个单词，如果不够那么全部返回
	 * @param aString
	 * @return
	 */
	public static final int unicodeCB=0x4e00;
	public static final int unicodeCE=0x9fbb;
	/**@parameter isCN:判断是不是中文
	 * 根据字符串aStrings的第一个代码点判断这个是不是中文
	 */
	
	public static String topNWords (String aString,int n,Boolean isCN) {
		aString=aString.trim();
		/**
		 * 如果是中文
		 */
		if (isCN) {
			return aString.length()>80?aString.substring(0,81):aString;
		}
		/**
		 * 如果不是中文，那么就从第120个字符，往回数，遇到第一个空格结束，返回
		 */
		int contentLength=250;
		if (aString.length()<=contentLength) {
			return aString;
		}
		while(contentLength>0){
			if (aString.charAt(contentLength)=='\u00A0'||aString.charAt(contentLength)=='\u0020') {
				System.err.println("find space");
				return aString.substring(0,contentLength);
			}else contentLength--;
		}
		if (contentLength==0) {
			System.err.println("not find space");
			return aString;
		}
		return aString.substring(0,contentLength);
	}
	/**
	 * 按照空格来分
	 * @param aString
	 * @param n ：前n个单词
	 * @param isCN ：是不是中文，是中文的话直接取得<=80个字符
	 * @return
	 */
	public static String topNWords2 (String aString,int n,Boolean isCN) {
		aString=aString.trim();
		if (isCN) {
			return aString.length()>80?aString.substring(0,81):aString;
		}
		int begin=0;
		int wordsCount=0;
		int tempBegin=0;
		/**
		 * 如果是中文
		 */
		while(wordsCount<n){
			tempBegin=aString.indexOf("\u00A0",begin+1)==-1?aString.indexOf("\u0020",begin+1):aString.indexOf("\u00A0",begin+1);
			if (tempBegin!=-1) {
				begin=tempBegin;
			}else{
				return aString;
			} 	
			wordsCount++;
		}
		return aString.substring(0,begin);
	}
	public static void main(String[] args) {
		System.out.println("--"+topNWords("abcdefd efrg asdf asdf adf",11,false)+"---");
//		"++"+top10Words(" 1abc 2def 3abc 4def 5abc 6def 7abc 8def 9abc 10def 11abc 12def 13abc 14def  15abc 16def "));
	}
	/**
	 * 判断前10个字符，只要里面有中文就判断它搜索中文
	 */
	public static boolean isCN(String aString){
	
		int firstCodeInt=aString.codePointAt(0);
		aString=aString.trim();
		/**
		 * 三元表达式：
		 * 		 条件？a：b
		 */
		int count=aString.length()>10?10:aString.length();
		for(int i=0;i<count;i++){
			if (firstCodeInt>unicodeCB&&firstCodeInt<unicodeCE) {
				return true;
			}
		}
		
		return false;
	}
}
