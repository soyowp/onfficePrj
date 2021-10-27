<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>부서 자유 게시판</title>
<style>
	body{
		margin:50px;
	}
</style>

<script>	
</script>
</head>
<body>
	<div class="container">
		<header>
			<div class="row">
				<div class="form-inline">
				<c:set var="user" value="${login_session}" />
				<a href="/company/dplobby?dp_code=${user.dp_code}"><button class="btn btn-dark">부서로비가기</button></a>
				<a href="/company/lobby"><button class="btn btn-dark">메인로비로가기</button></a>
				</div>
			</div>
			<div class="text-center">
				<h1>부서 자유 게시판</h1>
				
			</div>

			<hr/>
		</header>
				<main>
				<table class="table table-dark table-hover text-center">
					<tr>
						<th>글번호</th>
						<th>글제목</th>
						<th>부서명</th>
						<th>사원번호</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>수정일</th>
						<th>조회수</th>
					</tr>
					<c:forEach items="${dpCommunityList}" var="dpcList">
						<tr>	
							<td><c:out value="${dpcList.dc_num }"/></td>
							<td><a href="/dpcommunity/dpcdetail?dp_code=${user.dp_code}&dc_num=${dpcList.dc_num}&pageNum=${btnMaker.cri.pageNum}
												&searchType=${btnMaker.cri.searchType}&keyword=${btnMaker.cri.keyword}">
								<c:out value="${dpcList.dtitle}"/></a></td>
							<td><c:out value="${login_session.depart_name}"/></td>
							<td><c:out value="${dpcList.empno}"/></td>
							
							<td><c:out value="${dpcList.dwriter}"/></td>
							<td><c:out value="${dpcList.ddate}"/></td>
							<td><c:out value="${dpcList.dupdate}"/></td>
							<td><c:out value="${dpcList.dhits}"/></td>
						</tr>
					</c:forEach>
			</table>
			<br/>		
				
				<!-- 검색창 -->
				<form action="/dpcommunity/dpclist" method="get" class="text-center">
					<!-- option태그를 이용해 검색조건 선택창을 만들어주세요. -->
					<select name="searchType">
						<option value="null" 
						<c:out value="${btnMaker.cri.searchType == null ? 'selected': ''}" />>
						분류 없음 
					</option>
					<option value="t" 
					<c:out value="${btnMaker.cri.searchType eq 't' ? 'selected': ''}" />>
					제목
				</option>
				<option value="tc" 
				<c:out value="${btnMaker.cri.searchType eq 'tc' ? 'selected': ''}" />>
				제목 + 본문
			</option>
		<option value="w" 
		<c:out value="${btnMaker.cri.searchType eq 'w' ? 'selected': ''}" />>
		글쓴이
	</option>
</select>
<!-- 검색하기 버튼을 눌렀을때 dp_code와 keyword와 searchType을 담아서 dpclist로 보낸다 -->
<input type="hidden" name="dp_code" value="${login_session.dp_code}">
<input type="text" name="keyword" id="keywordInput"
placeholder="검색어" value="${btnMaker.cri.keyword}">
<button id="searchBtn">검색하기</button>

</form>

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${btnMaker.prev}">
				<li class="page-item">
					<a class="page-link" href="/dpcommunity/dpclist?dp_code=${user.dp_code}&pageNum=${btnMaker.startPage - 1}
								&searchType=${btnMaker.cri.searchType}&keyword=${btnMaker.cri.keyword}">
						Prev</a>
					</li>
				</c:if>
				
				<c:forEach begin="${btnMaker.startPage}"
				end="${btnMaker.endPage}"
				var="pageNum">
				<li class="page-item ${btnMaker.cri.pageNum == pageNum ? 'active' : ''}">
					<a class="page-link" href="/dpcommunity/dpclist?dp_code=${user.dp_code}&pageNum=${pageNum}
								&searchType=${btnMaker.cri.searchType}&keyword=${btnMaker.cri.keyword}">${pageNum}</a>
				</li>
			</c:forEach>
			
			<c:if test="${btnMaker.next}">
				<li class="page-item">
					<a class="page-link" href="/dpcommunity/dpclist?dp_code=${user.dp_code}&pageNum=${btnMaker.endPage + 1}
								&searchType=${btnMaker.cri.searchType}&keyword=${btnMaker.cri.keyword}">Next</a></li>	
				</c:if>
			</ul>
		</nav>

<div class="text-center">
	<a href="/dpcommunity/dpcwrite"><button class="btn btn-dark">게시글 작성</button></a>
	</div>

	&nbsp;

</main>

</div>
</body>
<footer>
	
	<hr/>

	<div class="row">
		<h6 class="text-center">홈페이지 : <strong>www.onffice.com</strong></h6>
		<h6 class="text-center">주소 : <strong>서울특별시 마포구 양화로 127, 첨단빌딩</strong></h6>
		<h6 class="text-center">만든이 : <strong>배용우 신우람 고광훈 서성현 신동규</strong> </h6>
	</div>


	
</footer>
</html>
