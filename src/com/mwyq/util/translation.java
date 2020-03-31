package com.mwyq.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mwyq.controller.TopController;

import net.sf.json.JSONObject;

/*
 * RNN 缈昏瘧鎺ュ彛
 * liwei
 * 2018/8/4
 * */

public class translation {

	// public static String URLZang = "http://10.10.130.152:10008/chatbot?query=";
	// public static String URLZang = "http://10.10.130.152:5000/zang_han_article";
	// public static String URLZang = "http://10.119.130.187:5000/zang_han_article";
	// public static String URLZang = "http://10.10.130.152:5000/zang_han";
	// public static String URLWei = "http://10.10.130.152:5000/wei_han";
	// public static String URLWei = "http://10.119.130.187:5000/wei_han_article";
	public static String URLZang = "http://10.119.130.185:5000/translator/translate_ti2zh_article";
	public static String URLWei = "http://10.119.130.185:5000/translator/translate_uy2zh_article";
	public static String URL_WEIBO = "http://10.119.130.185:5000/translator/translate_ti2zh_paragraph";
	
	private static Logger logger = LoggerFactory.getLogger(translation.class);


	/**
	 * get璇锋眰
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 *             钘忚缈昏瘧
	 */
	public String doGetZang(String param) {
		param = param.replace("་", "་ ");
		String url = "";
		try {
			param = URLEncoder.encode(param, "utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return "";
		}
		url = URLZang + param;
		try {
			HttpClient client = new DefaultHttpClient();
			// 鍙戦�乬et璇锋眰
			HttpGet request = new HttpGet(url);
			HttpResponse response = client.execute(request);
			/** 璇锋眰鍙戦�佹垚鍔燂紝骞跺緱鍒板搷搴� **/
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				/** 璇诲彇鏈嶅姟鍣ㄨ繑鍥炶繃鏉ョ殑json瀛楃涓叉暟鎹� **/
				String strResult = EntityUtils.toString(response.getEntity());
				return strResult;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "";
	}

	/**
	 * get璇锋眰
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 *             缁磋缈昏瘧
	 */
	public String doGetWei(String param) {
		String url = "";

		url = URLWei + "?" + param;
		try {
			HttpClient client = new DefaultHttpClient();
			// 鍙戦�乬et璇锋眰
			HttpGet request = new HttpGet(url);
			HttpResponse response = client.execute(request);

			/** 璇锋眰鍙戦�佹垚鍔燂紝骞跺緱鍒板搷搴� **/
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				/** 璇诲彇鏈嶅姟鍣ㄨ繑鍥炶繃鏉ョ殑json瀛楃涓叉暟鎹� **/
				String strResult = EntityUtils.toString(response.getEntity());

				return strResult;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "";
	}

	public String sendPostZang(String content) {

		String url = URLZang;

		// content = content.replace("嗉�","嗉� ");

		JSONObject param = new JSONObject();
		param.put("query_string", content);

		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			// 鎵撳紑鍜孶RL涔嬮棿鐨勮繛鎺�
			URLConnection conn = realUrl.openConnection();
			// 璁剧疆閫氱敤鐨勮姹傚睘鎬�
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Accept-Charset", "UTF-8");

			// 鍙戦�丳OST璇锋眰蹇呴』璁剧疆濡備笅涓よ
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 鑾峰彇URLConnection瀵硅薄瀵瑰簲鐨勮緭鍑烘祦
			out = new PrintWriter(conn.getOutputStream());
			// 鍙戦�佽姹傚弬鏁�
			out.print(param);
			// flush杈撳嚭娴佺殑缂撳啿
			out.flush();
			// 瀹氫箟BufferedReader杈撳叆娴佹潵璇诲彇URL鐨勫搷搴�
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			line = in.toString();
			while ((line = in.readLine()) != null) {
				result += line;
			}

			JSONObject json = JSONObject.fromObject(result);
			result = json.getString("result");

		} catch (Exception e) {
			System.out.println("鍙戦�� POST 璇锋眰鍑虹幇寮傚父锛�" + e);
			e.printStackTrace();
		}
		// 浣跨敤finally鍧楁潵鍏抽棴杈撳嚭娴併�佽緭鍏ユ祦
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}

		System.out.println(result);
		// result = unicodeToCn(result);
		// System.out.println(result);

		result = result.replace(" ", "");
		return result;
	}

	public String sendPostWei(String content) {
		String url = URLWei;
		JSONObject param = new JSONObject();
		param.put("query_string", content);
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			URLConnection conn = realUrl.openConnection();
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			out = new PrintWriter(conn.getOutputStream());
			out.print(param);
			out.flush();
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			line = in.toString();
			while ((line = in.readLine()) != null) {
				result += line;
			}
			JSONObject json = JSONObject.fromObject(result);
			result = json.getString("result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		result = result.replace(" ", "");
		return result;
	}
	
	//调用翻译接口
	public String sendPost(String content,String lang) {
		String url = null;
		if(lang.equals("wei")) {
			url = URLWei;
		}
		else if(lang.equals("zang")) {
			url = URLZang;
		}else if(lang.startsWith("weibo_")){
			url = URL_WEIBO;
		}else {
			return null;
		}
		JSONObject param = new JSONObject();
		param.put("query_string", content);
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			URLConnection conn = realUrl.openConnection();
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			out = new PrintWriter(conn.getOutputStream());
			out.print(param);
			out.flush();
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			line = in.toString();
			while ((line = in.readLine()) != null) {
				result += line;
			}
			logger.info("result={}",result);
			JSONObject json = JSONObject.fromObject(result);
			result = json.getString("result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		if(StringUtils.isNotBlank(result)) {
			result = result.replace(" ", "");			
		}
		return result;
	}
}
