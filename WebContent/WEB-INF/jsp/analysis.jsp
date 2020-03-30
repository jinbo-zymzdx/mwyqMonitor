<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="zh-CN">

<head>
<!-- analysis.jsp -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>民汉舆情汇聚与监测系统 - 统计分析</title>

<link rel="shortcut icon" href="favicon.png" />

<!-- 主页样式文件 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/normalize.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-theme.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/jquery-ui.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrapSwitch.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/morris-0.4.3.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/sb-admin.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/model.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/index-style.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/bootstrap-theme.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/bootstrapSwitch.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/jquery-ui.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/morris-0.4.3.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/sb-admin.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/model.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/analysis/analysis.css">

<!-- 历史话题排行所导入的其他页面的CSS -->
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/jquery-1.9.0.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/jquery-ui-1.9.2.custom.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/d3.v2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/d3.layout.cloud.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/highcharts-3.0.7.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/raphael-2.1.0.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/chinaMapConfig.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/analysis/map.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/morris.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/jquery.paginate.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/underscore-1.5.2.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/bootstrapSwitch.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/jquery.metisMenu.js"></script>

<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/charts.draw.js"></script>
<%-- <script
	src="<%=request.getContextPath()%>/resources/js/analysis/analysis.js"></script> --%>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/search.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/echarts.min.js"></script>

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
	min-height:90px;
}

.divbody1 {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	margin: 0 auto;
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
</style>

<script type="text/javascript">
	/* 局部刷新页面 */
	function loadHistoryTopic() {
		$("#historyTopic").load(location.href + " #historyTopic");
	}
	function switchLang(obj) {
		var form = document.getElementById("langTypeForm");
		form.submit();
	}
	$(function() {
		$("select option[value='" + '${lang}' + "']").attr("selected","selected");
		$('#selectedTime').text('${range}');
	});
</script>
</head>

<body>
	<div id="wrapper">
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
					<form id="langTypeForm" action="statSwitchlang" method="post">
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
						<!-- 新闻数量趋势图 -->
						<div class="col-sm-6">
							<div class="panel panel-success">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-stats"></span> 敏感分析
								</div>
								<div class="panel-body">
									<div id="sensitive_news_count_x" style="height: 310px"></div>
									<script type="text/javascript">
										var mySensitiveChart8 = echarts
												.init(document
														.getElementById('sensitive_news_count_x'));
										var optionSensitive = {
											tooltip : {
												trigger : 'axis'
											},
											legend : {
												data : [ '全部新闻', '中性新闻', '敏感新闻' ]
											},
											grid : {
												x : 50,
												y : 50,
												x2 : 50,
												y2 : 30
											},
											xAxis : {
												type : 'category',
												boundaryGap : false,
												axisLabel : {
													interval : 0,
													rotate : -10,
													margin : 2,
													textStyle : {
														color : "#000000"
													}
												}
											},
											yAxis : {
												type : 'value'
											},
											series : [ {
												name : '全部新闻',
												type : 'line'
											}, {
												name : '中性新闻',
												type : 'line'
											}, {
												name : '敏感新闻',
												type : 'line'
											} ]
										};

										function loadSensitiveData(option, lang) {
											$
													.ajax({
														type : "get",
														async : false,
														url : "${request.contextPath}/mwyqMonitor/mystat/getSensitiveByLang?lang="
																+ lang,
														data : {},
														dataType : "json",
														success : function(
																result) {
															option.xAxis.data = [];
															option.series[0].data = [];
															option.series[1].data = [];
															option.series[2].data = [];
															for ( var i in result) {
																option.xAxis.data
																		.push(i);
																option.series[0].data
																		.push(result[i][0]);
																option.series[1].data
																		.push(result[i][1]);
																option.series[2].data
																		.push(result[i][2]);
															}
														}
													});
										}
										var lang = '${sessionScope.lang}';
										loadSensitiveData(optionSensitive, lang);
										mySensitiveChart8
												.setOption(optionSensitive);
									</script>
								</div>
							</div>
						</div>

						<!-- 时间数量折线图 -->
						<div class="col-sm-6">
							<div class="panel panel-success">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-stats"></span> 话题数量
								</div>
								<div class="panel-body">
									<div id="event_count_chart_x"></div>
									<script type="text/javascript">
										var myChart = echarts
												.init(document
														.getElementById('event_count_chart_x'));
										var eventCountOption = {
											//数据提示框配置  
											tooltip : {
												trigger : 'item' //触发类型，默认数据触发，见下图，可选为：'item' | 'axis' 其实就是是否共享提示框  
											},
											grid : {
												x : 50,
												y : 15,
												x2 : 30,
												y2 : 30
											},
											calculable : true,
											//轴配置  
											xAxis : [ {
												type : 'category',
												axisLabel : {
													interval : 0,
													rotate : -10,
													margin : 2,
													textStyle : {
														//fontWeight : "bolder",
														color : "#000000"
													}
												}
											} ],
											//Y轴配置  
											yAxis : [ {
												type : 'value',
											} ],
											//图表Series数据序列配置  
											series : [ {
												type : 'line',
												smooth : true,
												itemStyle : {
													normal : {
														color : "#0f0",
														areaStyle : {
															color : "#2578cb",
														}
													}
												}
											} ]
										};
										function loadEventCountData(option,
												lang) {
											$
													.ajax({
														type : "get",
														async : false,
														url : "${request.contextPath}/mwyqMonitor/topic/getTopicNum?lang="
																+ lang,
														data : {},
														dataType : "json",
														success : function(
																result) {
															if (result) {
																option.xAxis[0].data = [];
																for ( var i in result) {
																	option.xAxis[0].data
																			.push(i);
																}
																option.series[0].data = [];
																for ( var i in result) {
																	option.series[0].data
																			.push(result[i]);
																}
															} else {
																option.xAxis[0].data = [
																		0, 0,
																		0, 0,
																		0, 0, 0 ];
																option.series[0].data = [
																		0, 0,
																		0, 0,
																		0, 0, 0 ];
															}
														}
													});
										}

										var lang = '${sessionScope.lang}';
										loadEventCountData(eventCountOption,
												lang);
										myChart.setOption(eventCountOption);
									</script>
								</div>
							</div>
						</div>
					</div>

					<div class="row row-not-margin">
						<!-- 实体统计饼图 -->
						<div class="col-sm-6">
							<div class="panel panel-success">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-stats"></span> 实体统计
								</div>
								<div class="panel-body">
									<div id="entity_count_chart_x">
										<script type="text/javascript">
											var myChart = echarts
													.init(document
															.getElementById('entity_count_chart_x'));
											var lang = '${sessionScope.lang}';
											var keys = [];
											var values = [];
											$
													.ajax({
														type : "get",
														async : false,
														url : "${request.contextPath}/mwyqMonitor/topic/getStaticEntity?lang="
																+ lang,
														dataType : "json",
														success : function(
																result) {
															if (result) {
																for ( var i in result) {
																	keys
																			.push(i);
																	values
																			.push(result[i]);
																}
															}
														}
													});

											option3 = {
												legend : {
													orient : 'vertical',
													x : 'left',
													data : [ '人物', '地点', '组织机构' ]
												},
												calculable : true,
												series : [ {
													name : '实体统计',
													type : 'pie',
													radius : '80%',
													center : [ '50%', '50%' ],
													itemStyle : {
														normal : {
															label : {
																show : true,
																formatter : "{b} : {c} ({d}%)",
																textStyle : {
																	fontSize : 15
																}
															}
														}
													},
													data : (function() {
														var res = [];
														var len = keys.length;
														while (len--) {
															res
																	.push({
																		name : keys[len],
																		value : values[len]
																	});
														}
														return res;
													})()
												} ]
											};
											var lang = '${sessionScope.lang}';
											myChart.setOption(option3);
										</script>
									</div>
								</div>
							</div>
							<!-- 饼图 -->
						</div>

						<div class="col-sm-6">
							<!-- 新闻语种统计 -->
							<div class="panel panel-success">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-stats"></span>新闻类别统计
								</div>
								<div class="panel-body">
									<div id="newsLangCount_chart">
										<script>
											var myChart4 = echarts
													.init(document
															.getElementById('newsLangCount_chart'));
											var lang = '${sessionScope.lang}';
											var dataCategory = [];
											var dataCateValue = [];
											$
													.ajax({
														type : "get",
														async : false,
														url : "${request.contextPath}/mwyqMonitor/topic/getNewsCategory?lang="
																+ lang,
														dataType : "json",
														success : function(
																result) {
															if (result) {
																for ( var i in result) {
																	dataCategory
																			.push(i);
																	dataCateValue
																			.push({
																				value : result[i],
																				name : i
																			});
																}
															}
														}
													});
											option4 = {
												tooltip : {
													trigger : 'item',
													formatter : "{a} <br/>{b}: {c} ({d}%)"
												},
												legend : {
													orient : 'vertical',
													x : 'left',
													data : dataCategory
												},
												series : [ {
													name : '新闻类别',
													type : 'pie',
													radius : '80%',
													center : [ '50%', '50%' ],
													avoidLabelOverlap : false,
													label : {
														normal : {
															 show : true,
															formatter : "{b} : {c} ({d}%)"
														},
														emphasis : {
															show : true,
															textStyle : {
																fontSize : '2',
																fontWeight : 'bold'
															}
														}
													},
													labelLine : {
														normal : {
															show : false
														}
													},
													data : dataCateValue
												} ]
											};
											myChart4.setOption(option4);
										</script>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 历史话题排行 -->
					<div class="row row-not-margin">
						<div class="col-sm-12">
							<div class="panel panel-success">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-sort"></span> 历史话题排行
									<div class="pull-right">
										<div class="btn-group">
											<button id="selectedTime" style="width: 100px; height: 26px;"
												type="button" class="btn btn-primary dropdown-toggle btn-sm"
												data-toggle="dropdown">全部
												 <span class="caret"></span>
											</button>
											<ul class="dropdown-menu menu_width" role="menu"
												id="searchTime">
												<li><a href="<%=request.getContextPath()%>/mystat/getSelect/all">全部</a></li>
												<li><a href="<%=request.getContextPath()%>/mystat/getSelect/week">过去一周</a></li>
												<li><a href="<%=request.getContextPath()%>/mystat/getSelect/month">过去一月</a></li>
												<li><a href="<%=request.getContextPath()%>/mystat/getSelect/year">过去一年</a></li>
											</ul>
										</div>
									</div>
								</div>
								<div class="panel-body divbody" id="historyTopic">
									<c:forEach items="${topicList}" var="topic">
										<div
											style="padding-right: 10px; display: inline; float: left; font-size: 20px; width: 50px; color: blue;">${topic.news_count}</div>
										<a style="font-size: 18px; margin-top: 10px;"
											href="<%=request.getContextPath() %>/topic/${topic.topic_id}/newtopic">${topic.topic_name}</a>
										<div style="float: right; padding-right: 100px;">
											<fmt:formatDate value="${topic.news_time}" type="date"
												pattern="yyyy-MM-dd" />
										</div>
										<p class="divbody1">${topic.news_content}</p>
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
		<!--版权-->
		<div class="footer"></div>

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
										<!-- sunpeng.2018.03.25
                                <option>蒙文</option>
                                <option>维文</option>
                                 -->
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
	</div>

</body>

</html>
