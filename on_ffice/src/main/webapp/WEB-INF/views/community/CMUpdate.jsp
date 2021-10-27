<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>자유게시판 수정창</h2>
	
	<form action="/community/Update" method="post" name="updateForm">
		<input type="text" name="community_num" value="${cm.community_num}" readonly="readonly"></br>
		<input type="text" name="ctitle" value="${cm.ctitle}"></br>
		<textarea rows="10" cols="50" name="ccontent">${cm.ccontent}</textarea></br>
		<input type="hidden" name="cwriter" value="${cm.cwriter}">
		<input type="password" name="cpwck" placeholder="비밀번호 입력" required="required">
		<input type="submit" value="수정완료">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

</body>
</html>