<%@ page language="java"
	import="com.mwyq.controller.*, java.util.*,java.text.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">

<head>
<!-- sensitive.jsp -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>民汉舆情汇聚与监测系统 — 敏感词检测</title>
<link rel="shortcut icon" href="favicon.png" />
<link rel="stylesheet"
	href="
	<%=request.getContextPath()%>/resources/css/hotpots/bootstrap-theme.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrapSwitch.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/sb-admin.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/model.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/timeline.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/hotspots.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/vendor-font.css">
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-3.2.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-1.9.0.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/bootstrap.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/bootstrapSwitch.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/jquery.metisMenu.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/underscore-1.5.2.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/search.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/hotpots/myjs.js"></script>
<link rel="stylesheet" charset="utf-8" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/hotpots/mycss.css">
<link rel="stylesheet"
	href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">

<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}

body {
	font: 16px/100% "微软雅黑";
}

.top {
	background-color: #0050a2;
	height: 50px;
}

.divhead {
	font-family: "微软雅黑";
	font-size: 17px;
	line-height: 25px;
}

.divbody {
	font-family: "微软雅黑";
	font-size: 16px;
	line-height: 25px;
}

.divbody1 {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	margin: 0 auto;
}

font {
	font-weight: bold;
	color: red;
}

.esc {
	width: 85px;
	height: 35px;
	margin: 7px 0;
	padding: 10px;
	border: 0px;
	text-decoration: none;
	border-radius: 5px;
	background-color: #0050a2;
	color: white;
	font-size: 16px;
}

#newsDialog {
	width: 50%;
	height: 70%;
	background-color: #BCD2EE;
	border: 1px solid green;
	position: fixed;
	top: 0px;
	left: 280px;
	right: 0px;
	bottom: 0px;
	margin: auto;
	padding: 0 20px;
	display: None;
}

.btnsen {
	padding: 0px 20px 15px 15px;
}

.btntime {
	padding: 0px 15px 15px 20px;
}
</style>

<script>

$(document).mouseup(function(e){
	var divlog=$('#newsDialog');
	if(!divlog.is(e.target)&&divlog.has(e.target).length===0){
		divlog.attr("style","display:none;");
	}
});

function displaycontent(e,news_id) {
	$.ajax({
		type : "get",
		async : false,
		url : "${request.contextPath}/mwyqMonitor/mynews/getSensitiveContent?news_id=" + news_id,
		data : {},
		dataType : "text",
		success : function(result) {
			document.getElementById("sensitive_content").innerHTML=result;
		}
	});
	var html="";
	$.ajax({
		type : "get",
		async : false,
		url : "${request.contextPath}/mwyqMonitor/sensite/getSensitiveWord?news_id=" + news_id,
		data : {},
		dataType : "json",
		success : function(result) {
			for(var i in result){
				html=html+"<p>"+"<span style=\"color:red\">"+i+"&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp"+result[i]+"</span>"+"</p>";
			}
			document.getElementById("sensitive_word_table").innerHTML=html;
		}
	});
	document.getElementById("sensitive_title").innerHTML=document.getElementById(news_id).innerHTML;
	var type = e.getAttribute("sensitiveType");
	if(type==1){
		document.getElementById("sensitive_type").innerHTML="中性";
	}
	if(type==2){
		document.getElementById("sensitive_type").innerHTML="敏感";
	}
	document.getElementById("sensitive_url").href=e.getAttribute("urlvalue");
	document.getElementById('newsDialog').style.display="block";
}

function switchLang(obj) {
	var form = document.getElementById("langTypeForm");
	form.submit();
}
$(function() {
	$("select option[value='" + '${lang}' + "']").attr("selected","selected");
	$('#selectedSensitive').text('${lastestSensitiveType}');
	$('.menu_width_sensive > li').on('click', function() {
		$('#selectedSensitive').text($(this).text());
	})
	$('#selectedTime').text('${selectedTime}');
	$('.menu_width_time > li').on('click', function() {
		$('#selectedTime').text($(this).text());
	})
});
</script>
</head>

<body>
	<div id="wrapper">
		<!--左侧部分-->
		<nav class="navbar navbar-fixed-top top" role="navigation"> <!-- 项目名 -->
		<div class="project">
			<div class="navbar-header">
				<a class="navbar-brand project-name" href="#"> <span
					style="color: white;">民汉舆情汇聚与监测系统</span>
				</a>
			</div>
		</div>
		<div class="col-md-3 col-set" style="float: right;">
			<div class="panel-body">
				<form id="langTypeForm" action="sensitiveSwitchlang" method="post">
					<div class="input-group">
						<span class="input-group-addon">切换语言</span> <select
							name="langtype" class="form-control"
							style="appearance: none; -moz-appearance: none; -webkit-appearance: none; width: 130px; height: 34px;"
							onchange="switchLang(this)">
							<option value="cn">中文</option>
								<option value="zang">藏文</option>
								<option value="wei">维吾尔文</option>
								<!-- <option value="meng">蒙文</option> -->
						</select>
					</div>
				</form>
			</div>
		</div>
		<!-- 左侧导航栏 -->
		<div class="navbar-default navbar-static-side" role="navigation">
				<div class="sidebar-collapse">
					<ul class="nav">
						<li><a href="<%=request.getContextPath()%>/main/"> <span
								class="glyphicon glyphicon-home span-icon"></span> 总览
						</a></li>
						<li><a href="http://210.31.15.93:8080/baidu/">
								<span class="glyphicon glyphicon-search span-icon"></span>搜索
						</a></li>
						<li>
							<a href="<%=request.getContextPath()%>/mynews/"> 
								<span class="glyphicon glyphicon-list span-icon"></span> 实时热点
							</a>
						</li>
						<li><a href="<%=request.getContextPath()%>/mystat/"> <span
								class="glyphicon glyphicon-stats span-icon"></span> 统计分析
						</a></li>
						<li><a href="<%=request.getContextPath()%>/sensite/"> <span
								class="glyphicon glyphicon-flag span-icon"></span> 敏感词检测
						</a></li>
						<li><a href="<%=request.getContextPath()%>/weibo/"> <span
								class="glyphicon glyphicon-time span-icon"></span> 微博分析
						</a></li>
						<li><a href="<%=request.getContextPath()%>/twitter/"> <span
								class="glyphicon glyphicon-th-large span-icon"></span> 推特分析
						</a></li>
						<li class="active"><a id="customMonitorBtn"
							href="javascript: void(0);" onclick="listUserWord();"> <span
								class="glyphicon glyphicon-book span-icon"></span> 自定义监测
						</a>
							<ul class="nav nav-second-level sub-menu" id="usersubmenu"></ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- 右侧主体部分 -->
		<div id="page-wrapper">
			<div class="row row-ptop-25">
				<div class="row row-not-margin">
					<div class="col-sm-12">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-time"></span>敏感词新闻
								<div class="pull-right btnsen">
									<div class="btn-group">
										<button type="button" id="selectedSensitive"
											style="width: 100px; height: 29px;"
											class="btn btn-default btn-xs" data-toggle="dropdown">
											<span id="lang_category">全部</span> <span class="caret"></span>
										</button>
										<ul class="dropdown-menu menu_width_sensive" role="menu">
											<li><a
												href="<%=request.getContextPath()%>/sensite/sennews/2/year">敏感新闻</a></li>
											<li><a
												href="<%=request.getContextPath()%>/sensite/sennews/1/year">中性新闻</a></li>
											<li><a
												href="<%=request.getContextPath()%>/sensite/sennews/0/year">正向新闻</a></li>
										</ul>
									</div>
								</div>
								<div class="pull-right btntime">
									<div class="btn-group">
										<button id="selectedTime" style="width: 100px; height: 29px;"
											type="button" class="btn btn-primary dropdown-toggle btn-sm"
											data-toggle="dropdown">
											全部 <span class="caret"></span>
										</button>
										<ul class="dropdown-menu menu_width_time" role="menu" id="searchTime">
											<li><a href="<%=request.getContextPath()%>/sensite/sennews/2/all">全部新闻</a></li>
											<li><a href="<%=request.getContextPath()%>/sensite/sennews/2/week">过去一周</a></li>
											<li><a href="<%=request.getContextPath()%>/sensite/sennews/2/month">过去一月</a></li>
											<li><a href="<%=request.getContextPath()%>/sensite/sennews/2/year">过去一年</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="panel-body divbody" id="sensitiveTopic">
							<c:forEach items="${sensitiveNews}" var="sensitiveNews">
								<a id=${sensitiveNews.news_id }
									style="font-size: 18px; margin-top: 10px;"
									onclick="displaycontent(this,${sensitiveNews.news_id})"
									urlvalue=${sensitiveNews.news_url
									}
									sensitiveType=${sensitiveNews.is_sensitive}>
									${sensitiveNews.news_title} </a>
								<div style="float: right; padding-right: 100px;">
									<fmt:formatDate value="${sensitiveNews.news_time}" type="date"
										pattern="yyyy-MM-dd" />
								</div>
								<p class="divbody1">${sensitiveNews.news_content}</p>
								<br>
								<hr>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footer"></div>

	<!-- Div弹出框 -->
	<div id="newsDialog">
		<div class="row row-ptop-25">
			<div class="row row-not-margin">
				<div class="col-sm-9">
					<div class="panel panel-success">
						<div class="panel-heading">
							<span class="glyphicon glyphicon-map-marker"></span> 新闻内容
						</div>
						<div class="panel-body divbody"
							style="overflow: auto; height: 420px;">
							<div style="text-align: center;">
								<h3 id="sensitive_title"
									style="color: #1874CD; word-wrap: break-word; white-space: normal;">${lastestSensitiveNews.news_title}</h3>
								<p>
									文章类型：<span id="sensitive_type" style="color: red">${lastestSensitiveType}</span>
									-- <a id="sensitive_url"
										href="${lastestSensitiveNews.news_url}" target="_blank">原文链接</a>
								</p>
							</div>
							<div>
								<p id="sensitive_content"
									style="font-size: 15px; margin: 15px auto; text-indent: 1em;">${firstContent}</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel panel-success">
						<div class="panel-heading">
							<span class="glyphicon glyphicon-align-left"></span> 敏感词表
						</div>
						<div class="panel-body divbody"
							style="overflow: auto; height: 420px;">
							<div id="sensitive_word_table">${firstWord}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- 自定义监测添加 -->
	<div id="monitor" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="monitor_title">自定义监测添加</h4>
				</div>
				<div class="modal-body">
					<div id="monitor_body">
						<div class="row monitor-row">
							<div class="col-xs-2 monitor-tag">
								<span class="node-name">监控词：</span>
							</div>
							<div class="col-xs-9">
								<input type="text" class="form-control" id="monitor_word"
									value="">
							</div>
						</div>
						<div class="row monitor-row">
							<div class="col-xs-2 monitor-tag">
								<span class="node-name">类型：</span>
							</div>
							<div class="col-xs-9">
								<select class="form-control input-group-sm"
									id="monitor_wordType">
									<option>其他</option>
									<option>人物</option>
									<option>地点</option>
									<option>组织机构</option>
								</select>
							</div>
						</div>
						<div class="row monitor-row">
							<div class="col-xs-2 monitor-tag">
								<span class="node-name">语言：</span>
							</div>
							<div class="col-xs-9">
								<select class="form-control input-group-sm"
									id="monitor_langType">
									<option>中文</option>
									<option>藏文</option>
								</select>
							</div>
						</div>
						<div class="row monitor-row">
							<div class="col-xs-2 monitor-tag">
								<span class="node-name">描述：</span>
							</div>
							<div class="col-xs-9">
								<input type="text" class="form-control" id="monitor_describe"
									value="">
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer modal-footer-point">
					<button type="button" class="btn btn-sm btn-default"
						data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-sm btn-primary"
						onclick="saveMonitor();">保存</button>

				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

</body>

</html>
