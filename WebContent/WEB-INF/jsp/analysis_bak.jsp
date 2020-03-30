<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="zh-CN">

<head>
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
<script
	src="<%=request.getContextPath()%>/resources/js/analysis/analysis.js"></script>
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
</style>

<script type="text/javascript">
  	function topic_filter(value)
  	{
  		$
	.ajax({
		type : "get",
		async : false,
		url : "${request.contextPath}/mwyqMonitor/mystat/getSelect",
		data : {
			selected:value
		},
		dataType : "text",
		success:function(){
			location.reload();
              }
	});
  	}
var myChart4 = echarts.init(document.getElementById('newsLangCount_chart'));
var lang = '${sessionScope.lang}';

var dataCategory = [];
var dataCateValue = [];
$.ajax({
	type : "get",
	async : false,
	url : "${request.contextPath}/mwyqMonitor/topic/getNewsCategory?lang=" + lang,
	dataType : "json",
	success : function(result) {
		if (result) {
			for ( var i in result) {
				dataCategory.push(i);
				dataCateValue.push({
					value:result[i],
					name:i
				});
			}
		}
	}
});

option4 = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        x: 'left',
	        data:dataCategory
	    },
	    series: [
	        {
	            name:'新闻类别',
	            type:'pie',
	            radius: ['50%', '70%'],
	            avoidLabelOverlap: false,
	            label: {
	                normal: {
	                    show: false,
	                    position: 'center'
	                },
	                emphasis: {
	                    show: true,
	                    textStyle: {
	                        fontSize: '20',
	                        fontWeight: 'bold'
	                    }
	                }
	            },
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:dataCateValue
	        }
	    ]
	};
	myChart4.setOption(option4);
	var mySensitiveChart8 = echarts.init(document.getElementById('sensitive_news_count_x'));
 	var optionSensitive = {
 		    tooltip: {
 		        trigger: 'axis'
 		    },
 		    legend: {
 		        data:['全部新闻','中性新闻','敏感新闻']
 		    },
 		    grid : {
					x : 50,
					y : 50,
					x2 : 50,
					y2 : 30
			},
 		    xAxis: {
 		        type: 'category',
 		        boundaryGap: false,
 		        //data: ['周一','周二','周三','周四','周五','周六','周日']
 		       axisLabel : {
					interval : 0,
					rotate : -10,
					margin : 2,
					textStyle : {
						//fontWeight : "bolder",
						color : "#000000"
					}
				}
 		    },
 		    yAxis: {
 		        type: 'value'
 		    },
 		    series: [
 		        {
 		            name:'全部新闻',
 		            type:'line',
 		            stack: '总量',
 		            //data:[120, 132, 101, 134, 90, 230, 210]
 		        },
 		        {
 		            name:'中性新闻',
 		            type:'line',
 		            stack: '总量',
 		            //data:[220, 182, 191, 234, 290, 330, 310]
 		        },
 		        {
 		            name:'敏感新闻',
 		            type:'line',
 		            stack: '总量',
 		            //data:[150, 232, 201, 154, 190, 330, 410]
 		        }
 		    ]
 		};
 	                     	
function loadSensitiveData(option,lang) {
	$.ajax({
		type : "get",
	async : false,
	url : "${request.contextPath}/mwyqMonitor/mystat/getSensitiveByLang?lang=" + lang,
	data:{},
	dataType : "json",
	success : function(result) {
		option.xAxis.data = [];
		option.series[0].data = [];
		option.series[1].data = [];
		option.series[2].data = [];
		for (var i in result) {
			option.xAxis.data.push(i);
			option.series[0].data.push(result[i][0]);
			option.series[1].data.push(result[i][1]);
			option.series[2].data.push(result[i][2]);
		}
	}
	});
}
loadSensitiveData(optionSensitive,lang);
mySensitiveChart8.setOption(optionSensitive);

var myChart = echarts.init(document.getElementById('event_count_chart_x'));
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
	}],
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
				color:"#0f0",
				areaStyle : {
					color:"#2578cb",
				}
			}
		}
	}]
};
function loadEventCountData(option, lang) {
	$.ajax({
		type : "get",
		async : false,
		url : "${request.contextPath}/mwyqMonitor/topic/getTopicNum?lang=" + lang,
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
					option.series[0].data.push(result[i]);
				}
			}
			else{
				option.xAxis[0].data = [0,0,0,0,0,0,0];
				option.series[0].data = [0,0,0,0,0,0,0];
			}
		}
	});
}
loadEventCountData(eventCountOption,lang);
myChart.setOption(eventCountOption); 
var myChart = echarts.init(document.getElementById('entity_count_chart_x'));
var keys = [];
var values = [];
$.ajax({
	type : "get",
	async : false,
	url : "${request.contextPath}/mwyqMonitor/topic/getStaticEntity?lang=" + lang,
	dataType : "json",
	success : function(result) {
		if (result) {
			for ( var i in result) {
				keys.push(i);
				values.push(result[i]);
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
		radius : '75%',
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
				res.push({
					name : keys[len],
					value : values[len]
				});
			}
			return res;
		})()
	} ]
};
myChart.setOption(option3);
</script>
</head>

<body>
	<div id="wrapper">
		<nav class="navbar navbar-fixed-top top" role="navigation">
			<div class="project">
				<div class="navbar-header">
					<a class="navbar-brand project-name" href="#"> <span
						style="color: white;">民汉舆情汇聚与监测系统</span>
					</a>
				</div>
			</div>
			<!-- 左侧导航栏 -->
			<div class="navbar-default navbar-static-side" role="navigation">
				<div class="sidebar-collapse">
					<ul class="nav">
						<li><a href="#"> <span
								class="glyphicon glyphicon-home span-icon"></span> 总览
						</a></li>
						<li><a href="http://210.31.15.93:8080/baidu/" target="_blank">
								<span class="glyphicon glyphicon-search span-icon"></span>搜索
						</a></li>
						<li>
							<a href="<%=request.getContextPath()%>/mynews/"> 
								<span class="glyphicon glyphicon-list span-icon"></span> 实时热点
							</a>
						</li>
						<li><a href="<%=request.getContextPath()%>/mystat/"
							target="_blank"> <span
								class="glyphicon glyphicon-stats span-icon"></span> 统计分析
						</a></li>
						<li><a href="<%=request.getContextPath()%>/sensite/"
							target="_blank"> <span
								class="glyphicon glyphicon-flag span-icon"></span> 敏感词检测
						</a></li>
						<li><a href="<%=request.getContextPath()%>/weibo/"
							target="_blank"> <span
								class="glyphicon glyphicon-time span-icon"></span> 微博分析
						</a></li>
						<li><a href="<%=request.getContextPath()%>/twitter/"
							target="_blank"> <span
								class="glyphicon glyphicon-th-large span-icon"></span> 推特分析
						</a></li>
						<li><a href="http://10.10.130.152:6688/" target="_blank">
								<span class="glyphicon glyphicon-road span-icon"></span> 知识图谱
						</a></li>
						<li class="active"><a id="customMonitorBtn"
							href="javascript: void(0);" onclick="listUserWord();"> <span
								class="glyphicon glyphicon-book span-icon"></span> 自定义监测
						</a>
							<ul class="nav nav-second-level sub-menu" id="usersubmenu"></ul>
						</li>
						<!-- 添加语言地图 -->
						<li><a href="http://10.119.130.183:8080/map/" target="_blank">
								<span class="glyphicon glyphicon-th-large span-icon"></span>
								语言地图
						</a></li>
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
								<span class="glyphicon glyphicon-stats"></span> 敏感分析
							</div>
							<div class="panel-body">
								<div id="sensitive_news_count_x" style="height: 310px"></div>
							</div>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-stats"></span> 话题数量
							</div>
							<div class="panel-body">
								<div id="event_count_chart_x"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row row-not-margin">
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-stats"></span> 实体统计
							</div>
							<div class="panel-body">
								<div id="entity_count_chart_x">
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="panel panel-success">
							<div class="panel-heading">
								<span class="glyphicon glyphicon-stats"></span>新闻类别统计
							</div>
							<div class="panel-body">
								<div id="newsLangCount_chart">
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
										<button type="button" id="btn_langFilter"
											class="btn btn-default btn-xs" data-toggle="dropdown">
											<span id="lang_category">全部</span> <span class="caret"></span>
										</button>
										<ul class="dropdown-menu pull-right" role="menu"
											id="filter_ul_li">
											<li><a onclick="topic_filter('all')">全部</a></li>
											<li><a onclick="topic_filter('week')">过去一周</a></li>
											<li><a onclick="topic_filter('month')">过去一月</a></li>
											<li><a onclick="topic_filter('year')">过去一年</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<c:forEach items="${topicList}" var="topic">
									<div id="hotTopicItem" style="height: 200px;">
										<div id="hotTopicNewsCount"
											style="display: inline; float: left; font-size: 20px; width: 50px; color: blue;">${topic.news_count}</div>
										<div id="hotTopicTitle"
											style="margin-left: 50px; margin-top: 25px; text-algin: left;">
											<a style="display: inline; font-size: 20px;"
												href="<%=request.getContextPath() %>/topic/${topic.topic_id}/newtopic"
												target="_blank">${topic.topic_name}</a> &nbsp;&nbsp;
											<fmt:formatDate value="${topic.news_time}" type="date"
												pattern="yyyy-MM-dd HH:mm:ss" />
											<br></br>
											<div id="topicNewsContent"
												style="width: 100%; height: 140px; overflow: hidden; font-size: 16px; line-height: 1.5;">${topic.news_content}</div>
										</div>
									</div>
									<hr></hr>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footer"></div>
</body>
</html>
