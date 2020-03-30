<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>新闻内容</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/resources/css/bootstrap_min.css" />
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/resources/css/timeline.css" />
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/resources/css/templatemo_justified.css" />
		
	<script
		src="<%=request.getContextPath()%>/resources/js/jquery-1.7.2.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/js/bootstrap-modal.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/js/bootstrap-dialog.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
	
	<script
		src="<%=request.getContextPath()%>/resources/js/index/html5shiv.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/js/index/respond.min.js"></script>
		<script
		src="<%=request.getContextPath()%>resources/js/echarts/echarts.js"></script>
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

	<link href="/resources/css/main.css" rel="stylesheet">
	<link href="/resources/css/bootstrap.css" rel="stylesheet">
	<link href="/resources/css/style.css" rel="stylesheet">

	<script type="text/javascript">
	require.config({
	    paths: {
	        echarts: 'http://echarts.baidu.com/build/dist'
	    }
	});
	
	// 使用
	require(
	    [
	        'echarts',
	        'echarts/chart/wordCloud',
	       
	        // 使用柱状图就加载bar模块，按需加载
	    ],
	    function (ec) {
	        // 基于准备好的dom，初始化echarts图表
	       
	        var myChart1 = ec.init(document.getElementById('ciyun1')); 
	        var myChart2 = ec.init(document.getElementById('ciyun2')); 
	        var myChart3 = ec.init(document.getElementById('ciyun3'));
	        
	        
	        function createRandomItemStyle() {
			    return {
			        normal: {
			            color: 'rgb(' + [
			                Math.round(Math.random() * 160),
			                Math.round(Math.random() * 160),
			                Math.round(Math.random() * 160)
			            ].join(',') + ')'
			        }
			    };
			}
	      
	        var keys_per=[];
			var values_per=[];
			 $.ajax({
			 	type:"get",
			 	async:false,
			 	url:"${request.contextPath}/mwyqMonitor/topic/${newsId}/getEntityPerKey",
			 	//url:"http://localhost:8080/mwyqMonitor/topic/92907/getEntityPerKey",
			 	dataType:"json",
			 	success:function(result){
			 		if(result){
			 			for(var i in result){
			 				keys_per.push(i);
			 				values_per.push(result[i]);
			 			}
			 		}
			 	}
			 });
			 
				option1 = {
				
				noDataLoadingOption:{
			        		text:'正在等待请求数据',
					        		effect:'bubble',
				        		effectOption:{
				        			effect:{
				        				n:0
				        			}
				        		}
				        	},      
				tooltip: {
				        show: true
				    },
				    series: [{
				      //  name: '中央民族大学',
				        type: 'wordCloud',
				        size: ['80%', '80%'],
				        textRotation : [0, 45, 90, -45],
				        textPadding: 0,
				        autoSize: {
				            enable: true,
				            minSize: 14
				        },
				        data:	
		            		(function(){
			        		var res=[];
			        		var len=keys_per.length;
			        		while(len--){
			        			res.push({
			        				name:keys_per[len],
			        				value:Math.round(Math.random() * 1000),
			        				itemStyle: createRandomItemStyle()	
			        			});
			        		}
			        		return res;
			        	})()
				    }]
				};
				
				var keys_loc=[];
				var values_loc=[];
				 $.ajax({
				 	type:"get",
				 	async:false,
				 	url:"${request.contextPath}/mwyqMonitor/topic/${newsId}/getEntityLocKey",
				 	dataType:"json",
				 	success:function(result){
				 		if(result){
				 			for(var i in result){
				 				keys_loc.push(i);
				 				values_loc.push(result[i]);
				 			}
				 		}
				 	}
				 });
				option2 = {
						
						noDataLoadingOption:{
					        		text:'正在等待请求数据',
							        		effect:'bubble',
						        		effectOption:{
						        			effect:{
						        				n:0
						        			}
						        		}
						        	},      
						tooltip: {
						        show: true
						    },
						    series: [{
						      //  name: '中央民族大学',
						        type: 'wordCloud',
						        size: ['80%', '80%'],
						        textRotation : [0, 45, 90, -45],
						        textPadding: 0,
						        autoSize: {
						            enable: true,
						            minSize: 14
						        },
						        data:	
				            		(function(){
					        		var res=[];
					        		var len=keys_loc.length;
					        		while(len--){
					        			res.push({
					        				name:keys_loc[len],
					        				value:Math.round(Math.random() * 1000),
					        				itemStyle: createRandomItemStyle()	
					        			});
					        		}
					        		return res;
					        	})()
						    }]
						};
				
				var keys_org=[];
				var values_org=[];
				 $.ajax({
				 	type:"get",
				 	async:false,
				 	url:"${request.contextPath}/mwyqMonitor/topic/${newsId}/getEntityOrgKey",
				 	dataType:"json",
				 	success:function(result){
				 		if(result){
				 			for(var i in result){
				 				keys_org.push(i);
				 				values_org.push(result[i]);
				 			}
				 		}
				 	}
				 });
				option3 = {
						
						noDataLoadingOption:{
					        		text:'正在等待请求数据',
							        		effect:'bubble',
						        		effectOption:{
						        			effect:{
						        				n:0
						        			}
						        		}
						        	},      
						tooltip: {
						        show: true
						    },
						    series: [{
						      //  name: '中央民族大学',
						        type: 'wordCloud',
						        size: ['80%', '80%'],
						        textRotation : [0, 45, 90, -45],
						        textPadding: 0,
						        autoSize: {
						            enable: true,
						            minSize: 14
						        },
						        data:	
				            		(function(){
					        		var res=[];
					        		var len=keys_org.length;
					        		while(len--){
					        			res.push({
					        				name:keys_org[len],
					        				value:Math.round(Math.random() * 1000),
					        				itemStyle: createRandomItemStyle()	
					        			});
					        		}
					        		return res;
					        	})()
					        	
						          
						    }]
						};
		 // 为echarts对象加载数据 
	        myChart1.setOption(option1); 
	        myChart2.setOption(option2);
	        myChart3.setOption(option3);
	    }
	);
	</script>
</head>

<body style="font-family: Menksoft2007;">
	<div id="container" class="container" style="float:left;">
		<img src="<%=request.getContextPath()%>/resources/images/templatemoheader.jpg"
			class="img-responsive" style="height: 10%;" />
		<ul class="nav nav-justified bd" style="height:60px;padding-left:50px;">
			<li style="width:200px;"><a href="/mwyqMonitor/topic/">&nbsp;&nbsp;首 &nbsp;&nbsp;页 &nbsp;&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/news/">&nbsp;实时热点&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/statis/">&nbsp;统计分析&nbsp;</a></li>
			<li style="width:200px;"><a href="/baidu/">&nbsp;&nbsp;搜 &nbsp;&nbsp;索 &nbsp;&nbsp;</a></li>
		</ul>

		<div style="word-break:keep-all;float:left;height:75%;width:60%;margin-top:20px;border:1px solid #e3e3e3;border-radius:4px;margin-left:10%;">
			<c:forEach items="${topicNewsContent }" var="topicNewsContent">
				<c:choose>
					<c:when test="${topicNewsContent.lang_type == 'cn' }">
						<table class="news-content-tab" style="height: 98%;width: 95%;margin-left: 2%;">
							<tr>
								<td>
									<div class="news-title" style="text-align: center;">
										<h3 id="title" style="color: #1874CD; word-wrap: break-word; white-space: normal;">${topicNewsContent.news_title }</h3>
									</div>
								</td>
							</tr>
							<tr>
								<td style="height: 40px;">
									<div class="news-time-source" style="text-align: center;">
										<h5>
											<fmt:formatDate value="${topicNewsContent.news_time}" type="date" pattern="yyyy-MM-dd" />
										</h5>
									</div>
								</td>
							</tr>
							<tr>
								<td style="height: 40px;">
									<div class="news-time-source" style="text-align: center;">
										<h5>
											${topicNewsContent.news_url}
										</h5>
									</div>
								</td>
							</tr>
							<tr>
								<td style="vertical-align: top;">
									<!-- 判断是不是中文，是中文的话 横排显示，否则默认不懂 -->
									<div class="news-content">
										<div style="padding: 5px; margin-bottom: 5px; min-width: 300px;">
											<div id="content" style="font-size: 20px; word-wrap: break-word; width: 100%; height:600px;text-align: top; vertical-align: top; margin: 0 15px 12px 12px; padding: 5px; min-width: 300px; line-height: 1.4;  overflow-x: hidden; overflow-y: scroll;">
												${topicNewsContent.news_content }</div>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<table class="news-content-tab" style="height: 98%;">
							<tr>
								<td>
									<div class="news-title" style="height: 590px; text-align: center; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr;">
										<h3 id="title" style="color: #1874CD; word-wrap: break-word; white-space: normal;">${topicNewsContent.news_title }</h3>
									</div>
								</td>
								<td>
									<div class="news-time-source" style="height: 590px; text-align: center; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr;">
										<h5>
											<fmt:formatDate value="${topicNewsContent.news_time}" type="date" pattern="yyyy-MM-dd" />
										</h5>
									</div>
								</td>
								<td>
									<div class="news-time-source" style="height: 590px; text-align: center; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr;">
										<h5>${topicNewsContent.news_url}</h5>
									</div>
								</td>
								<td>
									<!-- 判断是不是中文，是中文的话 横排显示，否则默认不懂 -->
									<div class="news-content">
										<div style="height: 590px; padding: 5px; margin-bottom: 5px; min-width: 300px;">
											<div id="content" style="height: 570px; font-size: 20px; word-wrap: break-word; width: 700px; text-align: top; vertical-align: top; margin: 0 15px 12px 12px; padding: 5px; min-width: 300px; line-height: 1.4; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr; overflow-x: auto; overflow-y: hidden;">
												${topicNewsContent.news_content }</div>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div style="float: left; height: 75%; margin-top:20px; border: 1px solid #e3e3e3; border-radius: 4px; margin-left:10px;width:20%;">
			<table style="height: 100%; width: 100%">
				<tr>
					<td>
						<div class="col-md-13" style="width:100%; height: 97%;">
							<div class="new-des  bd">
								<div class="panel panel-default">
									<div class="panel-heading ">人物词云</div>
									<div id="ciyun1" class="panel-body1" style="height: 170px;"></div>
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="col-md-13" style="width:100%; height: 97%;">
							<div class="new-des  bd">
								<div class="panel panel-default">
									<div class="panel-heading ">地点词云</div>
									<div id="ciyun2" class="panel-body1" style="height: 170px;"></div>
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="col-md-13" style="width:100%; height: 97%;">
							<div class="new-des  bd">
								<div class="panel panel-default">
									<div class="panel-heading ">组织机构词云</div>
									<div id="ciyun3" class="panel-body1" style="height: 170px;"></div>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="footer">
			<p style="text-align: center;">Copyright © 2018 中央民族大学</p>
		</div>
	</div>
</body>
</html>
