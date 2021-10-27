<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>

<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<style>
	body{
		align-items: center;
	}
</style>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<header>
		<h1 class="text-center">회원가입</h1>
		<hr>
	</header>
	<main>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-xs-3 w-50 p-3">
				<form name="regForm" method="post" action="/user/register" onsubmit="return regCheck(this)"> 
					<span style="color:red; font-weight: bold">* 필수입력</span> <br> 
					
					
								<div>*아이디</div>
								<div class="input-group mb-3">
									<span class="input-group-text" id="basic-addon1">
										<input type="button" value="ID중복확인" onclick="idCheck()" class="btn btn-dark">
									</span>
									<input type="text" name="uid" id="id" size="15" readonly required class="form-control" placeholder="Username" aria-describedby="basic-addon1"> 
								</div>
						
					
						
					
								<div>*비밀번호</div>
								<div class="input-group mb-3">
									<input type="password" name="upw" id="upw" size="15" required class="form-control">
								</div>
							
						 
								<div>*비밀번호 확인</div>
								<div class="input-group mb-3">
									<input type="password" name="rePw" id="rePw" size="15" required class="form-control">
								</div>
						
					
								<div>*이름</div>
							
								<div class="input-group mb-3">
									<input type="text" name="name" id="name" size="15" required class="form-control">
								</div>
							
								<div>*이메일</div>
										<div class="input-group mb-3">
										<span class="input-group-text" id="basic-addon1">
										<input type="button" value="Email 중복확인" onclick="emailCheck()" class="btn btn-dark">
										</span>
										<input type="text" name="email" id="email" size="30" required readonly class="form-control" aria-describedby="basic-addon1"> 
									</div>
							 
						
									<div>전화번호</div>
										<div class="input-group mb-3">
										<span class="input-group-text" id="basic-addon1">
										<input type="button" value="휴대폰 문자인증" onclick="phoneCheck()"class="btn btn-dark" aria-describedby="basic-addon1">
										</span>
										<input type="tel" name="cp" size="15" readonly required class="form-control">
									</div>

									<div>프로필 사진</div>
										<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
										<input type="radio" class="btn-check" id="btnradio1" autocomplete="off" name="profile_img" size="15" value="/resources/img/p1.PNG"> <label class="btn btn-outline-dark" for="btnradio1" checked> <img width="50px" height="50px" src="/resources/img/p1.PNG"> </label>
										<input type="radio" class="btn-check" id="btnradio2" autocomplete="off" name="profile_img" size="15" value="/resources/img/p2.PNG"> <label class="btn btn-outline-dark" for="btnradio2"> <img width="50px" height="50px" src="/resources/img/p2.PNG"> </label>
										<input type="radio" class="btn-check" id="btnradio3" autocomplete="off" name="profile_img" size="15" value="/resources/img/p3.PNG"> <label class="btn btn-outline-dark" for="btnradio3"> <img width="50px" height="50px" src="/resources/img/p3.PNG"> </label>
										<input type="radio" class="btn-check" id="btnradio4" autocomplete="off" name="profile_img" size="15" value="/resources/img/p4.PNG"> <label class="btn btn-outline-dark" for="btnradio4"> <img width="50px" height="50px" src="/resources/img/p4.PNG"> </label>
										<input type="radio" class="btn-check" id="btnradio5" autocomplete="off" name="profile_img" size="15" value="/resources/img/p5.PNG"> <label class="btn btn-outline-dark" for="btnradio5"> <img width="50px" height="50px" src="/resources/img/p5.PNG"> </label>
									</div>
								
								<div>성별</div>							
									<input type="radio" name="gender" value="남" size="15" class="btn-check" id="gender1"> <label class="btn btn-outline-dark" for="gender1">남</label>
									<input type="radio" name="gender" value="여" size="15" class="btn-check" id="gender2"> <label class="btn btn-outline-dark" for="gender2">여</label>
									
								<div>생년월일</div>
									<input type="date" id="start" name="birth" class="form-control"
											   value="2021-09-15" min="1900-01-01" max="2020-12-31">
							
							   <div>부서</div>
								<select name="dp_code" class="form-select form-select-sm">
								<c:forEach var="depart" items="${dpList }">
									<option value="${depart.dp_code }">${depart.depart_name }</option>
								</c:forEach>
								</select>

								<div>직위</div>
								<select name="position_code" class="form-select form-select-sm">
								<c:forEach var="position" items="${positionList }">
									<option value="${position.p_code}">${position.p_name }</option>
								</c:forEach>
								</select>
								<br>
							<div class="text-center"> 
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
								<input type="submit" class="btn btn-success" value="회원가입"/> 
								<input type="reset" class="btn btn-danger" value="재작성" /> 
								</div>
							</form>
							<br>
							<div class="text-center">
				                <a href="/user/login"><input type="button" class="btn btn-primary" value="뒤로가기" /></a>
						</div>

			</div>

			</div>
		</div>									<!-- onsubmit="false"면 submit을 차단 -->
		

		</main>

<script type="text/javascript">
	// id 중복체크
	function idCheck(){ 
	
	//새창 만들기
	window.open("/user/idCheckForm", "idwin", "width=400, height=350"); 
	
	}
	// email 중복체크 
	
	function emailCheck(){ 
		
	//새창 만들기 
	window.open("/user/emailCheckForm", "emailwin", "width=400, height=350"); 
	
	}
	
	// 문자인증
	
	function phoneCheck() {
		
		window.open("/user/goPhoneCheckForm", "phonewin", "width=400, height=350");
		
	}

	
	// 유효성 검사!
	function regCheck(param) {
		
		// 패스워드 길이 5~10 이내 인지 확인
		let pw = param.upw.value;
		pw = pw.trim();
		
		if(pw.length<5 || pw.length>30) {
			alert("비밀번호가 5~10자리 이내로 입력해주세요.")
			param.upw.focus();//커서 가져다 주기
			return false;
		} // if end
		
		// 패스워드와 패스워드 확인이 서로 일치하는지
		let upw = param.upw.value;
		upw=upw.trim();
		
		let rePw= param.rePw.value;
		rePw=rePw.trim();
		
		if(upw!=rePw) {
			alert("비밀번호가 일치 하지 않습니다.")
			param.upw.focus();
			return false;
		} // if end 
		
		
		
	}
</script>
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