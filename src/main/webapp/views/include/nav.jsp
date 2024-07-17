<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.book.member.user.vo.User" %>
<link href='../../resources/css/include/font.css' rel="stylesheet" type="text/css"> 
<style>
	@charset "UTF-8";

	* {
	    background-color: rgb(247, 247, 247);;
	    /* background-color: rgb(237, 237, 233); */
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
	
	.header_list:hover{
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
	    padding-left: 2%;;
	    padding-right: 2%;
	}
	
	
	div {
	    width: 100%;
	    height: 90px;
	    display: flex;
	    justify-content: space-between;
	    align-items: center; 
	    margin-bottom: 10px;
	}
	 
	.header_div>a {
	    font-weight: 900;
	    padding: 0 30px;
	    background-color: rgb(255, 255, 255);
	}
	
	.header_div>ul {
	    display: flex;
	    background-color: rgb(255, 255, 255);
	}
	
	.header_div>ul li {
	    padding: 0 20px;
	    background-color: rgb(255, 255, 255);
	}
	
	#header_join {
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
             <a href="#" class="main_logo">Knock Book</a>
             <ul>
                 <li><a href="#" class="header_list">도서 목록</a></li>
                 <li><a href="/event/create" class="header_list">이벤트</a></li>
                 <li><a href="/user/login" class="header_list" id="header_join">로그인</a></li>
                 <li><a href="/user/create" class="header_list" id="header_join">회원가입</a></li> 
             </ul>
         </div>
         <% }else{ %>
         <div class="header_div">
         	<a href="#" class="main_logo">Knock Book</a>
         	<%User u= (User)session.getAttribute("user");%>
			<ul>
				<li>
					<a href="/board/create"class="header_list" id="header_join">게시글 등록</a>
				</li>
				<li>
					<%=u.getUser_id()+"님 환영합니다." %>
					<a href="/user/logout"class="header_list" id="header_join">로그아웃</a>
				</li>
				<li>
				 	<a href="/user/checkpw"class="header_list" id="header_join">계정수정</a>
				</li>
			</ul>
		</div>
		<%} %>	
     </header>
</section> 
<script>
	
</script>