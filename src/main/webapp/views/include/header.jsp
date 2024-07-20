<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.book.member.event.dao.MemEventDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.book.member.user.vo.User" %>
<%@ page import="com.book.member.event.dao.MemEventDao" %>
<%@ page import="java.util.List"%>
<%@ page import="com.book.admin.event.vo.Event"%> 
<%@ page import="java.util.Date"%>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	@charset "UTF-8";  

	/* 눈누 */
	/* 강원교육튼튼체 */
	@font-face {
	    font-family: 'GangwonEduPowerExtraBoldA';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEduPowerExtraBoldA.woff') format('woff');
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

			
	* { 
	    box-sizing: border-box; 
	    margin: 0;  
	}
	
	body {
		background-color: rgb(247, 247, 247);
	}
	
	/* header */
	
	ul, ol {
	    list-style: none;
	}
	
	.main_logo {
	    font-size: 30px;
	    color: rgb(224, 195, 163);
	    text-decoration: none;
	    font-family: 'JalnanGothic';
	    background-color: rgb(255, 255, 255);
	}
	
	.header_list {
	    text-decoration: none;
	    color: #000000;
	    font-size: 18px;
	    background-color: white; 
	    font-family: 'BMHANNAPro';
	}
	
	.header_list:hover {
	    color: rgb(224, 195, 163);
	}
	
	#header_join:hover, #header_login:hover {
	    background-color: rgb(224, 195, 163);
	    color: rgb(254, 254, 254);
	}
	
	.main_header > header > .header_div {
	    background-color: rgb(255, 255, 255);
	    border-bottom: #b3b3b3c4 1px solid;
	    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
	    padding-left: 2%;
	    padding-right: 2%;
	}
	
	.header_div {
	    width: 100%;
	    height: 90px;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;  
	}
	
	.header_div > a {
	    font-weight: 900;
	    padding: 0 30px;
	    background-color: rgb(255, 255, 255);
	}
	
	.header_div > ul {
	    display: flex;
	    background-color: rgb(255, 255, 255);
	}
	
	.header_div > ul li {
	    padding: 0 20px;
	    background-color: rgb(255, 255, 255);
	}
	
	#header_join, #header_logout, #header_login {
	    color: rgb(0, 0, 0);
	    border: 1px solid #858585;
	    border-radius: 10px;
	    padding: 5px 15px;
	    background-color: rgb(255, 255, 255);
	}
	
	/* 알림 */
	.notification-icon {
	    position: relative;
	    cursor: pointer;
	}
	
	.notification-count {
	    position: absolute;
	    top: -5px;
	    right: -5px;
	    background-color: red;
	    color: white;
	    border-radius: 50%;
	    padding: 2px 5px;
	    font-size: 12px;
	}
	
	.modal {
	    display: none;
	    position: fixed;
	    z-index: 1;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgba(0,0,0,0.6);
	}
	
	.modal-content {
	    background-color: #fefefe;
	    margin: 15% auto;
	    padding: 20px;
	    border: 1px solid #888;
	    width: 80%;
	    max-width: 600px;
	}
	
	.modal-content h2 {
		text-align: center;
		font-family: 'Freesentation-9Black';
		font-size:30px;
		margin-bottom: 30px;
	}
	
	a {
		text-decoration: none;
		color : black;
	}
	
	.notification-item {
		background-color: rgba(250, 210, 125, 0.5);
		padding : 10px 0px;
		text-align: center;
		font-size:18px;
		font-weight:600;
		border-radius: 15px;
		margin-bottom: 15px;
	}
	
	#noti_date {
		margin-top:5px;
		font-size:15px;
		color: rgba(77, 77, 77);
	}
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	    cursor: pointer;
	}
	
	.close:hover,
	.close:focus {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	#notification-icon {
		font-size:20px;
	    color: #ffd700;
	}
	 
	#no_events {
		text-align: center;
	}
</style>
<section class="main_header">
     <header>
	    <%
	        User user = (User) session.getAttribute("user");
	        if (user == null) {
	    %>
	        <div class="header_div">
	            <a href="/" class="main_logo">Knock Book</a>
	            <ul> 
	                <li><a href="#" class="header_list">도서</a></li>
	                <li><a href="#" class="header_list">독후감</a></li>
	                <li><a href="/user/event/list?status=ongoing" class="header_list">이벤트</a></li>
	                <li><a href="/user/login" class="header_list" id="header_login">로그인</a></li>
	                <li><a href="/user/create" class="header_list" id="header_join">회원가입</a></li>
	            </ul>
	        </div>
	    <% 
	        } else if (user.getUser_no() == 1) {
	    %>
	        <div class="header_div">
	            <a href="/" class="main_logo">Knock Book</a>
	            <ul>
	            	<li><a href="#" class="header_list">도서</a></li> 
	                <li><a href="/event/list" class="header_list">이벤트</a></li> 
	                <li><a href="#" class="header_list" id="header_adminPage">관리자 페이지</a></li>
	                <li><a href="/user/logout" class="header_list" id="header_logout">로그아웃</a></li>
	            </ul>
	        </div>
	    <% 
	        } else { 
	    %>
	        <div class="header_div">
	            <a href="/" class="main_logo">Knock Book</a>
	            <ul>
	                <li><a href="#" class="header_list">도서</a></li>
	                <li><a href="#" class="header_list">독후감</a></li>
	                <li><a href="/user/event/list?status=ongoing" class="header_list">이벤트</a></li> 
	                <li><%= user.getUser_nickname() + "님 환영합니다." %></li>
	                <li><a href="/user/mypage" class="header_list" id="header_join">마이페이지</a></li>
	                <li><a href="/user/logout" class="header_list" id="header_logout">로그아웃</a></li>
	                <li id="notification-icon" class="notification-icon"><i class="fas fa-bell"></i>
	                </li>
	
	                <!-- 알림 모달 -->
	                <div id="notification-modal" class="modal">
	                    <div class="modal-content">
	                        <span class="close">&times;</span>
	                        <h2>알림 설정된 이벤트</h2>
	                        <div id="notification-list"> 
                        	    <%!
							        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
							        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
							
							        String formatDateString(String input) {
							            try {
							                Date date = inputFormat.parse(input);
							                return outputFormat.format(date);
							            } catch (Exception e) {
							                e.printStackTrace();
							                return "";
							            }
							        }
							    %>
	                            <%
	                                MemEventDao notificationDAO = new MemEventDao();
	                                List<Event> notifiedEvents = notificationDAO.getNotifiedEventsForUser(user.getUser_no());
	                                if (notifiedEvents != null && !notifiedEvents.isEmpty()) {
	                                    for (Event event : notifiedEvents) {
	                            %>
                                        <div class="notification-item">
                                            <a href="<%= request.getContextPath() %>/user/event/detail?eventNo=<%= event.getEvent_no() %>&eventType=<%= event.getEv_form() %>">
                                                <div id="noti_title"><%= event.getEv_title() %></div>
                                                <div id="noti_date"><%= formatDateString(event.getEv_start()) %> ~ <%= formatDateString(event.getEv_end()) %></div>
                                            </a>
                                        </div>
	                            <% 
	                                    }
	                                } else {
	                            %>
	                                    <p id="no_events">알림 설정된 이벤트가 없습니다.</p>
	                            <% 
	                                } 
	                            %>
	                        </div>
	                    </div>
	                </div>
	            </ul>
	        </div>
	    <% 
	        } 
	    %>  
	</header> 
</section>  
<script>
	$(document).ready(function() {
	    var modal = $("#notification-modal");
	    var icon = $("#notification-icon");
	    var closeBtn = $(".close");
	 
	    icon.click(function() { 
	        modal.css("display", "block");
	    });
	 
	    closeBtn.click(function() {
	        modal.css("display", "none");
	    });
	 
	    $(window).click(function(event) {
	        if (event.target == modal[0]) {
	            modal.css("display", "none");
	        }
	    }); 
	});
</script>