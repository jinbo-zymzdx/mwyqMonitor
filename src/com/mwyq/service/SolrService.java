package com.mwyq.service;

import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Service;

@Service
public class SolrService {

	private String url="http://192.168.1.104:8080/solr";
//	private String url="http://localhost:8080/solr";
	private HttpSolrServer server=null;
	/**
	 * ROWS:每一页显示多少
	 */
	public final static int ROWS=20;
	private final static int NULLCOUNT=20;
	private final static long MAXIMUMROWS=20;//
	private final static String DisableChars="|~!@$%^&*()_+={}:\";''.,/<>?";
	public static int getROWS(){
		return ROWS;
	}
	public SolrService() {
		//this.server=new HttpSolrServer(url);
	}
	public SolrDocumentList queryResponse(String queryParam,int start) throws SolrServerException{
		/**
		 * 按照keywords进行查询
		 * @param start:第几页
		 * 如果是查找video的话，只查找new_title;如果是查找内容的话news_title和news_content都要找
		 */
		/*queryParam=queryParam.replaceAll("\\|\\|[^#]*#","").trim();*/
		System.err.println(queryParam);
		for (int i = 0; i < DisableChars.length(); i++) {
			String c=String.valueOf(DisableChars.charAt(i));	
			if (queryParam.indexOf(c)>-1) {
				queryParam=queryParam.replace(c," ");
			}
		}
		ModifiableSolrParams params=new ModifiableSolrParams();
		start=(start-1)*ROWS;
		if (start<0) {
			start=0;
		}
		/**
		 * 可以先查找，如果有的话返回，如果没有的话再进行替换后的查找
		 */
		QueryResponse response=null;
		if (queryParam!=null&&queryParam.trim().length()>0) {			
			queryParam="\""+queryParam+"\"~10";
			String queryString="title_lading:"+queryParam;
			params.set("q",queryString);
			params.set("start",start);
			params.set("rows",String.valueOf(MAXIMUMROWS));
			System.out.println(queryParam);
			params.set("sort", "news_time desc");
			System.out.println(queryParam);
			System.err.println(params);
			response=this.server.query(params);
			SolrDocumentList solrDocumentList=response.getResults();
			if (solrDocumentList!=null&&solrDocumentList.size()>0) {
				return solrDocumentList;//response.getResults();
			}else {
				return null;
			}
		}
		queryParam=queryParam.replaceAll("\\|\\|[^#]*#"," ").trim();
		System.out.println("split之后查询关键词为："+queryParam);
		
		if (queryParam==null||queryParam.trim().length()==0) {
			/**
			 * 参数不存在，指定start为0
			 */
			return null;
		}else{
			String queryPa="\""+queryParam+"\"~10";
			String queryString="title_lading:"+queryPa;//+" OR content_lading:"+queryPa;
			params.set("q",queryString);
			params.set("start",start);
			params.set("rows",String.valueOf(MAXIMUMROWS));
			params.set("sort", "news_time desc");
			response=this.server.query(params);
			SolrDocumentList solrDocumentList=response.getResults();
			/**
			 * 说明光查标题就可以全部查出来，那么就不用查内容了
			 */
			return solrDocumentList;//response.getResults();
		}
	}
	public SolrDocumentList queryResponse_video(String queryParam,int start) throws SolrServerException{
		/**
		 * 按照keywords进行查询
		 * @param start:第几页
		 * 如果是查找video的话，只查找new_title;如果是查找内容的话news_title和news_content都要找
		 */

		StringBuffer stringBuffer=new StringBuffer();
		stringBuffer.append("\\");
		stringBuffer.append("a");
		for (int i = 0; i < DisableChars.length(); i++) {
			char c=DisableChars.charAt(i);
			if (queryParam.indexOf(c)>-1) {
				stringBuffer.setCharAt(1, c);
				queryParam=queryParam.replace(c+""," ");
				
			}
		}
		ModifiableSolrParams params=new ModifiableSolrParams();

		start=(start-1)*ROWS;
		if (start<0) {
			start=0;
		}
		/**
		 * 可以先查找，如果有的话返回，如果没有的话再进行替换后的查找
		 */
		QueryResponse response=null;
		if (queryParam!=null&&queryParam.trim().length()>0) {
			
			queryParam="\""+queryParam+"\"~10";

			String queryString="title_lading:"+queryParam;
			System.out.println(queryString);
			
			
			params.set("q",queryString);
			params.set("start",start);
			params.set("rows",String.valueOf(ROWS));
			params.set("sort", "news_time desc");
			response=this.server.query(params);
			params.clear();
			if (response!=null&&response.getResults().size()>0) {
				System.out.println("there is no need to replace the content of the parameters");
				return response.getResults();
			}else {
				System.out.println("");
			}
		}
		
		System.out.println("queryResonpse_vide queryParam :"+queryParam+"+++");
		
		
		if (queryParam==null||queryParam.trim().length()==0) {
			/**
			 * 参数不存在，指定start为0
			 */

			return null;
		}else{
			
			queryParam="\""+queryParam+"\"~10";

			String queryString="title_lading:"+queryParam;
			
			
			
			params.set("q", queryString);
			/**
			 * 这里的id就是topic_id 
			 */
			params.set("start",start);
			params.set("rows",String.valueOf(ROWS));
			params.set("sort", "news_time desc");
			response=this.server.query(params);
			params.clear();
			return response.getResults();
		}
	}
	/**
	 * 用于中文搜索，所有的title_lading 改成  news_title, content_lading 改成 news_content
	 */
	public SolrDocumentList queryResponseCN(String queryParam,int start) throws SolrServerException{
		/**
		 * 按照keywords进行查询
		 * @param start:第几页
		 * 如果是查找video的话，只查找new_title;如果是查找内容的话news_title和news_content都要找
		 */
		queryParam=queryParam.replaceAll("[|,#]"," ").trim();
		queryParam=queryParam.replaceAll(" {2,}"," ").trim();
		for (int i = 0; i < DisableChars.length(); i++) {
			String c=String.valueOf(DisableChars.charAt(i));	
			if (queryParam.indexOf(c)>-1) {
				queryParam=queryParam.replace(c," ");
			}
		}
		ModifiableSolrParams params=new ModifiableSolrParams();
		start=(start-1)*ROWS;
		if (start<0) {
			start=0;
		}
		/**
		 * 可以先查找，如果有的话返回，如果没有的话再进行替换后的查找
		 */
		QueryResponse response=null;
		if (queryParam!=null&&queryParam.trim().length()>0) {
			
			
			queryParam="\""+queryParam+"\"~10";
			String queryString="news_title:"+queryParam;
			/**
			 * 参数存在从指定的start开始查询20个结果
			 */
			params.set("q",queryString);
			params.set("start",start);
			params.set("rows",String.valueOf(MAXIMUMROWS));
			params.set("sort", "news_time desc");
			response=this.server.query(params);
			params.clear();
			if (response!=null&&response.getResults().size()>0) {
				System.out.println("there is no need to replace the content of the parameters");
				return response.getResults();
			}else {
				System.out.println("原始查询无果");
			}
			
			
		}
		System.out.println("split之后查询关键词为："+queryParam);
		
		if (queryParam==null||queryParam.trim().length()==0) {
			/**
			 * 参数不存在，指定start为0
			 */
			return null;
		}else{
			System.out.println("相同内容");

			return null;
		}
	}
	
	public SolrDocumentList queryResponse_videoCN(String queryParam,int start) throws SolrServerException{
		/**
		 * 按照keywords进行查询
		 * @param start:第几页
		 * 如果是查找video的话，只查找new_title;如果是查找内容的话news_title和news_content都要找
		 */
		queryParam=queryParam.replaceAll("[|,#]"," ").trim();
		queryParam=queryParam.replaceAll(" {2,}"," ").trim();
		StringBuffer stringBuffer=new StringBuffer();
		stringBuffer.append("\\");
		stringBuffer.append("a");
		for (int i = 0; i < DisableChars.length(); i++) {
			char c=DisableChars.charAt(i);//String.valueOf(DisableChars.charAt(i));
			if (queryParam.indexOf(c)>-1) {
				stringBuffer.setCharAt(1, c);
				queryParam=queryParam.replace(c+""," ");
			}
		}
		ModifiableSolrParams params=new ModifiableSolrParams();
		
		
		start=(start-1)*ROWS;
		if (start<0) {
			start=0;
		}
		/**
		 * 可以先查找，如果有的话返回，如果没有的话再进行替换后的查找
		 */
		QueryResponse response=null;
		if (queryParam!=null&&queryParam.trim().length()>0) {
			
			queryParam="\""+queryParam+"\"~10";
//			String queryString="has_video:1 AND news_title:"+queryParam;
			String queryString="news_title:"+queryParam;
			
			System.out.println(queryString);
			
			
			params.set("q",queryString);
			params.set("start",start);
			params.set("rows",String.valueOf(ROWS));
			params.set("sort", "news_time desc");
			response=this.server.query(params);
			params.clear();
			if (response!=null&&response.getResults().size()>0) {
				System.out.println("there is no need to replace the content of the parameters");
				return response.getResults();
			}else {
				System.out.println("");
			}
		}
		
		System.out.println("queryResonpse_vide queryParam :"+queryParam+"+++");
		
		
		if (queryParam==null||queryParam.trim().length()==0) {
			/**
			 * 参数不存在，指定start为0
			 */
			return null;
		}else{
			
			queryParam="\""+queryParam+"\"~10";
			
//			String queryString="has_video:1 AND news_title:"+queryParam;
			String queryString="news_title:"+queryParam;
			
			
			
			params.set("q", queryString);
			/**
			 * 这里的id就是topic_id 
			 */
			params.set("start",start);
			params.set("rows",String.valueOf(ROWS));
			params.set("sort", "news_time desc");
			response=this.server.query(params);
			params.clear();
			return response.getResults();
		}
	}
//	public void close(){
//		this.server.shutdown();
//	}
}
