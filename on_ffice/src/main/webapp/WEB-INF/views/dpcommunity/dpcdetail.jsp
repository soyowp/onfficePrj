
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	<style>
	body{
		margin-top:50px;
		margin-left: 100px;
		margin-right: 100px;
	}
	.cmargin{
		margin-left:20%;
		margin-right:20%;
	}
	.content{
		margin-left : auto;
		margin-right : auto;
		font-size: 30px;
		text-align: justify;
		background-color: gray;
	}
	
	.form{
		display: inline-block;
	}
	
	#modDiv {
			width: 300px;
			height: 100px;
			background-color: green;
			position: absolute;
			top: 50%;
			left: 50%;
			margin-top: -50px;
			margin-left: -150px;
			padding: 10px;
			z-index: 1000;
		}
	</style>
</head>
<body>
	<header>
		<a href="/dpcommunity/dpclist?dp_code=${login_session.dp_code}&dc_num=${param.dc_num}
			&pageNum=${param.pageNum}&searchType=${param.searchType}&keyword=${param.keyword}"><button class="btn btn-success">게시판으로</button></a>
	</header>
	<c:set var="DpCd" value="${dpcdetail}"></c:set>
	<div class="text-center">
		<div class="form-inline">
		<figure class="text-center">
  <blockquote class="blockquote">
    <h1><c:out value="${DpCd.dc_num}번 게시글"/></h1>
  </blockquote>
 
</figure>
	 
	
	부서번호 : <c:out value="${DpCd.dp_code}"/> 
	글쓴이 : <c:out value="${DpCd.dwriter}"/> 
	작성일 : ${DpCd.ddate} 
	수정일 : ${DpCd.dupdate} 
	조회수 : [${DpCd.dhits}]
	</div>
	<hr>
	</div>
	<div class = "cmargin">
	<div class="content text-center">
	<c:out value="${DpCd.dcontent}"/>
	</div>
	</div>
	<hr>
	
		<c:if test="${DpCd.dwriter eq login_session.name}">
<div class="text-end">
	<div class="form">
		<form action="/dpcommunity/dpcupdate?dc_num=${param.dc_num}&pageNum=${param.pageNum}
						&searchType=${param.searchType}&keyword=${param.keyword}" method="post">
			<input type="hidden" name="dc_num" value="${DpCd.dc_num}">
			<input type="hidden" name="pageNum" value="${param.pageNum}">
			<input type="hidden" name="searchType" value="${param.searchType}">
			<input type="hidden" name="keyword" value="${param.keyword}">
			<input type="submit" value="수정하기" class="btn btn-warning" data-bs-toggle="modal">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</form>
		</div>
		<div class="form">
		<form action="/dpcommunity/dpcdelete?dp_code=${login_session.dp_code}&dc_num=${param.dc_num}&pageNum=${param.pageNum}
						&searchType=${param.searchType}&keyword=${param.keyword}" method="post">
			<input type="hidden" name="dc_num" value="${DpCd.dc_num}">
			 <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#createTodo">삭제하기</button>
			 <div class="modal fade" id="createTodo" tabindex="-1" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">이 글을 삭제하시겠습니까?</h5>
			      </div>
			      	<div class="modal-body"> 
			      	<input type="submit" value="삭제하기">
			      	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			      	<button type="button" class="btn-primary" data-bs-toggle="modal" data-bs-target="#createTodo" aria-label="Close">취소</button> 
					</div>
			      </div>
			    </div>
			  </div>
			</form>
			</div>
			</div>
		</c:if>
		
		<div class="fs-5">댓글 등록</div>
		
			<div>
				<input type="hidden" name="replyer" value="${login_session.uid}" id="newReplyWriter">
			</div>
			<div class="form-inline">
				<div class="w-70">
				<input type="text" name="reply" placeholder="명예훼손, 개인정보 유출, 분쟁, 유발, 허위사실 유포 등의 글은 이용약관에 의해 제재는 물론 법률에 의해 처벌 받을수 있습니다. 건전한 커뮤니티를 위해 자제 부탁드립니다."
					id="newReply" class="form-control fs-6" required="required"><br/>
				</div>
			<div class="text-end">
				<button id="replyAddBtn" class="btn btn-dark">댓글 등록</button>
			</div>
			</div>
			<div id="modDiv" style="display:none;">
				<div class="modal-title"></div>			
					<div>
						<input type="text" id="replytext" required="required">
					</div>
				<div>
					<button type="button" id="replyModBtn">댓글 수정</button>
					<button type="button" id="replyDelBtn">댓글 삭제</button>
					<button type="button" id="closeBtn">창 닫기</button>
				</div>
			</div>
			
		<hr>
		
		<h2>댓글 창</h2>
		&nbsp;
		<ul id="dpcreplies">
		
		
		</ul>
	
	<script>
		var dp_community = "${DpCd.dc_num}";
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		function getAllList(){
		
		$.getJSON("/dpcommunity/dpcdetail/dpcreplies/all/" + dp_community ,function(data) {
						
			var str = "";
		
			$(data).each(function(){
				
				var replyer = this.replyer;
				var reply = this.reply;
				var dno = this.dno;
				var timestamp = this.updatedate;
				var date = new Date(timestamp);
				
				console.log(date);
				var formattedTime = "댓글 게시일 : " + date.getFullYear() 
			 						+ "/" + (date.getMonth() + 1)
				 					+ "/" + date.getDate()
				function button() {
					var l_s = "${login_session.uid}";
				
					if(l_s===replyer){
						return "<button type='button' class='btn btn-info'>수정/삭제</button>";
					} 
					return "";
				}
				
				// 댓글 작성자와 로그인한 유저와 정보가 같을 때 button부분 출력하게 
				str +="<li data-dno='" + this.dno + "' class='replyLi'>"
				+ "댓글 : " + this.reply + " / " + "작성자 : " + this.replyer + " / " + formattedTime + " " + button() + "<br><br></li>";
			});
			
			$("#dpcreplies").html(str);
			
			});
		}
		getAllList();
		
		$("#replyAddBtn").on("click", function(){
			var replyer = $("#newReplyWriter").val();
			var reply = $("#newReply").val();
			
			
			console.log(replyer + "/" + reply);
			
			$.ajax({
				beforeSend: function(xhr) {
				    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'post',
				url : '/dpcommunity/dpcdetail/dpcreplies/',
				headers: {
					"Content-Type"  :"application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					dp_community: dp_community,
					replyer : replyer,
					reply : reply
				}),
				success : function(result){
					if(result == 'SUCCESS'){
						alert("댓글 등록 완료");
						$("#newReply").val("");
						getAllList();
					}
				}
			})
		});
		
		$("#replyModBtn").on("click", function() {
			
			var dno = $(".modal-title").html();
			var reply = $("#replytext").val();
			console.log("댓글번호" + dno + "/댓글" + reply);
				$.ajax({
					beforeSend: function(xhr) {
					    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
				type : 'patch',
				url : '/dpcommunity/dpcdetail/dpcreplies/' + dno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH"
				},
				dataType : 'text',
				data : JSON.stringify({reply:reply}),
				success : function(result) {
					if(result === 'SUCCESS') {
						alert(dno + "번 댓글 수정 완료");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			})
		});
		
		$("#replyDelBtn").on("click", function() {
			
			var dno = $(".modal-title").html();
			
			$.ajax({
				beforeSend: function(xhr) {
				    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'delete',
				url : '/dpcommunity/dpcdetail/dpcreplies/' + dno,
				success : function(result) {
					if(result === 'SUCCESS') {
						alert(dno + "번 댓글 삭제 완료");
						$("#modDiv").hide("slow");
						getAllList();
					}
				} 
			})
		});
		
		$("#dpcreplies").on("click", ".replyLi button", function() {
			var replyLi = $(this).parent();
			var dno = replyLi.attr("data-dno");
			var reply = $(this).parent().siblings(".reply").text();
			
			console.log("this"  +$(this).parent().text());
					
			$(".modal-title").html(dno);
			$("#replytext").val(reply);
			$("#modDiv").show("slow");
		});
		
		$("#closeBtn").on("click", function() {
			$("#modDiv").hide("slow");
		})
		</script>
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