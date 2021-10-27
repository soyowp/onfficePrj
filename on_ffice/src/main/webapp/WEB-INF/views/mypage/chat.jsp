<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<script>
window.onload = function(){
	let sock;
	let userid;
	
$("#sendBtn").click(function(){
	sendMessage();
	$('#message').val('');
});
}
function connect() {
	sock = new SockJS("http://localhost:8181/chat");
	sock.onopen = function() {
		console.log('연결 생성');
		register();
	};
	
	sock.onmessage = function(e) {
		console.log('메시지 받음');
		let data = e.data;
		addMsg(data);
	};
	
	sock.onclose = function() {
		console.log('연결 끊김');
	};
	
}
	function register(){
		let msg = {
				type : "register",
				userid : $("#userId").val()
		};
		sock.send(JSON.stringify(msg));
	}
	
	//서버로부터 메세지를 받을때
	function addMsg(msg) {
		let chat = $('#msgArea').val();
		chat = chat + "\n"+ $("#targetName").val() +" : " +  msg;
		$('#msgArea').val(chat);
	}
	//메세지 전송
	function sendMsg(){
		let msg = {
				type : "chat", 
				target : $("#targetUser").val(),
				message : $("#chatMsg").val()
		};
		sock.send(JSON.stringify(msg));
	};
	
	$(function() {
		console.log("connect 함수 실행?");
		connect();
		$('#btnSend').on("click", function() {
			let chat = $("#msgArea").val();
			chat = chat + "\n"+$("#userName").val()+" : " + $("#chatMsg").val();
			$("#msgArea").val(chat);
			sendMsg();
			$("#chatMsg").val("");
		})
	});
</script>
	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>${param.targetName}과의 대화</h2>
	<textarea rows="5" cols="30" id="msgArea" readonly>
	</textarea>
	<input type="hidden" id="userId" value="${login_session.uid}">
	<input type="hidden" id="userName" value="${login_session.name}">
	<br> 메시지 : <input type="text" id="chatMsg">
	<br> <input type="hidden" id="targetName" value="${param.targetName }" readonly>
	<br> <input type="hidden" id="targetUser" value="${param.targetUser }" readonly>
	<br>
	<input type="button" value="전송" id="btnSend">
</body>
</html>