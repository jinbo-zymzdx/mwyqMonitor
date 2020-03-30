<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>话题详情</title>
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/bootstrap_min.css" />
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
require.config({
    paths: {
        echarts: 'http://echarts.baidu.com/build/dist'
    }
});

// 使用
require(
    [
        'echarts',
        'echarts/chart/bar',
        'echarts/chart/wordCloud',
        'echarts/chart/force'
        // 使用柱状图就加载bar模块，按需加载
    ],
    function (ec) {
        // 基于准备好的dom，初始化echarts图表
       
        var myChart1 = ec.init(document.getElementById('person1')); 
        var myChart2 = ec.init(document.getElementById('place1')); 
        var myChart3 = ec.init(document.getElementById('org1')); 
        var myChart4 = ec.init(document.getElementById('ciyun'));
        var myChart5 = ec.init(document.getElementById('shiti'));
               
        var option1 = {
		    noDataLoadingOption:{
		    	text:'暂无数据',
		    	effect:'bubble',
		    	effectOption:{
		    		effect:{
		    			n:0
		    		}
		    	}
		    },
        		tooltip : {
		        trigger: 'item'
		    },
		    grid:{
           x:35,
           y:10,
           x2:10,
           y2:20
           },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'value',
		            boundaryGap : [0, 0.01]
		        }
		    ],
		    yAxis : [
		        {
		            type : 'category',
		          //  data : ['巴西','印尼','美国','印度','中国','世界']
		        }
		    ],
		    series : [
		        {
		            type:'bar',
		          //  data: [100, 200, 500, 550, 600, 600]
		        }
		    ]
		};
        function loadData1(option){
			$.ajax({
				type : "get",
				async : false,
				url : "${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicPer",
				data : {},
				dataType : "json",
				success : function(result) {
					if (result) {
						option.yAxis[0].data = [];
						for(var i in result){
							option.yAxis[0].data.push(i);
						}
						option.series[0].data = [];
						for(var i in result){
							option.series[0].data.push(result[i]);
						}
					}
				}

			});
		}
        
		 var option2 = {
				 noDataLoadingOption:{
				    	text:'暂无数据',
				    	effect:'bubble',
				    	effectOption:{
				    		effect:{
				    			n:0
				    		}
				    	}
				    },
				 tooltip : {
		        trigger: 'item'
		    },
		    grid:{
           x:35,
           y:10,
           x2:10,
           y2:20
           },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'value',
		            boundaryGap : [0, 0.01]
		        }
		    ],
		    yAxis : [
		        {
		            type : 'category',
		       //     data : ['巴西','印尼','美国','印度','中国','世界']
		        }
		    ],
		    series : [
		        {
		            type:'bar',
		       //     data:[100, 200, 500, 550, 600, 600]
		        }
		    ]
		};
		
		 function loadData2(option){
				$.ajax({
					type : "get",
					async : false,
					url : "${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicLoc",
					data : {},
					dataType : "json",
					success : function(result) {
						if (result) {
							option.yAxis[0].data = [];
						//	for (var i = 0; i < result.length; i++) {
						//		option.xAxis[0].data.push(i);
						//	}
							for(var i in result){
								option.yAxis[0].data.push(i);
							}
							option.series[0].data = [];
						//	for (var i = 0; i < result.length; i++) {
						//		option.series[0].data.push(result[i]);
						//	}
							for(var i in result){
								option.series[0].data.push(result[i]);
							}
						}
					}

				});
			}
		 
		 var option3 = {
				 noDataLoadingOption:{
				    	text:'暂无数据',
				    	effect:'bubble',
				    	effectOption:{
				    		effect:{
				    			n:0
				    		}
				    	}
				    },
				 tooltip : {
				        trigger: 'item'
				    },
				    grid:{
	               x:35,
	               y:10,
	               x2:10,
	               y2:20
	               },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'value',
				            boundaryGap : [0, 0.01]
				        }
				    ],
				    yAxis : [
				        {
				            type : 'category',
				          //  data : ['巴西','印尼','美国','印度','中国','世界']
				        }
				    ],
				    series : [
				        {
				            type:'bar',
				          //  data:[100, 200, 500, 550, 600, 600]
				        }
				    ]
				};   
		 function loadData3(option){
				$.ajax({
					type : "get",
					async : false,
					url : "${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicOrg",
					data : {},
					dataType : "json",
					success : function(result) {
						if (result) {
							option.yAxis[0].data = [];
							for(var i in result){
								option.yAxis[0].data.push(i);
							}
							option.series[0].data = [];
							for(var i in result){
								option.series[0].data.push(result[i]);
							}
						}
					}

				});
			}
		 
		 
		 function createRandomItemStyle() {
			    return {
			        normal: {
			            color: 'rgb(' + [
			                Math.round(Math.random() * 160),
			                Math.round(Math.random() * 160),
			                Math.round(Math.random() * 160)
			            ].join(',') + ')'
			        }
			    };
			}

		 
		 var keys=[];
		 var values=[];
		 $.ajax({
		 	type:"get",
		 	async:false,
		 	url:"${request.contextPath}/mwyqMonitor/topic/${topicId}/getEntityKey",
		 	dataType:"json",
		 	success:function(result){
		 		if(result){
		 			for(var i in result){
		 				keys.push(i);
		 				values.push(result[i]);
		 			}
		 		}
		 	}
		 });

		 
			option4 = {
			//    title: {
			//        text: 'Google Trends',
			//        link: 'http://www.google.com/trends/hottrends'
			//    },
			 noDataLoadingOption:{
		    	text:'暂无数据',
		    	effect:'bubble',
		    	effectOption:{
		    		effect:{
		    			n:0
		    		}
		    	}
		    },   
			tooltip: {
			        show: true
			    },
			    series: [{
			     //   name: '中央民族大学',
			        type: 'wordCloud',
			        size: ['80%', '80%'],
			        textRotation : [0, 45, 90, -45],
			        textPadding: 0,
			        autoSize: {
			            enable: true,
			            minSize: 14
			        },
			        data:	
	            		(function(){
		        		var res=[];
		        		var len=keys.length;
		        		while(len--){
		        			res.push({
		        				name:keys[len],
		        				value:values[len],
		        				itemStyle: createRandomItemStyle()	
		        			});
		        		}
		        		return res;
		        	})()
		        	
			          
			    }]
			};
			
			var names=[];
			var name_values=[];
			 $.ajax({
			 	type:"get",
			 	async:false,
			 	url:"${request.contextPath}/mwyqMonitor/topic/${topicId}/getTopicToEntity",
			 	dataType:"json",
			 	success:function(result){
			 		if(result){
			 			for(var i in result){
			 				names.push(i);
			 				name_values.push(result[i]);
			 			}
			 		}
			 	}
			 });
			
			
			option5 = {
				  //  title : {
				  //      text: '人物关系：乔布斯',
				  //      subtext: '数据来自人立方',
				  //      x:'right',
				  //      y:'bottom'
				  //  },
				   noDataLoadingOption:{
		    	text:'暂无数据',
		    	effect:'bubble',
		    	effectOption:{
		    		effect:{
		    			n:0
		    		}
		    	}
		    }, 
				  tooltip : {
				        trigger: 'item',
				        formatter: '{a} : {b}'
				    },
				    toolbox: {
				        show : true,
				      //  feature : {
				      //      restore : {show: true},
				     //       magicType: {show: true, type: ['force', 'chord']},
				     //       saveAsImage : {show: true}
				     //   }
				    },
				    legend: {
				        x: 'left',
				        data:['话题','人物','地点','组织机构']
				    },
				    series : [
				        {
				            type:'force',
				       //     name : "话题和实体的关系",
				            ribbonType: false,
				            categories : [
				                {
				                    name: '话题'
				                },
				                {
				                    name:'人物'
				                },
				                {
				                    name: '地点'
				                },
				                {
				                    name: '组织机构'
				                }
				            ],
				            itemStyle: {
				                normal: {
				                    label: {
				                        show: true,
				                        textStyle: {
				                            color: '#333'
				                        }
				                    },
				                    nodeStyle : {
				                        brushType : 'both',
				                        borderColor : 'rgba(255,215,0,0.4)',
				                        borderWidth : 1
				                    },
				                    linkStyle: {
				                        type: 'curve'
				                    }
				                },
				                emphasis: {
				                    label: {
				                        show: false
				                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
				                    },
				                    nodeStyle : {
				                        //r: 30
				                    },
				                    linkStyle : {}
				                }
				            },
				            useWorker: false,
				            minRadius : 15,
				            maxRadius : 25,
				            gravity: 1.1,
				            scaling: 1.1,
				            roam: 'move',
				            nodes:
				            	/*
				            	[
				                {category:0, name: '乔布斯', value : 10, label: '乔布斯\n（主要）'},
				                {category:1, name: '丽萨-乔布斯',value : 2},
				                {category:1, name: '保罗-乔布斯',value : 3},
				                {category:1, name: '克拉拉-乔布斯',value : 3},
				                {category:1, name: '劳伦-鲍威尔',value : 7},
				                {category:2, name: '史蒂夫-沃兹尼艾克',value : 5},
				                {category:2, name: '奥巴马',value : 8},
				                {category:2, name: '比尔-盖茨',value : 9},
				                {category:2, name: '乔纳森-艾夫',value : 4},
				                {category:2, name: '蒂姆-库克',value : 4},
				                {category:2, name: '龙-韦恩',value : 1},
				            ],
				            */
				            	(function(){
					        		var res=[];
					        		var len=names.length;
					        		while(len--){
					        			res.push({
					        				name:names[len],
					        				category:name_values[len],
					        				//itemStyle: createRandomItemStyle()	
					        				value:Math.round(Math.random() * 100)
					        			});
					        		}
					        		return res;
					        	})()
					        	,

				            links : 
				            	
				            	(function(){
					        		var res=[];
					        		var len=names.length;
					        		while(len--){
					        			res.push({
					        				source:names[len],
					        				target:names[names.length-1]
					        				//itemStyle: createRandomItemStyle()	
					        			});
					        		}
					        		return res;
					        	})()
				            

				        }
				    ]
				};
			
				
				
				loadData1(option1);
				loadData2(option2);
				loadData3(option3);
				                    
        // 为echarts对象加载数据 
         
        myChart1.setOption(option1); 
        myChart2.setOption(option2); 
        myChart3.setOption(option3); 
        myChart4.setOption(option4); 
        myChart5.setOption(option5);
      
    }
);
</script>

<script type="text/javascript">

	window.onload=function(){
		alert($("#topicId").val());
	}
	function PageCallback(index) { 
		window.location.href="<%=request.getContextPath()%>
	/topic/topicPage?page="
				+ (index + 1);
	}
	$(document).ready(function() {
		var id = 0;
		$("#Pagination").pagination("${page.totalPage }", {
			current_page : "${page.currentPage-1}",
			callback : PageCallback
		});
	});
</script>

</head>
<body class="topic" style="font-family: MENKSOFT2007">
	<div id="container" class="container" style="float:left">
		<img src="<%=request.getContextPath()%>/resources/images/templatemoheader.jpg"
			class="img-responsive" style="height: 10%;" />
		<ul class="nav nav-justified bd" style="height:60px;padding-left:50px;">
			<li style="width:200px;"><a href="/mwyqMonitor/topic/">&nbsp;&nbsp;首 &nbsp;&nbsp;页 &nbsp;&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/news/">&nbsp;实时热点&nbsp;</a></li>
			<li style="width:200px;"><a href="/mwyqMonitor/statis/">&nbsp;统计分析&nbsp;</a></li>
			<li style="width:200px;"><a href="/baidu/">&nbsp;&nbsp;搜 &nbsp;&nbsp;索 &nbsp;&nbsp;</a></li>
		</ul>
		
		<div id="row-1" style="width:100%;height:600px;margin-left:10%;margin-right:10%;">
			<!-- 搜索 -->
			<div class="col-md-3" style="width:10%;height:500px;margin-top:10px;">
				<div class="meng">
					<input type="text" style="height: 350px; margin-top: auto; width: 50px; float: left; writing-mode: tb-lr;" />
					<input type="button" value="搜索" style="height: 80px; width: 50px; background-color: #cdcdcd; float: left" />
				</div>
			</div><!-- 搜索 -->
			
			<!-- 话题信息 -->
			<div class="col-md-13" style="width:35%;height:600px;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading" style="padding: 5px 5px; height:50px;">
							<div class="main-news-title">
								<span id="mainnew_title"> 话题下有： <span id="huatishu"
									class="font_news">${newsCount}</span> 篇新闻， <span
									id="numplace" class="font_loc">${locNum}</span> 个地点实体， <span
									id="numper" class="font_per">${perNum}</span> 个人物实体， <span
									id="numorg" class="font_org">${orgNum}</span> 个组织机构实体
								</span>
							</div>
						</div>
						<div class="panel-body1 meng" style="height: 85%; word-break: keep-all;">
							<c:forEach items="${topicNews }" var="topicNews">
								<c:choose>
									<c:when test="${topicNews.lang_type == 'cn'}">
										<div style="writing-mode: lr-tb; overflow-x: hidden; overflow-y: scroll; width: 685px; height:100%;">
											<p>
												<fmt:formatDate value="${topicNews.news_time}" type="date" pattern="yyyy-MM-dd" />
											</p>
											<p>${topicNews.news_author}</p>
											<p id="huatixia" class="huatixia" style="height: 100%; break-word: keep-all; width: 685;">
												${topicNews.news_content}</p>
										</div>
									</c:when>
									<c:otherwise>
										<p><fmt:formatDate value="${topicNews.news_time}" type="date" pattern="yyyy-MM-dd" /></p>
										<p>${topicNews.news_author}</p>
										<p id="huatixia" class="huatixia"
											style="height: 100%; word-wrap: break-word; overflow-x: auto; overflow-y: hidden; width: 95%">
											${topicNews.news_content}</p>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>
			</div><!-- 话题信息 -->
			
			<!-- 新闻列表 -->
			<div class="col-md-13" style="width:35%;height:600px;">
				<div class="new-des  bd" style="height:98%; width:100%">
					<div class="panel panel-default">
						<div class="panel-heading" style="padding: 5px 5px; height:50px;">
							<div class="main-news-title">
								<span id="mainnew_title"> 新闻列表 </span>
							</div>
						</div>
						<div class="panel-body1 meng"
							style="font-family: MENKSOFT2007; height: 85%; width: 98%; moz-writing-mode: vertical-lr; writing-mode: vertical-lr; -webkit-writing-mode: vertical-lr; -o-writing-mode: vertical-lr; -ms-writing-mode: tb-lr; writing-mode: tb-lr; overflow-x: auto; overflow-y: hidden;">
							<c:forEach items="${topicAllNews }" var="topicAllNews">
								<div class="newslist" style="height: 100%; word-break: keep-all;">
									<p id="newstitle" style="height: auto;">
										<a style="height: auto;" href="<%=request.getContextPath()%>/topic/${topicAllNews.news_id }/newsContent">
											${topicAllNews.news_title }</a>
										<small id="time" class="pull-right text-muted meng"
											style="border-right: 1px dotted #333333; height: 100%; text-align: right; width: 30px;">
											<fmt:formatDate value="${topicAllNews.news_time}" type="date" pattern="yyyy-MM-dd" />
										</small>
									</p>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div><!-- 新闻列表 -->
		</div>
		
		<div id="row-2" style="width:100%;height:400px;margin-left:10%;margin-right:10%;">
			<div class="col-md-13" style="width:26%;height:400px;float:left;margin-right:15px;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading ">人物统计</div>
							<div id="person1" class="panel-body1" style="height:330px;"></div>
						</div>
				</div>
			</div>
			<div class="col-md-13" style="width:26%;height:400px;float:left;margin-right:15px;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading ">地点统计</div>
						<div id="place1" class="panel-body1" style="height:330px;"></div>
					</div>
				</div>
			</div>
			<div class="col-md-14" style="width:26%;height:400px;float:left;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading ">组织机构统计</div>
						<div id="org1" class="panel-body1" style="height:330px;"></div>
					</div>
				</div>
			</div>
		</div><!-- id="row-2" -->
		
		<div id="row-3" style="width:100%;height:400px;margin-left:10%;margin-left:10%;">
			<div class="col-md-13" style="width:40%;height:400px;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading ">词云</div>
						<div id="ciyun" class="panel-body1"></div>
					</div>
				</div>
			</div>
			<div class="col-md-13" style="width:40%;height:400px;">
				<div class="new-des  bd">
					<div class="panel panel-default">
						<div class="panel-heading ">实体关系</div>
						<div id="shiti" class="panel-body1"></div>
					</div>
				</div>
			</div>						
		</div><!-- id="row-3" -->
		
		<div class="footer" style="height:50px;">
			<p style="text-align: center;">Copyright © 2018 中央民族大学</p>
		</div>
	</div>
</body>
</html>