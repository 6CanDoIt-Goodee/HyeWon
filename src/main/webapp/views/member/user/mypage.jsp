<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
	<script src="../../../resources/javascript/mypageSidebar.js"></script>   
<style>
	@font-face {
	    font-family: 'GangwonEduPowerExtraBoldA';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEduPowerExtraBoldA.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	/* 프리젠테이션 */
	@font-face {
	    font-family: 'Freesentation-9Black';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404@1.0/Freesentation-9Black.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	
	/* LINE Seed */
	@font-face {
	    font-family: 'LINESeedKR-Bd';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	
	/* 한나체Pro */
	@font-face {
	    font-family: 'BMHANNAPro';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_seven@1.0/BMHANNAPro.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	} 
	
	/* 여기어때 잘난체 고딕 */
	@font-face {
	    font-family: 'JalnanGothic';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	/* 세방고딕 */
	@font-face {
	    font-family: 'SEBANG_Gothic_Bold';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2104@1.0/SEBANG_Gothic_Bold.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	/* 오아고딕 */
	@font-face {
	    font-family: 'OAGothic-ExtraBold';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/OAGothic-ExtraBold.woff2') format('woff2');
	    font-weight: 800;
	    font-style: normal;
	}
	
	/* 레페리포인트 */
	@font-face {
	    font-family: 'LeferiPoint-BlackA';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/LeferiPoint-BlackA.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
.main_content {
    max-width: 1300px; 
    height: 740px;
    margin: 5rem auto;
    background-color: rgb(247, 247, 247);
    display: flex;
    flex-direction: row;
}
/* 사이드바 */
.section1{
    width: 20%;
    margin-right: 2rem;
    height: 100%;
    background-color: white;
    font-family: 'BMHANNAPro';
}
.menu {
    list-style-type: none;
    padding: 0;
    height: 600px;
    background-color: white;
}

.menu-item {
    width: 100%;
    background-color: white;
    font-family: 'BMHANNAPro';
    font-size: 22px;
}

.menu-item a {
    color: black;
    text-decoration: none;
    display: block;
    padding: 20px;
    padding-left: 30px;
    background-color: white;
    transition: background-color 0.3s ease;
    font-family: 'BMHANNAPro';
}


.menu-item a:hover {
    background-color: rgb(247, 247, 247);
}
@keyframes slide-down {
    0% {
        opacity: 0;
        transform: translateY(-10px);
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes slide-up {
    0% {
        opacity: 1;
        height: auto;
    }
    100% {
        opacity: 0;
        height: 0;
        padding: 0;
        margin: 0;
        border: 0;
    }
}
.submenu {
    display: none;
    list-style-type: none;
    padding: 0;
    margin-top: 5px;
    overflow: hidden;
}

.submenu li a {
    color: black;
    text-decoration: none;
    padding: 20px;
    display: block;
    transition: background-color 0.3s ease;
}
.submenu li a:hover {
    background-color: white;
}
/* 나의 정보 form */
.section2{
    width: 100%;
    background-color: white;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
/* 나의 프로필 */
.profileForm{
    background-color: white;
    margin: 15px;
    margin-bottom: 5px;
    width: 97%;
    border: 1px solid #858585;
    border-radius: 10px;
}
#myProfile{
    font-size: 30px;
    font-weight: 500;
    margin-bottom: 25px;
    padding-left: 15px;
    margin-top: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    font-family: 'BMHANNAPro';
}
.profileInfo{
    background-color: white;
    width: 100%;
   	height: 140px;
   	font-family: 'BMHANNAPro';
}
.firstGroup{
    background-color: white;
    width: 96%;
    display: flex;
    margin-top : 30px;
    margin-bottom: 30px;
}
.firstGroup > div{
    background-color: white;
    width: 500px;
    display: flex;
    justify-content: space-around;
}
.firstGroup > div > p{
    background-color: white;
    width: 30%;
    text-align: center;
    font-size: 22px;
    margin-top: 10px;
    font-family: 'BMHANNAPro';
}
.firstGroup > div > input{
	font-family: 'BMHANNAPro';
	font-size : 20px;	
}
.secondGroup{
    background-color: white;
    width: 96%;
    display: flex;
    margin-bottom: 20px;
}
.secondGroup > div {
    background-color: white;
    width: 500px;
    display: flex;
    justify-content: space-around;
    
}.secondGroup > div > p{
    background-color: white;
    width: 30%;
    text-align: center;
    font-size: 22px;
    margin-top: 10px;
}
.secondGroup > div > input{
	font-family: 'BMHANNAPro';
	font-size : 20px;
	}
.profile{
    background-color: rgb(247, 247, 247);
    height: 35px;
    width: 300px;
    border: none;
    font-size: 22px;
    pointer-events: none;
    margin-left: 10px;
    text-align: center;
    color: black;
}
.updateProfile{
    text-align: right;
    margin-bottom: 25px;
    background-color: white;
}
#profileBtn{
    padding: 6px 12px;
    font-size: 18px;
    font-family: 'BMHANNAPro';
    text-decoration: none;
    color: black;
    background-color: white;
    border: solid 1px #858585;
    border-radius: 10px;
    margin-right: 23px;
}
/*  나의 프로필 아래 부분 */
.underForm{
    display: flex;
    background-color: white;
}
/* 출석 (달력)*/
.attendForm{
    background-color: white;
    margin: 15px;
    height: 420px;
    width: 500px;
    border: 1px solid #858585;
    border-radius: 10px;
    flex-direction: column;
    flex-wrap: wrap;
    justify-content: center;
}
#attend{
    font-size: 30px;
    font-weight: 500;
    font-family: 'BMHANNAPro';
    margin-top: 32px;
    /* background-color: white; */
    display: flex;
    justify-content: center;
}
#attendInfo{
    background-color: white;
    margin: 60px;
}
#attendInfo > div{
    margin-left: 22px;
    background-color: white;
    font-size: 22px;
    font-family: 'BMHANNAPro';
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    width: 330px;
}
/* 나의 활동 */
.sec3{
    background-color: white;
    margin: 15px;
    height: 420px;
    width: 500px;
    border: 1px solid #858585;
    border-radius: 10px;
}
.myRec{
    font-size: 30px;
    font-family: 'BMHANNAPro';
    font-weight: 500;
    margin-bottom: 20px;
    margin-top: 30px;
    display: flex;
    justify-content: center;
}
.myRecForm{
    background-color: white;
    margin: 60px;
}
.myRecForm > div{
    margin-left: 22px;
    background-color: white;
    font-size: 22px;
    font-family: 'BMHANNAPro';
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    width: 330px;
}
.myRecForm > div > input{
    background-color: rgb(247, 247, 247);
    height: 35px;
    width: 170px;
    border: none;
    font-size: 22px;
    font-family: 'BMHANNAPro';
    pointer-events: none;
    margin-left: 10px;
    text-align: center;
}

</style>
</head>
<body>
    <%@ include file="../../include/header.jsp" %>
    <div class="main_content">
        <div class="section1">
            <ul class="menu">
                <li class="menu-item"><a href="#">나의 정보</a></li>
                <li class="menu-item">
                    <a href="#">독후감 목록</a>
                    <ul class="submenu">
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp; 작성된 독후감</a></li>
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp; 나만보기</a></li>
                    </ul>
                </li>
                <li class="menu-item"><a href="#">이벤트 참여 내역</a></li>
                <li class="menu-item"><a href="#">도서 신청</a></li>
                <li class="menu-item">
                    <a href="#">문의 사항</a>
                    <ul class="submenu">
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp; 문의 사항 작성</a></li>
                        <li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp; 문의 사항 목록</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="section2">
			<div class="profileForm">
			    <div id="myProfile">나의 프로필</div>
			    <% 
			    	User us = (User)session.getAttribute("user");
			    %>
			        <div class="profileInfo">
			            <div class="firstGroup">
			                <div>
			                    <p>아이디</p>
			                    <input type="text" class="profile" id="id" 
			                    value="<%=us.getUser_id()%>" readonly disabled>
			                </div>
			                <div>
			                    <p>이름</p>
			                    <input type="text" class="profile" id="name" 
			                    value="<%=us.getUser_name()%>" readonly disabled>
			                </div>                    
			            </div>
			            <div class="secondGroup">
			                <div>
			                    <p>이메일</p> 
			                    <input type="text" class="profile" id="email" 
			                    value="<%=us.getUser_email()%>" readonly disabled>
			                </div>
			                <div>
			                    <p>닉네임</p>
			                    <input type="text" class="profile" id="nickname" 
			                    value="<%=us.getUser_nickname()%>" readonly disabled">
			                </div>
			            </div>
			    </div>
			    <div class="updateProfile">
			        <a href="/user/edit" id="profileBtn">프로필 수정</a>
			    </div>
			</div>
			<div class="underForm">
			    <div class="attendForm">
			        <div id="attend">출석</div>
			        <div id="attendInfo">
			        	<div>총 출석일</div>
			        </div>
			    </div>
			    <div class="sec3">
			        <div class="myRec">나의 활동</div>
			        <div class="myRecForm">
			            <div>이벤트 참여 수
			                <input type="text" id="eventCount" value="${evCount}" readonly disabled>
			            </div>
			            <div>독후감 수
			                <input type="text" id="btCount" value="${btCount}" readonly disabled>
			            </div>
			            <div>문의사항 수
			                <input type="text" id="askCount" value="${sgCount}" readonly disabled>
			            </div>
			        </div>
			    </div>
			</div>
        </div> 
    </div>
</body> 
</html>