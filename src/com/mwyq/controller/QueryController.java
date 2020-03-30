package com.mwyq.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;
import com.codetrans.mktoun.biz.MKtoUnicodeByRuleList;
import com.mwyq.model.Topic;
import com.mwyq.service.SolrService;
import com.mwyq.util.Indexes;
import com.mwyq.util.IsChinese;
import com.mwyq.util.NewsArr;
import com.mwyq.util.Utilities;

@RestController
@RequestMapping("/query")
public class QueryController {
	
	@Autowired
	public SolrService solrService;
	
	@RequestMapping(value ="/getResByKeyWord",method=RequestMethod.GET)
	public void getResByKeyWord(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Z: "+new String(request.getParameter("keyword").getBytes("iso-8859-1"),"utf-8"));
		System.out.println(request.getContextPath());
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		/**
		 * 定义中文Unicode编码的范围一开始是unicodeCB，结尾是unicodeCE
		 */
		int unicodeCB=0x4e00;
		int unicodeCE=0x9fbb;
		
		/**
		 * 乱码解决:
		 */
		
		String keyWord1=request.getParameter("keyword");
		System.out.println("setcharset:"+keyWord1);
		keyWord1=keyWord1.replace(":", " ");
		String parameter="";
		String keyword=keyWord1;//new String(keyWord1.getBytes("iso-8859-1"),"utf-8");
		keyword=keyword.trim();
		List<String>ids=new ArrayList<String>();
		/**
		 * 转成拉丁文进行查询工作
		 */
		SolrDocumentList resultDocumentList=null;
		parameter=keyword;
		String[] keywords=keyword.split("᠂");
		List<Topic> list=new ArrayList<Topic>();
		/**
		 * 记录一共找到了多少条记录
		 * 这里有可能有多个关键字要按照空格进行 split
		 */
		long resultCount=0;
		int start=1;
		long rows=Integer.valueOf(solrService.ROWS);
		boolean isCN=false;
		for(String keywordn:keywords){
			if(keywordn.endsWith("᠂")){
				keywordn=keywordn.substring(0, keywordn.length()-1);
			}
			System.out.println(keywordn+"转换前关键词");
			keywordn=MKtoUnicodeByRuleList.getUTF8String(keyword,true);
			System.out.println(keywordn+"转换Unicode");
			/**
			 * 判断是不是中文
			 */
			if (!IsChinese.isChinese(keywordn)) {
				keywordn=LatinToUnicodeRuleList.getLatinString(keywordn, true);
				System.out.println(keywordn+"转换后的拉丁");
			}
			/**
			 * 在solr的查询语句中，双引号代表结束符，所以如果拉丁转写中出现了双引号，那么就要进行转义，在变成字符'\"'
			 * '\'需要在它前面加上一个'\'作为'\'的语义转写，'"'又需要'\'来进行语义转写,所以最终replacement函数的第二个参数是"\\\""
			 */
			/**
			 * 会出现     ||标点符号#   这样的符号，需要过滤掉
			 */
			if (keywordn.indexOf("\"")>-1) {
				keywordn=keywordn.replace("\"", "\\\"");
			}
			try {
				/**
				 * 这里的start是第几页
				 */
				if (request.getParameter("start")!=null&&Integer.valueOf(request.getParameter("start"))>0) {
					start=Integer.valueOf(request.getParameter("start"));
				}
				/**	Unicode编码单元可以表示为16进制值，其范围是 \u0000 到 \uffff, 例如\u2122 表示注册符号（™）
				 * 利用Unicode编码来判断是中文还是蒙文，中文的Unicode编码范围是0x4e00--0x9fbb
				 * 		有两种方式来判断
				 * 			
				 * 			1、利用代码点返回这个编码的十进制整数，再利用Integer.toHexString(int a),或者String Integer.parseInt(String s,int radix)将这个整数
				 * 				转换成一个16进制的字符串，但是要想比较这两个16进制的值，还得再把这个字符串转为16进制整数比较.
				 * 			
				 * 			2、由于中文的Unicode的编码范围是0x4e00--0x9fbb，那么将这个16进制转换成10进制，直接和代码点的十进制比较即可。
				 * 		
				 * 		这里采用第2种
				 */
				/**
				 * 根据第一个代码点（字符）的Unicode对应的10进制编码判断是不是中文
				 */
				if (IsChinese.isChinese(keywordn)) {
					/**
					 * 是中文
					 */
					System.out.println("中文搜索");
					isCN=true;
					resultDocumentList=solrService.queryResponseCN(keywordn,start);
					
				}else{
					System.out.println("非中文搜索！！！！！");
					resultDocumentList=solrService.queryResponse(keywordn,start);
				}
				
//				}
			} catch (SolrServerException e) {
				e.printStackTrace();
			}
			if(resultDocumentList==null||resultDocumentList.size()==0){
				/**
				 * 没有结果
				 */
				rows=0;
				continue;
			}else{
				resultCount+=resultDocumentList.getNumFound();
				for(SolrDocument doc:resultDocumentList){
					String timeString=doc.getFieldValue("news_time").toString();
					if(timeString.split(" ")[0].length()<4){
						timeString=timeString.split(" ")[1];
					}else{
						timeString=timeString.split(" ")[0];
					}
					if(ids.contains(doc.getFieldValue("id").toString())){
						continue;
					}
					Topic topic=new Topic();
					String topic_name=doc.getFieldValue("news_title").toString();
					topic.setTopic_name(topic_name);
					topic.setProducedtime(Date.valueOf(timeString));
					topic.setTopic_id(doc.getFieldValue("id").toString());
					topic.setNews_count(Integer.valueOf(doc.getFieldValue("news_count").toString()));
					ids.add(doc.getFieldValue("id").toString());
					String news_content=doc.getFieldValue("news_content").toString();
					/**
					 * 返回前10个单词
					 */
					String content=Utilities.topNWords(news_content, 10,isCN);
					String news_cont=content.replaceAll(" +", " ");
				    topic.setNews_content(news_cont);

					list.add(topic);
				}	
			}
		}
		/**
		 * pageCount:是一共多少页
		 */
		System.out.println("rows: "+rows+"resultCount: "+resultCount);
		long pageCount=0;
		if (rows!=0) {
			pageCount=resultCount/rows;
			
			if (resultCount%rows!=0) {
				pageCount+=1;
			}
		}
		/**
		 * 如果大于10页
		 * 如果起始页大于3，那么把前三页的显示出来
		 * 设置好返回的页码
		 * 
		 */
		long beginNum=1;
		long endNum=10;
		if (start>3) {
			beginNum=start-3;
			endNum=pageCount>=start+6?start+6:pageCount;
		}else{
			beginNum=1;
			endNum=pageCount>=10?10:pageCount;
		}
		System.out.println("一共有"+(endNum-beginNum)+"个页码");
		/**
		 * parameter 就是最顶上的keywordn
		 */
		request.setAttribute("start2", start);
		request.setAttribute("parameter2", parameter);
		if (start>1) {
			request.setAttribute("lastPage",start-1);
		}
		List<Indexes>indexesList=new ArrayList<>();
		for (long i = beginNum; i <=endNum ; i++) {
			System.err.println(i+"   "+start);
			if (i==start) {
				System.err.println("i==start");
				indexesList.add(new Indexes(i, parameter,"<font color='red'>"+i+"</font>"));
			}else {
				indexesList.add(new Indexes(i, parameter,i+""));
			}
			
		}
		if (start<pageCount) {
			request.setAttribute("nextPage",start+1);
		}
		
		List<NewsArr> arrList = new ArrayList<NewsArr>();
		request.setAttribute("listSize",resultCount);
		request.setAttribute("list", list);
		request.setAttribute("indexesList", indexesList);
		request.setAttribute("keyword", keyword);
		ids.clear();
//		solrService.close();
		request.getRequestDispatcher("/list.jsp").forward(request, response);
	}
}
