<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
    <title>民文舆情汇聚与监测系统 — 设定</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/lib/bootstrap/css/bootstrap.min.css">
	
	<script src="<%=request.getContextPath()%>/resources/lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/lib/jquery-3.3.1.min.js"></script>
</head>

<body style="margin-top: 100px;">
    <script>
	    function Submit() {
	        var userModel = {};
	        var username = $("#userName").val();
	        var password = $("#password").val();
	
	        userModel.userName = username;
	        userModel.password = password;
	
	        if (username == "") {
	            alert("请输入用户名");
	            return false;
	        } else {
	            if (password == "") {
	                alert("密码不能为空");
	                return false;
	            } else {
	                document.getElementById("ajaxform").submit();
	            }
	        }
	    }
	</script>

    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <a class="navbar-brand" href="http://localhost:8080/mwyqMonitor/main/" style="font-size:25px;"><strong>藏汉舆情汇聚与监测系统</strong></a>
            <ul class="nav navbar-nav">
                <li><a style="font-size:18px;margin-top:10px;"><strong>个人设定</strong></a></li>
            </ul>
            <form action="" class="navbar-form">
                <button type="submit" class="btn navbar-btn btn-primary btn-sm navbar-right">保存</button>
            </form>
        </div>
    </nav>

    <div class="container" style="margin-top:50px;">
        <div class="row">
            <div class="col-md-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-user"></span>
                        <strong>&nbsp;个人信息</strong></div>
                    <div class="panel-body">
                        <ul>
                            <li><p>账&nbsp;&nbsp;&nbsp;户：<span>sunpeng</span></p></li>
                            <li><p>单&nbsp;&nbsp;&nbsp;位：<span>sunpeng</span></p></li>
                            <li><p>邮&nbsp;&nbsp;&nbsp;箱：<span>sunpeng</span></p></li>
                        </ul>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-briefcase"></span>
                        <strong>&nbsp;我的收藏</strong></div>
                    <div class="panel-body">
                        <ul>
                            <li><p>中央民族大学</p></li>
                            <li><p>中央民族大学</p></li>
                            <li><p>中央民族大学</p></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-cog"></span>
                        <strong>&nbsp;用户设定</strong></div>
                    <div class="panel-body">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-cog"></span>
                            <strong>专题设置</strong></div>
                        <div class="panel-body">
                            <ul><li><span>关键词：</span><input type="text" placeholder="以空格分割多个关键词"></li></ul>
                        </div>
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-cog"></span>
                            <strong>预警设置</strong></div>
                        <div class="panel-body">
                            <ul>
                                <li><span>预警开关：</span>
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default btn-sm">打开</button>
                                        <button type="button" class="btn btn-default btn-sm">关闭</button>
                                    </div>
                                </li><br/>
                                <li><span>预警内容：</span>
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default btn-sm">全部</button>
                                        <button type="button" class="btn btn-default btn-sm">敏感</button>
                                    </div>
                                </li><br/>
                                <li><span>预警来源：</span>
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default btn-sm">全部</button>
                                        <button type="button" class="btn btn-default btn-sm">新浪</button>
                                    </div>
                                </li><br/>
                                <li><span>预警方式：</span>
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default btn-sm">全部</button>
                                        <button type="button" class="btn btn-default btn-sm">省内</button>
                                        <button type="button" class="btn btn-default btn-sm">省外</button>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-cog"></span>
                            <strong>偏好设置</strong></div>
                        <div class="panel-body">
                            <ul>
                                <li><span>字号设置：</span>
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default btn-sm">10</button>
                                        <button type="button" class="btn btn-default btn-sm">12</button>
                                        <button type="button" class="btn btn-default btn-sm">14</button>
                                        <button type="button" class="btn btn-default btn-sm">16</button>
                                        <button type="button" class="btn btn-default btn-sm">18</button>
                                        <button type="button" class="btn btn-default btn-sm">20</button>
                                    </div>
                                </li><br/>
                                <li><span>改换色调：</span>
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default btn-sm">红</button>
                                        <button type="button" class="btn btn-default btn-sm">黄</button>
                                        <button type="button" class="btn btn-default btn-sm">绿</button>
                                        <button type="button" class="btn btn-default btn-sm">蓝</button>
                                        <button type="button" class="btn btn-default btn-sm">紫</button>
                                    </div>
                                </li><br/>
                                <li><span>版本信息：</span>1.0</li><br/>
                                <li><span>关于我们：</span>卡尔玛文化传播（北京）有限公司</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <nav class="navbar navbar-default navbar-fixed-bottom">
        <div class="container" style="text-align: center">
            <h4>&copy; 2018 中央民族大学</h4>
        </div>
    </nav>
</body>
</html>