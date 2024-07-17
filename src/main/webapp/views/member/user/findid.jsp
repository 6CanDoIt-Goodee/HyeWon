<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href='../../resources/css/member/user/findid.css' rel="stylesheet" type="text/css">
</head>
<body>
	<main>
        <div class="container">
        <nav class="navbar">
            <a href="#" id="main_logo">Knock Book</a>
        </nav>
        <div class="text-center">
            <h2>아이디 찾기</h2>
            <hr />
            <h4>본인확인 이메일로 인증</h4>
            <p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
        </div>
        <div>
        <form name="findid_form" action="/user/findid" method="post">
            <div class="form-group">
                <label for="name">이름:</label>
                <input type="text" id="name" name="name" placeholder="이름을 입력하세요" style="width: 352px;">
            </div>
            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" placeholder="이메일을 입력하세요">
                <input type="button" value="인증번호 받기" onclick="sendVerificationCode()">
            </div>
            <div class="form-group">
                
                <input type="text" name="email_number" maxlength="6" placeholder="인증번호 6자리 입력해 주세요." style="margin-left: 95px;">
                <input type="button" value="인증번호 확인" onclick="verifyCode()">
            </div>
            <div class="button-group">
                <button type="button" class="btn">다음</button>
                <button type="button" class="btn btn-secondary">취소</button>
            </div>
            </form>
        </div>
    </div>
    </main>
	<script type="text/javascript">
        function sendVerificationCode() {
            const form = document.findid_form;
            const email = form.email.value;
            if (!email.includes("@")) {
                alert("올바른 이메일 주소를 입력하세요.");
                return;
            }
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/user/sendVerificationCode", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert("인증번호가 발송되었습니다. 이메일을 확인하세요.");
                }
            };
            xhr.send("email=" + encodeURIComponent(email));
        }

        function verifyCode() {
            const form = document.findid_form;
            const email = form.email.value;
            const code = form.email_number.value;
            if (code.length !== 6) {
                alert("6자리 인증 코드를 입력하세요.");
                return;
            }
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/user/verifyCode", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    if (xhr.responseText === "success") {
                        alert("인증번호가 확인되었습니다.");
                    } else {
                        alert("잘못된 인증번호입니다.");
                    }
                }
            };
            xhr.send("email=" + encodeURIComponent(email) + "&code=" + encodeURIComponent(code));
        }

        function next_button() {
            const form = document.findid_form;
            if (form.name.value == '') {
                alert('이름을 입력하세요.');
                form.name.focus();  
            } else if (form.email.value == '') {
                alert('이메일을 입력하세요.');
                form.email.focus();
            } else if (form.email_number.value == '') {
                alert('인증번호를 입력하세요.');
                form.email_number.focus();
            } else {
                form.submit();
            }
        }
    </script>
</body>
</html>