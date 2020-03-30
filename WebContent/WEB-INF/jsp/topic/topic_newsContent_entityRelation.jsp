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
	href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" />
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
<!-- <script -->
<%-- 	src="<%=request.getContextPath()%>/resources/js/index/jquery-1.8.3.min.js"></script> --%>
<link href="/resources/css/main.css" rel="stylesheet">
<link href="/resources/css/bootstrap.css" rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<!--   <link href="css/bootstrap.min.css" rel="stylesheet"> -->

<!--       <link href="css/timeline.css" rel="stylesheet"> -->
<!--     <link href="css/templatemo_justified.css" rel="stylesheet"> -->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--       <script src="js/html5shiv.js"></script> -->
<!--       <script src="js/respond.min.js"></script> -->
<!--       <script src="js/jquery-1.8.3.min.js"></script> -->
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

<%-- <center> --%>
<!-- <div  > -->
<%-- 	<c:forEach items="${topicNewsContent }" var="topicNewsContent"> --%>
<%-- 	<b>【新闻标题】${topicNewsContent.news_title }</b> --%>
<%-- 	</c:forEach> --%>
<!--  	<table  height="600px"> -->
<%--  		<c:forEach items="${topicNewsContent }" var="topicNewsContent"> --%>
<!--  			<tr> -->
<%-- <%--  				<td align="center">${topicNewsContent.news_id }</td> --%>

<%--  				<td align="center">【${topicNewsContent.news_author }】</td> --%>
<!--  				<td align="center"> -->
<%--  				【<fmt:formatDate value="${topicNewsContent.news_time}" type="date" pattern="yyyy-MM-dd"/>】 --%>
<!--  				</td> -->
<!--  			</tr> -->
<!--  			<tr > -->
<!--  				<td colspan="3" align="center"><b>【新闻内容】</b></td> -->
<!--  			</tr> -->
<!--  			<tr > -->
<%--  				<td colspan="3" align="center">${topicNewsContent.news_content }</td> --%>
<!--  			</tr> -->
<%--  		</c:forEach> --%>
<!--  	</table> -->
<!--  	</div> -->
<%-- </center> --%>



<body style="font-family: Menksoft2007; width: auto;">
	<div id="container" class="container" style="float:left;width:auto">
		<div style="position: fixed; top: 0px; width: 98%;">
			<img
				src="<%=request.getContextPath()%>/resources/images/entityrelation.jpg"
				class="img-responsive" style="height: 10%;" />


			<ul class="nav nav-justified bd" style="height: 8%; width: auto">

				
			</ul>
		</div>

		<%-- <div
			style="word-wrap:break-word;writing-mode: tb-lr; height: 72%; margin-top: 11%; margin-left: 35px;border: 1px solid #e3e3e3;border-radius: 4px;">
			<c:forEach items="${topicNewsContent }" var="topicNewsContent">
				<p style="font-size: 22px; height: 85%;color: #428bca;text-align: center;margin-top: 20px;margin-left: 30px;">${topicNewsContent.news_title }</p>
			</c:forEach>
			<table style="height: 92%; font-size: 18px;margin-top: 20px;">

				<c:forEach items="${topicNewsContent }" var="topicNewsContent">
					<tr>
						<td colspan="3" >
						<div style="word-wrap:break-word;line-height: 1.4;margin-left: 20px;width: 900px;overflow-x: auto; overflow-y: hidden;margin-right: ">${topicNewsContent.news_content }</div>
						</td>
					</tr>
					<tr>
						<td>
							 				<a href="${topicNewsContent.news_url}">${topicNewsContent.news_url}</a></td>
					</tr>
					<tr>
						<td>
						<div style="text-align: center;font-size: 15px;margin-left: 20px;">
						<fmt:formatDate value="${topicNewsContent.news_time}"
								type="date" pattern="yyyy-MM-dd" />
								</div>
								</td>
					</tr>

				</c:forEach>
			</table>
		</div> --%>
		<div
			style="word-break: keep-all; float: left; height: 75%; margin-top: 12%; border: 1px solid #e3e3e3; border-radius: 4px; margin-left: 5%; width: 70%;">
			<c:forEach items="${topicNewsContent }" var="topicNewsContent">
				<c:choose>
					<c:when test="${topicNewsContent.lang_type == 'cn' }">
						<table class="news-content-tab" style="height: 98%;width: 95%;margin-left: 2%;">
							<tr>
								<td>
									<div class="news-title"
										style="text-align: center;">
										<h3 id="title"
											style="color: #1874CD; word-wrap: break-word; white-space: normal;">${topicNewsContent.news_title }</h3>
									</div>
								</td>
								</tr>
								<tr>
								<td style="height: 40px;">
									<div class="news-time-source"
										style="text-align: center;">
										<h5>
											<fmt:formatDate value="${topicNewsContent.news_time}"
												type="date" pattern="yyyy-MM-dd" />
										</h5>
										<%-- <h5 style="word-wrap: break-word;white-space:normal;">${list.news_url}</h5> --%>
									</div>
								</td>
								</tr>
								<tr>
								<td style="height: 40px;">
									<div class="news-time-source"
										style="text-align: center;">
										<h5>
											${topicNewsContent.news_url}
										</h5>
										<%-- <h5 style="word-wrap: break-word;white-space:normal;">${list.news_url}</h5> --%>
									</div>
								</td>
								</tr>
								<tr>
								<td style="vertical-align: top;">
									<!-- 判断是不是中文，是中文的话 横排显示，否则默认不懂 -->

									<div class="news-content">
										<div
											style="padding: 5px; margin-bottom: 5px; min-width: 300px;">
											<div id="content"
												style="font-size: 20px; word-wrap: break-word; width: 100%; height:600px;text-align: top; vertical-align: top; margin: 0 15px 12px 12px; padding: 5px; min-width: 300px; line-height: 1.4;  overflow-x: hidden; overflow-y: scroll;">
												${topicNewsContent.news_content }</div>
										</div>
										<%-- 												<form action="QueryByTitle?news_id=${list.news_id}" --%>
										<!-- 													method="post" style="float: left;"> -->
										<!-- 													<input type="submit" class="btn btn-info" value="编辑新闻" -->
										<!-- 														style="margin-top: 10px;"> -->
										<!-- 												</form> -->
									</div>
								</td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<table class="news-content-tab" style="height: 98%;">
							<tr>
								<td>
									<div class="news-title"
										style="height: 590px; text-align: center; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr;">
										<h3 id="title"
											style="color: #1874CD; word-wrap: break-word; white-space: normal;">${topicNewsContent.news_title }</h3>
									</div>
								</td>
								<td>
									<div class="news-time-source"
										style="height: 590px; text-align: center; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr;">
										<h5>
											<fmt:formatDate value="${topicNewsContent.news_time}"
												type="date" pattern="yyyy-MM-dd" />
										</h5>
										<%-- <h5 style="word-wrap: break-word;white-space:normal;">${list.news_url}</h5> --%>
									</div>
								</td>
								<td>
									<div class="news-time-source"
										style="height: 590px; text-align: center; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr;">
										<h5>
											${topicNewsContent.news_url}
										</h5>
										<%-- <h5 style="word-wrap: break-word;white-space:normal;">${list.news_url}</h5> --%>
									</div>
								</td>
								<td>
									<!-- 判断是不是中文，是中文的话 横排显示，否则默认不懂 -->

									<div class="news-content">
										<div
											style="height: 590px; padding: 5px; margin-bottom: 5px; min-width: 300px;">
											<div id="content"
												style="height: 570px; font-size: 20px; word-wrap: break-word; width: 700px; text-align: top; vertical-align: top; margin: 0 15px 12px 12px; padding: 5px; min-width: 300px; line-height: 1.4; -moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr; overflow-x: auto; overflow-y: hidden;">
												${topicNewsContent.news_content }</div>
										</div>
										<%-- 												<form action="QueryByTitle?news_id=${list.news_id}" --%>
										<!-- 													method="post" style="float: left;"> -->
										<!-- 													<input type="submit" class="btn btn-info" value="编辑新闻" -->
										<!-- 														style="margin-top: 10px;"> -->
										<!-- 												</form> -->
									</div>
								</td>
							</tr>
						</table>
					</c:otherwise>
				</c:choose>


			</c:forEach>
		</div>
		<div
			style="float: left; height: 75%; margin-top: 12%; border: 1px solid #e3e3e3; border-radius: 4px; margin-left: 1%; width: 20%;">
			<table style="height: 100%; width: 100%">
				<tr>
					<td>
						<div class="col-md-13" style="width: 95%; height: 97%;">
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
						<div class="col-md-13" style="width: 95%; height: 97%;">
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
						<div class="col-md-13" style="width: 95%; height: 97%;">
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
		
		<div id="modaldiv" class="table-responsive modal fade in"
						style="display: none;position: fixed;
                        top: 50%;left: 50%;z-index: 1050;max-height: 300px;overflow: auto;width: 500px;margin: -250px 0 0 -280px;background-color: #ffffff;
                        border: 1px solid #999;border: 1px solid rgba(0, 0, 0, 0.3);border: 1px solid #999;-webkit-border-radius: 6px;-moz-border-radius: 6px;
                        border-radius: 6px;-webkit-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);-moz-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);-webkit-background-clip: padding-box;
                        -moz-background-clip: padding-box;background-clip: padding-box;">
						<form id="langTypeForm" action="/mwyqMonitor/topic/chooselang" method="POST">
							<div class="modal-header">
								<a class="close" data-dismiss="modal">×</a>
								<h3 id="mytitle">选择语种</h3>
							</div>
							<div class="modal-body">
								<table class="table table-bordered table-hover">
									<tr>
										<td style="text-align: center;">蒙文:&nbsp;&nbsp;
										<input type="radio" checked="checked" id="mengradio" name="langtype" value="meng"/>
										</td>
										<td style="text-align: center;">中文：
										<input type="radio" id="cnradio" name="langtype" value="cn" /></td>
									</tr>
								</table>
							</div>
							<div class="modal-footer">
								<input type="botton" class="btn btn-success" value="提交"
									onClick="chooselang()" style="width: 60px;"><a href="#" class="btn"
									data-dismiss="modal">关闭</a>
							</div>
						</form>
					</div>

		<!-- /container -->
		<div class="footer">
			<p style="text-align: center;">Copyright © 2016 中央民族大学</p>
		</div>
	</div>
<script>
		function showModal() {
			var lang = '${sessionScope.lang}';
			if(lang=="meng"){
				$("#mengradio").attr("checked","checked");
				$("#cnradio").attr("checked",false);
			}else{
				$("#cnradio").attr("checked","checked");
				$("#mengradio").attr("checked",false);
			}
			$('#modaldiv').modal('show');
		}
		function chooselang(){
			$("#langTypeForm").submit();
		}
	</script>
</body>
</html>
