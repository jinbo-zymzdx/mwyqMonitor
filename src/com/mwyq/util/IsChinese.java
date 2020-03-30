package com.mwyq.util;

public class IsChinese {
	
	public static final int unicodeCB=0x4e00;
	public static final int unicodeCE=0x9fbb;
	/**
	 * 根据字符串aStrings的   第一个代码点  判断这个是不是中文
	 */
	public static boolean isChinese2(String aString){
		int firstCodeInt=aString.codePointAt(0);
		aString=aString.trim();
		/**
		 * 三元表达式：
		 * 		 条件？a：b
		 */
		return firstCodeInt>unicodeCB&&firstCodeInt<unicodeCE?true:false;
	}
	/**
	 * 如果前10个字符中有中文，那么就判断为输入的是中文
	 * @param aString
	 * @return
	 */
	public static boolean isChinese(String aString){
		aString=aString.trim();
		aString=aString.replace(" ", "");
		int count=aString.length()>10?10:aString.length();
		for(int i=0;i<count;i++){
			if (aString.codePointAt(i)>unicodeCB&&aString.codePointAt(i)<unicodeCE) {
				return true;
			}
		}
		
		return false;
	}
	public static boolean isNumberChar(String aString){
		aString=aString.trim();
		if (aString.matches("[0-9\\-a-zA-Z ]{1,}")) {
			return true;
		}else {
			return false;
		}
	}
	public static boolean isNumber(String aString){
		aString=aString.trim();
		if (aString.matches("[0-9\\- ]{1,}")) {
			return true;
		}else {
			return false;
		}
	}
	public static boolean isChars(String aString){
		aString=aString.trim();
		if (aString.matches("[a-zA-Z. ]{1,}")) {
			return true;
		}else {
			return false;
		}
	}
	public static void main(String[] args) {
		String aString="10月15日上午9点，重庆沙坪坝一家小面馆围满了人。大家不是来吃面的，而是围着一位婆婆看。吸引大家注意的是老人脚上的一条铁链，脚踝处还有一把铁锁。此后赶到的民警将80多岁的老人想方设法送回家中。看到民警，老人的儿子一脸委屈，“我们不是虐待老人，母亲经常往外跑，有一次跑出去十天才把她找到。”民警告知张婆婆的家人，用铁链子把老人锁起来涉嫌虐待老人，子女多陪伴才是良";
		aString="12-34adfdd--asddfas123123";
		System.err.println(isNumber("201 90"));
	}
}
