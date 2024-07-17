<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>6캔두잇</title> 
	<link href="../../../resources/css/header.css" rel="stylesheet" type="text/css">
	<link href="../../../resources/css/mypageSideBar.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../../../resources/javascript/mypage.js"></script>
</head>

<body>
    <section class="main_header">
        <header>
            <nav id="header_nav">
                <a href="#" id="main_logo">Knock Book</a>
                <ul>
                    <li><a href="#" class="header_list">도서 목록</a></li>
                    <li><a href="#" class="header_list">이벤트</a></li>
                    <li><a href="#" class="header_list" id="header_join">로그인</a></li>
                    <li><a href="#" class="header_list" id="header_join">회원가입</a></li> 
                </ul>
            </nav>
        </header>
    </section> 

    <section class="main_content">
        <main>
            <!-- 이 선 위는 변경 X -->
            <!-- 아래에 추가 --> 
            <section class="sec1">
                <div class="section1">
                    <div class="sidebar">
                        <ul class="menu">
                            <li class="menu-item"><a href="#">나의 정보</a></li>
                            <li class="menu-item"><a href="#">팔로잉 목록</a></li>
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
                </div>
            </section> 
            <!-- 여기까지 사이드 바 코드 -->
            <section class="sec2">
               	<div class="section 안 요소2 1"></div>
                <div class="section 안 요소2 2"></div>
            </section> 
        </main>
    </section>
</body> 
</html>
