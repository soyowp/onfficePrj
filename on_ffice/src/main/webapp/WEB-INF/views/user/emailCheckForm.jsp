<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="col-xs-3 w-70 p-3">
	<div style="text-align: center"> 
		<h3>이메일 중복확인</h3> 
		<form method="post" action="/user/emailCheckProc" onsubmit="return blankCheck(this)"> 
			<input type="text" name="email" maxlength="50" autofocus class="form-control" placeholder ="이메일을 입력해주세요" style="text-align: center"> 
			<br/>
			<input type="submit" value="중복확인" class="btn btn-dark"> 
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</form> 
	</div> 
</div>
<script> 
	// blankCheck 함수 시작
	// 파라미터로 자기 자신을 받고,
	function blankCheck(param){ 
	// 변수 email 에 자기 자신의 email 값을 넣는 구문
	// trim()은 공백을 모두 없애는 메서드
	// trim을 이용하여 공백을 없앤 email 값을 변수 email에 저장
		let email=param.email.value; 
			email=email.trim(); 
		// email에 '@'가 포함되지 않을 경우 경고창 출력
		if(email.indexOf('@')==-1){ alert("이메일을 올바르게 입력해주세요."); 
		// false를 리턴해줘야만 onsubmit의 원리로 submit자체를 차단할 수 있음
		// onsubmit 뒤에 "return false"가 있으면 이 폼의 submit을 차단할 수 있음
		return false; 
		
		}//if end return true; 
		
	}//blankCheck() end 
		
</script>

</body>
</html>