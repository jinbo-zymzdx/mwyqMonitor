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
</head>

<body style="font-family:Menksoft2007;word-break:keep-all">
	<div id="container" class="container" style="float:left;">
		<img src="<%=request.getContextPath()%>/resources/images/templatemoheader.jpg"
			class="img-responsive" style="height: 10%;" />
		<ul class="nav nav-justified bd" style="height:60px;padding-left:50px;">
			<li style="width:200px;"><a href="/mwyqMonitor/topic/">&nbsp;&nbsp;首 &nbsp;&nbsp;页 &nbsp;&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/news/">&nbsp;实时热点&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/statis/">&nbsp;统计分析&nbsp;</a></li>
			<li style="width:200px;"><a href="/baidu/">&nbsp;&nbsp;搜 &nbsp;&nbsp;索 &nbsp;&nbsp;</a></li>
		</ul>
		
		<div class="row space29" style="margin-left:10%;width:80%;">
			<div style="width:100%;margin-left:10px;">
				<c:forEach items="${latestNews}" var="latestNews">
					<div id="news-content" 
						style="font-family:MENKSOFT2007;height:300px;margin-bottom:50px;background-color:#76EEC6; moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr;">
						<h3 id="title" style="height:100%;margin-top:2px;border-right:1px dashed;width:auto;">
							<a href="<%=request.getContextPath()%>/news/${latestNews.news_id}/newsContent">${latestNews.news_title}</a>
						</h3>
						<p id="con" style="width:60%;font-size:15px;height:100%;margin-right:10px;overflow:hidden;">${latestNews.news_content}</p>
						<span id="date" class="cd-date" style="margin-left: 40px;">
							<fmt:formatDate value="${latestNews.news_time}" type="date" pattern="yyyy-MM-dd" />
						</span>
					</div>
				</c:forEach>
				<script>
					$(function() {
						var $timeline_block = $('.cd-timeline-block');
						//hide timeline blocks which are outside the viewport
						$timeline_block
								.each(function() {
									if ($(this).offset().top > $(window)
											.scrollTop()
											+ $(window).height() * 0.75) {
										$(this)
												.find(
														'.cd-timeline-img, .cd-timeline-content')
												.addClass('is-hidden');
									}
								});
						//on scolling, show/animate timeline blocks when enter the viewport
						$(window)
								.on(
										'scroll',
										function() {
											$timeline_block
													.each(function() {
														if ($(this).offset().top <= $(
																window)
																.scrollTop()
																+ $(window)
																		.height()
																* 0.75
																&& $(this)
																		.find(
																				'.cd-timeline-img')
																		.hasClass(
																				'is-hidden')) {
															$(this)
																	.find(
																			'.cd-timeline-img, .cd-timeline-content')
																	.removeClass(
																			'is-hidden')
																	.addClass(
																			'bounce-in');
														}
													});
										});
					});
				</script>

			</div>
			<!-- /row 1 -->
		</div>
		<!-- /container -->
		<div class="footer">
			<p style="text-align: center;">Copyright © 2018 中央民族大学</p>
		</div>
	</div>
</body>
</html>
