<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
				
				$(uploadResultArr).each(function(i, obj) {
					
					if(!obj.image) {
						
						let fileCallPath = encodeURIComponent(
								obj.uploadPath+"/"+
								obj.uuid + "_" + obj.fileName);
						
						str+= "<li><img src='/resources/attachment.png'>"
							+ obj.fileName
							+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> X </span>"
							+ "</li>";
							
					} else {
						
						let fileCallPath = encodeURIComponent(obj.uploadPath + "//s_" +
															obj.uuid + "_" + obj.fileName);
			
						str += "<li><img src='/display?fileName=" + fileCallPath+"'>"
										+ obj.fileName
										+ "<span data-file=\'" + fileCallPath + "\'data-type='image'> X </span>" 
										+ "</li>";
					}
					
				});
				
				uploadResult.append(str);
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
				
				
			});
			
			
			
			
		});
	</script>
</body>
</html>