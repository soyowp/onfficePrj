<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
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
		.a { background-color: gray;
		text-overflow: ellipsis;
		overflow: hidden;
		width: 800px;
	 	margin-left: 30%;
		}
		.btn2 { margin-right:5px;}
		
		ul{
   list-style:none;
   }
   .form{
		display: inline-block;
	}
	</style>
</head>
<body>

	
	<c:set var="cd" value="${csDetail}"></c:set>
	<header>
	<a href="/community/CMList" class="btn btn btn-success">목록으로</a>
	<div class="text-center">
	<h1>"<c:out value="${cd.community_num}"/>번 게시글"</h1>
	&nbsp;	
	<h2>제목 : <input type="text" disabled value="${cd.ctitle}">
	작성자 : <input type="text" disabled value="${cd.cwriter}"></h2>
	<hr/>
	</div>
</header>
<div class="text-center">
	<h2 class="mx-auto w-75" style="background-color: gray"><c:out value="${cd.ccontent}"/></h2>
</div>

	<hr>
	<div class="text-end">
	<div class="btn-group">
	<form action="/community/CMUpdate" method="post">
			<input type="hidden" name="community_num" value="${cd.community_num}">
			<input type="submit" value="수정하기" class="btn2 btn btn-warning">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
	</form>

	<form action="/community/deleteCheck" method="post">
		<input type="hidden" name="community_num" value="${cd.community_num}">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="submit" value="삭제하기" class="btn3 btn btn-danger">

</form>
</div>
</div>
	
		<div class="fs-5">댓글 등록</div>

			<div>
				<c:if test="${login_session ne null}">
					<input type="hidden" name="replyer" value="${login_session.name}" id="newReplyWriter">
				</c:if>
				<c:if test="${login_session eq null}">
					<input type="hidden" name="replyer" value="${ip}" id="newReplyWriter">
				</c:if>
				</div>
				<div class="form-inline">
					<div class="w-70">
					<input type="text" class="form-control fs-6" name="reply" placeholder="명예훼손, 개인정보 유출, 분쟁, 유발, 허위사실 유포 등의 글은 이용약관에 의해 제재는 물론 법률에 의해 처벌 받을수 있습니다. 건전한 커뮤니티를 위해 자제 부탁드립니다." 
					id="newReply">
				</div>
				&nbsp;
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
			
			<script>
			var result = "${update}";
			console.log(result);
			
			if(result==="success"){
				alert("수정완료했습니다.")
			}else if(result==="fail")(
				alert("비밀번호가 달라 수정 실패했습니다.")
			)
			</script>
			
			<hr>
			<h2>댓글 창</h2>
			&nbsp;
		<ul id="cmreplies">
		
		</ul>
		
	<script>
	
		var community = "${cd.community_num}";
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		function getAllList(){
		
		$.getJSON("/community/CMDetail/cmreplies/all/" + community ,function(data) {
			console.log(data);
			console.log("------");
			console.log(data.length);
			
			var str = "";
			
			$(data).each(function(){
				
				var replyer = this.replyer;
				var reply = this.reply;
				var cno = this.cno
				var timestamp = this.updatedate;
				var date = new Date(timestamp);
				var formattedTime = "댓글 게시일 : " + date.getFullYear() 
											+ "/" + (date.getMonth() + 1)
											+ "/" + date.getDate()
				
				function button() {
					var l_s = "${login_session.name}";
					var l_ip = "${ip}";
					// 로그인 세션의 이름이 같을 댓글 작성자와 같을 경우 또는 ip값이 작성자와 같을 경우 수정/삭제 버튼이 보이되
					// 로그인한 작성자와 guest로 입장한 ip가 동일한 경우 guest에서 댓글을 작성하고 다시 로그인해서 댓글로 가면
					// 수정 및 삭제 버튼이 보인다.
					if(l_s===replyer || l_ip===replyer) {
						return "<button type='button' class='btn btn-info'>수정/삭제</button>";
					}
					return "";
				}
		
				str +="<li data-cno='" + this.cno + "' class='replyLi'>"
				+  "댓글 : " + this.reply + " / " + "작성자 : " + this.replyer + " / " + formattedTime + " "
				+ button() + "<br/><br/></div></li>";
			});
			
			$("#cmreplies").html(str);
				
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
				url : '/community/CMDetail/cmreplies',
				headers: {
					"Content-Type"  :"application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					community : community ,
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
			
			var cno = $(".modal-title").html();
			var reply = $("#replytext").val();
			console.log(cno);
			$.ajax({
				beforeSend: function(xhr) {
				    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'patch',
				url : '/community/CMDetail/cmreplies/' + cno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH"
				},
				dataType : 'text',
				data : JSON.stringify({reply:reply}),
				success : function(result) {
					if(result === 'SUCCESS') {
						alert(cno + "번 댓글 수정 완료");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			})
		});
		
		$("#replyDelBtn").on("click", function() {
			
			var cno = $(".modal-title").html();
			
			$.ajax({
				beforeSend: function(xhr) {
				    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'delete',
				url : '/community/CMDetail/cmreplies/' + cno,
				success : function(result) {
					if(result === 'SUCCESS') {
						alert(cno + "번 댓글 삭제 완료");
						$("#modDiv").hide("slow");
						getAllList();
					}
				} 
			})
		});
		
		$("#cmreplies").on("click", ".replyLi button", function() {
			var replyLi = $(this).parent();
			var cno = replyLi.attr("data-cno");
			var reply = $(this).parent().siblings(".reply").text();
		
			console.log("this"  +$(this).parent().text());
			console.log("button부모 : " + replyLi);
			console.log("글번호" + cno + "/ 글" + reply);
			$(".modal-title").html(cno);
			$("#replytext").val(reply);
			$("#modDiv").show("slow");
		});
		
		$("#closeBtn").on("click", function() {
			$("#modDiv").hide("slow");
		})
			
</script>

</div>
	
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