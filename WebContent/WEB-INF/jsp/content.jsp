<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${requestScope.key } - 盘一下</title>
<link rel="icon" href="${pageContext.request.contextPath}/image/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/image/favicon.ico" type="image/x-icon" />

<meta name="keywords" content="盘一下,百度网盘搜索,百度云搜索"/>
<meta name="description" content="盘一下,是一个专业搜索百度网盘资源的搜索引擎。"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">

</head>
<body>
	<div id="header" >
		<div class="s" >
			<a href="${pageContext.request.contextPath}/" title="盘一下">
				<div class="logo png" ></div>
			</a>
			<div class="searchbox">
				<form action="doSearch" method="post" onsubmit="return subck();">
					<input align="middle" name="key" class="q" id="kw" value="${requestScope.key }"
						autocomplete="off" baiduSug="1" x-webkit-speech />
						<input id="btn" class="btn" align="middle" value="搜索" type="submit" />
				</form>
			</div>
		</div>
	</div>
	<div id="topnav">
		
	</div>
	<div id="p_main">
		<div id="con" class="con">
			<div id="contentinfo">
				关于 <h1>${requestScope.key }</h1> 的信息为您搜索如下:
			</div>
			<c:if test="${requestScope.list.size()>0}">
			<div id="content">
				<c:forEach items="${requestScope.list}" var="advice">
				<div class="pss">
				    <h1>
						<a class="title_a_label" href="https://www.${advice.crawlSource}">${advice.newsTitle}	</a>
					</h1>
					<div class="des">
						${fn:substring(advice.newsContent,0,110)}${'...'} 
						<div>		
							<a href="https://www.${advice.crawlSource}">${advice.crawlSource}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
							${advice.newsTime}
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
			</c:if>
			<c:if test="${requestScope.list.size()<=0}">
				<br><br><br>
				<h2 style="font-size: xx-large;">亲，找不到您搜索的内容，换一个关键字试试吧(´･ω･`)</h2>
			</c:if>
			
			<div class="pagead">
				
			</div>
			<div class="cl11"></div>
			<c:if test="${requestScope.list.size()>0}">
			<div id="sopage">
				<c:forEach var="i" begin="0" end="9">
					<c:choose>
						<c:when test="${param.currentPage==i}">
							<a class="this" href="doSearch?key=${requestScope.key }&currentPage=${i+1}">${i+1}</a>
						</c:when>
						<c:otherwise>
							<a href="doSearch?key=${requestScope.key }&currentPage=${i+1}">${i+1}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			</c:if>
		</div>
		<div id="sidebar">
			<div>
				<h5 style="color: #336666;">关于我们</h5>
			</div>
			
			<img alt="" src="image/3.png" height="213px" width="397px">
			<br>
			
			
			<font color="red"> [中心动态]</font> 戳以下链接<br>
			<div id="egg2" class="cl15" style="width: 402px;height: 460px;line-height:30px;">
				
				中心网址<a href="http://www.nmlr.muc.edu.cn" target="_blank" rel="nofollow">http://www.nmlr.muc.edu.cn</a> <br>
				<br>
				<font color="red">国家语言资源监测与研究 少数民族语言中心</font>
			</div>
		</div>
	</div>
	<div id="footer">
		&nbsp;&nbsp;&copy; 2017
			Panyixia.cn&nbsp;&nbsp; 湘ICP备15015633
	</div>
    <script charset="gbk" src="http://www.baidu.com/js/opensug.js"></script>
	<script>
		function ColorEggs1(){			
			$("#egg1").toggle();
		}
	</script>
</body>
</html>