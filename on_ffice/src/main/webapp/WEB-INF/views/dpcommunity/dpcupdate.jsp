<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<style>
body{
	text-align : center;
	margin : 50px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<header>
		<h3>글 수정하기</h3>
	</header>
	<main>
		<div class="d-flex justify-content-center">
		
		<form action="/dpcommunity/Update/" method="post" class="w-50">

		${dpcommunity.dp_code}게시판의 ${dpcommunity.dc_num}번 글 수정하기<br/>
		<div class="d-flex justify-content-center">
		<span class="fs-4">제목 :</span>
		 <input type="text" name="dtitle" value="${dpcommunity.dtitle}" class="form-control w-50">
		</div>
		<br/>

		<div class="form-floating">
		<textarea rows="10" cols="80" style="height: 500px" name="dcontent" class="form-control" id="floatingInput">${dpcommunity.dcontent}</textarea><br/>
		 <label for="floatingInput">글 내용</label>

		<div class="d-flex justify-content-center">
		<span class="fs-4">	작성자 :</span>
			<input type="text" name="dwriter" value="${dpcommunity.dwriter}" readonly="readonly" class="form-control w-25">
		</div>
		<br/>
		<input type="hidden" name="dc_num" value="${dpcommunity.dc_num}">
		<input type="hidden" name="dp_code" value="${dpcommunity.dp_code}">
		<input type="hidden" name="pageNum" value="${param.pageNum}">
		<input type="hidden" name="searchType" value="${param.searchType}">
		<input type="hidden" name="keyword" value="${param.keyword}">
		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createTodo">수정하기</button>
		<button type="reset" class="btn btn-warning">초기화</button>
</div>
		<!-- Modal -->
   			<div class="modal fade" id="createTodo" tabindex="-1" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">이 글을 작성하시겠습니까?</h5>
			      </div>
			      	<div class="modal-body"> 
			      	<input type="submit" value="수정완료">
			      	<button type="button" class="btn-primary" data-bs-toggle="modal" data-bs-target="#createTodo" aria-label="Close">취소</button> 
					</div>
			      </div>
			    </div>
			  </div>
			  <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</form>
</div>
		<!-- Modal -->
	</main>
</body>
</html>