<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
	crossorigin="anonymous"></script>

<style>
body {
	margin: 20px;
}

#todoList {
	display: block;
}

.userListDiv{
	height : 150px;
	overflow-x:hidden; 
	overflow-y:scroll; 
}

</style>


<script>
	window.onload = function() {

		let csrfHeaderName = "${_csrf.headerName}";
		let csrfTokenValue = "${_csrf.token}";
		let result = "${result}"

		
		
		$.ajax({
			beforeSend: function(xhr) {
			    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			url : "/mypage/awayFromKeyboard",
			type : "POST",
			data : {
				uid : "${info.uid}",
				stat : "온라인"
			},
			success : function(data) {
				$('.stat').html('접속상태 : 온라인');
			},
			error : function() {
				alert("에러");
			}
		})
		
				

		if (result === "insert") {
			alert("TODO를 생성했습니다.")
		}
		;
		if (result === "pass") {
			alert("TODO를 전달했습니다.")
		}
		;
		if (result === "complete") {
			alert("TODO를 완료했습니다.")
		}
		;

		let active = false;
		let afk = 0;

		function userStat() {
			let result = document.getElementById("result");

			$('*').on("keydown mousemove", _.throttle(function() {
				active = true;
			}, 1000));
			
			
		}

		setTimeout(userStat, 0);

		setInterval(function() {
			let result = document.getElementById("result");
			if (active != false) {
				active = false;
			}
		}, 5000);

		setInterval(function() {
			if (active === false) {
				if (afk < 10) {
					afk++;

				} else if (afk === 10) {
					$('#AFKModal').modal('show');
					$('.stat').html('접속상태 : 부재중');
							
					$.ajax({
						beforeSend: function(xhr) {
						    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
						},
						url : "/mypage/awayFromKeyboard",
						type : "POST",
						data : {
							uid : "${info.uid}",
							stat : "부재중"
						},
						success : function(data) {

						},
						error : function() {
							alert("에러");
						}
					})
					console.log("부재중입니다");

					afk += 1;
				}

			} else if (active === true) {
				afk = 0;
			}
		}, 1000);

		function currentTime() {
			let now = new Date();
			let hours = now.getHours();
			let minutes = now.getMinutes();
			let seconds = now.getSeconds();
			let clock = document.getElementById("clock");

			if (hours > 12) {
				hours -= 12;
				apm = "오후"
			} else {
				apm = "오전"
			}

			if (hours < 10) {
				hours = "0" + hours;
			}

			if (minutes < 10) {
				minutes = "0" + minutes;
			}

			if (seconds < 10) {
				seconds = "0" + seconds;
			}

			clock.innerHTML = "현재 시간 : " + apm + hours + ":" + minutes + ":"
					+ seconds;
		}
		setInterval(currentTime, 1000)

		let toggle = document.getElementById("todoToggle");
		toggle.onclick = function() {
			let todoList = document.getElementById("todoList");
			todoList.style.display = ((todoList.style.display != 'none') ? 'none'
					: 'block');
			
			
		}
	}
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div class="container">
		<header> </header>
		<main>
			<div class="row">

				<div class="col-md-3">
					<a href="/company/lobby"><button class="btn btn-primary">Lobby</button></a><br/>
					&nbsp;
					<div>접속자 : <c:out value="${info.name }"/></div>
					<div>직원번호 : ${info.empno}</div>
					<div>부서 : ${info.depart_name }</div>
					<div>직급 : ${info.p_name }</div>
					<div class=stat>접속상태 : ${info.stat }</div>

					<br /> 접속한 시간<br /> ${login_time }<br />
					<div id="clock"></div>
					&nbsp;
					<div>
					<a href="/user/userInfo" class="btn btn-dark">내 정보보기</a>
					<!-- <form action="/user/userInfo" method="post">
						<input type="hidden" name="uid" value="${login_session}">
						<input class="btn btn-primary" type="submit" value="회원정보">
					</form>
					 -->
					</div>
					<br/><br/><br/>
					
					
					<!-- 회원 리스트 들어올 곳! -->
					<h3>유저리스트</h3>
					<div class="userListDiv">
						<ol class="list-group">
						<c:forEach items="${users }" var="users">
						  <li class="list-group-item d-flex justify-content-between align-items-start">
						    <div class="ms-2 me-auto">
						      <div class="fw-bold"><c:out value="${users.name }"/>(<c:out value="${users.uid}"/>)</div>
						      ${users.depart_name }
						    </div>
						    	<c:if test = "${users.stat eq '온라인' }">
							    	<button onclick ="window.open('/mypage/chat?targetUser=${users.uid}&targetName=${users.name }', 'Chat', 'width=300, height=250')"
							    	class="badge rounded-pill bg-primary" id ="submit">Go Chat</button>
						    	</c:if>
						  </li>
						</c:forEach>
						 </ol>
					</div>

					<!-- 회원 리스트 끝 -->
					
				</div>

				<div class="col-md-9">

					<h2 id="todoToggle">TODO</h2>
					<button type="button" class="btn btn-warning"
						data-bs-toggle="modal" data-bs-target="#createTodo">
						TODO생성</button>
					<button type="button" class="btn btn-primary"
						data-bs-toggle="modal" data-bs-target="#passTodo">작업자전환</button>
					<button type="button" class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#completeTodo">작업완료</button>
					<hr>
					<div id="todoList">
					나의 업무
					<table class="text-center table table-hover">
						<thead>
							<tr>
								<th>업무번호</th>
								<th>담당자</th>
								<th>업무제목</th>
								<th>생성시간</th>
								<th>완료여부</th>
							</tr>
						</thead>
						<c:forEach items="${todoList}" var="todo">
							<tr>
								<td>${todo.todo_num }</td>
								<td><c:out value="${todo.checker }"/></td>
								<td><a href="/mypage/detailTodo?todo_num=${todo.todo_num }">
										<c:out value="${todo.todo_title}"/> </a></td>
								<td>${todo.recive_time }</td>
								<td>${todo.complete }</td>
							</tr>
						</c:forEach>
					</table>
					<nav aria-label="Page navigation">
						<ul class="pagination">

							<c:if test="${btnMaker.prev }">
								<li class="page-item"><a class="page-link"
									href="/mypage/main?pageNum=${btnMaker.startPage - 1 }"
									aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
								</li>
							</c:if>

							<c:forEach begin="${btnMaker.startPage }"
								end="${btnMaker.endPage }" var="pageNum">
								<li
									class="page-item ${btnMaker.cri.pageNum == pageNum ? 'active' : '' }">
									<a class="page-link" href="/mypage/main?pageNum=${pageNum }">${pageNum }</a>
								</li>
							</c:forEach>

							<c:if test="${btnMaker.next }">
								<li class="page-item"><a class="page-link"
										href="/mypage/main?pageNum=${btnMaker.endPage + 1 }"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:if>

						</ul>
					</nav>
					</div>
					
					<div class="row">
					<div class="completeList">
					
					내가 생성한 업무(최근5개)
					<table id=completeList class="text-center table table-hover">
						<thead>
							<tr>
								<th>업무번호</th>
								<th>작업자</th>
								<th>업무제목</th>
								<th>생성시간</th>
							</tr>
						</thead>
						<c:forEach items="${createdList}" var="created">
							<tr>
								<td>${created.todo_num }</td>
								<td>${created.worker }</td>
								<td><a href="/mypage/detailTodo?todo_num=${created.todo_num }">
										<c:out value="${created.todo_title}"/> </a></td>
								<td>${created.recive_time }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				</div>
					
					
					
					
					<div class="row">
					<div class="completeList">
					
					완료받은 업무(완료목록 최근5개)
					<table id=completeList class="text-center table table-hover">
						<thead>
							<tr>
								<th>업무번호</th>
								<th>마지막 작업자</th>
								<th>업무제목</th>
								<th>완료시간</th>
								<th>완료여부</th>
							</tr>
						</thead>
						<c:forEach items="${completeList}" var="comp">
							<tr>
								<td>${comp.todo_num }</td>
								<td>${comp.worker }</td>
								<td><a href="/mypage/detailTodo?todo_num=${comp.todo_num }">
										<c:out value="${comp.todo_title}"/> </a></td>
								<td>${comp.complete_time }</td>
								<td>${comp.complete }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				</div>
				
									

					
				</div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4"></div>
				<div class="col-md-4"></div>
			</div>

		</main>
		<!-- Button trigger modal -->
		<!-- Modal todoInsert -->
		<form action="/mypage/insertTodo" method="post">
			<div class="modal fade" id="createTodo" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">TODO를 생성합니다</h5>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="hidden" name="checker" value="${info.empno }">
							<select class="form-select btn btn-secondar" name="worker" required>
								<option selected disabled="disabled" value=>작업자를 선택해주세요</option>
								<c:forEach items="${users}" var="users">
									<option value="${users.empno}">직원번호[${users.empno}]
										${users.dp_code}부서 ${users.name }</option>
								</c:forEach>
							</select> <span class="input-group-text">작업 제목</span> <input type="text"
								class="form-control" placeholder="작업명 입력" name="todo_title" required>
							<br> <span class="input-group-text">작업내용</span>
							<textarea class="form-control" placeholder="작업내용 입력"
								name="todo_content" required></textarea>
							<br /> <input type="submit" class="btn btn-primary"
								value="TODO생성" />
						</div>
					</div>
				</div>
			</div>
		</form>


		<!-- Modal todoPass -->
		<form action="/mypage/passTodo" method="post">
			<div class="modal fade" id="passTodo" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">작업을 넘겨줍니다</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<select class="form-select btn btn-secondar" name="worker" required>
								<option selected disabled="disabled" value=>넘겨줄 작업자를 선택해주세요</option>
								<c:forEach items="${users}" var="users">
									<option value="${users.empno}">직원번호[${users.empno}]
										${users.dp_code}부서 ${users.name }</option>
								</c:forEach>
							</select>
							<select	class="form-select btn btn-secondar" name="todo_num" id="todoSelect" required>
								<option selected disabled="disabled" value=>넘겨줄 작업을 선택해주세요</option>
								<c:forEach items="${todoList}" var="todo">
									<option value="${todo.todo_num}">작업번호[${todo.todo_num}]
										작업제목 : ${todo.todo_title} 담당자 : ${todo.checker }</option>
								</c:forEach>
								</select>
								
								<script>
					$("#todoSelect").change(function(){
						
						let csrfHeaderName = "${_csrf.headerName}";
						let csrfTokenValue = "${_csrf.token}";
						let todo_num = $("#todoSelect option:selected").val();
						
						$.ajax({
							beforeSend: function(xhr) {
							    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
						url : "/mypage/detailTodo",
						type : "GET",
						data : {
							todo_num : todo_num
						},
						success : function(data) {
						$("#todo_con").html(data.substring(data.indexOf("인덱스")+5, data.lastIndexOf("/span>")-1));
						console.log(data);
						},
						error : function() {
							
						}
								})
					
					});
								</script>

								<br /> <span class="input-group-text">↓기존작업내용</span>
							<textarea class="form-control" name="already_todo_content"
							id="todo_con" rows="5" readonly="readonly" style="overflow-y:scroll"></textarea>
								<br /> <span class="input-group-text">↓추가/변경된내용</span>
								<textarea class="form-control" name="todo_content"
							rows="10" style="overflow-y:scroll" required></textarea>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="submit" class="btn btn-primary" value="작업넘기기" />
						</div>
					</div>
				</div>
			</div>
		</form>


		<!-- Modal todoComplete -->
		<form action="/mypage/completeTodo" method="post">
			<div class="modal fade" id="completeTodo" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">작업의 상태를
								변경합니다.</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<select class="form-select btn btn-secondar" name="todo_num" required>
								<option selected disabled="disabled" value=>완료할 작업을 선택해주세요</option>
								<c:forEach items="${todoList}" var="todo">
									<option value="${todo.todo_num}">작업번호[${todo.todo_num}]
										작업제목 : ${todo.todo_title} 담당자 : ${todo.checker }</option>
								</c:forEach>
							</select>
							<input type="hidden" name="complete" value="complete">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="submit" class="btn btn-primary" value="완료하기!"/>
						</div>
					</div>
				</div>
			</div>
		</form>

		<!-- Modal AFK -->
		<div class="modal fade" id="AFKModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h3 class="modal-title" id="staticBackdropLabel">부재중입니다.</h3>
					</div>
					<div class="modal-body">
						<h5>부재중 상태를 해제하려면 아래 버튼을 클릭하거나 새로고침하세요</h5>
						<form action="/mypage/awayFromKeyboard" method="post">
							<input type="hidden" name="stat" value="온라인">
							<input type="hidden" name="uid" value="${info.uid}">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="submit" value="부재중 해제" class="btn btn-success">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="mx-auto w-75 text-center">
	
	<!-- 가입 요청 받는 곳 -->
	<c:if test="${info.dp_code eq '1'}">
		<h3>가입 요청유저리스트</h3>
					<div class="userListDiv w-75 mx-auto">
						<ol class="list-group list-inline">
						<c:forEach items="${StatNull }" var="users">
						  <li class="mx-auto border border-primary rounded">
						    <div class="ms-2 me-auto">
						    
						      <div class="fw-bold">${users.name }(${users.uid})</div>
						      ${users.depart_name }
						    	<form action="/user/permit" method="post">
						    		<input type="hidden" name="uid" value="${users.uid }">
						    		<select name="permit" class="form-control">
						    			<option value="ok">승인</option>
						    			<option value="no">거절</option>
						    		</select>
						    		<input type="submit" value="처리" class="btn btn-dark">
						    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						    	</form>
						   </div>
						  </li>
						  <br/>
						</c:forEach>
						 </ol>
					</div>
			</c:if>
			
		<script type="text/javascript">
				var permit = "${permit}";
				if(permit==="ok"){
					alert("가입승인 완료되었습니다.");
				}
			</script>
			</div>
	<footer>
	</footer>
</body>

</html>