<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<!-- <div style="text-align: center"> -->
		<c:choose>
			<c:when test="${sms_result eq null }">
			<h3> 전화번호 문자인증 </h3> 
		<form method="post" action="/user/phoneCheckForm"> 
			<input type="tel" name="cp" maxlength="50" required autofocus class="form-control" placeholder="전화번호를 입력해주세요" style="text-align: center">
			<br/>
			<input type="submit" value="인증문자 전송" class="btn btn-dark"> 
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</form> 
			</c:when>
			<c:when test="${sms_result eq 'success'}">
				<script>
					alert('인증 코드를 전송하였습니다.');
				</script>
				<form action="/user/phoneCheckProc" method="post">
					인증번호 : <input type="text" name="code" maxlength="10" required>
					<input type="hidden" name="cp" value="${cp }">
					<input type="hidden" name="codeString" value="${codeString }">
					<input type="submit" value="제출">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
			</c:when>
			
			<c:when test="${sms_result eq 'fail' }">
				<script>
					alert('인증번호 전송 실패');
					window.close();				
				</script>
				
			</c:when>
		</c:choose>
		
	<c:if test="${codeCheck_result eq 'success'}">
	<a href='javascript:apply("${cp }")'>적용</a>
		<script>
			alert('문자 인증에 성공하였습니다.');
			
			function apply(cp){ 
				 //2) 중복확인 id를 부모창에 적용 //부모창 opener 
				 
				 opener.document.regForm.cp.value=cp; 
				 
				 window.close(); 
				 //창닫기 
				 
				 }//apply () end 
			
		</script>
	</c:if>
	
	<c:if test="${codeCheck_result eq 'fail' }">
		<script>
			alert('문자 인증에 실패했습니다.');
			window.close();
		</script>
	</c:if>
	
<!-- </div> --> 
	
</body>
</html>