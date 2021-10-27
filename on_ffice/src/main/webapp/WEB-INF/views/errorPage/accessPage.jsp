<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style>
body{
text-align: center;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<h1>잘못된 접근입니다.</h1>
	</header>
	<hr>
	
	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() }" /></h2>
	
	<h2><c:out value="${errorMessage}" /></h2>
	
	<a href="javascript:history.back();"><button class="btn btn-dark">돌아가기</button></a>
</body>
</html>