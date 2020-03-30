<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title >民文舆情汇聚与监测系统 — 登录</title>
    <link rel="shortcut icon" href="favicon.png"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="
	<%=request.getContextPath()%>/resources/css/hotpots/bootstrap-theme.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/hotpots/bootstrap.min.css">
	
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-3.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/hotpots/jquery-1.9.0.min.js"></script>
    
    
</head>
<body>

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
//                document.getElementById("ajaxform").action = "svc/user/mwhjlogin/userLogin";
                //document.getElementById("ajaxform").action = "svc/user/mwhjlogin/userLogin";
                document.getElementById("ajaxform").submit();
                
            }
        }
    }
</script>

<div class="container">
	<div class="row" style="background-color:#FFFFFF;margin:auto;">
    	<div class="col-sm-12" style="height:200px;text-align:center;padding-top:100px;">
    		<h1>民汉舆情汇聚与分析系统</h1>
    	</div>
    	<div class="col-sm-4" id="left"></div>
        <div class="col-sm-4">
            <div class="panel-body" style="padding-left:125px;padding-right:125px;">
                <!-- 用户名和密码 -->
                <form name="ajaxform" id="ajaxform" action="userForm" method="GET">
                    <fieldset>
                        <div class="form-group">
                            <span style="font-size:16px;">用户名：</span>
                            <input id="userName" class="form-control" name="userName" type="text"></input>
                        </div>
                        <div class="form-group">
                            <span style="font-size:16px;">密&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
                            <input id="password" class="form-control" name="password" type="password" onkeydown='if(event.keyCode==13){$(".btn-login").click();}'> </input>
                        </div>
                    </fieldset>
                </form>
                <!-- 登陆-->
                <br/>
                <div id="button-div">
                    <div id="login-button" style="width:100%;">
                        <button id="login" class="btn btn-lg btn-success btn-block btn-login" onclick="javascript: Submit()" style="border-radius:0;">登录</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4" id="right"></div>
    </div>
</div>

</body>
</html>