<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	&nbsp;

	<header>
		<h1 class="text-center">로그아웃</h1>
		<hr>
	</header>
	<h4 class="text-center">"오늘 할 일을 내일로 미루지 말자"</h4>

	&nbsp;
	<form action="/user/logout" method="post">
		<div class="text-center">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="submit" value="로그아웃" class="btn btn-dark">
		<a href="/mypage/main"><input type="button" class="btn btn-danger" value="일하러가기" /></a>
	</div>
	</form>

	&nbsp;
	
</body>
<footer>

	<div class="row">
		<hr>
		<h6 class="text-center">홈페이지 : <strong>www.onffice.com</strong></h6>
		<h6 class="text-center">주소 : <strong>서울특별시 마포구 양화로 127, 첨단빌딩</strong></h6>
		<h6 class="text-center">만든이 : <strong>배용우 신우람 고광훈 서성현 신동규</strong> </h6>
	</div>

</footer>
</html>