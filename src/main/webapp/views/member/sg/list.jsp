<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 필요한 import 들 넣어주기 밑에 세개는 문의사항꺼여서 지우고 넣으세요 -->
<%@page import="com.book.member.sg.vo.Suggestion, java.util.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>6캔두잇</title>
<link href="/resources/css/member/sg/pasing.css" rel="stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"/>
 </head>
 
<style>
body {
	background-color: rgb(247, 247, 247);
}

.main_content {
	max-width: 1300px;
	height: 750px;
	margin: 5rem auto;
	display: flex;
	flex-direction: row;
}
/* 사이드바 */
.section1 {
	width: 20%;
	margin-right: 2rem;
	height: 100%;
	background-color: white;
	font-size:15px
}

.section2 {
	width: 80%;
	margin-right: 2rem;
	margin-top:50px
}

.section2>form {
	height: 350px;
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
}

.menu-item a {
	color: black;
	text-decoration: none;
	display: block;
	padding: 20px;
	padding-left: 30px;
	background-color: white;
	transition: background-color 0.3s ease;
}

.menu-item a:hover {
	background-color: rgb(247, 247, 247);
}

@keyframes slide-down { 0% {
	opacity: 0;
	transform: translateY(-10px);
}

100%{ 
	opacity:1;
	transform:translateY(0);
	}
}
@keyframes slide-up { 0% {
	opacity: 1;
	height: auto;
}

100%{
	opacity:0;
	height:0;
	padding:0;
	margin:0;
	border:0;
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

.write_container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50vh;
}

.form_write {
	padding: 2rem;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	width: 50%;
}

.form_write input, .form_write textarea {
	width: 100%;
	padding: 10px;
	margin-bottom: 1rem;
	border: 1px solid #ced4da;
	border-radius: 5px;
	transition: border-color 0.2s;
}

.form_write input:focus, .form_write textarea:focus {
	border-color: #80bdff;
	outline: none;
}

.bw_btn {
	text-align: right;
}

.btn-custom {
	background-color: #6c757d;
	color: white;
}

.btn-custom:hover {
	background-color: #5a6268;
}

* {
	background-color: rgb(247, 247, 247);
	box-sizing: border-box;
	margin: 0;
}

html {
	font-size: 10px;
}

.search_section {
	margin-bottom: 20px
}

.search_title {
	font-size: 23px;
	font-weight: 600;
	text-align: center;
	color: #2c2c2c;
	margin-bottom: 20px;
}

.search_input {
	width: 40%;
	padding: 15px 24px;
	height: 30px;
	font-size: 14px;
	line-height: 18px;
	color: #575756;
	border-radius: 20px;
	border: 1px solid #575756;
}

.search_btn {
	border: none;
}

#sglist {
	width: 1000px;
}

.board_list {
	width: 100%;
	border-collapse: collapse;
	border-top: 2px solid #000;
}

.board_list th, .board_list td {
	padding: 15px 0;
	text-align: center;
	font-size: 1.4rem;
	border-bottom: 1px solid #ddd;
}

.board_list thead tr {
	border-bottom: 1px solid #999;
}

.board_list th {
	font-weight: 600;
}

.board_list .num {
	width: 10%;
}

.board_list .title {
	width: 60%;
	text-align: left;
}

.board_list .title a {
	color: #2c2c2c;
	text-decoration: none;
}

.board_list thead .title {
	text-align: center;
}

.board_list .date {
	width: 10%;
}

.board_list .status {
	width: 10%;
}

#paging{
	width: 100%;
}
.center { 
  text-align: center;
  margin-top: 20px;
}
.pagination {
  display: inline-block;
}
.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
  margin: 0 4px;
}
.pagination a.active {
  background-color: #A5A5A5;
  color: white;
  border: 1px solid #A5A5A5;
}
.pagination a:hover:not(.active) {background-color: #ddd;}
</style>
  <body>
<% Boolean success = (Boolean) request.getAttribute("success"); %>
<% if (success != null && success) { %>
    <script type="text/javascript">
        alert("신청이 완료되었습니다");
    </script>
<% } %>
   <%@ include file="../../include/header.jsp" %>
            <div class="main_content"> 
            <div class="section1">
                <ul class="menu">
	                <li class="menu-item"><a href="/user/mypage">나의 정보</a></li>
	                <li class="menu-item">
	                    <a href="#">독후감 목록</a>
	                    <ul class="submenu">
	                        <li><a href="/user/bookList">&nbsp;&nbsp;&nbsp;&nbsp; 작성된 독후감</a></li>
	                        <li><a href="/user/saveTextList">&nbsp;&nbsp;&nbsp;&nbsp; 나만보기</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item"><a href="/user/event/parList">이벤트 참여 내역</a></li>
	                <li class="menu-item"><a href="/book/apply">도서 신청</a></li>
	                <li class="menu-item">
	                    <a href="#">문의 사항</a>
	                    <ul class="submenu">
	                        <li><a href="/member/sg/create">&nbsp;&nbsp;&nbsp;&nbsp; 문의 사항 작성</a></li>
	                        <li><a href="/member/sg/list">&nbsp;&nbsp;&nbsp;&nbsp; 문의 사항 목록</a></li>
	                    </ul>
	                </li>
	            </ul>
            </div>
<!-- 여기 밑에 넣을 내용 추가 하면 되는데
위에 css 지울부분도 있고 그래서 일단 수정해야햄... 알아서 수정하시길.... ( 자기가 원하는대로 하면 될듯) -->
<section class="section2">
<!-- 검색 기능 -->
  <section class="search_section">
    <form action="/member/sg/list" name="search_sg_form" method="get">
     <div class="search_container">
       <input class="search_input" name="sg_title" type="text"  placeholder="제목을 입력하세요.">
        <input class="search_btn" type="submit" value="검색" style="font-size:15px">
      </div>
    </form>
  </section> 
<!-- 문의사항 목록 -->
<table class="board_list">
   <thead>
     <tr class="top">
       <th class="num">번호</th>
       <th class="title">제목</th>
       <th class="date">등록일</th>
       <th class="status">답변여부</th>
     </tr>
   </thead>
   <tbody>
   
   <%
   // 문의사항 list 불러오기
   List<Suggestion> list =(List<Suggestion>)request.getAttribute("resultList");
   // 날짜 포맷
     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
   // 목록 번호
     int pageSize = 10;
     int nowPage = request.getParameter("nowPage") == null ? 1 : Integer.parseInt(request.getParameter("nowPage"));
     int startNo = (nowPage - 1) * pageSize + 1;
     // list 뽑을려고
     for(int i = 0; i < list.size(); i++){
     LocalDateTime date = list.get(i).getSg_mod_date();
     // 3항 연산자
     String status = (list.get(i).getSg_status() == 1) ? "답변완료" : "미답변";
          %>
        <tr>
          <td class="num"><%=startNo + i%></td>
          <td class="title"><a href="/member/sg/detail?sg_no=<%=list.get(i).getSg_no()%>"><%=list.get(i).getSg_title()%></a></td>
          <td class="date"><%=formatter.format(date)%></td>
          <td class="status"><%=status%></td>
        </tr>
        <%}%>
      </tbody>
    </table>
<!-- 페이징  -->
 <section id="paging">
  <% Suggestion paging = (Suggestion)request.getAttribute("paging"); %>
  <%if(paging != null) {%>
  <div class = "center">
     <div class="pagination">
        <%if(paging.isPrev()){%>
           <a href = "/member/sg/list?nowPage=<%=(paging.getPageBarStart()-1)%>">&laquo;</a>
        <%}%>
        <%for(int i = paging.getPageBarStart() ; i < paging.getPageBarEnd() ; i++){ %>
           <a href="/member/sg/list?nowPage=<%=i%>"<%=paging.getNowPage() == i ? "class='active'" : "" %>>
           <%=i%></a>
        <%}%>
        <%if(paging.isNext()){%>
           <a href="/member/sg/list?nowPage=<%=(paging.getPageBarEnd()+1)%>">&raquo;</a>
        <%}%>
     </div>
   </div>
  <%}%>  
 </section>  
</section>
  
  <script>
  document.addEventListener("DOMContentLoaded", function() {
      const menuItems = document.querySelectorAll(".menu-item > a");

      menuItems.forEach(function(item) {
          const submenu = item.nextElementSibling;
          let isOpen = false;

          item.addEventListener("click", function(event) {
              if (submenu) {

                  if (isOpen) {
                      submenu.style.animation = "slide-up 0.3s ease";
                      
                      setTimeout(function(){
                          submenu.style.display = "none";
                          submenu.style.animation = "";
                      }, 300);

                      isOpen = false;
                  } else {
                      submenu.style.display = "block";
                      submenu.style.height = "auto";
                      void submenu.offsetWidth;
                      submenu.style.animation = "slide-down 0.3s ease";
                      submenu.style.height = submenu.scrollHeight + "px";

                      isOpen = true;
                  }
              }
          });
      });

      const submenuLinks = document.querySelectorAll(".submenu li a");
      submenuLinks.forEach(function(link) {
          link.addEventListener("click", function(event) {
          });
      });
  });
  </script>
</body>
</html>
