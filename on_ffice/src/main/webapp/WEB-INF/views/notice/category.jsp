<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		margin:50px;
	}
</style>
<script>
	function selectreq() {
		var select = document.getElementById("select").value;
		window.location.href = '/notice/category?ncategory=' + select;

	}
</script>
</head>
<body>
	<header>
		<div class="row">
			<div class="form-inline">
				<a href="/notice/noticeList"><button class="btn btn-dark">전체보기</button></a>
			</div>
		</div>
		<div class="text-center">
			<h4>"글을 확인 하시려면 글번호를 클릭해주세요!"</h4>
		</div>
	</header>
	<hr/>

	<select id="select" onchange="selectreq()">
		<option value="" selected="disalbed">--선택--</option>
		<option value="공지">공지</option>
		<option value="행사">행사</option>
		<option value="자료">자료</option>
		<option value="기타">기타</option>
	</select>

	<div>
		&nbsp;
	</div>
	

	<table class="table table-dark table-hover text-center">
		<tr>
			<th>글번호</th>
			<th>카테고리</th>
			<th>글제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<tr>
			<c:forEach items="${category}" var="cg">
			<td><a href="/notice/noticeDetail?notice_num=${cg.notice_num}"><c:out value="${cg.notice_num}"/></a></td>
			<td><c:out value="${cg.ncategory}"/></td>
			<td><c:out value="${cg.ntitle}"/></td>
			<td><c:out value="${cg.nwriter}"/></td>
			<td><c:out value="${cg.ndate}"/></td>
			<td><c:out value="${cg.nhits}"/></td>
		</tr>

</c:forEach>
</table>

		<br/>
	
	
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${btnMaker.prev}">
				<li class="page-item">
				<a class="page-link" href="/notice/category?pageNum=${btnMaker.startPage - 1}">
				Previous</a>
				</li>
			</c:if>
			
			<c:forEach begin="${btnMaker.startPage}"
						end="${btnMaker.endPage}"
						var="pageNum">
				<li class="page-item ${btnMaker.cri.pageNum == pageNum ? 'active' : ''}">
				<a class="page-link" href="/notice/category?pageNum=${pageNum}">${pageNum}</a>
				</li>
			</c:forEach>
			
			<c:if test="${btnMaker.next}">
				<li class="page-item">
				<a class="page-link" href="/notice/category?pageNum=${btnMaker.endPage + 1}">Next</a></li>	
			</c:if>
			
		</ul>
	</nav>

	<div class="text-center">
		<form action="/notice/gowrite" method="post">
				<c:if test="${login_session.position_code >= 6}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</c:if>
		
				<input type="submit" value="글쓰러가기">
		</form>
		
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