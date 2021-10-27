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
	<script>
		window.onload=function(){
			var fail = ${l_s}
			console.log(fail);
		
			if(fail==="fail"){
			alert("로그인을 해주세요!!!");
				}
			}
		
	</script>

	
	<h2>ict03회사직원들</h2><a href="/company/lobby"><button>로비로가기</button></a><br>
	직위/부서/이름/성별/이메일/휴대전화/상태 <hr>
	<c:forEach items="${usersInfo}" var="ui">
		${ui.job}
		${ui.depart_name}
		${ui.name}
		${ui.gender}
		${ui.email}
		${ui.cp}
		${ui.stat}
		<br>
	</c:forEach>	
</body>
</html>