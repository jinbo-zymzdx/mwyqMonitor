<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/index/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/index/menu.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/index/templatemo_justified.css" />

    <script src="<%=request.getContextPath() %>/resources/js/html5shiv.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/respond.min.js"></script>
  </head>

  <body>
    <div id="container" class="container"  style="float: right">
        
        <img src="resources/images/index/templatemoheader.jpg" class="img-responsive" />
        
       
        <ul class="nav nav-justified">
        
        <li ><a href="/mwyqMonitor/topic/"> 首页&nbsp;&nbsp;&nbsp;</a></li>
        <li ><a href="/mwyqMonitor/topic/" class="meng" >实时热点&nbsp;</a></li>
        <li> <a href="/mwyqMonitor/topic/" class="meng" >敏感事件&nbsp;</a></li>
        <li ><a href="/mwyqMonitor/topic/" class="meng">统计分析&nbsp;</a></li>
        <li><a href="/mwyqMonitor/topic/" class="sub meng" >自定义检测</a>
                  <ul>
                        <li><a href="#" >添加</a></li>
                    </ul>
                </li>
            </ul> 
        
      
        
       
      <div class="row space29" style="padding-left: 20px"> <!-- row 1 begins -->
      <div class="col-md-3">
           <div class="meng" ><input type="button" value="search" style="height:100px; width:50px; margin-top: 10%; background-color: #006699; float:left" /></div>
    <div class="meng"><input type="text" style=" height:400px; margin-top:auto; width:50px;float:left"/></div>
    </div>
            <div id="map" class="col-md-4" >
              	地图
            </div>
        
            <div class="col-md-4">
              	<h2>波形图</h2>
           </div>
              
            <div class="col-md-5">
              	<div style="float:left">
              	<p>地点统计</p>
                <p>Donec auctor aliquet suscipit. Fusce euismod sem neque, eu fermentum libero pretium a. Praesent vel condimentum augue. Vivamus tempor metus sed mollis scelerisque. <a href="#">More Info.</a></p>
            </div>
            <div style="float:left">
                <p>人物统计</p>
                <p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam tempor, elit sit amet iaculis sodales, orci tellus fringilla nibh, fringilla malesuada ligula sapien quis odio. <a href="#">More Info.</a></p>
            </div>
            
            <div style="float:left">
              	<p>组织机构统计</p>
                <p>Quisque tincidunt turpis eleifend, facilisis quam vitae, rhoncus nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at erat vitae lacus bibendum malesuada quis quis neque. <a href="#">More Info.</a></p>
            </div>
            <div style="clear:both"></div> 
            </div>
       <div style="clear:both"></div> 
      </div> <!-- /row 1 -->
     
      <div id="top" class="row space30  meng" style="margin-left: 5%"> <!-- row 2 begins --> 
      		<table>
      				<tr>
 			  			<td><a id="" href="<%=request.getContextPath() %>/topic/topicPage?page=1">更多</a></td>
 			  			<td></td>
 			  			<td></td>
 			  			<td></td>
 			  			<td></td>
 			  			<td></td>
 			  		</tr>
 			  		<c:forEach items="${topicAndNumList}" var="topic">
 			  		<tr>
	 			  		<td>(${topic.newsNum})</td>
	 			  		<td><a id="" href="<%=request.getContextPath() %>/topic/topicPage?page=1">${topic.topiclabel}</a></td>
	 			  		<td>[新闻作者]${topic.newsAuthor}</td>
	 			  		<td>[新闻标题]${topic.newsTitle}</td>
	 			  		<td>[新闻内容]${topic.newsContent}</td>
	 			  		<td>[时间]${topic.newsTime}</td>
	 			  	</tr>
 			  		</c:forEach>
 			  	</table>
      </div> <!-- /row 2 -->

      <!-- Site footer -->
      <div class="footer">
        <p style="text-align: center;">Copyright © 2016 中央民族大学</p>
      </div>

    </div> <!-- /container -->
 
  </body>
</html>
