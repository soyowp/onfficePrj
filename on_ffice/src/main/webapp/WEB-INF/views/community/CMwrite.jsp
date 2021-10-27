<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
<style>
body{
margin:20px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<a href="/community/CMList" class="btn btn-dark">돌아가기</a>
	<div class="text-center">
	<h2>글 작성</h2>
	</div>
	</header>
	<main>
	
	
	<div class="container">
    
    <div class="row">
        <div class="col-xs-12 w-70 p-3">
		<form action="/community/write" name="guest" method="post">
		<input type="text" name="ctitle" placeholder="제목" required="required" class="form-control"><br>
		<textarea rows="10" cols="50" name="ccontent" required="required" class="form-control"></textarea><br>
		<input type="hidden" name="cwriter" value="${login_session.name}" placeholder="작성자입력" readonly class="form-control w-25 p-3">
		<div class="text-center">
		<input type="password" name="cpw" placeholder="PW입력(수정, 삭제할때 사용합니다.)" required="required" class="form-control w-25 p-3 "/> <br>
		<input type="submit" value="작성완료" class ="btn btn-dark">
		<input type="reset" value="다시작성" class ="btn btn-warning">
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
        </div>
    </div>
</div>
	
	
	
	<script type="application/javascript">
	
  function getIP(json) {
	  
    var ip = json.ip
    
    console.log(ip);
	if(document.guest.cwriter.value == "") {
		document.guest.cwriter.value=ip;
	}
    
  }
</script>

<script type="application/javascript" src="https://api.ipify.org?format=jsonp&callback=getIP"></script>
</main>

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