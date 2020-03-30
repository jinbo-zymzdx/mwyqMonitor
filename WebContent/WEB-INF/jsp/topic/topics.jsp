<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/pagination.css" />
<script src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.pagination.js"></script>

<script type="text/javascript">

function PageCallback(index) { 
	window.location.href="<%=request.getContextPath() %>/topic/topicPage?page="+(index+1);
}
$(document).ready(function() {
	var id = 0;
	$("#Pagination").pagination("${page.totalPage }",{
		current_page:"${page.currentPage-1}",
		callback: PageCallback
	});
});
</script>
<title>话题分页</title>
</head>
<body>

<center>
	<div>
		<table>
			<c:forEach items="${topics }" var="topic">
	  			<tr>
		  			<td>${topic.topic_id }</td><td>${topic.topic_label }</td>
		  		</tr>
	  		</c:forEach>
		</table>
	</div>
	<div class="pages">
		<div id="Pagination"></div>
	</div>
</center>
</body>
</html>