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
		.btn1 { margin-right:5px;}
		ul{
   list-style:none;
   }
   #uploadResult {
   	width: 100%;
   	background-color : gray;
   }
   #uploadResult ul {
   	display: flex;
   	flex-flow: row;
   	justify-content : center;
   	align-items : center;
   }
   #uploadResult ul li{
   	list-style : none;
   	padding: 10px;
   	align-content : center;
   	text-align : center;
   }
   #uploadResult ul li img{
   	width: 100px;
   }
	</style>
</head>
<body>


	
	<c:set var="nd" value="${noticeDetail}"></c:set>
	<header>
	<a href="/notice/noticeList" class="btn btn-success">목록으로</a>
	<div class="text-center">
	<h1>"<c:out value="${nd.notice_num}"/>번 게시글" </h1>
	<h2>제목 :  <input type="text" disabled value="${nd.ntitle}">
		작성자 : <input type="text" disabled value="${nd.nwriter}">
	</h2>
</div>
</header>
<hr/>

<div class="text-center">
	<h2 class="mx-auto w-75" style="background-color: gray"><c:out value="${nd.ncontent}" /></h2>
</div>

<hr/>

<div class="text-end">
	<div class="btn-group">
	
	<c:if test="${nd.nwriter eq login_session.uid}">
	
		<form action="/notice/noticeUpdate" method="post">
			<input type="hidden" name="notice_num" value="${nd.notice_num}">
			<input type="submit" value="수정하기" class="btn1 btn btn-warning">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>

		<form action="/notice/noticeDelete" method="post">
			<input type="hidden" name="notice_num" value="${nd.notice_num}">
			<input type="submit" value="삭제하기" class="btn2 btn btn-danger">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
		</c:if>
	</div>
</div>

<div class="row">
	<h2 class="text-primary">첨부파일</h2>
	<div id="uploadResult">
		<ul>
			<!-- 첨부파일 들어갈 위치 -->
		</ul>
	</div>
</div>

<script>
	(function() {
		
		$.getJSON("/notice/getAttachList", {notice_num: ${nd.notice_num}}, function(arr){
			
			console.log(arr);
			
			let str = "";
			
			$(arr).each(function(i, attach){
				let fileCallPath = "";
				// 그림파일일 경우!
				if(attach.image){
					fileCallPath = encodeURIComponent(attach.uploadPath + "//s_" + 
							attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='" + attach.uploadPath + "' data-uuid='"
						+ attach.uuid + "' data-filename='" + attach.fileName
						+ "' data-type='" + attach.image + "' ><div>"
						+ "<span> "+ attach.fileName + "</span><br>"
						+ "<img src='/display?fileName="+ fileCallPath + "'>"
						+ "</div>"
						+ "</li>";
				} else {
					// 그림파일 아닐 경우! 
					fileCallPath = encodeURIComponent(attach.uploadPath + "/" +
							attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='" + attach.uploadPath + "' data-uuid='"
					+ attach.uuid + "' data-filename='" + attach.fileName
					+ "' data-type='" + attach.image + "' ><div>"
					+ "<span> "+ attach.fileName + "</span><br>"
					+ "<img src='/resources/attachment.png'" + " width='100px' height='100px'>"
					+ "</div>"
					+ "</li>";
				}
			});
			$("#uploadResult ul").html(str);
		});// getJSON 끝
		
		
		$("#uploadResult").on("click", "li", function(e){
			
			let liObj = $(this);
			
			let path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_"
											+ liObj.data("filename"));
				//download
				self.location = "/download?fileName=" + path;
				
		});
		
	})(); // 익명함수 끝 
	
</script>

		<hr>
		<div class="fs-5">댓글 등록</div>
				<c:if test="${login_session eq null}">
					<script type="text/javascript">
						alert("로그인을 해야 댓글을 달수 있습니다.");
					</script>
				</c:if>
				<c:if test="${login_session ne null}">
			<div>
				<input type="hidden" name="replyer" value="${login_session.uid}" id="newReplyWriter">
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
		</c:if>
	
		<hr>
			<h2>댓글 창</h2>
			&nbsp;

		<ul id="replies">
		
		</ul>
	
	<script>
		var notice = "${nd.notice_num}";
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		function getAllList(){
		
		$.getJSON("/notice/noticeDetail/replies/all/" + notice ,function(data) {
			console.log(data);
			console.log("------");
			console.log(data.length);
			
			var str = "";
			

			
			$(data).each(function(){
				
				
				var replyer = this.replyer;
				var reply = this.reply;
				var rno = this.rno;
				var timestamp = this.updatedate;
				var date = new Date(timestamp);
				var formattedTime = "댓글 게시일 : " + date.getFullYear() 
											+ "/" + (date.getMonth() + 1)
											+ "/" + date.getDate()

				function button() {
					var l_s = "${login_session.uid}";
					console.log(rno + "번째 " + replyer + "가 가진 답변" + reply);
					if(l_s===replyer){
						return "<button type='button' class='btn btn-info'>수정/삭제</button>";
					} 
					return "";
				}
				
				// 댓글 작성자와 로그인한 유저와 정보가 같을 때 button부분 출력하게 
				str +="<li data-rno='" + this.rno + "' class='replyLi'>"
				+ "댓글 : " + this.reply + " / " + "작성자 : " + this.replyer + " / "  + formattedTime + " "
				+ button() + "<br/><br/></li>";
			});
			
			$("#replies").html(str);
				
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
				url : '/notice/noticeDetail/replies/',
				headers: {
					"Content-Type"  :"application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					notice : notice,
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
			
			var rno = $(".modal-title").html();
			var reply = $("#replytext").val();
			console.log("댓글번호" + rno + "/댓글" + reply);
				$.ajax({
					beforeSend: function(xhr) {
					    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
				type : 'patch',
				url : '/notice/noticeDetail/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH"
				},
				dataType : 'text',
				data : JSON.stringify({reply:reply}),
				success : function(result) {
					if(result === 'SUCCESS') {
						alert(rno + "번 댓글 수정 완료");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			})
		});
		
		$("#replyDelBtn").on("click", function() {
			
			var rno = $(".modal-title").html();
			
			$.ajax({
				beforeSend: function(xhr) {
				    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'delete',
				url : '/notice/noticeDetail/replies/' + rno,
				success : function(result) {
					if(result === 'SUCCESS') {
						alert(rno + "번 댓글 삭제 완료");
						$("#modDiv").hide("slow");
						getAllList();
					}
				} 
			})
		});
		
		$("#replies").on("click", ".replyLi button", function() {
			var replyLi = $(this).parent();
			var rno = replyLi.attr("data-rno");
			var reply = $(this).parent().siblings(".reply").text();
			
			console.log("this"  +$(this).parent().text());
			console.log("button부모 : " + replyLi);
			console.log("글번호" + rno + "/ 글" + reply);
			
			$(".modal-title").html(rno);
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