<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{margin: 50px;}
</style>
<script>
	
</script>
</head>
<body>
	<header>
	<a href="/company/lobby"><button class="btn btn-dark">로비로가기</button></a>
	
	<div class="text-center">
		<h1>자유 게시판</h1>
	</div>

	<hr/>

	</header>
	

	<table class="table table-dark table-hover text-center">
		<tr>
			<th>글번호</th>
			<th>글제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${cmList}" var="cl">
		<tr>
			<td><c:out value="${cl.community_num}"/></td>
				<td><a href="/community/CMDetail?community_num=${cl.community_num}">${cl.ctitle}</a></td>
				<td><c:out value="${cl.cwriter}"/></td>
				<td><c:out value="${cl.cdate}"/></td>
				<td><c:out value="${cl.chits}"/></td>
			</tr>
		</c:forEach>
	</table>
		<br/>
	<!-- url로 접속할 때 잘못된 주소로 접근하면 error창 처리하는 것 만들기 -->
	<div class="row text-center justify-content-center">
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${btnMaker.prev}">
				<li class="page-item">
					<a class="page-link" href="/community/CMList?pageNum=${btnMaker.startPage - 1}">
						Previous</a>
					</li>
				</c:if>
				
				<c:forEach begin="${btnMaker.startPage}"
				end="${btnMaker.endPage}"
				var="pageNum">
				<li class="page-item ${btnMaker.cri.pageNum == pageNum ? 'active' : ''}">
					<a class="page-link" href="/community/CMList?pageNum=${pageNum}">${pageNum}</a>
				</li>
			</c:forEach>
			
			<c:if test="${btnMaker.next}">
				<li class="page-item">
					<a class="page-link" href="/community/CMList?pageNum=${btnMaker.endPage + 1}">Next</a></li>	
				</c:if>
			</ul>
		</nav>
		<div>
		<a href="/community/write"><button class="btn btn-dark">글쓰러가기</button></a></div><br/><br/>
	
	</div>
 <script>
	var result = "${result}"
	
	if(result==="success"){
		alert("삭제가 정상적으로 진행되었습니다.");
	}else if(result==="fail"){
		alert("비밀번호가 달라 삭제 실패하였습니다.");
	}
 
 </script> 

<footer>

	<div class="row">
		<hr>
		<h6 class="text-center">홈페이지 : <strong>www.onffice.com</strong></h6>
		<h6 class="text-center">주소 : <strong>서울특별시 마포구 양화로 127, 첨단빌딩</strong></h6>
		<h6 class="text-center">만든이 : <strong>배용우 신우람 고광훈 서성현 신동규</strong> </h6>
	</div>

</footer>

</body>
</html>