<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<meta charset="UTF-8">
<title>정보수정</title>
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
		<h1 class="text-center">정보 수정</h1>
		<hr>
	</header>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-xs-3 w-50 p-3">
				<p class="text-center">* 필수입력</p> 
				<!-- onsubmit="false"면 submit을 차단 -->
	<form name="regForm" method="post" action="/user/userModify" onsubmit="return regCheck(this)"> 
		
		<div class="text-center">프로필 사진</div>
		<div class="text-center">
			<img width ="400px" height="250px" src="${login_session.profile_img }">
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				<input type="radio" class="btn-check" id="btnradio1" autocomplete="off" name="profile_img" size="15" value="/resources/img/p1.PNG"> <label class="btn btn-outline-dark" for="btnradio1" checked> <img width="50px" height="50px" src="/resources/img/p1.PNG"> </label>
				<input type="radio" class="btn-check" id="btnradio2" autocomplete="off" name="profile_img" size="15" value="/resources/img/p2.PNG"> <label class="btn btn-outline-dark" for="btnradio2"> <img width="50px" height="50px" src="/resources/img/p2.PNG"> </label>
				<input type="radio" class="btn-check" id="btnradio3" autocomplete="off" name="profile_img" size="15" value="/resources/img/p3.PNG"> <label class="btn btn-outline-dark" for="btnradio3"> <img width="50px" height="50px" src="/resources/img/p3.PNG"> </label>
				<input type="radio" class="btn-check" id="btnradio4" autocomplete="off" name="profile_img" size="15" value="/resources/img/p4.PNG"> <label class="btn btn-outline-dark" for="btnradio4"> <img width="50px" height="50px" src="/resources/img/p4.PNG"> </label>
				<input type="radio" class="btn-check" id="btnradio5" autocomplete="off" name="profile_img" size="15" value="/resources/img/p5.PNG"> <label class="btn btn-outline-dark" for="btnradio5"> <img width="50px" height="50px" src="/resources/img/p5.PNG"> </label>
			</div>
		</div>
		&nbsp;
		<div class="text-center">*아이디 :&nbsp;
			<input type="text" name="uid" id="id" size="30" value ="${userInfo.uid }" readonly required> 
		</div>
		&nbsp;
		<div class="text-center">*비밀번호 :&nbsp;
			<input type="password" name="upw" id="upw" size="30" required> 
		</div>
		&nbsp;
		<div class="text-center">*비밀번호 확인 :&nbsp;
			<input type="password" name="rePw" id="rePw" size="30" required> 
		</div>
		&nbsp;
		<div class="text-center">*이름 :&nbsp;
			<input type="text" name="name" id="name" size="30" value="${userInfo.name }" readonly> 
		</div>
		&nbsp;
		<div class="text-center">*이메일 :&nbsp;
			<input type="text" name="email" id="email" size="30" readonly value="${userInfo.email }"> 
		</div>
		&nbsp;
		<div class="text-center">전화번호 :&nbsp;
			<input type="tel" name="cp" size="30" value="${userInfo.cp }" readonly required>
		</div>
		&nbsp;
		<div class="text-center">성별 :&nbsp;
			남<input type="radio" name="gender" value="남" size="30">
						여<input type="radio" name="gender" value="여" size="30">
		</div>
		&nbsp;
		<div class="text-center">생일 :&nbsp;
			<label for="start">Start date:</label>
					
						<input type="date" id="start" name="birth"
					       value="${userInfo.birth }"
					       min="1900-01-01" max="2020-12-31" required>  
		</div>
		&nbsp;
		<div class="text-center">부서번호 :&nbsp;
			<input type="text" name="dp_code" id="dp_code" size="30" value="${userInfo.dp_code }" readonly required>
		</div>
		&nbsp;
		<div class="text-center">직위번호 :&nbsp;
			<input type="text" name="position_code" id="position_code" size="30" value="${userInfo.position_code }" readonly required>
		</div>
		&nbsp;
		<div class="text-center">
		<div class="btn group">
					<input type="submit" class="btn1 btn btn-warning" value="정보 수정"/> 
					<input type="reset" class="btn2 btn btn-danger" value="초기화" /> 
					<a href="javascript:history.back()"><input type="button" value="돌아가기" class="btn3 btn btn-primary"></a>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</div>
</div>
	</form>

<script type="text/javascript">
	
	// email 중복체크 
	
	function emailCheck(){ 
		
	//새창 만들기 
	window.open("/user/emailCheckForm", "emailwin", "width=400, height=350"); 
	
	}
	//emailCheck() end

	
	// 유효성 검사!
	function regCheck(param) {
		
		// 패스워드 길이 5~10 이내 인지 확인
		let pw = param.upw.value;
		pw = pw.trim();
		
		if(pw.length<5 || pw.length>10) {
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