<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<!-- index.jsp 主页 -->
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>民汉舆情汇聚与监测系统 - 首页</title>

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

<script
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/json2.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/d3.v2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/d3.layout.cloud.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/highcharts-3.0.7.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/highcharts-more.js"></script>

<script
	src="<%=request.getContextPath()%>/resources/js/underscore-1.5.2.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/map_demo.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/raphael-2.1.0.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/jquery.paginate.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/morris.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrapSwitch.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/jquery.metisMenu.js"></script>

<script src="<%=request.getContextPath()%>/resources/js/echarts.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/settings.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/hcdraw.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/charts.draw.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/highlight.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/index.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/search.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/test.js"></script>

<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=5rxDjqRP3g01EacBIyIbhsu9"></script>
<link rel="stylesheet"
	href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=3.0&ak=fjsxGIsSOK38jRWvX2KVjIzGZ0FfZceT"></script>

<script type="text/javascript">
	var width;
	var height;
	$(window).resize(function() {
		width = $(window).width();
		height = $(window).height();
		$("#mainBar").css("width", width - 40); //
		$("#mainBar").css("height", height - 40); //		
	});

	//路径配置
	require.config({
		paths : {
			echarts : 'http://echarts.baidu.com/build/dist'
		}
	});

	// 使用
	require(
			[ 'echarts', 'echarts/chart/map', 'echarts/chart/line',
					'echarts/chart/bar', 'echarts/chart/pie' ],
			function setEcharts(ec) {
				// 基于准备好的dom，初始化echarts图表
				//var topicMapChart = ec.init(document.getElementById('topic_map'));
				//var entityNewsTrendChart = ec.init(document.getElementById('news_trends_echart'));
				var entityNewsSourceChart = ec.init(document
						.getElementById('news_source'));
				//var entityLocChart = ec.init(document.getElementById('panel_loc_stat'));
				//var entityPerChart = ec.init(document.getElementById('panel_per_stat'));
				//var entityOrgChart = ec.init(document.getElementById('panel_org_stat'));
				var entityAllChart = ec.init(document
						.getElementById('news_count_entity'));
				//var sensitiveTrendChart = ec.init(document.getElementById('sensitive_tendency_echarts'));

				var newsNumChart = ec.init(document
						.getElementById('news_count_chart'));

				window.onresize = newsNumChart.resize;
				//window.onresize = sensitiveTrendChart.resize;
				//window.onresize = topicMapChart.resize;
				window.onresize = entityNewsSourceChart.resize;
				//window.onresize = entityLocChart.resize;
				//window.onresize = entityPerChart.resize;
				//window.onresize = entityOrgChart.resize;
				window.onresize = entityAllChart.resize;

				var topicMapOption = {
					tooltip : {
						trigger : 'item'
					},
					dataRange : {
						min : 0,
						max : 2500,
						x : 'left',
						y : 'bottom',
						text : [ '高', '低' ], // 文本，默认为数值文本
						calculable : true
					},
					toolbox : {
						show : true
					},
					series : [ {
						name : '相关新闻',
						type : 'map',
						mapType : 'china',
						roam : true,
						itemStyle : {
							normal : {
								label : {
									show : true
								}
							},
							emphasis : {
								label : {
									show : true
								}
							}
						},
						data : [ {
							name : '北京',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '天津',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '上海',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '重庆',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '河北',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '河南',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '云南',
							value : Math.round(Math.random() * 1000)
						} ]
					} ]
				};

				var entityNewsSourceOption = {
					//数据提示框配置  
					tooltip : {
						trigger : 'item' //触发类型，默认数据触发，见下图，可选为：'item' | 'axis' 其实就是是否共享提示框  
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 50,
						y2 : 50,
						calculable : true,
					},
					//轴配置  
					xAxis : [ {
						name : '来源',
						type : 'category',
						//data:['人民网蒙文版','青海湖网','中国新闻网','好乐宝网','正北方网','中国西藏新闻网','蒙古语新闻网','海西州人民政府','新疆维吾尔自治区人民政府网','新华网维语版'],
						axisLabel : {
							interval : 0,
							rotate : -15,
							margin : 2,

							textStyle : {
								color : "#000000"
							}
						}
					} ],
					//Y轴配置  
					yAxis : [ {
						name : '数量',
						type : 'value',
					} ],
					//图表Series数据序列配置  
					series : [ {
						type : 'bar',
						barWidth : 45,
						itemStyle : {
							normal : {
								areaStyle : {
									color : '#00CED1'
								},
								label : {
									show : true, //开启显示
									position : 'top', //在上方显示
									textStyle : { //数值样式
										color : 'black',
										fontSize : 16
									}
								}
							}
						},
					} ]
				};

				function loadNewsSourceData(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/news/getNewsSource",
								data : {},
								dataType : "json",
								success : function(result) {
									if (result) {
										option.xAxis[0].data = [];
										for ( var i in result) {
											option.xAxis[0].data.push(i);
										}
										option.series[0].data = [];
										for ( var i in result) {
											option.series[0].data
													.push(result[i]);
										}
									}
								}
							});
				}

				var entityLocOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [ {
						name : '数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [ {
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						}
					} ],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color : "#1C86EE",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					} ]
				};

				function loadEntityLocData(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/main/getLoc?lang="
										+ lang,
								data : {},
								dataType : "json",
								success : function(result) {
									if (result) {
										option.xAxis[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.xAxis[0].data
													.push(result[i].entity_key);
										}
										option.series[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.series[0].data
													.push(result[i].count);
										}
									}
								}
							});
				}

				var entityPerOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [ {
						name : '数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [ {
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						},
					} ],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color : "#8968CD",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					} ]
				};

				function loadEntityPerData(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/main/getPer?lang="
										+ lang,
								data : {},
								dataType : "json",
								success : function(result) {
									if (result) {
										option.xAxis[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.xAxis[0].data
													.push(result[i].entity_key);
										}
										option.series[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.series[0].data
													.push(result[i].count);
										}
									}
								}
							});
				}

				var entityOrgOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [ {
						name : '实体数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [ {
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						},
					} ],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color : "#228B22",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					} ]
				};
				function loadEntityOrgData(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/main/getOrg?lang="
										+ lang,
								data : {},
								dataType : "json",
								success : function(result) {
									if (result) {
										option.xAxis[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.xAxis[0].data
													.push(result[i].entity_key);
										}
										option.series[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.series[0].data
													.push(result[i].count);
										}
									}
								}
							});
				}

				//全部实体
				var entityAllOption = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 50,
						y : 25,
						x2 : 20,
						y2 : 80
					},
					calculable : true,
					yAxis : [ {
						name : '数量',
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [ {
						name : '实体',
						type : 'category',
						axisLabel : {
							interval : 0,
							rotate : -45,
							margin : 5,
						},
					} ],
					series : [ {
						type : 'bar',
						itemStyle : {
							normal : {
								color : "#228B22",
								label : {
									show : true,
									textStyle : {
										fontWeight : 'boler',
										fontSize : '12',
										fontFamily : '微软雅黑',
										color : "#000000"
									}
								}
							}
						},
					} ]
				};
				function loadEntityAllData(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/main/getAll?lang="
										+ lang,
								data : {},
								dataType : "json",
								success : function(result) {
									if (result) {
										option.xAxis[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.xAxis[0].data
													.push(result[i].entity_key);
										}
										option.series[0].data = [];
										for (var i = 0; i < result.length; i++) {
											option.series[0].data
													.push(result[i].count);
										}
									}
								}
							});
				}

				var newsCountOption = {
					tooltip : {
						trigger : 'axis'
					},
					legend : {
						data : [ '中文', '藏文', '维文', '蒙文' ]
					},
					grid : {
						x : 50,
						y : 50,
						x2 : 50,
						y2 : 50,
						containLabel : true
					},
					toolbox : {
						feature : {
							saveAsImage : {}
						}
					},
					xAxis : {
						name : '日期',
						type : 'category',
						boundaryGap : false,
					//data: ['周一','周二','周三','周四','周五','周六','周日']
					},
					yAxis : {
						name : '数量',
						type : 'value'
					},
					series : [ {
						name : '中文',
						type : 'line',
						stack : '总量',
					//data:[120, 132, 101, 134, 90, 230, 210]
					}, {
						name : '藏文',
						type : 'line',
						stack : '总量',
					//data:[220, 182, 191, 234, 290, 330, 310]
					}, {
						name : '维文',
						type : 'line',
						stack : '总量',
					//data:[150, 232, 201, 154, 190, 330, 410]
					}, {
						name : '蒙文',
						type : 'line',
						stack : '总量',
					//data:[320, 332, 301, 334, 390, 330, 320]
					} ]
				};

				function loadNewsNumData(option) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/main/getAllNewsNum",
								data : {},
								dataType : "json",
								success : function(result) {
									option.xAxis.data = [];
									option.series[0].data = [];
									option.series[1].data = [];
									option.series[2].data = [];
									option.series[3].data = [];
									for ( var i in result) {
										option.xAxis.data.push(i);
										option.series[0].data
												.push(result[i][0]);
										option.series[1].data
												.push(result[i][1]);
										option.series[2].data
												.push(result[i][2]);
										option.series[3].data
												.push(result[i][3]);
									}
								}
							});
				}

				var lang = '${sessionScope.lang}';
				loadNewsSourceData(entityNewsSourceOption, lang);
				loadEntityLocData(entityLocOption, lang);
				loadEntityPerData(entityPerOption, lang);
				loadEntityOrgData(entityOrgOption, lang);
				loadEntityAllData(entityAllOption, lang);
				//loadSensitiveData(sensitiveOption,lang);

				loadNewsNumData(newsCountOption);

				//topicMapChart.setOption(topicMapOption);
				entityNewsSourceChart.setOption(entityNewsSourceOption);
				//sensitiveTrendChart.setOption(sensitiveOption);
				//entityLocChart.setOption(entityLocOption);
				//entityPerChart.setOption(entityPerOption);
				//entityOrgChart.setOption(entityOrgOption);
				entityAllChart.setOption(entityAllOption);
				newsNumChart.setOption(newsCountOption);
			});

	function switchLang(obj) {
		var form = document.getElementById("langTypeForm");
		form.submit();
	}
	function removeMapLogo() {
		if (document.readyState == 'complete') {
			$(".anchorBL").remove();
		}
	}
	$(function() {
		$("select option[value='" + '${lang}' + "']").attr("selected",
				"selected");
		document.body.onselectstart = document.body.oncontextmenu = function() {
			return false;
		}
		document.onreadystatechange = removeMapLogo;
	});
</script>
<style type="text/css">
body {
	font: 16px/100% "微软雅黑";
}

.top {
	background-color: #0050a2;
	height: 50px;
}
</style>
</head>

<body onload="javascript: loadData();">
	<div id="wrapper">
		<nav class="navbar navbar-fixed-top top" role="navigation">
			<!-- 项目名 -->
			<div class="project">
				<div class="navbar-header">
					<a class="navbar-brand project-name" href="#"> <span
						style="color: white;">民汉舆情汇聚与监测系统</span>
					</a>
				</div>
			</div>
			<div class="col-md-3 col-set" style="float: right;">
				<div class="panel-body">
					<form id="langTypeForm" action="chooselang" method="post">
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
						<!-- <li><a href="http://10.10.130.152:6688/" target="_blank">
								<span class="glyphicon glyphicon-road span-icon"></span> 知识图谱
						</a></li> -->
						<li class="active"><a id="customMonitorBtn"
							href="javascript: void(0);" onclick="listUserWord();"> <span
								class="glyphicon glyphicon-book span-icon"></span> 自定义监测
						</a>
							<ul class="nav nav-second-level sub-menu" id="usersubmenu"></ul>
						</li>
						<!-- 添加语言地图 -->
						<!-- <li><a href="http://10.119.130.183:8080/map/" target="_blank">
								<span class="glyphicon glyphicon-th-large span-icon"></span>
								语言地图
						</a></li> -->
					</ul>
				</div>
			</div>
		</nav>

		<!-- 右侧主体部分 -->
		<div id="page-wrapper">
			<div class="row row-ptop-25">
				<div class="row row-not-margin">
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-map-marker"></span> 话题地图
							</div>
							<div class="panel-body panel-map">
								<div id="topic_map" style="width: 100%; height: 360px;"></div>
							</div>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-stats"></span> 新闻来源
							</div>
							<div class="panel-body">
								<div id="news_source" style="width: 100%; height: 350px;"></div>
							</div>
						</div>
					</div>
				</div>

				<script type="text/javascript">
					var map1 = new BMap.Map("topic_map", {
						minZoom : 3,
						maxZoom : 7
					});
					var point = new BMap.Point(116.404, 39.915);
					map1.centerAndZoom(point, 6); // 编写自定义函数，创建标注
					map1.enableScrollWheelZoom(true); //开启鼠标滚轮缩放

					var data_info = [ [ 116.380943298, 39.923614502, "35" ],
							[ 117.20349884, 39.1311187744, "41" ],
							[ 114.489776611, 38.0451278687, "69" ],
							[ 118.201728821, 39.6253395081, "49" ],
							[ 119.598297119, 39.9243087769, "52" ],
							[ 114.472953796, 36.6015167236, "33" ],
							[ 114.49508667, 37.0655899048, "89" ],
							[ 113.574256897, 37.8606567383, "31" ],
							[ 113.105567932, 36.1819114685, "83" ],
							[ 112.842720032, 35.5065116882, "11" ],
							[ 112.423271179, 39.3131332397, "19" ],
							[ 118.75, 30.95, "35" ], [ 110.47, 29.13, "41" ] ];
					var opts = {
						width : 250, // 信息窗口宽度
						height : 80, // 信息窗口高度
						title : "新闻数量", // 信息窗口标题
						enableMessage : true
					//设置允许信息窗发送短息
					};
					for (var i = 0; i < data_info.length; i++) {
						var marker = new BMap.Marker(new BMap.Point(
								data_info[i][0], data_info[i][1])); // 创建标注
						var content = data_info[i][2];
						map1.addOverlay(marker); // 将标注添加到地图中
						addClickHandler(content, marker);
					}
					function addClickHandler(content, marker) {
						marker.addEventListener("click", function(e) {
							openInfo(content, e)
						});
					}
					function openInfo(content, e) {
						var p = e.target;
						var point = new BMap.Point(p.getPosition().lng, p
								.getPosition().lat);
						var infoWindow = new BMap.InfoWindow(content, opts); // 创建信息窗口对象 
						map1.openInfoWindow(infoWindow, point); //开启信息窗口
					}
				</script>

				<!-- 实体统计 -->
				<div class="row row-not-margin">
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-stats"></span> 实体统计
							</div>
							<div class="panel-body">
								<div id="news_count_entity" style="width: 100%; height: 350px;"></div>
							</div>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-stats"></span> 新闻统计
							</div>
							<div class="panel-body">
								<div id="news_count_chart" style="width: 100%; height: 350px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 热门话题 -->
			<div class="row row-not-margin">
				<div class="panel panel-success">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-bell"></span> 热门话题
					</div>
					<div class="panel-body"
						style="overflow: auto; margin-bottom: 10px;">
						<c:forEach items="${topicList}" var="topic">
							<div style="height: auto;">
								<div style="float: left; padding-right: 10px;">
									<span style="color: blue;">${topic.news_count}</span>
								</div>
								<div style="margin-top: 5px">
									<a
										href="<%=request.getContextPath() %>/topic/${topic.topic_id}/newtopic"
										style="cursor: pointer;">${topic.topic_name}</a>
								</div>
								<div style="float: right; padding-right: 70px;">
									<fmt:formatDate value="${topic.news_time}" type="date" pattern="yyyy-MM-dd" />
								</div>
								<br />
							</div>
						</c:forEach>
					</div>
				</div>
			</div>

			<!-- 宗教新闻 -->
			<div class="row row-not-margin">
				<div class="panel panel-success">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-stats"></span> 宗教新闻
					</div>
					<div class="panel-body"
						style="overflow: auto; margin-bottom: 10px;">
						<c:forEach items="${religion}" var="religion">
							<div style="height: auto;">
								<div style="margin-top: 15px">
									<a style="height: auto;"
										href="<%=request.getContextPath()%>/topic/${religion.news_id }/newsDisplay">${religion.news_title}</a>
								</div>
								<div style="float: right; padding-right: 70px;">
									<fmt:formatDate value="${religion.news_time}" type="date"
										pattern="yyyy-MM-dd" />
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.row -->

	<!--版权-->
	<div class="footer"></div>

	<!-- 半透明背景层 -->
	<div id="bg">
		<div id="wait_login">
			<img src="img/wait_login.gif" />
		</div>
	</div>

	<!-- 新闻列表模态框 -->
	<div id="pointNewsList" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="modal-title">新闻列表</h3>
				</div>
				<div class="modal-body modal-body-point"></div>
				<div class="modal-footer modal-footer-point">
					<div id="pagination"></div>
					<!-- 模态框页脚分页 -->
					<button type="button" class="btn btn-sm btn-primary"
						data-dismiss="modal">关 闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 新闻内容模态框 -->
	<div id="pointNewsContent" class='modal fade news-modal' tabindex='-1'
		role='dialog' aria-labelledby='modalLabel' aria-hidden='true'>
		<div class='modal-dialog modal-newsContent-width'>
			<div class='modal-content'>
				<div class='modal-header'>
					<button type='button' class='close' data-dismiss='modal'
						aria-hidden='true'>&times;</button>
					<h3 class='modal-title' id='modalNewstTitle'></h3>
				</div>
				<div class='modal-body modal-news-content'
					style="min-height: 410px;">
					<div class='news_time'>
						<span class='glyphicon glyphicon-time'></span> <span
							id="modalNewsTime"></span>
					</div>
					<span id="modalNewsContent"></span>
				</div>
				<div class='modal-footer modal-footer-point' id='yqjg_a'></div>
			</div>
		</div>
	</div>

	<!-- 自定义监测添加 -->
	<div id="monitor" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
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
		</div>
	</div>
	<!-- 实体详情 -->
	<div class="popover top">
		<div class="arrow"></div>
		<div class="popover-title"></div>
		<div class="popover-content"></div>
	</div>
</body>

</html>
