<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href='../../resources/css/member/user/delete.css' rel="stylesheet" type="text/css">
</head>
<body>
    <div class="container">
        <nav class="navbar">
            <a href="/" id="main_logo">Knock Book</a>
        </nav>
        <div class="text-center">
            <h2>회원 탈퇴</h2>
            <hr />
            <strong><p style="margin-top: -10px;">탈퇴 정책</p></strong>
            <p style="margin-top: -12px;">탈퇴한 아이디는 다시 사용할 수 없습니다.</p>
        </div>
        <div>
            <form name="delete_form" action="/user/deleteEnd" method="post">
                <div class="form-group">
                    <div style="width: 150px;font-weight: bold;">현재 아이디 :</div>
                </div>
                <div class="form-group">
                    <label for="pw">현재 비밀번호 :</label>
                    <input type="password" id="pw" name="pw" placeholder="현재 비밀번호">
                </div>
                <div class="button-group">
                    <button type="button" onclick="delete_button();" class="btn">확인</button>
                    <button type="button" class="btn btn-secondary" onclick="location.href='/'">취소</button>
                </div>
            </form>
        </div>
    </div>
    <script>
   	 function delete_button() {
        const form = document.delete_form;
        if (form.pw.value == '') {
            alert('비밀번호를 입력하세요.');
            form.name.focus();  
        } else {
            form.submit();
        	}
    	}
    </script>
</body>
</html>
