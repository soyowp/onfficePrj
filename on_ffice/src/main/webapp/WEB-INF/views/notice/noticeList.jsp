<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function selectreq() {
		var select = document.getElementById("select").value;
		window.location.href = '/notice/category?ncategory=' + select;

	}
</script>
<style>
	body{margin: 50px;}
</style>
</head>
<body>

	<a href="/company/lobby"><button class="btn btn-dark">로비로가기</button></a>
	
	<div class="text-center">
		<h1>알림 게시판</h1>
	</div>

	<hr/>


	<select id="select" onchange="selectreq()">
		<option value="" selected="disalbed">--선택--</option>
		<option value="공지">공지</option>
		<option value="행사">행사</option>
		<option value="자료">자료</option>
		<option value="기타">기타</option>
	</select>
	<br>
	
	<table class="table table-dark table-hover text-center">
		<tr>
			<th>카테고리</th>
			<th>글번호</th>
			<th>글제목</th>
			<th>글쓴이</th>
			<th>쓴날짜</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${noticeList}" var="nl">
		<tr>
				<td><c:out value="${nl.ncategory}" /></td>
				<td><c:out value="${nl.notice_num}"/></td>
				<td><a href="/notice/noticeDetail?notice_num=${nl.notice_num}"><c:out value="${nl.ntitle}" /></a></td>
				<td><c:out value="${nl.nwriter}" /></td>
				<td><c:out value="${nl.ndate}" /></td>
				<td><c:out value="${nl.nhits}" /></td>
			</tr>
		</c:forEach>
		</br>

	</table>
	<!-- url로 접속할 때 잘못된 주소로 접근하면 error창 처리하는 것 만들기 -->
	
	<div class="row text-center justify-content-center">
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${btnMaker.prev}">
				<li class="page-item">
				<a class="page-link" href="/notice/noticeList?pageNum=${btnMaker.startPage - 1}">
				Previous</a>
				</li>
			</c:if>
			
			<c:forEach begin="${btnMaker.startPage}"
						end="${btnMaker.endPage}"
						var="pageNum">
				<li class="page-item ${btnMaker.cri.pageNum == pageNum ? 'active' : ''}">
				<a class="page-link" href="/notice/noticeList?pageNum=${pageNum}">${pageNum}</a>
				</li>
			</c:forEach>
			
			<c:if test="${btnMaker.next}">
				<li class="page-item">
				<a class="page-link" href="/notice/noticeList?pageNum=${btnMaker.endPage + 1}">Next</a></li>	
			</c:if>
		
			<c:set var="position" value="${login_session.position_code}" />

		</ul>
	</nav>

	<div>
		<form action="/notice/gowrite" method="post">
				<c:if test="${position >= 6}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</c:if>
				<input type="submit" value="글쓰러가기" class="btn btn-dark">
		</form>
		
		
	
		
		
	</div>

</div>

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