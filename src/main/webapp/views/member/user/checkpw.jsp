<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link href='../../resources/css/member/user/checkpw.css' rel="stylesheet" type="text/css">
</head>
<body>
	 <header>
        <nav id="header_nav">
            <a href="#" id="main_logo">Knock Book</a>
            <ul>
                <li><a href="#" class="header_list">회원 관리</a></li>
                <li><a href="#" class="header_list">정보 수정</a></li>
                <li><a href="#" class="header_list" id="header_user">admin님</a></li>
                <li><a href="#" class="header_list" id="header_logout">로그아웃</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section id="right">
            <div id="main_div">
            <form name="checkpw_form" action="/user/checkpwEnd" method="post">
                <label for="pw" style="width: 550px; text-align: center;">
                    <h2><strong>회원 정보 수정시, 개인 정보 보호를 위해 본인확인을 진행합니다.</strong></h2>
                </label>
                <input type="password" name="pw" placeholder="비밀번호를 입력해 주세요" style="width: 500px;">
                <div>
                    <button onclick="checkpw();">확인</button>
                    <button>취소</button>
                </div>
                </form>
            </div>
        </section>
    </main>
    
    <script type="text/javascript">
		function checkpw() {
			let form = document.checkpw_form;
			if (form.pw.value == '') {
				alert('비밀번호를 입력하세요.');
				form.pw.focus();	
			} else {
				form.submit();
			}
		}
	</script>
</body>
</html>