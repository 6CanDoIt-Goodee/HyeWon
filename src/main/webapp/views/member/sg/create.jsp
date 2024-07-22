<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.book.member.user.vo.User"%>
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
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

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

.sec2 {
	width: 100%;
	background-color: white;
}

.form {
	background-color: white;
}

.sgDiv {
	display: flex;
	flex-direction: column;
	padding: 30px;
	margin-top: 20px;
	width: 600px;
	margin: 0 auto;
}

.sgTitle {
	width: 100%;
	height: 50px;
	padding: 10px;
	line-height: 1.5;
	border: 1px solid #575756;
	border-radius: 15px;
	background: #fff;
	font-size: 15px;
	outline: none;
	resize: none;
	overflow-wrap: break-word;
	margin-bottom: 10px;
}

#sgForm {
	width: 600px;
	height: 550px;
}

.sgWrite {
	width: 100%;
	height: 400px;
	padding: 10px;
	line-height: 1.5;
	border: 1px solid #575756;
	border-radius: 15px;
	background: #fff;
	font-size: 15px;
	outline: none;
	resize: none;
	overflow-wrap: break-word;
	margin-bottom: 10px;
}

.image-preview {
	display: inline-block;
	margin: 5px;
}

.image-preview img {
	width: 150px;
	height: 200px;
	object-fit: cover;
}

#btn_gr {
	text-align: right;
	
}

.btnFile {
	width: 40px;
	height: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 20px;
	color: #fff;
	border: none;
	border-radius: 5px;
	background-color: #575756;
	margin-bottom: 10px;
}

.btn {
	width: 50px;
	border-radius: 15%;
	text-align: center;
	box-sizing: border-box;
	border: none;
	background: #575756;
	color: #fffbfb;
	font-size: 14px;
	margin-left: 10px;
}

.btn:hover {
	background: #18283235;
}
</style>
</head>

<body>
  <%@ include file="../../include/header.jsp" %>
	<%
	Boolean success = (Boolean) request.getAttribute("success");
	%>
	<%
	if (success != null && success) {
	%>
	<script type="text/javascript">
        alert("신청이 완료되었습니다");
    </script>
	<%
	}
	%>
	<div class="main_content">
		<!-- 이 선 위는 변경 X -->
		<!-- 아래에 추가 -->
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
		
		
<div class="section2">
	<form action="/member/sg/createEnd" id="create_sg_form" method="post" enctype="multipart/form-data">
		<input type="text" class="sgTitle" name="sg_title" placeholder="제목을 작성해 주세요" required>
		<textarea class="sgWrite" name="sg_content" placeholder="문의사항 작성 시 주의할 점 
		1. 가능한 한 명확하고 구체적으로 작성해 주세요.
 		2. 필요한 경우 관련된 정보나 배경 설명을 포함해 주세요
 		3. 이미지파일은 3개까지만 등록 가능합니다."required></textarea>
		<div id="imageContainer" class="image-container">
		<!-- 이미지를 보여줄 컨테이너 --></div>
		<input type="file" name="sg_file1" accept=".png,.jpg,.jpeg">
		<input type="file" name="sg_file2" accept=".png,.jpg,.jpeg">
		<input type="file" name="sg_file3" accept=".png,.jpg,.jpeg">
		<%User sg_userNo = (User) session.getAttribute("user");%>
		<input type="hidden" name="user_no"value="<%=sg_userNo.getUser_no()%>">
		<div id="btn_gr">
			<input type="button" class="btn" value="등록" onclick="createSgForm();"> <input type="button"class="btn" value="취소">
		</div>
	</form>
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

// 폼 유효성 검사 함수
function createSgForm() {
    let form = document.getElementById('create_sg_form');
    if (!form.sg_title.value) {
        alert("제목을 입력하세요.");
        form.sg_title.focus();
    } else if (!form.sg_content.value) {
        alert("내용을 입력하세요.");
        form.sg_content.focus();
    } else {
        let validImages = true;
        // 이미지 파일 유효성 검사
        const fileInputs = document.querySelectorAll('input[type="file"]');
        fileInputs.forEach(input => {
            if (input.value) {
                const file = input.files[0];
                const fileType = file.type.split('/')[1];
                if (!(fileType === 'jpg' || fileType === 'jpeg' || fileType === 'png')) {
                    validImages = false;
                }
            }
        });

        if (!validImages) {
            alert("이미지 파일은 .jpg, .jpeg, .png 형식만 업로드 가능합니다.");
        } else {
            form.submit();
        }
    }
}

</script>
</body>
</html>
