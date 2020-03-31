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
<title>实时热点</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/timeline.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/templatemo_justified.css" />

<script
	src="<%=request.getContextPath()%>/resources/js/index/html5shiv.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/index/respond.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/index/jquery-1.8.3.min.js"></script>

<!--   <link href="css/bootstrap.min.css" rel="stylesheet"> -->

<!--       <link href="css/timeline.css" rel="stylesheet"> -->
<!--     <link href="css/templatemo_justified.css" rel="stylesheet"> -->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--       <script src="js/html5shiv.js"></script> -->
<!--       <script src="js/respond.min.js"></script> -->
<!--       <script src="js/jquery-1.8.3.min.js"></script> -->

</head>

<body style="font-family: Menksoft2007; width:auto;">
	<div id="container" class="container" style="float:left;width:auto">
 <div style="position: fixed;top: 0px;width: 100%;">
		<img
			src="<%=request.getContextPath()%>/resources/images/templatemoheader.jpg"
			class="img-responsive" style="height: 10%;" />


		<ul class="nav nav-justified" style="height: 8%">

			<li><a href="/mwyqMonitor/topic/">&nbsp;&nbsp;首 &nbsp;
					&nbsp;页 &nbsp;&nbsp;</a></li>
			<li><a href="/mwyqMonitor/news/">&nbsp;实时热点&nbsp;</a></li>
			<!--  		<li><a href="/mwyqMonitor/topic/">&nbsp;敏感事件&nbsp;</a></li>-->
			<li><a href="/mwyqMonitor/statis/">&nbsp;统计分析&nbsp;</a></li>
<!-- 			<li><a href='javascript:return test()'>自定义监测</a></li> -->
		</ul>
</div>

<div  style="word-wrap:break-word;writing-mode: tb-lr;margin-top: 11%;height: 50%;margin-left: 20px;writing-mode: vertical-lr;;">
	<c:forEach items="${newsContent }" var="newsContent">
	<p style="font-size: 22px; height: 90%">${newsContent.news_title }</p>
	</c:forEach>
	<div style="height: 90%;">
 	<table style="font-size: 18px">
 	
 		<c:forEach items="${newsContent }" var="newsContent">
 			<tr >
 				<td colspan="3">
 				<div>${newsContent.news_content }
 				</div>
 				</td>
 			</tr>
 			<tr>
 				<td >
 				<a href="${newsContent.news_url}">${newsContent.news_url}</a></td>
 			</tr>
 			<tr>
 				<td>
 				<fmt:formatDate value="${newsContent.news_time}" type="date" pattern="yyyy-MM-dd"/>
 				</td>
 			</tr>
 			
 		</c:forEach>
 	</table></div>
 	</div>


<!-- 		<div -->
<!-- 			style="width: auto; height: 70%; margin-left: 20px; margin-top: 10px;"> -->
			
<%-- 			<c:forEach items="${newsContent}" var="newsContent"> --%>
<!-- 			<div -->
<!-- 					style="height: 100%; width: auto; writing-mode: tb-lr; word-wrap: break-word; float: left;"> -->
<!-- 					<div style="width: auto; height: 100%; font-size: 20px;"> -->
<%-- 						${newsContent.news_title}</div> --%>
<!-- 				</div> -->

<!-- 				<div -->
<!-- 					style="height: 100%; width: auto; writing-mode: tb-lr; word-wrap: break-word; float: left;"> -->
<!-- 					<div style="width: auto; height: 100%; font-size: 20px;"> -->
<%-- 						<fmt:formatDate value="${newsContent.news_time}" type="date" --%>
<%-- 							pattern="yyyy-MM-dd" /> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div -->
<!-- 					style="height: 100%; width: auto; writing-mode: tb-lr; word-wrap: break-word; float: left;"> -->
<!-- 					<div style="width: auto; height: 100%; font-size: 20px;"> -->
<%-- 						<a href="${newsContent.news_url}">${newsContent.news_url}</a> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div -->
<!-- 					style="height: 100%; width: auto; writing-mode: tb-lr; word-wrap: break-word; float: left;"> -->
<!-- 					<div style="width: auto; height: 100%; font-size: 20px;"> -->
<%-- 						${newsContent.news_content}</div> --%>
<!-- 				</div> -->
<%-- 			</c:forEach> --%>
<!-- 			</div> -->
			<%-- <table style="height: 100%; width: auto;word-wrap:break-word;text-align:justify;">
				<c:forEach items="${newsContent}" var="newsContent">
					<tr>
						<td style="writing-mode: tb-lr;width: auto; ">
							<div style="width:auto;height: 100%;font-size: 20px;">
								${newsContent.news_title}
							</div>
						</td>
						<td style="writing-mode: tb-lr;"><div style="width: auto;height: 100%;margin-left: 15px;">
								<a href="${newsContent.news_url}">${newsContent.news_url}</a>
							</div></td>
						<td style="writing-mode: tb-lr;"><div>
								<fmt:formatDate value="${newsContent.news_time}" type="date"
									pattern="yyyy-MM-dd" />
							</div></td>

						<td style="writing-mode: tb-lr;"><div>${newsContent.news_content}</div></td>


					</tr>
				</c:forEach>

			</table> --%>
		


		<!-- /container -->
		<div class="footer">
			<p style="text-align: center;">Copyright © 2016 中央民族大学</p>
		</div>
	</div>
</body>
</html>
