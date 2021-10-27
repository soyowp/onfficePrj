<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#uploadResult {
		width: 100%;
		background-color : gray;
	}
	
	#uploadResult ul {
		display:flex;
		flex-flow: row;
		justify-content : center;
		align-items : center;
	}
	
	#uploadResult ul li {
		list-style : none;
		padding : 10px;
	}
	
	#uploadResult ul li img {
		width : 20px;
		height : 20px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>notice수정창</h2>
	
	<form action="/notice/Update" method="post">
		<input type="text" name="notice_num" value="${notice.notice_num}" readonly="readonly"></br>
		<input type="text" name="ntitle" id = "title" required value="${notice.ntitle}"><br>
		<textarea rows="10" cols="50" name="ncontent">${notice.ncontent}</textarea><br>
		<input type="text"  value="${login_session.name}" readonly="readonly">
		<input type="hidden" name="nwriter" value="${notice.nwriter}" readonly="readonly"></br>
		<input type="submit" value="수정완료" id="submitBtn">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	
	<div class="row">
		<h3 class="text-primary">첨부 파일</h3>
		
		<div class="form-group uploadDiv">
			<input type="file" name="uploadFile" multiple>
			<button id="uploadBtn">등록</button>
		</div>
	
		<div id="uploadResult">
			<ul>
				<!-- 첨부파일 들어갈 자리 -->
			</ul>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	(function(){
		
	
	$.getJSON("/notice/getAttachList", {notice_num: ${notice.notice_num}}, function(arr){
		
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
					+ "<span> "+ attach.fileName + "</span>"
					+ "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' "
					+ "class='btn btn-warning btn-circle'><i class='fa fa-times'>X</i></button><br>"
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
				+ "<span> "+ attach.fileName + "</span>"
				+ "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' "
				+ "class='btn btn-warning btn-circle'><i class='fa fa-times'>X</i></button><br>"
				+ "<img src='/resources/attachment.png'>"
				+ "</div>"
				+ "</li>";
			}
		}); // 포문 끝
		$("#uploadResult ul").html(str);
	});// getJSON 끝
	})();
	
$("#uploadResult").on("click", "button", function(e){
	if(confirm("선택한 파일을 삭제하시겠습니까?")){
		let targetLi = $(this).closest("li");
		targetLi.remove();
	}
	
}); // 삭제버튼


let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
let maxSize = 5242880; // 5MB

function checkExtension(fileName, fileSize) {
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
	
	if(regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}

let cloneObj = $(".uploadDiv").clone();

$('#uploadBtn').on("click", function(e) {
	
	let formData = new FormData();
	 
	let inputFile = $("input[name='uploadFile']");
	
	let files = inputFile[0].files;
	
	console.log(files);
	
	// 파일 데이터를 폼에 집어넣기
	for(let i =0; i<files.length; i++) {
		
		if(!checkExtension(files[i].name, files[i].size)){
			return false;
		}
		
		formData.append("uploadFile", files[i]);
	}
	
	$.ajax({
		
		beforeSend: function(xhr) {
		    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		
		url : '/uploadAjaxAction',
		processData: false,
		contentType: false,
		data: formData,
		type: 'POST',
		dataType:'json',
		success: function(result) {
			console.log(result);
			
			showUploadedFile(result);
			
			$(".uploadDiv").html(cloneObj.html());
			
			alert("Uploaded");
		}
	}); // ajax
}); // onclick uploadBtn
	
let uploadResult = $("#uploadResult ul");

function showUploadedFile(uploadResultArr) {
	let str = "";
	let fileCallPath="";
	
	$(uploadResultArr).each(function(i, obj) {
		
		if(!obj.image) {
			
			fileCallPath = encodeURIComponent(
					obj.uploadPath+"/"+
					obj.uuid + "_" + obj.fileName);
			
			str+= "<li "
				+ "data-path='"+ obj.uploadPath + "' data-uuid='" 
				+ obj.uuid + "' data-filename='" + obj.fileName 
				+ "' data-type='" + obj.image + "'><div>"
				+ "<span>"+ obj.fileName+"</span>"
				+ "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' "
				+ "class='btn btn-warning btn-circle'><i class='fa fa-times'>X</i></button><br/>"
				+ "<img src='/resources/attachment.png' width='100px' height='100px'>"
				+ "</div>"
				+ "</li>";
				
		} else {
			
			fileCallPath = encodeURIComponent(obj.uploadPath + "//s_" +
												obj.uuid + "_" + obj.fileName);

			str += "<li data-path='"+ obj.uploadPath + "' data-uuid='" 
				+ obj.uuid + "' data-filename='" + obj.fileName 
				+ "' data-type='" + obj.image + "' ><div>"
				+ "<span>" + obj.fileName + "</span>"
				+ "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' "
				+ "class='btn btn-warning btn-circle'><i class='fa fa-times'>X</i></button><br/>"
			    +"<img src='/display?fileName=" + fileCallPath+"'>"
				+ "</div>"
				+ "</li>"
		
		
		}
	
	}); // for문 끝
	uploadResult.append(str);
	console.log(uploadResult);
	
	}// showUploadedFile
	
	
$("#submitBtn").on("click", function(e){
	// 1. 버튼 기능을 막기
	// e.preventDefault();
	
	// 2. let formObj = $("form");로 폼태그를 가져오기
	let formObj = $("form");
	
	// hidden 태그를 만들기
	let str ="";
	
	let title = $("#title").val();
	console.log(title);
	
	if(title===""){
		
		alert('제목을 입력해주세요.');
		
	} else{
		
		
	
	$("#uploadResult ul li").each(function(i, obj){
		
		let data_input = $(obj);
		
		console.info($(obj));
		
		str += 
			"<input type='hidden' name='attachList["+i+"].fileName'"
			+ "value='" + data_input.data("filename") + "'>"
			
			+ "<input type='hidden' name='attachList["+i+"].uuid'"
			+ "value='" + data_input.data("uuid") + "'>"
			
			+ "<input type='hidden' name='attachList["+i+"].uploadPath'"
			+ "value='" + data_input.data("path") + "'>"
			
			+ "<input type='hidden' name='attachList["+i+"].image'"
			+ "value='" + data_input.data("type") + "'>";
			
			console.log(data_input.data("path"));
	});// 반복문 끝
	
	
	formObj.append(str).submit();
	}
	// console.log($(formObj)); 
}); // submit 버튼


});

</script>
	
</body>
</html>