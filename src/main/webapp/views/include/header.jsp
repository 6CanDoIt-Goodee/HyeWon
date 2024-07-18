<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.book.member.user.vo.User" %>
<link href='../../resources/css/include/font.css' rel="stylesheet" type="text/css"> 
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
	    background-color: rgb(247, 247, 247);
	    box-sizing: border-box; 
	    margin: 0;  
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
	
	#header_join:hover {
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
	    margin-bottom: 10px;
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
	
	#header_join, #header_logout {
	    color: rgb(0, 0, 0);
	    border: 1px solid #858585;
	    border-radius: 10px;
	    padding: 5px 15px;
	    background-color: rgb(255, 255, 255);
	}
	 
</style>
<section class="main_header">
     <header>
     	<%
			User user=(User)session.getAttribute("user");
			if(user == null){
		%>
         <div class="header_div">
             <a href="/" class="main_logo">Knock Book</a>
             <ul>
                 <li><a href="#" class="header_list">도서 목록</a></li>
                 <li><a href="/user/event/list" class="header_list">이벤트</a></li>
                 <li><a href="/user/login" class="header_list" id="header_join">로그인</a></li>
                 <li><a href="/user/create" class="header_list" id="header_join">회원가입</a></li> 
             </ul>
         </div>
         <% }else{ %>
         <div class="header_div">
         	<a href="/" class="main_logo">Knock Book</a>
         	<%User u= (User)session.getAttribute("user");%>
			<ul>
				<li>
					<a href="/board/create"class="header_list" id="header_join">게시글 등록</a>
				</li>
				<li><a href="/user/event/list" class="header_list">이벤트</a></li>
				<li>
					<%=u.getUser_id()+"님 환영합니다." %>
				</li>
				<li>
					<a href="/user/logout"class="header_list" id="header_logout">로그아웃</a>
				</li>
				<li>
				 	<a href="/user/checkpw"class="header_list" id="header_join">계정수정</a>
				</li>
			</ul>
		</div>
		<%} %>	
     </header>
</section>  