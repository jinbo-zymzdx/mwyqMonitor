<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>蒙汉舆情汇聚与分析系统</title>
	<meta name="description" content="">
	<meta name="author" content="">
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/resources/css/bootstrap_min.css" />
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/resources/css/menu.css" />
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
	
	<script type="text/javascript">
		//路径配置
		require.config({
			paths : {
				echarts : 'http://echarts.baidu.com/build/dist'
			}
		});
	
		// 使用
		require(
				[ 'echarts', 'echarts/chart/line', 'echarts/chart/bar',
						'echarts/chart/pie'
	
				// 使用柱状图就加载bar模块，按需加载
				],
				//  drewEcharts
				//    );
				function(ec) {
					// 基于准备好的dom，初始化echarts图表
					var myChart1 = ec.init(document.getElementById('test1'));
					var myChart2 = ec.init(document.getElementById('test2'));
					var myChart3 = ec.init(document.getElementById('test3'));
	
					//window.onresize = myChart1.resize;
					option1 = {
						//    title : {
						//        text: '某楼盘销售情况',
						//        subtext: '纯属虚构'
						//    },
						tooltip : {
							trigger : 'axis'
						},
						//    legend: {
						//        data:['意向','预购','成交']
						//    },
						toolbox : {
							show : true,
						//      feature : {
						//          mark : {show: true},
						//          dataView : {show: true, readOnly: false},
						//          magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
						//          restore : {show: true},
						//          saveAsImage : {show: true}
						//      }
						},
						calculable : true,
						xAxis : [ {
							type : 'category',
							boundaryGap : false,
							//    data : ['周一','周二','周三','周四','周五','周六','周日']
							axisLabel : {
								interval : 0,
								rotate : 5,
								margin : 2,
								textStyle : {
									fontWeight : "bolder",
									color : "#000000"
								}
							},
						} ],
						yAxis : [ {
							type : 'value'
						} ],
						series : [ {
							name : '新闻数量',
							type : 'line',
							smooth : true,
							itemStyle : {
								normal : {
									areaStyle : {
										type : 'default'
									}
								}
							},
						//  data:[10, 12, 21, 54, 260, 830, 710]
						}
	
						]
					};
	
					function loadData1(option, lang) {
						$
								.ajax({
									type : "get",
									async : false,
									url : "${request.contextPath}/mwyqMonitor/news/getNewsTime?lang="
											+ lang,
									data : {},
									dataType : "json",
									success : function(result) {
										if (result) {
											option.xAxis[0].data = [];
											//	for (var i = 0; i < result.length; i++) {
											//		option.xAxis[0].data.push(i);
											//	}
											for ( var i in result) {
												option.xAxis[0].data.push(i);
											}
											option.series[0].data = [];
											//	for (var i = 0; i < result.length; i++) {
											//		option.series[0].data.push(result[i]);
											//	}
											for ( var i in result) {
												option.series[0].data
														.push(result[i]);
											}
										}
									}
	
								});
					}
	
					option2 = {
						//  title : {
						//      text: '世界人口总量',
						//      subtext: '数据来自网络'
						//  },
						tooltip : {
							trigger : 'axis'
						},
						//    legend: {
						//        data:['2011年', '2012年']
						//    },
						toolbox : {
							show : true,
						//    feature : {
						//        mark : {show: true},
						//        dataView : {show: true, readOnly: false},
						//        magicType: {show: true, type: ['line', 'bar']},
						//        restore : {show: true},
						//        saveAsImage : {show: true}
						//    }
						},
						calculable : true,
						yAxis : [ {
							type : 'value',
							boundaryGap : [ 0, 0.01 ]
						} ],
						xAxis : [ {
							type : 'category',
							//  data : ['巴西','印尼','美国','印度','中国','世界人口(万)']
							axisLabel : {
								interval : 0,
								rotate : 5,
								margin : 2,
								textStyle : {
									fontWeight : "bolder",
									color : "#000000"
								}
							},
						} ],
						series : [ {
							name : '话题数量',
							type : 'bar',
						//   data:[18203, 23489, 29034, 104970, 131744, 630230]
						},
	
						]
					};
					function loadData2(option, lang) {
						$
								.ajax({
									type : "get",
									async : false,
									url : "${request.contextPath}/mwyqMonitor/topic/getTopicTime?lang="
											+ lang,
									data : {},
									dataType : "json",
									success : function(result) {
										if (result) {
											option.xAxis[0].data = [];
											//	for (var i = 0; i < result.length; i++) {
											//		option.xAxis[0].data.push(i);
											//	}
											for ( var i in result) {
												option.xAxis[0].data.push(i);
											}
											option.series[0].data = [];
											//	for (var i = 0; i < result.length; i++) {
											//		option.series[0].data.push(result[i]);
											//	}
											for ( var i in result) {
												option.series[0].data
														.push(result[i]);
											}
										}
									}
	
								});
					}
	
					var lang = '${sessionScope.lang}';
					var keys = [];
					var values = [];
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/topic/getEntityNum?lang="
										+ lang,
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
						//title : {
						//    text: '某站点用户访问来源',
						//     subtext: '纯属虚构',
						//      x:'center'
						//   },
						tooltip : {
							trigger : 'item',
							formatter : "{a} <br/>{b} : {c} ({d}%)"
						},
						legend : {
							orient : 'vertical',
							x : 'left',
							data : [ '人物', '地点', '组织机构' ]
						},
						/*
						toolbox: {
							show : true,
							feature : {
						    	mark : {show: true},
						   	 	dataView : {show: true, readOnly: false},
						    	magicType : {
						        	show: true, 
						        	type: ['pie', 'funnel'],
						        	option: {
						            	funnel: {
						                	x: '25%',
						                	width: '50%',
						                	funnelAlign: 'left',
						                	max: 1548
						            	}
						        	}
						    	},
						    	restore : {show: true},
						    	saveAsImage : {show: true}
							}
						},
						 */
						calculable : true,
						series : [ {
							name : '实体统计',
							type : 'pie',
							radius : '75%',
							center : [ '50%', '60%' ],
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
					var lang = '${sessionScope.lang}';
					loadData1(option1, lang);
					loadData2(option2, lang);
					// 为echarts对象加载数据 
					myChart1.setOption(option1);
					myChart2.setOption(option2);
					myChart3.setOption(option3);
	
				}
		/*
		 function loadData(option3){
		
		 $.ajax({
		 type : "GET",
		 async : false,
		 url : "/",
		 data : {},
		 dataType : "json",
		 success : function(result){
		 if(result){
		 option3.yAxis[0].data=[];
		 for(var i=0;i<result.length;i++){
		 option3.yAxis[0].data.push(result[i].entity_key);
		 }
		 option3.series[0].data=[];
		 for(var i=0;i<result.length;i++){
		 option3.series[0].data.push(result[i].entity_type);
		 }
		 }
		 }
		
		 });
		 }
		 */
		);
	</script>
</head>
<body>
	<div id="container" class="container" style="float:left;">
		<img src="<%=request.getContextPath()%>/resources/images/templatemoheader.jpg"
			class="img-responsive" style="height: 10%;" />
		<ul class="nav nav-justified bd" style="height:60px;padding-left:50px;">
			<li style="width:200px;"><a href="/mwyqMonitor/topic/">&nbsp;&nbsp;首 &nbsp;&nbsp;页 &nbsp;&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/news/">&nbsp;实时热点&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/statis/">&nbsp;统计分析&nbsp;</a></li>
			<li style="width:200px;"><a href="/baidu/">&nbsp;&nbsp;搜 &nbsp;&nbsp;索 &nbsp;&nbsp;</a></li>
		</ul>

		<div class="row space29" style="width:80%;margin-left:10%;height:400px;margin-bottom:20px;">
			<div class="col-md-4" style="width:50%;height:100%;float:left;padding-right:10px;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading ">新闻数量</div>
						<div id="test1" class="panel-body" style="height:350px;width:100%;"></div>
					</div>
				</div>

			</div>
			<div class="col-md-4" style="width:50%;height:100%;float:left;padding-left:10px;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading ">话题数量</div>
						<!-- 话题数量ID未知，注意修改 -->
						<div id="test2" class="panel-body" style="height:350px;width:100%;"></div>
					</div>
				</div>

			</div>
			<!-- /row 1 -->
		</div>

		<div class="row space29" style="width:80%;margin-left:10%;height:500px;">
			<div class="col-md-4" style="width:50%;height:100%;float:left;padding-right:10px;">
			<div class="new-des" style="">
			<div class="panel panel-default">
				<div class="panel-heading ">话题历史排行</div>
				<div class="row space30  meng" style="width:100%;height:440px;">
					<!-- row 2 begins -->
					<div class="bottomRealContent" style="width: 100%;">
						<!-- 此处要求获取话题历史排行，目前放的是新闻获取代码，请注意修改！ -->
						<div id="hot_topic_div"
							style="margin-bottom: 8px;">
							<c:forEach items="${topicList}" var="topic">
								<div class="bottomContentBox"
									style="font-family: MENKSOFT2007; word-break: keep-all; border-right: 3px solid #cdcdcd; moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr; width: auto;">
									<div class="huati">
										<p style="writing-mode: tb-lr; writing-mode: vertical-lr; font-size: 20px; height: 400px; width: auto; border-right: 1px dashed #cdcdcd;">
											<a style="writing-mode: lr-tb; writing-mode: lr-vertical; color: red">${topic.news_count}</a>
											<a href="<%=request.getContextPath() %>/topic/${topic.topic_id}/news" style="font-size: 20px; width:auto;height:430px;">${topic.topic_name}</a>
										</p>
									</div>
									<p class="show-line-3" style="height: 400px; margin-top: 5px; width: 200px;font-size: 16px;">
										${topic.news_content} <small class="pull-right text-muted" style="font-size: 12px;">${topic.news_time}</small>
									</p>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				</div>
				</div>
			</div>

			<div class="col-md-4" style="width:50%;height:100%;float:left;padding-left:10px;">
				<div class="new-des" style="">
					<div class="panel panel-default">
						<div class="panel-heading ">实体统计</div>
						<div id="test3" class="panel-body" style="height: 440px; width:100%;"></div>
					</div>
				</div>
			</div>
		</div>

		<!-- Site footer -->
		<div class="footer bd">
			<p style="text-align: center;">Copyright @ 2018 中央民族大学</p>
		</div>
		<!-- /container -->
	</div>
</body>
</html>
