<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF"
	crossorigin="anonymous">
<meta charset="UTF-8">
<style>
body {
	margin: 50px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<header>
				<div class="row">
				<div class="form inline">
					<a href="/company/lobby"><button class="btn btn-dark">로비로가기</button></a>
					<a href="/dpcommunity/dpclist?dp_code=${login_session.dp_code}"><button class="btn btn-success">부서게시판으로가기</button></a>
					<a href="/mypage/main"><button class="btn btn-info">마이페이지로</button> </a>
				</div>
				</div>
				<figure class="text-center">
					<blockquote class="blockquote">
						<h1>${dpinfo.depart_name}</h1>
					</blockquote>
					<figcaption class="blockquote"> 부서코드: [${dpinfo.dp_code}] 총 인원:${dpinfo.count}인</figcaption>
				</figure>
				<div class="row">
				</div>

				<!-- 부서 사람들 불러오는것 -->
				<!-- 부서 커뮤니티 연결 -->
				<hr>
				<div class="text-center">
							<h2>${dpinfo.depart_name} 소속 인원</h2>
					<c:forEach items="${dpu_list}" var="dl">
						<c:if test="${dl.dp_code eq login_session.dp_code}">
								<div class="fs-6">
								test : ${dl.stat }
								사원번호:[${dl.empno}] /
								직급:${dl.p_name} /
								이름:${dl.name} /
								아이디:${dl.uid}
								</div>
						</c:if>
					</c:forEach>
				</div>
				<hr>
			</header>
		</div>

		<main>
			<div class="row text-center">
				<h2>${dpinfo.depart_name} 최근 업로드 게시글</h2>
			</div>
			<div class="row text-center">
				<table class="table table-dark table-hover">
					<tr>
						<th>글 번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<c:forEach items="${dpc_list}" var="dpcl">
						<c:if test="${dpcl.dp_code eq login_session.dp_code}">
							<tr>
								<td>${dpcl.dc_num}</td>
								<td>${dpcl.dtitle}</td>
								<td>${dpcl.dwriter}</td>
								<td>${dpcl.ddate}</td>
								<td>${dpcl.dhits}</td>
							</tr>
						</c:if>
						</c:forEach>
					</table>
					<br />
			</div>
		</main>
		<footer>

			<div class="row">
				<hr>
				<h6 class="text-center">홈페이지 : <strong>www.onffice.com</strong></h6>
				<h6 class="text-center">주소 : <strong>서울특별시 마포구 양화로 127, 첨단빌딩</strong></h6>
				<h6 class="text-center">만든이 : <strong>배용우 신우람 고광훈 서성현 신동규</strong> </h6>
			</div>
	
		</footer>


	</div>
</body>
</html>