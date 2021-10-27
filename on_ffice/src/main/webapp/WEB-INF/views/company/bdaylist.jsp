<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	body{margin: 50px;}
</style>
</head>
<body>
	<header>
		<a href="/company/lobby"><button class="btn btn-dark">로비로가기</button></a>

		<div class="text-center">
			<h1>이달의 생일</h1>
		</div>

		<hr/>
	</header>

		<table class="table table-dark table-hover text-center">
		<thaed>
			<tr>
				<th scope="col">이름</th>
				<th scope="col">부서</th>
				<th scope="col">직급</th>
				<th scope="col">생일</th>
			</tr>
		</thaed>
		<tbody>	
			<c:forEach items="${blist }" var="list">
			<tr>
				<td>${list.name }</td>
				<td>${list.dp_code }</td>
				<td>${list.position_code }</td>
				<td>${list.birth }</td>
			</tr>	
			
			</c:forEach>
	  </tbody>		
		</table>
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