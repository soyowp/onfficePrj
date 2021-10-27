<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	body { margin:20px;}
	
	.uploadResult {
		width: 100%;
		background-color : gray;
	}
	
	.uploadResult ul {
		display:flex;
		flex-flow: row;
		justify-content : center;
		align-items : center;
	}
	
	.uploadResult ul li {
		list-style : none;
		padding : 10px;
	}
	
	.uploadResult ul li img {
		width : 20px;
	}
</style>
</head>
<body>
	
	<header>
	<a href="/notice/noticeList" class="btn btn-dark">돌아가기</a>
	<div class="text-center">
	<h2>글작성</h2>
	</div>
	
</header>

<div class="container">
	<div class="row">
		<div class="col-xs-12 w-70 p-3">

	<form action="/notice/write" method="post">
		<select name="ncategory" id="check" required="required">
			<option value= >--선택--</option>
			<option value="공지">공지</option>
			<option value="행사">행사</option>
			<option value="자료">자료</option>
			<option value="기타">기타</option>
		</select>
		<br/><br/>
		<input type="text" name="ntitle" id="title" placeholder="제목" required="required" class="form-control"><br>

		<textarea rows="10" cols="50" name="ncontent" required="required" class="form-control"></textarea>
		<input type="hidden" name="nwriter" value="${login_session.uid}" placeholder="로그인해주세요" readonly="readonly"></br>
		<input type="text" value="${login_session.name}" placeholder="로그인해주세요" readonly="readonly" class="form-control w-25 p-3"></br>
		<div class="text-center">
		<input type="submit" value="작성완료" class="btn btn-dark" id="submitBtn">
		<input type="reset" value="다시작성" class="btn btn-warning">
	</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
</div>
</div>
</div>

<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
		<ul>
			<!-- 업로드된 파일이 들어갈 자리 -->
		</ul>
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script>
		$(document).ready(function(){
			let csrfHeaderName = "${_csrf.headerName}";
			let csrfTokenValue = "${_csrf.token}";
			
			let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			let maxSize = 5242880; //5MB
			
			function checkExtension(fileName, fileSize){
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
			
			let uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr) {
				let str = "";
				let fileCallPath="";
				
				$(uploadResultArr).each(function(i, obj) {
					
					if(!obj.image) {
						
						fileCallPath = encodeURIComponent(
								obj.uploadPath+"/"+
								obj.uuid + "_" + obj.fileName);
						
						str+= "<li "
							+ "data-path='"+ obj.uploadPath + "' data-uuid='" + obj.uuid
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image
							+ "'>"+ "<img src='/resources/attachment.png'>"
							+ obj.fileName
							+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> X </span>"
							+ "</li>";
							
					} else {
						
						fileCallPath = encodeURIComponent(obj.uploadPath + "//s_" +
															obj.uuid + "_" + obj.fileName);
						let fileCallPath2 = encodeURIComponent(obj.uploadPath +
															obj.uuid + "_" + obj.fileName);
			
						str += "<li "
							+ "data-path='"+ obj.uploadPath + "' data-uuid='" + obj.uuid
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image
							+ "'>" + "<img src='/display?fileName=" + fileCallPath+"'>"
										+ obj.fileName
										+ "<span data-file=\'" + fileCallPath2 + "\'data-type='image'> X </span>" 
										+ "</li>";
						
					}
					
				});
				
				uploadResult.append(str);
				console.log(uploadResult);
			} // showUploadedFile
			$(".uploadResult").on("click", "span", function(e){
				
				console.log($(e)); // e는 이벤트! 
				
				console.log($(this)); // this는 클릭한 x 문자! 
				let targetFile = $(this).data("file");
				let type = $(this).data("type");
				console.log(targetFile + "///" + type); // 클릭한 파일명
				
				let targetLi = $(this).closest("li");
				
				$.ajax({
					beforeSend: function(xhr) {
					    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					url : '/deleteFile',
					data : {fileName : targetFile, type:type},
					dataType : 'text',
					type : 'post',
					success : function(result){
						alert(result);
						targetLi.remove();
					}
				})
				
				
			}); // x 버튼 끝
			
			$("#submitBtn").on("click", function(e){
				// 1. 버튼 기능을 막기
				// e.preventDefault();
				
				// 2. let formObj = $("form");로 폼태그를 가져오기
				
				let check = $("#check").val();
				console.log(check);
				let title = $("#title").val();
				console.log(title);
				
				if(check===""||title===""){
					alert('카테고리, 제목을 입력해주세요.');
					
				} else{
					
					
				
				
				let formObj = $("form");
				
				// hidden 태그를 만들기
				let str ="";
				
				$(".uploadResult ul li").each(function(i, obj){
					
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
				
				// console.log($(formObj)); 
			}
				
			})
			
			
			
		});
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