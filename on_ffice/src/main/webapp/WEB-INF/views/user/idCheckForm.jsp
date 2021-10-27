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
		<h3>아이디 중복확인</h3> 
		<form method="post" action="/user/idCheckProc" onsubmit="return blankCheck(this)"> 
			<input type="text" name="uid" maxlength="20" autofocus class="form-control" placeholder="아이디를 입력해주세요" style="text-align: center"> 
			<br/>
			<input type="submit" value="중복확인" class="btn btn-dark"> 
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form> 
	</div> 
</div>
	</body>
<script> 
	// blankCheck 함수 시작
	// 파라미터로 자기 자신을 받고,
	function blankCheck(param){ 
	// 변수 uid 에 자기 자신의 uid 값을 넣는 구문
	// trim()은 공백을 모두 없애는 메서드
	// trim을 이용하여 공백을 없앤 uid 값을 변수 uid에 저장
		let uid=param.uid.value; 
			uid=uid.trim(); 
		
		// uid의 길이가 5 미만일 경우 아이디는 5자 이상 입력해주세요 경고창 출력
		if(uid.length<4){ alert("아이디는 4자 이상 입력해주십시오."); 
		// false를 리턴해줘야만 onsubmit의 원리로 submit자체를 차단할 수 있음
		// onsubmit 뒤에 "return false"가 있으면 이 폼의 submit을 차단할 수 있음
		return false; }//if end return true; 
		
	}//blankCheck() end 
		
</script>

</body>
</html>