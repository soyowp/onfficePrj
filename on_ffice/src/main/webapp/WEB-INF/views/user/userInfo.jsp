<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		align-items: center;
	}
	.btn1 { margin-right:10px;}
	.btn2 { margin-right:10px;}
	p { color: red;
		font-weight: bold;}
</style>
</head>
<body>
	<header>
		&nbsp;
		<h1 class="text-center">회원 정보</h1>
		<hr>
	</header>

	<div class="container">
		<script>
			var result = "${delete_result}";
			
			if(result==="fail"){
				alert('비밀번호가 올바르지 않습니다.');
				setTimeout(function() {
					window.close();
				}, 1000);
			}else if(result==="success"){
				opener.parent.location.replace("/user/login");
				setTimeout(function() {
					window.close();
				}, 1000);
			}
			
		
			
		</script>

	<c:if test="${modify_result eq 'success'}">
		<script>
			alert('회원 정보 수정이 완료되었습니다.');
		</script>
	</c:if>
	
		<div class="row justify-content-center">
			<div class="col-xs-3 w-50 p-3">
		<p class="text-center">* 정보 조회</p>
	<form name="regForm" method="post" action="/user/register" onsubmit="return regCheck(this)"> 

		<div class="text-center">프로필 사진</div>
		<div class="text-center">
			<img width ="400px" height="250px" src="${login_session.profile_img }">
		</div>
		&nbsp;
		<div class="text-center">*아이디 &nbsp;
			<input type="text" name="uid" id="id" size="30" readonly class="text-center" value="${login_session.uid }"> 
		</div>
		&nbsp;
		<div class="text-center">*비밀번호 &nbsp;
			<input type="password" name="upw" id="upw" size="30" required readonly class="text-center" value="${login_session.upw }">
		</div>
		&nbsp;
		<div class="text-center">*이름 &nbsp;
			<input type="text" name="name" id="name" size="30" required readonly class="text-center" value="${login_session.name }">
		</div>
		&nbsp;
		<div class="text-center">*이메일 &nbsp;
			<input type="text" name="email" id="email" size="30" readonly class="text-center" value="${login_session.email }"> 
		</div>
		&nbsp;
		<div class="text-center">전화번호 &nbsp;
			<input type="tel" name="cp" size="30" readonly class="text-center" value="${login_session.cp }">
		</div>
		&nbsp;
		<div class="text-center">성별 &nbsp;
			<input type="text" name="gender" size="30" readonly class="text-center" value="${login_session.gender }">
		</div>
		&nbsp;
		<div class="text-center">생일 &nbsp;
			<input type="text" id="start" name="birth" readonly class="text-center" value="${login_session.birth }" size="30">
		</div>
		&nbsp;
		<div class="text-center">부서번호 &nbsp;
			<input type="text" name="dp_code" id="dp_code" readonly class="text-center" value="${login_session.dp_code}"size="30">
		</div>
		&nbsp;
		<div class="text-center">직위번호 &nbsp;
			<input type="text" name="position_code" id="position_code" size="30" readonly class="text-center" value="${login_session.position_code }">
		</div>
		&nbsp;
	</form>
	<div class="text-center">
	<div class="btn-group">
	<form action="/user/goUserModify" method="post">
		<input type="hidden" name="uid" value="${login_session.uid}">
		<input type="submit" value="회원정보수정" class="btn1 btn btn-warning">
		<input type="button" value="돌아가기" onclick ="location.href ='/mypage/main'" class="btn2 btn btn-primary">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
	
	<input type="button" value="회원탈퇴" onclick="deleteCheck()" class="btn3 btn btn-danger">
</div>
</div>
	<script>
		
		function deleteCheck() {
			let check = confirm('정말로 회원 탈퇴를 진행하시겠습니까?');
			
			if(check) {
				window.open("/user/deleteCheckForm", "idwin", "width=400, height=350");
									
			}
			else {
				return false;
			}
		}
	</script>
	</div>
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