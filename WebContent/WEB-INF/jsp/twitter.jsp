<%@ page language="java" import="com.mwyq.controller.*, java.util.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
	<!-- twitter.jsp -->
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title >民汉舆情汇聚与监测系统 — 推特数据</title>

	<link rel="shortcut icon" href="favicon.png"/>

    <!-- Core CSS - Include with every page -->
	<link rel="stylesheet" href="
	<%=request.getContextPath()%>/resources/css/hotpots/bootstrap-theme.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrapSwitch.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/jquery-ui.css">
	
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/sb-admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/model.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/timeline.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/hotspots.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/vendor-font.css">
	
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-3.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-1.9.0.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/bootstrap.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-ui.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/bootstrapSwitch.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery.metisMenu.js"></script>
	

    <script src="<%=request.getContextPath()%>/resources/js/analysis/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/d3.v2.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/d3.layout.cloud.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/highcharts-3.0.7.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/raphael-2.1.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/chinaMapConfig.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/map.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/morris.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/underscore-1.5.2.js"></script>

    <script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/charts.draw.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/analysis.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/analysis/search.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/echarts.common.min.js"></script>
    
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css"> 
    

</head>

<body>

<div id="wrapper">
    <!--左侧部分-->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <!-- 项目名 -->
        <div class="project">
            <div class="navbar-header">
                <a class="navbar-brand project-name" href="#"><span>民汉舆情汇聚与监测系统</span></a>
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
			
				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
                            <span class="glyphicon glyphicon-stats"></span>作者排行                   
                        </div>
                        <div class="panel-body" >
                           	<div id="author_chart" style="height:300px;">
                           		<script type="text/javascript">
							   
							   		var myChartAuthor = echarts.init(document.getElementById('author_chart'));
							   		var optionAuthor = {
							   			
						   			    tooltip: {
						   			        trigger: 'axis',
						   			        axisPointer: {
						   			            type: 'shadow'
						   			        }
						   			    },
							   				
							   			grid : {
											x: 50,
											y: 30,
									        left: '3%',
									        right: '4%',
									        bottom: '3%',
									        containLabel: true
										},
							   			xAxis: {
							   				type: 'category',
							   				splitLine: {lineStyle:{type:'dashed'}},
							   			},
							   			yAxis: {
							   				name : '推特数量',
							   				type: 'value'
							   			},
							   			series: [{
							   				//data: datavalue,
							   			    type: 'bar'
							   			}]
							   		};
								   		
									function loadAuthorData(option) {
										
										$.ajax({
											type : "get",
											async : false,
											url : "${request.contextPath}/mwyqMonitor/twitter/getTwitterAuthor",
											data : {
											},
											dataType : "json",
											success : function(result) {
				
												if (result) {
													option.xAxis.data = [];
													option.series[0].data = [];
													for(i in result){
														option.xAxis.data.push(i);
														option.series[0].data.push(result[i]);
													}
												}
											}
										});
									};
									loadAuthorData(optionAuthor);
								   	myChartAuthor.setOption(optionAuthor);
								</script>
                           	</div>
                        </div>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="panel panel-default">
						<div class="panel-heading">
                            <span class="glyphicon glyphicon-bell"></span>情感分析                          
                        </div>
                        <div class="panel-body" >
                           	<div id="emotion_chart" style="height:300px;">
                           		<script type="text/javascript">  
					       			var myChartEmotion = echarts.init(document.getElementById('emotion_chart'));
					       			var optionEmotion = {
					       				    title : {
					       				        text: '情感分析',
					       				        x:'center'
					       				    },
					       				    tooltip : {
					       				        trigger: 'item',
					       				        formatter: "{a} <br/>{b} : {c} ({d}%)"
					       				    },
					       				    series : [
					       				        {
					       				            name: '情感倾向',
					       				            type: 'pie',
					       				            radius : '75%',
					       				            center: ['50%', '60%'],
					       				            itemStyle: {
					       				                emphasis: {
					       				                    shadowBlur: 10,
					       				                    shadowOffsetX: 0,
					       				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
					       				                }
					       				            }
					       				        }
					       				    ]
					       				};
					       			
									function loadEmotionData(option) {
					
										$.ajax({
											type : "get",
											async : false,
											url : "${request.contextPath}/mwyqMonitor/twitter/getTwitterEmotion",
											data : {
											},
											dataType : "json",
											success : function(result) {
				
												if (result) {
													option.series[0].data = [];
													for(i in result){
														option.series[0].data.push({
															value:result[i],
															name:i
														});
														}
													}
												}
					
										});
									};
									
									loadEmotionData(optionEmotion);
									myChartEmotion.setOption(optionEmotion);
			       				</script>
                           	</div>
                        </div>
					</div>
				</div>
			</div>
			
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
	   			
	   			function searchAuthor(){
	   				var name = document.getElementById("searchAuthor").value;
	   				if(name!=""){
						$
						.ajax({
							type : "post",
							async : false,
							url : "${request.contextPath}/mwyqMonitor/twitter/TwitterSearch?author=" + name,
							data : {},
							dataType : "html",
							success:function(response) {
								$("html").html(response);
							}
						});
	   				}

	   			}

			</script>
			
			<div style="margin-left:23px;margin-left:20px">
				<span>
					请输入作者名称：<input id="searchAuthor" type="text" name="fname" />
					<button class="btn btn-default" onclick="searchAuthor()">搜索</button>
				</span>
			</div>
			
			
			<div class="row row-not-margin">
				<div class="col-sm-12">
					<div class="panel panel-default">
						<div class="panel-heading"><span class="glyphicon glyphicon-th-large"></span>推特内容
						</div>
						<div class="panel-body">
						
							<c:forEach items="${twitter}" var="twitter">
								<div style="height:120px;" id=${twitter.id}>                                       
									<div style="height:50px;">
										<div style="float:left;width:150px;padding-top:5px;">
											
											   <span style="font-size:15px;color:blue;">${twitter.name}</span>
											
										</div>
										<div  style="float:left;width:250px;padding-top:5px;">
											<span style="font-size:15px;color:blue;margin-top:10px;"> 
												<fmt:formatDate value="${twitter.time}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
											</span>									
										</div>
										<div style="float:left;width:60px;padding-top:5px;">
											<span style="font-size:15px;">
												<c:if test="${twitter.sentiment==0}">
													<span>负向</span>
												</c:if>
												<c:if test="${twitter.sentiment==1}">
													<span>正向</span>
												</c:if>
											</span>
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
				</div>  <!-- col-sm-6 --> 
			</div>
			
			
			
		</div><!-- end row row-ptop-25 -->
	</div><!-- end page-wrapper -->

</div>


<!--版权-->
<div class="footer">
    版权所有 &copy; 2018 中央民族大学
</div>

<!-- 自定义监测添加 -->
<div id="monitor" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
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
