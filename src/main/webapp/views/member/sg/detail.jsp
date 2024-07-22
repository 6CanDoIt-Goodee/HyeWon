<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.book.member.sg.vo.Suggestion, java.util.*,com.book.admin.sg.vo.SuggestionReply"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>6캔두잇</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous" />
<style>
.main_content {
	max-width: 1300px;
	height: 750px;
	margin: 5rem auto;
	background-color: rgb(247, 247, 247);
	display: flex;
	flex-direction: row;
}

.section1 {
	width: 20%;
	margin-right: 2rem;
	height: 100%;
	background-color: white;
}

.section2 {
	width: 80%;
	margin-right: 2rem;
	margin-top:50px
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
100%
{
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

.sec2 {
	width: 100%;
	background-color: white;
}

.form {
	background-color: white;
}

body {
	height: 100%;
	line-height: 1.6;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

.sg_post_detail {
	width: 100%;
	height: 550px;
	background: #f4f4f4;
	padding: 20px;
	margin-bottom: 20px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border: 1px solid #ccc;
}

#sg_post_title {
	color: #2c3e50;
	margin-bottom: 10px;
	background: transparent;
}

.sg_post_info {
	font-size: 16px;
	color: #7f8c8d;
	margin-bottom: 20px;
	background: transparent;
}

#sg_post_date {
	border-bottom: 1px solid #e0e0e0;
	display: block;
	margin-bottom: 10px;
	background: transparent;
}

#sg_post_content {
	color: #575756;
	padding-top: 15px;
	background: transparent;
}

.replyList {
	width: 100%;
	padding: 30px;
}

.replyContent {
	width: 95%;
	height: 100px;
	padding: 10px;
	border-radius: 5px;
	border: 1px solid #ccc;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	resize: none;
	overflow: auto;
}

.btn_container {
	gap: 10px;
	display: flex;
	justify-content: right;
	margin-top: 20px;
}

.back_btn, .delete_btn {
	width: 50px;
	height: 30px;
	border-radius: 15%;
	text-align: center;
	background: #575756;
	color: #fffbfb;
	font-size: 14px;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	text-decoration: none;
	border: none;
}

.back_btn:hover, .delete_btn:hover {
	background: #18283235;
}
</style>

</head>

<body>
  <%@ include file="../../include/header.jsp" %>
	<%Boolean success = (Boolean) request.getAttribute("success");%>
	<%if (success != null && success) {%>
	<script type="text/javascript">
        alert("신청이 완료되었습니다");
    </script>
	<%}%>
	<div class="main_content">
		<!-- 이 선 위는 변경 X -->
		<!-- 아래에 추가 -->
		<div class="section1">
			<ul class="menu">
				<li class="menu-item"><a href="#">나의 정보</a></li>
				<li class="menu-item"><a href="#">독후감 목록</a>
					<ul class="submenu">
						<li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp; 작성된 독후감</a></li>
						<li><a href="#">&nbsp;&nbsp;&nbsp;&nbsp; 나만보기</a></li>
					</ul></li>
				<li class="menu-item"><a href="#">이벤트 참여 내역</a></li>
				<li class="menu-item"><a href="/book/apply">도서 신청</a></li>
				<li class="menu-item"><a href="#">문의 사항</a>
					<ul class="submenu">
						<li><a href="/member/sg/create">&nbsp;&nbsp;&nbsp;&nbsp;문의 사항 작성</a></li>
						<li><a href="/member/sg/list">&nbsp;&nbsp;&nbsp;&nbsp; 문의사항 목록</a></li>
					</ul></li>
			</ul>
		</div>
<div class="section2">
	<div class="sg_post_detail">
	<%
	// getAttribute로 정보 가져오기
	Suggestion sg = (Suggestion) request.getAttribute("sgDetail");
	String img1 = sg.getNew_img1();
	String img2 = sg.getNew_img2();
	String img3 = sg.getNew_img3();
	// 이미지가 널값리면 빈 문자열로 
	String imgSrc1 = (img1 != null && !img1.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img1 : "";
	String imgSrc2 = (img2 != null && !img2.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img2 : "";
	String imgSrc3 = (img3 != null && !img3.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img3 : "";
	// 날짜 포맷
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");%>
	<!-- 문의사항 상세 -->
	<h2 id="sg_post_title"><%=sg.getSg_title()%></h2>
	<p class="sg_post_info"><span id="sg_post_date">작성일: <%=formatter.format(sg.getSg_mod_date())%></span></p>
	<%if (!imgSrc1.isEmpty()) {%>
	<img src="<%=imgSrc1%>" alt="이미지 1" class="sg_image" width="200">
	<%}%>
	<%if (!imgSrc2.isEmpty()) {	%>
	<img src="<%=imgSrc2%>" alt="이미지 2" class="sg_image" width="200">
	<%}%>
	<%if (!imgSrc3.isEmpty()) {%>
	<img src="<%=imgSrc3%>" alt="이미지 3" class="sg_image" width="200">
	<%}%>
	<div id="sg_post_content"><%=sg.getSg_content()%></div>
	</div>

	<div class="btn_container">
	<a href="/member/sg/list" class="back_btn">목록</a>
	<form id="deleteForm"action="/member/sg/delete?sg_no=<%=sg.getSg_no()%>" method="POST">
	<button class="delete_btn" type="submit" onclick="return confirmDelete();">삭제</button>
	</form>
	</div>
	<div class="replyList">
	<!-- 답변 -->
	<%List<SuggestionReply> replyList = (List<SuggestionReply>) request.getAttribute("replyList");
	if (replyList != null && !replyList.isEmpty()) {
		for (SuggestionReply reply : replyList) {%>
		<div class="replyContent"><%=reply.getSg_reply_content()%></div>
		<%}
		} else {
		%><div class="replyContent">관리자가 빠른 시일 내에 답변을 드릴거에요 :)</div>
		<%}%>
	</div>
</div>

<script type="text/javascript">
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
		
// 삭제할 때 confrim 
deleteForm.addEventListener('submit', function(e) {
    e.preventDefault();
    
    const confirmDelete = confirm('정말로 삭제하시겠습니까?');
    
    if (confirmDelete) {
        this.submit(); // 폼 제출
    } else {
        alert('삭제가 취소되었습니다.');
    }
});

</script>
</body>
</html>
