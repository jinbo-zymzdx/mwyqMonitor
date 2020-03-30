<%@ page language="java" import="com.mwyq.controller.*, java.util.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title >民文舆情汇聚与监测系统 — 推特定制</title>

    <link rel="shortcut icon" href="favicon.png"/>

    <!-- Core CSS - Include with every page -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/bootstrap-theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/bootstrapSwitch.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/jquery-ui.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/sb-admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/model.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/timeline.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/hotspots.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/vendor-font.css">

    <script src="<%=request.getContextPath()%>/resources/js/topic_news/jquery-1.9.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/bootstrap.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/bootstrapSwitch.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/jquery.metisMenu.js"></script>

    <script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/underscore-1.5.2.js"></script>
    <!--<script src="js/highlight.js"></script>-->
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/hotspots.js"></script>
    <!-- 搜索提示 -->
    <script src="<%=request.getContextPath()%>/resources/js/topic_news/search.js"></script>


    <!--例子-->
    <script src="resourse/js/myjs.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/topic_news/mycss.css">

    <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
    
    <!-- 上一个页面链接 -->
    	<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" />
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

  
<!-- 另一个页面考过来的代码 -->
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
        var myChart1 = ec.init(document.getElementById('per')); 
        var myChart2 = ec.init(document.getElementById('loc')); 
        var myChart3 = ec.init(document.getElementById('org')); 
     
        var option1 = {
		    noDataLoadingOption:{
		    	//text:'正在等待请求数据或者数据不存在',
		    	text:'暂无数据', //sunpeng-2018.03.25
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
           		x:60,
           		y:15,
           		x2:15,
           		y2:20
           	},
		    calculable : true,
		    xAxis : [{
				type : 'value',
		        boundaryGap : [0, 0.01]
		    }],
		    yAxis : [{
				type : 'category',
		        //  data : ['巴西','印尼','美国','印度','中国','世界']
		        axisLabel : {
					interval : 0,
					rotate : 30,
					margin : 5,
				}
		    }],
		    series : [{
		    	type:'bar',
		        //  data: [100, 200, 500, 550, 600, 600]
		    }]
		};
        function loadData1(option){
        	 var result = ${resultPer}
			 option.yAxis[0].data = [];
				for(var i in result){
					option.yAxis[0].data.push(i);
				}
				option.series[0].data = [];
				for(var i in result){
					option.series[0].data.push(result[i]);
				}
		}
        
		var option2 = {
			noDataLoadingOption:{
				//text:'正在等待请求数据或者数据不存在',
				text:'暂无数据', //sunpeng-2018.03.25
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
           		x:60,
           		y:15,
           		x2:15,
           		y2:20
           	},
		    calculable : true,
		    xAxis : [{
				type : 'value',
		        boundaryGap : [0, 0.01]
		    }],
		    yAxis : [{
		    	type : 'category',
		       	//data : ['巴西','印尼','美国','印度','中国','世界']
		    	axisLabel : {
					interval : 0,
					rotate : 30,
					margin : 5,
				}
		    }],
		    series : [
		        {
		            type:'bar',
		       //     data:[100, 200, 500, 550, 600, 600]
		        }
		    ]
		};
		
		function loadData2(option){
        	 var result = ${resultLoc}
			 option.yAxis[0].data = [];
				for(var i in result){
					option.yAxis[0].data.push(i);
				}
				option.series[0].data = [];
				for(var i in result){
					option.series[0].data.push(result[i]);
				}
			}
		 
		var option3 = {
			noDataLoadingOption:{
				//text:'正在等待请求数据或者数据不存在',
				text:'暂无数据', //sunpeng-2018.03.25
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
			grid : {
				x:60,
		        y:15,
		        x2:15,
				y2:20
			},
			calculable : true,
			xAxis : [{
		       type : 'value',
		       boundaryGap : [0, 0.01]
		    }],
			yAxis : [{
	       		type : 'category',
				//  data : ['巴西','印尼','美国','印度','中国','世界']
				axisLabel : {
					interval : 0,
					rotate : 30,
					margin : 5,
				}
			}],
			series : [{
				type:'bar',
				//  data:[100, 200, 500, 550, 600, 600]
	        }]
		};   
		function loadData3(option) {
        	var result = ${resultOrg}
			option.yAxis[0].data = [];
			for(var i in result) {
				option.yAxis[0].data.push(i);
			}
			option.series[0].data = [];
			for(var i in result) {
				option.series[0].data.push(result[i]);
			}
		}
		 
		loadData1(option1);
		loadData2(option2);
		loadData3(option3);
		                    
        // 为echarts对象加载数据 
        myChart1.setOption(option1); 
        myChart2.setOption(option2); 
        myChart3.setOption(option3); 
    }
);
</script>


</head>

<body>

<div id="wrapper">
    <!--左侧部分-->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <!-- 项目名 -->
        <div class="project">
            <div class="navbar-header">
                <a class="navbar-brand project-name" href="#"><span>民文舆情汇聚与监测系统</span></a>
            </div>
        </div>

        <!-- 搜索栏 -->
        <div class="search-and-seting">
        </div>

        <!-- 左侧导航栏 -->
        <div class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li><a href="<%=request.getContextPath()%>/main/" target="_blank">
                    	<span class="glyphicon glyphicon-home span-icon"></span>总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;览</a>
                    </li>
                    <li><a href="/baidu/" target="_blank">
                    	<span class="glyphicon glyphicon-search span-icon"></span>搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </a>
                    </li>
                    <li><a href="<%=request.getContextPath()%>/mynews/" target="_blank">
                    	<span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a>
                    </li>
                    <li><a href="<%=request.getContextPath()%>/mystat/" target="_blank">
                    	<span class="glyphicon glyphicon-stats span-icon"></span> 统计分析</a>
                    </li>
                    <li><a href="<%=request.getContextPath()%>/sensite/" target="_blank">
                    	<span class="glyphicon glyphicon-flag span-icon"></span> 敏感词检测</a>
                    </li>
                    <li><a href="<%=request.getContextPath()%>/weibo/" target="_blank">
                    	<span class="glyphicon glyphicon-time span-icon"></span> 微博分析</a></li>
                    <li><a href="http://10.10.130.152:6688/" target="_blank">
                    	<span class="glyphicon glyphicon-road span-icon"></span> 知识图谱</a></li>
                    <li class="active">
                        <a href="javascript: void(0);" onclick="listUserWord();">
                            <span class="glyphicon glyphicon-book span-icon"></span> 自定义监测
                        </a>
                        <ul class="nav nav-second-level sub-menu" id="usersubmenu"></ul>
                    </li>
                </ul>
                <!-- /#side-menu -->
            </div>
            <!-- /.sidebar-collapse -->
        </div>
    </nav>
    
   		  <script type="text/javascript">
   			function twitterContent(e,twitter_id) {
					$
					.ajax({
						type : "get",
						async : false,
						url : "${request.contextPath}/mwyqMonitor/twitter/getTwitterContent?twitter_id=" + twitter_id,
						data : {},
						dataType : "text",
						success : function(result) {
								document.getElementById(twitter_id).lastElementChild.lastElementChild.innerHTML=result;
						}
					});		
   			}
		</script>

    <!-- 右侧主体部分 -->
    <div id="page-wrapper" style="margin-top:50px">
        <div class="row row-ptop-25">
            <!--时事热点显示-->
            <div class="row row-not-margin">
                <div class="col-sm-12" >
                    <div class="panel panel-default" style="height:100%;">
                        <div class="panel-heading"><span class="glyphicon glyphicon-sort"></span> 推特统计</div>
                        <div class="panel-body" style="overflow:auto;height:900px;width:98%;">
                        	<h3 style="color:blue;font-size:20px;">与<span style="color:red;font-size:30px;">${keyWord}</span>相关的推特如下:</h3><br>
							<c:forEach items="${twitter}" var="twitter">
								 <div style="height:120px;" id=${twitter.id}>                                       
									<div style="height:50px;">
										<div  style="float:left;width:250px;padding-top:5px;">
											<span style="font-size:15px;color:blue;margin-top:10px;"> 
												<fmt:formatDate value="${twitter.time}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
											</span>									
										</div>
										<div style="float:left;width:60px;padding-top:5px;">
											<c:if test="${twitter.sentiment==0}">
												<span>负向</span>
											</c:if>
											<c:if test="${twitter.sentiment==1}">
												<span>正向</span>
											</c:if>
										</div>
										
										<button class="btn btn-default" onclick="twitterContent(this,${twitter.id})">翻译</button>	
									</div>
									
									
									
									<div style="height:70px;">
										<span>&nbsp;&nbsp;&nbsp;&nbsp;${twitter.content}</span>
										<div class="translation">
									</div>
									</div>
									
									
								</div>
									<hr/> 
							</c:forEach>



                        </div>
                    </div>
                </div>
            </div>
        </div>

</div>
<!-- /#wrapper -->


<!--版权-->
<div class="footer">
    版权所有 &copy; 2017中央民族大学
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
                            <input type="text" class="form-control" id="monitor_word" value="">
                        </div>
                    </div>
                    <div class="row monitor-row">
                        <div class="col-xs-2 monitor-tag">
                            <span class="node-name">类型：</span>
                        </div>
                        <div class="col-xs-9">
                            <select class="form-control input-group-sm" id="monitor_wordType">
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
                            <select class="form-control input-group-sm" id="monitor_langType">
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
                            <input type="text" class="form-control" id="monitor_describe" value="">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer modal-footer-point">
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-sm btn-primary" onclick="saveMonitor();">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>