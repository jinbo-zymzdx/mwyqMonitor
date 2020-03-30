<%@ page language="java" import="com.mwyq.controller.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">

<head>

    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title >民文舆情汇聚与监测系统 — 实时热点</title>

	<link rel="shortcut icon" href="favicon.png"/>

    <!-- Core CSS - Include with every page -->
	<link rel="stylesheet" href="resources/css/hotpots/bootstrap-theme.css">
	<link rel="stylesheet" href="resources/css/hotpots/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/hotpots/bootstrapSwitch.css">
	<link rel="stylesheet" href="resources/css/hotpots/jquery-ui.css">
	
    <link rel="stylesheet" href="resources/css/hotpots/sb-admin.css">
    <link rel="stylesheet" href="resources/css/hotpots/model.css">
	<link rel="stylesheet" href="resources/css/hotpots/timeline.css">
	<link rel="stylesheet" href="resources/css/hotpots/hotspots.css">
	<link rel="stylesheet" href="resources/css/hotpots/vendor-font.css">
	
	<script src="resources/js/hotpots/jquery-1.9.0.min.js"></script>
	<script src="resources/js/hotpots/bootstrap.js"></script>
	<script src="resources/js/hotpots/jquery-ui.js"></script>
	<script src="resources/js/hotpots/bootstrapSwitch.js"></script>
	<script src="resources/js/hotpots/jquery.metisMenu.js"></script>
	
	<script src="resources/js/hotpots/common.js"></script>
	<script src="resources/js/hotpots/underscore-1.5.2.js"></script>
	<!--<script src="js/highlight.js"></script>-->
	<script src="resources/js/hotpots/hotspots.js"></script>
	<!-- 搜索提示 -->
	<script src="resources/js/hotpots/search.js"></script>
	
	
	
	<!--例子-->
    <script src="resources/js/hotpots/myjs.js"></script>
    <link rel="stylesheet" href="resources/css/hotpots/mycss.css">
	
	
	<link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">

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
            <div class="search col-xs-8">
                <!-- 搜索 -->
                <div id="search_conditions" class="input-group input-group-sm">
                    <!-- 搜索条件集合 -->
                    <div id="conditions_tagList"></div>

                    <!-- 搜索输入框 -->
                    <div id="conditions_input"><input id="conditions_keyword" value="" placeholder="" class="ui-autocomplete-input" autocomplete="off"></div>

                    <!-- 搜索按钮 -->
                    <span class="input-group-btn">
							<button class="btn btn-primary btn-search" type="button" onclick="getConditions(null);"><span class="glyphicon glyphicon-search"></span></button>
						</span>
                </div>

            </div>

            <!-- 工具栏 -->
            <div class="col-xs-4 col-set">
                <ul class="nav navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" title="个人中心" onclick="hideSettings();">
                            <span class="glyphicon glyphicon-user"></span>  <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <!--
                            <li><a href="login.html"><i class="glyphicon glyphicon-log-in"></i>  登 录</a></li>
                            <li><a href="#"><i class="glyphicon glyphicon-hand-right"></i>  注 册</a></li>
                            <hr>
                             -->
                            <li><a href="http://myportal.xinhuaxinwen.com/xh-portal/home.do"><i class="glyphicon glyphicon-arrow-left"></i>  返回门户</a></li>
                            <hr>
                            <li><a href="javascript:void(0);" onclick="logout()"><i class="glyphicon glyphicon-log-out"></i>  退 出</a></li>
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" title="设置" onclick="settings();">
                            <span class="glyphicon glyphicon-cog"></span> <span class="caret"></span>
                        </a>
                    </li>

                    <!-- 打印 -->
                    <li class="dropdown">
                        <a id="dropdownPrint" class="dropdown-toggle" data-toggle="dropdown" title="打印" onclick="javascript:window.print()">
                            <span class="glyphicon glyphicon-print"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 左侧导航栏 -->
        <div class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li><a href="index.jsp" target="_blank"><span class="glyphicon glyphicon-home span-icon"></span> 首 页</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-list span-icon"></span> 实时热点</a></li>
                    <li><a href="analysis.jsp" target="_blank"><span class="glyphicon glyphicon-stats span-icon"></span> 统计分析</a></li>
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

        <!-- 设置页面，隐藏域 -->
        <div id="set-panel" class="panel panel-default set-panel">
            <div class="panel-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="control-label set-label">搜索最大新闻数 :</label>
                        <div class="max-search">
                            <select id="rblPageSize">
                                <option value="100" selected>-- 请选择 --</option>
                                <option value="100">100</option>
                                <option value="200">200</option>
                                <option value="500">500</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label set-label">时间选择 :</label>
                        <div class="max-search">
                            <select id="rblTimeDuration">
                                <option value="1d">1 天</option>
                                <option value="2d">2 天</option>
                                <option value="7d" selected>7 天</option>
                                <option value="30d">4 周</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label set-label">语言选择 :</label>
                        <div class="max-search">
                            <div class="input-group margin-right-15" id="langsRadio">
									<span class="input-group-addon">
										<input name="cbLanguage" type="radio" checked="checked" value="zh-CN" >中文</input>
									</span>
                                <span class="input-group-addon">
										<input name="cbLanguage" type="radio" value="ko" >朝文</input>
									</span>
                                <span class="input-group-addon">
										<input name="cbLanguage" type="radio" value="ui" >维文</input>
									</span>
                                <span class="input-group-addon">
										<input name="cbLanguage" type="radio" value="bo">藏文</input>
									</span>
                                <!--
                                <span class="input-group-addon">
                                    <input name="cbLanguage" type="radio" value="zh-CN" >中文</input>
                                </span>
                                 -->
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
        <!-- 设置页面 end -->


    </nav>

    <!-- 右侧主体部分 -->
    <div id="page-wrapper">


        <div class="row row-ptop-25">


            <!--蓝色显示框-->
            <div class="row row-not-margin">

                <div class="col-sm-12">
                    <div class="alert alert-info">
                        <strong>今日已抓取4610篇新闻，其中：中文2042篇，朝文1882篇，维文582篇，藏文104篇</strong>
                    </div>
                </div>
            </div>


            <!--时事热点显示-->
            <div class="row row-not-margin">
                <div class="col-sm-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-time"></span>  实时热点
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs" data-toggle="dropdown">
                                        <span id="lang_category">全部</span>
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu pull-right" role="menu" id="filter_ul_li">
                                        <li><a href="javascript:void(0);" onclick="langFilter(this,'all')">全部</a></li>
                                        <li><a href="javascript:void(0);" onclick="langFilter(this,'zh')">中文</a></li>
                                        <li><a href="javascript:void(0);" onclick="langFilter(this,'ko')">朝文</a></li>
                                        <li><a href="javascript:void(0);" onclick="langFilter(this,'ui')">维文</a></li>
                                        <li><a href="javascript:void(0);" onclick="langFilter(this,'bo')">藏文</a></li>
                                        <!--
                                        <li><a href="javascript:void(0);" onclick="langFilter(this,'zh')">中文</a></li>
                                         -->
                                    </ul>
                                </div>
                            </div>
                            <!--
                            <div class="pull-right" style="line-height: 18px;">
                                <span class="checkbox-inline"><input type="checkbox" checked="checked" name="checkname" id="lang_all">全部</span>
                                <span class="checkbox-inline"><input type="checkbox" checked="checked" name="checkname" id="lang_zh" value="zh">中文</span>
                                <span class="checkbox-inline"><input type="checkbox" checked="checked" name="checkname" id="lang_ko" value="ko">朝文</span>
                                <span class="checkbox-inline"><input type="checkbox" checked="checked" name="checkname" id="lang_ui" value="ui">维文</span>
                                <span class="checkbox-inline"><input type="checkbox" checked="checked" name="checkname" id="lang_bo" value="bo">藏文</span>
                            </div>
                            -->
                        </div>
                        <div class="panel-body timeline-body">
                            <!--<ul class="timeline">

                                <li>
                                    <div class="timeline-badge success"><span class="glyphicon glyphicon-credit-card"></span></div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 class="timeline-title tl-title">新闻标题1</h4>
                                            <p>
                                                <small class="text-muted">40分钟以前</small>
                                            </p>
                                        </div>
                                        <div class="timeline-body">
                                            <div class="timeline-content">中新网寸土必保。</div>
                                        </div>
                                    </div>
                                </li>

                            </ul>-->
                            <div id="showTimeLine">
                            	

                                <a onclick="chakan(this)" name="1" class="a1">新闻1</a>
                                
                                <p>545454444444444444444444444444444444</p>
                                <c:forEach items="${latestNews}" var="latestNews">                       
									<p class="a1">${latestNews.news_title}</p><br>
									<hr><br>
								</c:forEach>
                            </div>
                            <div class="showMore"><a class="showMore-a" onclick="takeMore();">加载更多</a></div>
                        </div>
                    </div>
                </div><!-- end col-sm-8  -->

                <div class="col-sm-4">
                    <div class="panel panel-default panel-fixed" id="panel_show_news">
                        <div class="panel-heading"><span class="glyphicon glyphicon-align-justify"></span>  新闻内容</div>
                        <div class="panel-body">
                            <!--<div id="news_content"></div>-->
                            <div >
                                <p id="news_content">123</p>
                            </div>
                        </div>
                    </div>
                </div><!-- end col-sm-4 -->
            </div>



        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->










<!--版权-->
<div class="footer">
    版权所有 &copy; 2014 新华通讯社
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
                                <option>朝文</option>
                                <option>维文</option>
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
