<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href='../../resources/css/member/user/login.css' rel="stylesheet" type="text/css">
</head>
<body>
	<main>
        <section id="right">
            <div id="main_div">
                <a href="#" id="main_logo">
                    <h1>Knock Book</h1>
                </a>
                <form name="login_form" action="/user/loginEnd" method="post">
                    <input type="text" name="id" placeholder="아이디를 입력해 주세요">
                    <input type="password" name="pw" placeholder="비밀번호를 입력해 주세요">
                    <button type="button" onclick="loginForm();">로그인</button>
                </form>
                <br>
                <div id="down_link">
                    <a href="/user/findid">아이디 찾기 | </a><a href="/user/findpw">비밀번호 찾기 | </a><a href="/user/create">회원가입</a>
                </div>
            </div>
        </section>
    </main>

	<script type="text/javascript">
		function loginForm() {
			let form = document.login_form;
			if (form.id.value == '') {
				alert('아이디를 입력하세요.');
				form.id.focus();	
			} else if (form.pw.value == '') {
				alert('비밀번호를 입력하세요.');
				form.pw.focus();
			} else {
				form.submit();
			}
		}
	</script>
</body>
</html>