<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.book.member.user.vo.User"%>
<%-- <%@page import="com.book.member.user.vo.Booktext"%> --%>
<%-- <%@page import="com.book.member.user.vo.Book"%> --%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>6캔두잇</title> 
	<link href="../../../resources/css/include/header_user.css" rel="stylesheet" type="text/css">
	<link href="../../../resources/css/member/user/mypage.css" rel="stylesheet" type="text/css">
	<script src="../../../resources/js/mypageSidebar.js"></script>
	<script src="../../../resources/js/attendCalendar.js"></script>    
</head>

<body>
	<%
/*		User u = (User)session.getAttribute("user");
		Booktext bt =(Booktext)session.getAttribute("booktext");
 		Book b = (Book)session.getAttribute("book"); 
		Participates p = (Participates)session.getAttribute("Participates");
		Suggestion sg = (suggestion)session.getAttribute("suggestion");
*/
	%>
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
    <div class="main_content">
        <!-- 이 선 위는 변경 X -->
        <!-- 아래에 추가 --> 
        <div class="section1">
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
        <div class="section2">
            <div class="profileForm">
                <div id="myProfile">나의 프로필</div>
                    <div class="profileInfo">
                        <div class="firstGroup">
                            <div>
                                <p>아이디</p>
                                <input type="text" class="profile" id="id" 
                                value="id"
                               <%--  "<%=u.getUser_id()%>" readonly disabled --%>
                                >
                            </div>
                            <div>
                                <p>이름</p>
                                <input type="text" class="profile" id="name" 
                                value="name"
                                <%-- <%=u.getUser_name()%>" readonly disabled --%>
                                >
                            </div>                    
                        </div>
                        <div class="secondGroup">
                            <div>
                                <p>이메일</p> 
                                <input type="text" class="profile" id="email" 
                                value="email"
                               <%--  <%=u.getUser_email()%>" readonly disabled --%>
                                >
                            </div>
                            <div>
                                <p>닉네임</p>
                                <input type="text" class="profile" id="nickname" 
                                value="nickname"
                               <%--  <%=u.getUser_nickname()%> readonly disabled" --%>
                                >
                            </div>
                        </div>
                </div>
                <div class="updateProfile">
                    <a href="#" id="profileBtn">프로필 수정</a>
                </div>
            </div>
            <div class="underForm">
                <div class="calendarForm">
                    <div id="attend">출석</div>
                    <div class="sec_cal">
                        <div class="cal_nav">
                            <a href="javascript:;" class="nav-btn go-prev">prev</a>
                            <div class="year-month"></div>
                            <a href="javascript:;" class="nav-btn go-next">next</a>
                            </div>
                            <div class="cal_wrap">
                            <div class="days">
                                <div class="day">MON</div>
                                <div class="day">TUE</div>
                                <div class="day">WED</div>
                                <div class="day">THU</div>
                                <div class="day">FRI</div>
                                <div class="day">SAT</div>
                                <div class="day">SUN</div>
                            </div>
                            <div class="dates"></div>
                        </div>
                    </div>
                </div>
                <div class="sec3">
                    <div class="myRec">나의 활동</div>
                    <div class="myRecForm">
                        <div>팔로잉 수
                            <input type="text" id="followingCount" value="3" readonly disabled>
                        </div>
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
