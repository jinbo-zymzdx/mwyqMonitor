<%@ page language="java"
	import="com.mwyq.controller.*, java.util.*,java.text.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">

<head>
<!-- hotspots.jsp -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>民汉舆情汇聚与监测系统 — 实时热点</title>
<link rel="shortcut icon" href="favicon.png" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrap-theme.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrapSwitch.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/jquery-ui.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotpots/sb-admin.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/model.css">
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
	src="<%=request.getContextPath()%>/resources/js/hotpots/hotspots.js"></script>
<!-- 搜索提示 -->
<script
	src="<%=request.getContextPath()%>/resources/js/hotpots/search.js"></script>
<!--例子-->
<script src="<%=request.getContextPath()%>/resources/js/hotpots/myjs.js"></script>
<link rel="stylesheet" charset="utf-8" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/hotpots/mycss.css">
<link rel="stylesheet"
	href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
<!-- 筛选 -->
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/js/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/js/commonSearch.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/bootstrap.min.css.map">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/font-awesome.css">
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
	margin:0 auto;
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
	width: 60%;
	height: 65%;
	background-color: #BCD2EE;
	border: 1px solid green;
	position: fixed;
	top: 0px;
	left: 500px;
	right: 0px;
	bottom: 0px;
	margin: auto;
	display: none;
	padding: 10px;
}

</style>

<script type="text/javascript">

$(document).mouseup(function(e){
	var divlog=$('#newsDialog');
	if(!divlog.is(e.target)&&divlog.has(e.target).length===0){
		divlog.attr("style","display:none;");
	}
});
function dragFunc(id) {
    var Drag = document.getElementById(id);
    Drag.onmousedown = function(event) {
        var ev = event || window.event;
        event.stopPropagation();
        var disX = ev.clientX - Drag.offsetLeft;
        var disY = ev.clientY - Drag.offsetTop;
        document.onmousemove = function(event) {
            var ev = event || window.event;
            Drag.style.left = ev.clientX - disX + "px";
            Drag.style.top = ev.clientY - disY + "px";
            Drag.style.cursor = "move";
        };
    };
    Drag.onmouseup = function() {
        document.onmousemove = null;
        this.style.cursor = "default";
    };
};

var lang = '${sessionScope.lang}';
function displaynewsContent(e, news_id) {
	$.ajax({
		type : "get",
		async : false,
		url : "${request.contextPath}/mwyqMonitor/mynews/getContent?news_id="+ news_id,
		data : {},
		dataType : "text",
		success : function(result) {
			document.getElementById("divNewsContent").innerHTML = result;
		}
	});
	document.getElementById("news_content_url").href=e.getAttribute("urlvalue");
	document.getElementById("divNewsTitle").innerHTML = document.getElementById(news_id).innerHTML;
	document.getElementById('newsDialog').style.display="block";
	if(lang == 'cn'){
		newsKeyWords(news_id);
	}else{
		transContent(news_id);
	}
}
function newsKeyWords(news_id) {
	$.ajax({
		type : "get",
		async : false,
		url : "${request.contextPath}/mwyqMonitor/mynews/getNewskeywords?news_id=" + news_id,
		data : {},
		dataType : "json",
		success : function(result) {
			document.getElementById('transDiv').style.display="none";
			document.getElementById('newsKeyDiv').style.display="block";
		    var newsKeywords=result.newsKeywords;
		    var keyWord="";
			$.each(newsKeywords, function(key,obj) {
 				keyWord += "<span style='padding-left: 50px;'>"+obj.name+"</span><span style='float: right; padding-right: 100px;'>"+obj.value+"</span><br />"
			});
			$("#keyWordDiv").html(keyWord);
		}
	});
}
function transContent(news_id) {
	$.ajax({
		type : "get",
		async : false,
		url : "${request.contextPath}/mwyqMonitor/mynews/getTransAll?news_id=" + news_id,
		data : {},
		dataType : "json",
		success : function(result) {
			document.getElementById("trans_Title").innerHTML = result.title;
			document.getElementById("trans_Content").innerHTML = result.content;
		}
	});
}

function switchLang(obj) {
	var form = document.getElementById("langTypeForm");
	form.submit();
}
$(function() {
	$("select option[value='" + '${lang}' + "']").attr("selected","selected");
	dragFunc('newsDialog');
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
				<form id="langTypeForm" action="switchlang" method="post">
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
				<!--蓝色显示框-->
				<div class="row row-not-margin">
					<div class="col-sm-12">
						<div class="alert alert-info divhead">
							<p>
								<strong>热门新闻：</strong>中文 <font>${ch}</font> 篇，蒙文 <font>${wei}</font>篇，藏文
								<font>${zang}</font> 篇
							</p>
						</div>
					</div>
				</div>
				<!--时事热点显示-->
				<div class="row row-not-margin">
					<div class="col-md-12">
						<div class="panel panel-success">
							<div class="panel-heading" id="search-filter">
								<span class="glyphicon glyphicon-list span-icon"></span> 实时热点
							</div>
							<div class="panel-body divbody">
								<c:forEach items="${latestNews}" var="latestNews">
										<a id=${latestNews.news_id } style="font-size: 18px;margin-top:10px;"
											onclick="displaynewsContent(this,${latestNews.news_id})"
											urlvalue=${latestNews.news_url}
											style=""> ${latestNews.news_title} </a> 
										<div style="float: right; padding-right: 100px;">
											<fmt:formatDate value="${latestNews.news_time}" type="date" pattern="yyyy-MM-dd" />
										</div>
										<p class="divbody1">${latestNews.news_content}</p>
										<br>
									<hr>
								</c:forEach>
							</div>
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
			<div class="point" id="newsDiv">
				<div class="row row-not-margin">
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-map-marker"></span> 新闻内容
							</div>							
							<div class="panel-body divbody" style="overflow: auto; height: 370px;">
								<div style="text-align: center;">
									<h3 id="divNewsTitle" style="color: #1874CD; word-wrap: break-word; white-space: normal;"></h3>
									<fmt:formatDate value="${lastestOneNews.news_time}" type="date" pattern="yyyy-MM-dd" />
									<a id="news_content_url" cursor: pointer href="${lastestOneNews.news_url}" target="_blank">原文链接</a>
								</div>
								<div id="divNewsContent"></div>
							</div>
						</div>
					</div>
					<div class="col-sm-6" id="transDiv">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-align-left"></span> 译文内容
							</div>
							<div class="panel-body divbody" style="overflow: auto; height: 370px;">
								<div style="text-align: center;">
									<h3 id="trans_Title" style="color: #1874CD; word-wrap: break-word; white-space: normal;"></h3>
								</div>
								<div id="trans_Content"></div>
							</div>
						</div>
					</div>
					<div class="col-sm-6" id="newsKeyDiv"  style="display:none;">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-align-left"></span> 新闻关键字
							</div>
							<div id="keyWordDiv" class="panel-body divbody" style="overflow: auto; height: 370px;"></div>
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
