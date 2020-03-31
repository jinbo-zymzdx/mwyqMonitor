<%@ page language="java" import="com.mwyq.controller.*, java.util.*,java.text.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title >民文舆情汇聚与监测系统 — 自定义监测</title>

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

     
        <div class="search-and-seting">
        <!-- 
            <div class="search col-xs-8">
          
                <div id="search_conditions" class="input-group input-group-sm">

                    <div id="conditions_tagList"></div>

          
                    <div id="conditions_input"><input id="conditions_keyword" value="" placeholder="" class="ui-autocomplete-input" autocomplete="off"></div>

          
                    <span class="input-group-btn">
							<button class="btn btn-primary btn-search" type="button" onclick="getConditions(null);"><span class="glyphicon glyphicon-search"></span></button>
						</span>
                </div>

            </div>
             -->
            
        </div>

        <!-- 左侧导航栏 -->
        <div class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li><a href="<%=request.getContextPath()%>/main/" target="_blank"><span class="glyphicon glyphicon-home span-icon"></span>总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;览</a></li>
                      <li><a href="/baidu/" target="_blank"><span class="glyphicon glyphicon-search span-icon"></span>搜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;索 </a></li>
                    <li><a href="<%=request.getContextPath()%>/mynews/" target="_blank"><span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a></li>
                    <li><a href="<%=request.getContextPath()%>/mystat/" target="_blank"><span class="glyphicon glyphicon-stats span-icon"></span> 统计分析</a></li>
                    <li><a href="<%=request.getContextPath()%>/sensite/" target="_blank"><span class="glyphicon glyphicon-flag span-icon"></span> 敏感词检测</a></li>
                    <li><a href="<%=request.getContextPath()%>/weibo/" target="_blank"><span class="glyphicon glyphicon-time span-icon"></span> 微博分析</a></li>
                    <li><a href="http://10.10.130.152:6688/" target="_blank"><span class="glyphicon glyphicon-road span-icon"></span> 知识图谱</a></li>
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
    <!-- 右侧主体部分 -->
    <div id="page-wrapper">
        <div class="row" style="padding-top:25px;">
        	<div class="alert alert-danger alert-dismissible fade in" role="alert">
        		<h3>找不到与"${word} "相关的话题！</h3>
        		<p style="font-size:14px; line-height:26px;">可能原因是："${word}"不是一个实体或由于网络原因导致返回结果丢失</p>
        	</div>
        </div>
    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->


<!--版权-->
<div class="footer">
    版权所有 &copy; 2017中央民族大学
</div>

</body>
</html>