<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>藏汉舆情汇聚与监测系统 — 话题新闻</title>

<link rel="shortcut icon" href="favicon.png" />

<!-- Core CSS - Include with every page -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap-theme.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrapSwitch.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/jquery-ui.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/sb-admin.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/model.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/timeline.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/hotspots.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/vendor-font.css">

<script
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery-ui.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrapSwitch.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/jquery.metisMenu.js"></script>

<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/underscore-1.5.2.js"></script>
<!--<script src="js/highlight.js"></script>-->
<script src="<%=request.getContextPath()%>/resources/js/js/hotspots.js"></script>
<script src="<%=request.getContextPath()%>resources/js/echarts.js"></script>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<!-- 搜索提示 -->
<script src="<%=request.getContextPath()%>/resources/js/js/search.js"></script>
<!--例子-->
<script src="<%=request.getContextPath()%>/resources/js/myjs.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/js/mycss.css">

<link rel="stylesheet"
	href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">

<script type="text/javascript">

$(document).ready(function() {
	document.body.onselectstart=document.body.oncontextmenu=function(){ return false;}
});
	require.config({
		paths : {
			echarts : 'http://echarts.baidu.com/build/dist'
		}
	});

	// 使用
	require(
			[ 'echarts', 'echarts/chart/wordCloud',

			// 使用柱状图就加载bar模块，按需加载
			],
			function(ec) {
				// 基于准备好的dom，初始化echarts图表

				var myChart1 = ec.init(document.getElementById('ciyun1'));
				var myChart2 = ec.init(document.getElementById('ciyun2'));
				var myChart3 = ec.init(document.getElementById('ciyun3'));

				function createRandomItemStyle() {
					return {
						normal : {
							color : 'rgb('
									+ [ Math.round(Math.random() * 160),
											Math.round(Math.random() * 160),
											Math.round(Math.random() * 160) ]
											.join(',') + ')'
						}
					};
				}

				var keys_per = [];
				var values_per = [];
				$
						.ajax({
							type : "get",
							async : false,
							url : "${request.contextPath}/mwyqMonitor/topic/${newsId}/getEntityPerKey",
							dataType : "json",
							success : function(result) {
								if (result) {
									for ( var i in result) {
										keys_per.push(i);
										values_per.push(result[i]);
									}
								}
							}
						});

				option1 = {
					noDataLoadingOption : {
						//text:'正在等待请求数据',
						text : '暂无数据', //sunpeng-2018
						effect : 'bubble',
						effectOption : {
							effect : {
								n : 0
							}
						}
					},
					tooltip : {
						show : true
					},
					series : [ {
						//  name: '中央民族大学',
						type : 'wordCloud',
						size : [ '80%', '80%' ],
						textRotation : [ 0, 45, 90, -45 ],
						textPadding : 0,
						autoSize : {
							enable : true,
							minSize : 14
						},
						data : (function() {
							var res = [];
							var len = keys_per.length;
							while (len--) {
								res.push({
									name : keys_per[len],
									value : Math.round(Math.random() * 1000),
									itemStyle : createRandomItemStyle()
								});
							}
							return res;
						})()

					} ]
				};

				var keys_loc = [];
				var values_loc = [];
				$
						.ajax({
							type : "get",
							async : false,
							url : "${request.contextPath}/mwyqMonitor/topic/${newsId}/getEntityLocKey",
							dataType : "json",
							success : function(result) {
								if (result) {
									for ( var i in result) {
										keys_loc.push(i);
										values_loc.push(result[i]);
									}
								}
							}
						});
				option2 = {

					noDataLoadingOption : {
						//text:'正在等待请求数据',
						text : '暂无数据', //sunpeng-2018
						effect : 'bubble',
						effectOption : {
							effect : {
								n : 0
							}
						}
					},
					tooltip : {
						show : true
					},
					series : [ {
						//  name: '中央民族大学',
						type : 'wordCloud',
						size : [ '80%', '80%' ],
						textRotation : [ 0, 45, 90, -45 ],
						textPadding : 0,
						autoSize : {
							enable : true,
							minSize : 14
						},
						data : (function() {
							var res = [];
							var len = keys_loc.length;
							while (len--) {
								res.push({
									name : keys_loc[len],
									value : Math.round(Math.random() * 1000),
									itemStyle : createRandomItemStyle()
								});
							}
							return res;
						})()

					} ]
				};

				var keys_org = [];
				var values_org = [];
				$
						.ajax({
							type : "get",
							async : false,
							url : "${request.contextPath}/mwyqMonitor/topic/${newsId}/getEntityOrgKey",
							dataType : "json",
							success : function(result) {
								if (result) {
									for ( var i in result) {
										keys_org.push(i);
										values_org.push(result[i]);
									}
								}
							}
						});
				option3 = {
					noDataLoadingOption : {
						//text:'正在等待请求数据',
						text : '暂无数据', //sunpeng-2018
						effect : 'bubble',
						effectOption : {
							effect : {
								n : 0
							}
						}
					},
					tooltip : {
						show : true
					},
					series : [ {
						//  name: '中央民族大学',
						type : 'wordCloud',
						size : [ '80%', '80%' ],
						textRotation : [ 0, 45, 90, -45 ],
						textPadding : 0,
						autoSize : {
							enable : true,
							minSize : 14
						},
						data : (function() {
							var res = [];
							var len = keys_org.length;
							while (len--) {
								res.push({
									name : keys_org[len],
									value : Math.round(Math.random() * 1000),
									itemStyle : createRandomItemStyle()
								});
							}
							return res;
						})()

					} ]
				};
				// 为echarts对象加载数据 
				myChart1.setOption(option1);
				myChart2.setOption(option2);
				myChart3.setOption(option3);
			});
	function transContent() {
		$.ajax({
			type : "get",
			async : false,
			url : "${request.contextPath}/mwyqMonitor/mynews/getTransAll?news_id="+ '${newsId}',
			data : {},
			dataType : "json",
			success : function(result) {
				if (result) {
					document.getElementById("trans_content").innerHTML = result.content;
					document.getElementById("trans_title").innerHTML = result.title;
				}
			}
		});
	}
	var lang = '${sessionScope.lang}';
	window.onload = function(){
		if(lang == 'cn'){
			var  transDiv = document.getElementById('transDiv').style.display="none";
			var  newsKeyDiv = document.getElementById('newsKeyDiv').style.display="block";
		}else{
			setTimeout("transContent()",10)
		}
	}
</script>
<style type="text/css">
body {
	font: 16px/100% "微软雅黑";
}

.top {
	background-color: #0050a2;
	height: 50px;
}

.divbody {
	font-family: "微软雅黑";
	font-size: 16px;
	line-height: 25px;
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
</head>

<body>
	<div id="wrapper">
		<nav class="navbar navbar-fixed-top top" role="navigation"> <!-- 项目名 -->
		<div class="project">
			<div class="navbar-header">
				<a class="navbar-brand project-name" href="#"> <span
					style="color: white;">民汉舆情汇聚与监测系统</span> <!-- <input type=button value="返回" onclick="window.history.go(-1)"> -->
				</a>
				<button type="button" class="esc" onclick="window.history.go(-1);">
					<img src="/mwyqMonitor/resources/images/home.png"
						style="padding: 0; margin-top: -3px;"><b>返回</b>
				</button>
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

		<!--右侧主题部分-->
		<div id="page-wrapper">
			<div class="row row-ptop-25">
				<div class="row row-not-margin">
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-map-marker"></span> 新闻内容
							</div>
							<div class="panel-body divbody"
								style="overflow: auto; height: 500px;">
								<div style="text-align: center;">
									<h3 id="title"
										style="color: #1874CD; word-wrap: break-word; white-space: normal;">
										${displayNew.news_title }</h3>
									<fmt:formatDate value="${displayNew.news_time}" type="date"
										pattern="yyyy-MM-dd" />
									<a cursor: pointer href="${displayNew.news_url}"
										target="_blank">原文链接</a>
								</div>
								<div style="padding: 5px; margin-bottom: 5px; min-width: 300px;">
									<div
										style="font-size: 16px; word-wrap: break-word; width: 100%; height: 400px; text-align: top; vertical-align: top; margin: 0 15px 12px 12px; padding: 5px; min-width: 300px; line-height: 1.5;">
										${displayNew.news_content }</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-6" id="transDiv">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-align-left"></span> 译文内容
							</div>
							<div class="panel-body divbody"
								style="overflow: auto; height: 500px;">
								<div style="text-align: center;">
									<h3 id="trans_title"
										style="color: #1874CD; word-wrap: break-word; white-space: normal;">
									</h3>
								</div>
								<div id="trans_content"></div>
							</div>
						</div>
					</div>
					<div class="col-sm-6" id="newsKeyDiv"  style="display:none;">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-align-left"></span> 新闻关键字
							</div>
							<div class="panel-body divbody"
								style="overflow: auto; height: 500px;">
								<c:forEach items="${newsKeywords}" var="newsKeyword">
									<span style="padding-left: 50px;">${newsKeyword.name}</span>
									<span style="float: right; padding-right: 100px;">${newsKeyword.value}</span>
									<br />
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row row-ptop-24">
				<div class="row row-not-margin">
					<div class="col-xs-4 col4-draw-left">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-align-left"></span> 人物词云
							</div>
							<div class="panel-body" id="ciyun1" style="height: 300px"></div>
						</div>
					</div>
					<div class="col-xs-4 col4-draw-left">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-align-left"></span> 地点词云
							</div>
							<div class="panel-body" id="ciyun2" style="height: 300px"></div>
						</div>
					</div>
					<div class="col-xs-4 col4-draw-left">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-align-left"></span> 组织机构词云
							</div>
							<div class="panel-body" id="ciyun3" style="height: 300px"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
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
									<!-- sunpeng-2018.03.25
                                <option>朝文</option>
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
</body>

</html>