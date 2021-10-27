<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
    

    .header {
       
        height: 150px;
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
        grid-template-rows: 150px;
        padding: 0px;
        text-align: center;
    }
    .container {
        display: table;
        width: 100%;
        height: 50%;
        margin: -100px auto;
        padding: 100px 0;
        
        
    }
    .side {
        display: table-cell;
        width: 450px;
        height: 50%;
        
        background-color: #B0C4DE;
        border-style: solid;
        border-width: 2px 2px 0px 2px;
    }
    .content {
        display: grid;
        grid-template-columns: 1fr 1fr;
        grid-template-rows: 500px 500px;
        border-style: solid;
        border-width: 2px 0px 0px 0px;
         
    }
    .footer {
        background-color: gray;
        height: 100px;
        border-style: solid;
        border-width: 2px 0px 0px 0px;  
    }
  /*   .company {
        
        background-image: url('https://png.pngtree.com/element_our/20190601/ourmid/pngtree-blue-building-house-free-illustration-image_1373123.jpg');
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        justify-content: center;
    } */
    .introduce {
     
        text-align: center;
        background-image: url('https://www.urbanbrush.net/web/wp-content/uploads/edd/2020/04/urbanbrush-20200429142434662995.jpg');
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        justify-content: center;
    }
    .freeboard {
       
        text-align: center;
        background-image: url('https://littledeep.com/wp-content/uploads/2021/05/notice-board-illustration-main-1024x607.png');
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        justify-content: center;
    }
    .noticeboard {
      
        text-align: center;
        background-image: url('https://littledeep.com/wp-content/uploads/2021/05/notice-board-illustration-main-1024x607.png');
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        justify-content: center;
    }
    .login {
        background-image: url('https://previews.123rf.com/images/yupiramos/yupiramos1709/yupiramos170927668/86857106-%EA%B0%9C%EC%9D%B8-%EA%B8%B0%ED%98%B8-%EB%B3%B4%ED%98%B8%EC%99%80-%EA%B0%9C%EC%9D%B8-%EC%A0%95%EB%B3%B4-%EC%95%84%EC%9D%B4%EC%BD%98-%EB%B0%A9%ED%8C%A8-%EC%9D%B8%EC%A6%9D-%EB%B3%B4%EC%95%88-%EB%B2%A1%ED%84%B0-%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8-%EB%A0%88%EC%9D%B4%EC%85%98.jpg');
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        justify-content: center;
    }
    .mypage {
       
        text-align: center;
        background-image: url('https://www.urbanbrush.net/web/wp-content/uploads/edd/2019/07/urbanbrush-20190719004812478595.png');
        background-size: cover;
        background-repeat: no-repeat;
    }
    .dppage {
      
        text-align: center;
        background-image: url('https://st2.depositphotos.com/8080374/12533/v/600/depositphotos_125338664-stock-illustration-isometric-office-floor-interior-departments.jpg');
        background-size: cover;
        background-repeat: no-repeat;
    }
    .food {
        
        text-align: center;
        background-image: url('https://blog.kakaocdn.net/dn/kHnPi/btqFdm3xHXm/25bjduUOc9zVJffKZ7MsF1/img.png');
        background-size: cover;
        background-repeat: no-repeat;
    }
    .birth {
        
        text-align: center;
        background-image: url('https://us.123rf.com/450wm/fotoidee/fotoidee1803/fotoidee180300132/96855533-%EC%83%9D%EC%9D%BC-%EC%B6%95%ED%95%98-%EB%B0%B0%EB%84%88-%ED%8E%B8%EC%A7%91-%EA%B0%80%EB%8A%A5%ED%95%9C-%EB%B2%A1%ED%84%B0-%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8-%EB%A0%88%EC%9D%B4%EC%85%98.jpg?ver=6');
        background-size: contain;
        background-repeat: no-repeat;
        
    }

    ul,li { list-style: none;
            padding-left: 0px;
            color: white;
            text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;
            margin-top: 30px;}
    h2 { margin-top: 10%;}    
    .a { margin-top: 50px;
        font-weight: bold;}
    a { text-decoration:none !important }
    a:hover {color: brown;}
</style>
<script>
	var result = "${login_result}";
	var name = "${uid}";
	
	if(result==="success"){
		alert(name + "님 환영합니다.");
	}

	$(document).ready(function(){
		let letter = "Onffice";
		let length = letter.length;
		let text = "";
		let i=0;
		console.log("몇글자냐" + length);
		
	
setInterval(function(){
		if(i <= length){
			text += letter.charAt(i);
			i++;
		}
			$("#logo").html(text);
		if(i === length+1){
			$("#logo").css('color','#a4c9c5');
		}
		
		},1000);
		
	})
	
	
</script>
<title></title>
</head>
<body>

    <div class="wrap"> <!-- wrap 열기 -->

        <div class="header">
                <h1 id="logo" class="text-center" style="font-weight: bold; margin-top: 50px;"></h1> 
            <div class="introduce">
                <h2><a href="/company/intro">회사소개</a></h2></div>
            <div class="freeboard">
                <h2><a href="/community/CMList">자유게시판</a></h2></div>
            <div class="noticeboard">
                <h2><a href="/notice/noticeList">알림게시판</a></h2></div>
            <div class="login">
	<c:set var="user" value="${login_session}" />
	<c:if test="${login_session eq null}">
                <h2><a href="/user/login">로그인</a></h2>
	</c:if>
	<c:if test="${login_session ne null}">
	    <h2><a href="/user/logout">로그아웃</a></h2>
	    </c:if> 
    </div>
        </div>
        <div class="container"> 
            <div class="side">
            <div class="text-center">
            <h1>${crawl.temp} ${crawl.weather }</h1>
           <h5>${crawl.dust }</h5><br/>
            <h1>헤드라인뉴스</h1><br/>
            <c:forEach items="${crawl.headLine }" var="hL">${hL}<br/><br/></c:forEach>
            </div>
            </div>
            <div class="content"> 
                <a class="mypage" href="/mypage/main"><h2 class="a">마이페이지</h2><div class="mypage"></div></a>
                <a class="dppage" href="/company/dplobby?dp_code=${user.dp_code}"><h2 class="a">부서페이지</h2><div class="dppage"></div></a>
                <div class="birth">
                    <a href="/company/bdaylist"><br><br><br><br><br><img src="https://cdn.crowdpic.net/list-thumb/thumb_l_36E02FCA9051376724F589C917B34346.png"width="400px" height="300px"><h2 class="a">이달의 생일</h2></a></div>
                <div class="food"><h2 class="a">이번주 식단</h2>
                 
<!-- carousel를 구성할 영역 설정 -->
<div class="justify-content-center">
    <!-- carousel를 사용하기 위해서는 class에 carousel와 slide 설정한다. -->
    <!-- carousel는 특이하게 id를 설정해야 한다.-->
    <div id="carousel-example-generic" class="carousel slide" >
    <!-- carousel의 지시자 -->
    <!-- 지시자라고는 하는데 ol태그의 class에 carousel-indicators를 넣는다. -->
    
    <ol class="carousel-indicators">
    <!-- li는 이미지 개수만큼 추가하고 data-target은 carousel id를 가르킨다. -->
    <!-- data-slide-to는 순서대로 0부터 올라가고 0은 active를 설정한다. -->
    <!-- 딱히 이 부분은 옵션별로 설정하게 없다. -->
    <!--
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
    <li data-target="#carousel-example-generic" data-slide-to="4"></li>
    -->
    </ol>    

    <div class="carousel-inner" role="listbox">
    <div class="item active">
        <h1>월요일</h1>
        <ul>
    <c:forEach items="${rice}" var="rice" begin="0" end="0">    
        <li><h3>${rice.main}</h3></li>
		<li><h3>${rice.side1}</h3></li>
		<li><h3>${rice.side2}</h3></li>
		<li><h3>${rice.side3}</h3></li>
		<li><h3>${rice.side4}</h3></li>
        </c:forEach>
		
        </ul>
    </div>


<div class="item">
  
    <h1>화요일</h1>
    <ul>
    </ul>
	<c:forEach items="${rice}" var="rice" begin="1" end="1">
		<li><h3>${rice.main}</h3></li>
		<li><h3>${rice.side1}</h3></li>
		<li><h3>${rice.side2}</h3></li>
		<li><h3>${rice.side3}</h3></li>
		<li><h3>${rice.side4}</h3></li>
    </c:forEach>
</div>
<div class="item">
  	<h1>수요일</h1>
    <ul>
	<c:forEach items="${rice}" var="rice" begin="2" end="2">
        <li><h3>${rice.main}</h3></li>
		<li><h3>${rice.side1}</h3></li>
		<li><h3>${rice.side2}</h3></li>
		<li><h3>${rice.side3}</h3></li>
		<li><h3>${rice.side4}</h3></li>
    </c:forEach>
        </ul>
</div>
<div class="item">
  <h1>목요일</h1>
  <ul>
  <c:forEach items="${rice}" var="rice" begin="3" end="3">
        <li><h3>${rice.main}</h3></li>
        <li><h3>${rice.side1}</h3></li>
        <li><h3>${rice.side2}</h3></li>
        <li><h3>${rice.side3}</h3></li>
        <li><h3>${rice.side4}</h3></li>
</c:forEach>
        </ul>
</div>
<div class="item">
 <h1>금요일</h1>
  <ul>
  <c:forEach items="${rice}" var="rice" begin="4" end="4">
        <li><h3>${rice.main}</h3></li>
        <li><h3>${rice.side1}</h3></li>
        <li><h3>${rice.side2}</h3></li>
        <li><h3>${rice.side3}</h3></li>
        <li><h3>${rice.side4}</h3></li>
        
</c:forEach> 
</ul> 
</div>
</div>
</div> 
            </div>
            </div>
            </div>
            
        </div>
        </div>   

       
 <!-- wrap 닫기-->
     <script>
        $(function(){
        // 이미지 슬라이드 컨트롤를 사용하기 위해서는 carousel를 실행해야한다.
        $('#carousel-example-generic').carousel({
        // 슬리아딩 자동 순환 지연 시간
        // false면 자동 순환하지 않는다.
        interval: 3000,
        // hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
        pause: "hover",
        // 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
        wrap: true,
        // 키보드 이벤트 설정 여부(?)
        keyboard : true
        });
        });
        </script> 
</body>

<div class="footer">
    <div class="row">
        <h6 class="text-center">홈페이지 : <strong>www.onffice.com</strong></h6>
        <h6 class="text-center">주소 : <strong>서울특별시 마포구 양화로 127, 첨단빌딩</strong></h6>
        <h6 class="text-center">만든이 : <strong>배용우 신우람 고광훈 서성현 신동규</strong> </h6>
    </div>

</div>
</html>