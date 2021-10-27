<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>구내식당 총 메뉴 표</h2>
	<c:forEach items="${week}" var="menu">
		${menu.mno}
		${menu.main}
		${menu.side1}
		${menu.side2}
		${menu.side3}
		${menu.side4}
		<br>
	</c:forEach>	

</body>
</html>