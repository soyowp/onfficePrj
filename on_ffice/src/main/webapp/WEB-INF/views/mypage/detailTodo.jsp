<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<meta charset="UTF-8">
<style>
body{
	margin: 50px;
}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<header>
    <div class="row">
			<a href="/mypage/main"><button class="btn btn-dark">돌아가기</button></a>
        </div>
	</header>
    <div class="row d-flex align-items-center h-100">
        <div class="col-xs-12 text-center">
       	
				<h1>[${getTodo.todo_num }]번 작업 상세정보</h1>
				<h5>담당자 직원번호 [${getTodo.checker }]</h5>
				<h5>현재 작업자 직원번호 [${getTodo.worker }]</h5>
				<br>
				<h3>작업명</h3>
				<h2>${getTodo.todo_title}</h2>
				<hr>
				<h3>작업내용</h3>
				<div class="w-75 mx-auto">
				<h4 style="font-weight: bold"><span class="인덱스"><c:out value="${getTodo.todo_content }"/></span></h4>
				</div>
				<hr>
				<h4>작업생성시간 - ${getTodo.recive_time }</h4>
		
        </div>
    </div>
</div>
	<main>
			
	</main>
	</body>
</html>