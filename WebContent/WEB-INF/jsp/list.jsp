<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>蒙汉舆情汇聚与分析系统</title>
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" />
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
	var width;
	var height;
	$(function() {
		width = $(window).width();
		height = $(window).height();
		$("#mainBar").css("width", width - 40);
		$("#mainBar").css("height", height - 40);
		console.log(height);
		setEcharts();
	});
	$(window).resize(function() {
		width = $(window).width();
		height = $(window).height();
		$("#mainBar").css("width", width - 40);
		$("#mainBar").css("height", height - 40);
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
					'echarts/chart/bar', 'echarts/chart/pie'
			// 使用柱状图就加载bar模块，按需加载
			],
			//  drewEcharts
			//    );
			function setEcharts(ec) {
				// 基于准备好的dom，初始化echarts图表
				var myChart = ec.init(document.getElementById('map'));
				var myChart1 = ec.init(document.getElementById('bo'));
				var myChart2 = ec.init(document.getElementById('place'));
				var myChart3 = ec.init(document.getElementById('person'));
				var myChart4 = ec.init(document.getElementById('org'));

				window.onresize = myChart.resize;
				window.onresize = myChart1.resize;
				window.onresize = myChart2.resize;
				window.onresize = myChart3.resize;
				window.onresize = myChart4.resize;

				var option = {
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
						}, {
							name : '辽宁',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '黑龙江',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '湖南',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '安徽',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '山东',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '新疆',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '江苏',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '浙江',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '江西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '湖北',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '广西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '甘肃',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '山西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '内蒙古',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '陕西',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '吉林',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '福建',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '贵州',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '广东',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '青海',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '西藏',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '四川',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '宁夏',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '海南',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '台湾',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '香港',
							value : Math.round(Math.random() * 1000)
						}, {
							name : '澳门',
							value : Math.round(Math.random() * 1000)
						} ]
					} ]
				};
				var option1 = {
					//数据提示框配置  
					tooltip : {
						trigger : 'item' //触发类型，默认数据触发，见下图，可选为：'item' | 'axis' 其实就是是否共享提示框  
					},
					grid : {
						x : 55,
						y : 10,
						x2 : 10,
						y2 : 20
					},
					calculable : true,
					//轴配置  
					xAxis : [ {
						type : 'category',
						// data:[{value:"${year}"+"-"+"${month}"+"-"+"${date}"}],
						//data : [ '2016-4-5', '2016-06-05', '2016-06-10', '2016-06-15',
						//		'2016-06-20', '2016-06-25', '2016-06-30', '2016-07-05',
						//		'2016-07-10', '2016-07-15', '2016-07-20' ],
						//data : arrx
						//data: 
						axisLabel : {
							interval : 0,
							rotate : 5,
							margin : 2,
							textStyle : {
								fontWeight : "bolder",
								color : "#000000"
							}
						}
					} ],
					//Y轴配置  
					yAxis : [ {
						type : 'value',
					//  splitArea: { show: true },  
					//   name:"数值"  
					} ],
					//图表Series数据序列配置  
					/*  series: []
					 }; */
					series : [ {
						type : 'line',
						smooth : true,
						itemStyle : {
							normal : {
								areaStyle : {
									type : 'default'
								}
							}
						},
					// data:[{value:"${integerlist[i]}"}],
					//data : [ 500, 100, 1000, 2500, 2000, 1000, 200, 1000, 500, 500,
					//		2000, 100 ]
					//data:arry
					} ]
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

				var option2 = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 40,
						y : 18,
						x2 : 10,
						y2 : 35
					},
					calculable : true,
					yAxis : [ {
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [ {
						type : 'category',
						//  data : ['巴西','印尼','美国','印度','中国','世界']
						axisLabel : {
							interval : 0,
							rotate : -90,
							margin : 8,
						//textStyle:{
						//	fontWeight:"bolder",
						//	color:"#000000"
						//}
						}
					} ],
					series : [ {
						type : 'bar',
						// data:[100, 200, 500, 550, 600, 600]
						itemStyle : {
							normal : {
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

				function loadData2(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/topic/getLoc?lang="
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

				//	var keys = new Array("夏天","天天");
				//var values = [100,200];

				var option3 = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 40,
						y : 18,
						x2 : 10,
						y2 : 35
					},
					calculable : true,
					yAxis : [ {
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					//type : 'category',
					} ],
					xAxis : [ {
						type : 'category',
						// data : ['巴西','印尼','美国','印度','中国','世界']
						//data:keys

						//data : keys

						//type : 'value',
						//boundaryGap : [0, 0.01]
						axisLabel : {
							interval : 0,
							rotate : -90,
							margin : 8,
						//textStyle:{
						//	fontWeight:"bolder",
						//	color:"#000000"
						//}
						},

					} ],
					series : [ {
						'type' : 'bar',
						//   data:[100, 200, 500, 550, 600, 600]
						//	data : [${indexEntity['per_1']},${indexEntity['per_2']}]
						//'data':values
						itemStyle : {
							normal : {
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

				function loadData3(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/topic/getPer?lang="
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

				var option4 = {
					tooltip : {
						trigger : 'item'
					},
					grid : {
						x : 40,
						y : 18,
						x2 : 10,
						y2 : 35
					},
					calculable : true,
					yAxis : [ {
						type : 'value',
						boundaryGap : [ 0, 0.01 ]
					} ],
					xAxis : [ {
						type : 'category',
						//   data : ['巴西','印尼','美国','印度','中国','世界']
						axisLabel : {
							interval : 0,
							rotate : -90,
							margin : 8,
						//textStyle:{
						//	fontWeight:"bolder",
						//	color:"#000000"
						//}
						},
					} ],
					series : [ {
						type : 'bar',
						//    data:[100, 200, 500, 550, 600, 600]
						itemStyle : {
							normal : {
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
				function loadData4(option, lang) {
					$
							.ajax({
								type : "get",
								async : false,
								url : "${request.contextPath}/mwyqMonitor/topic/getOrg?lang="
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

				var lang = '${sessionScope.lang}';

				loadData1(option1, lang);
				loadData2(option2, lang);
				loadData3(option3, lang);
				loadData4(option4, lang);

				// 为echarts对象加载数据 
				myChart.setOption(option);
				myChart1.setOption(option1);
				myChart2.setOption(option2);
				myChart3.setOption(option3);
				myChart4.setOption(option4);
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


	<div id="container" class="container bd" style="float: right">

		<img
			src="<%=request.getContextPath()%>/resources/images/templatemoheader.jpg"
			class="img-responsive" style="height: 10%;" />


		<ul class="nav nav-justified bd" style="height: 8%;">

			<li><a href="/mwyqMonitor/topic/">&nbsp;&nbsp;首 &nbsp;
					&nbsp;页 &nbsp;&nbsp;</a></li>
			<li><a href="/mwyqMonitor/news/">&nbsp;实时热点&nbsp;</a></li>
			<!--  		<li><a href="/mwyqMonitor/topic/">&nbsp;敏感事件&nbsp;</a></li>-->
			<li><a href="/mwyqMonitor/statis/">&nbsp;统计分析&nbsp;</a></li>
			<a onclick="showModal()" style="float: right;margin-right: 10px;font-size: 13px;color: white;font-family: 宋体;cursor:pointer;">语种选择</a>
			<!-- 			<li><a href='javascript:return test()'>自定义监测</a></li> -->
		</ul>

		<div class="row space29" style="float:left;margin-left:50px;padding-left: 20px; margin-top: 2px;width:50px">
			<!-- row 1 begins -->
				<div class="col-md-3" style="width:50px">
					<div class="meng" style="width:50px">
					<form action="/mwyqMonitor/query/getResByKeyWord" method="get">
						<input type="text" name="keyword"
							style="height: 400px; margin-top: 10px; width: 50px; float: left; writing-mode: tb-lr;font-family:menksoft2007" />
						<input type="submit" value="搜索"
							style="height: 100px; width: 50px; background-color: #cdcdcd; float: left" />
					</form>
					</div>
				</div>
			<!-- /row 1 -->
		</div>
		<div class="row space30  meng bd"
			style="float:left;margin-left:50px;padding-left: 2%; margin-bottom: 50px;width:80%">
			<!-- row 2 begins -->
			<div class="bottomRealContent" style="margin-bottom: 10px;">


				<div class="panel-heading meng">热门话题</div>

				<div id="hot_topic_div"
					style="border: 1px solid; margin-bottom: 8px;">
					<c:forEach items="${list}" var="topic">
						<div class="bottomContentBox"
							style="font-family: MENKSOFT2007; word-break: keep-all; border-right: 3px solid #cdcdcd; moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr; width: auto;">
							<div class="huati">
								<p
									style="writing-mode: tb-lr; writing-mode: vertical-lr; font-size: 20px; height: 450px; width: auto; border-right: 1px dashed #cdcdcd;">
									<a
										style="writing-mode: lr-tb; writing-mode: lr-vertical; color: red">${topic.news_count}</a>
									<a
										href="<%=request.getContextPath() %>/topic/${topic.topic_id}/news"
										style="font-size: 20px; width: auto; height: 450px;">${topic.topic_name}
									</a>

								</p>


							</div>
							<p class="show-line-3"
								style="height: 450px; margin-top: 5px; width: auto; font-size: 16px;">
								<!--【新闻内容】  -->
								${topic.news_content} <small class="pull-right text-muted"
									style="font-size: 12px;"><fmt:formatDate
										value="${topic.news_time}" type="date" pattern="yyyy-MM-dd" /></small>
							</p>
						</div>
					</c:forEach>

				</div>

			</div>
			
			
		</div>

		<!-- /row 2 -->
		
		

		<!-- Site footer -->
		<div class="footer bd">
			<p style="text-align: center;">Copyright @ 2016 中央民族大学</p>
		</div>
		<!-- /container -->
		
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
