<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <title>마이페이지 사이드바</title> 
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
    height: 750px;
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
}
	</style>
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
			<!-- 여기에 파일을 넣으세요. -->
        </div> 
    </div>
</body> 
</html>