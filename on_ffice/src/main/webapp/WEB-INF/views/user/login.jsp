<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body { text-align: center;}
	.g-recaptcha { display: table; margin-left: auto; margin-right: auto;}
</style>

<h1 class="text-center">로그인</h1>

		<hr/>
</head>
<body>
<script src='https://www.google.com/recaptcha/api.js'></script> 
<script type="text/javascript"> 
/* 서브밋 전에 리캡챠 체크 여부 를 확인합니다. */
 
 function FormSubmit() { 
	if (grecaptcha.getResponse() == ""){ 
		alert("리캡챠를 체크해야 합니다."); 
		return false; 
		} else {
			return true; 
			} 
	}

	var result = "${delete_result}";
	console.log(result);
	
	if(result==="success"){
		alert("탈퇴가 정상적으로 되었습니다");
		
		setTimeout(function() {
			window.close();
		}, 1);
	}
	
	var check= "${check}";
	
	if(check==="no"){
		alert("승인이 필요합니다. 로그인 실패하였습니다.");
	}
	
	var permit="${permit}";
	if(permit==="fail"){
		alert("가입 거절되었습니다. 관리자에게 문의하세요");
	}

 </script>

	<c:if test="${register_result eq 'success' }">
		<script>
			alert('회원 가입이 정상적으로 진행되었습니다.');
			
		</script>
	</c:if>
	<c:if test="${login_result eq 'fail'}">
		<script>
			alert('아이디 혹은 패스워드를 확인해주세요.');
		
		</script>
	</c:if>
	<div class="container text-center">
		<div class="row">&nbsp;</div>

		<c:out value="${error }" />
		<c:out value="${logout}" />

		<form action ="/user/login" method="post" onsubmit="return FormSubmit();">

		<div class="md-3">
			<label for="uid" class="form-laber">아이디</label>
			<input type="text" name="uid" placeholder="ID" id="uid" required>
		</div>

		<div class="row">&nbsp;</div>

		<div class="md-3">
			<label for="upw" class="form-laber">비밀번호</label>
			<input type="password" name="upw" placeholder="PASSWORD" id="upw" required>
		</div>

		<div class="row">&nbsp;</div>

		<div class="g-recaptcha" data-sitekey="6LezJokcAAAAAGeSI922uGsecDbO3MCUTxplIzLj"></div>

		<div class="row">&nbsp;</div>
		
		<div class="row">
		<p>" 환영합니다. <strong>로그인</strong>을 해주세요! "</p>
		</div>
		<div class="row">&nbsp;</div>
		<div class="row">
			<div class="col-md-12">
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='/user/agreeCheck'">
			<div class="row">&nbsp;</div>
			</div>
			<div class="col-md-12">
				<input type="button" value="게스트" onclick="location.href='/user/guestIn'">
				<div class="row">&nbsp;</div>
				</div>
		</div>
			
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>

	<div class="row">&nbsp;</div>


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