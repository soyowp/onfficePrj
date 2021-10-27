<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- ComMunityDeleteCheckForm.jsp -->
	<h2>글 삭제를 위해 다시 한번 비밀번호를 입력해주세요.</h2>
	<form name="pwCheck" action="/community/CM_dcf" method="post">
		비밀번호<input type="password" name="cpwck" id="cpwck">
		<input type="hidden" name="community_num" value="${community.community_num}">
		<input type="submit" value="글삭제">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	
		<script>
				var result = ${result};
				console.log(result);
		
		</script>
	
	

</body>
</html>