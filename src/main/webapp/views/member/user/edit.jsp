<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.book.member.user.vo.User" %> <!-- 임포트 해서 유저 아이디 네임 값 가져오기 위해  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<link href='../../resources/css/member/user/edit.css' rel="stylesheet" type="text/css">
</head>
<body>
	 <section id="left">
            <ol id="my">
                <li>나의 정보</li>
                <li>팔로잉 목록</li>
                <li>독후감 목록
                    <ul>
                        <li>작성된 독후감</li>
                        <li>나만 보기</li>
                    </ul>
                </li>
                <li>이벤트 참여 내역</li>
                <li>문의 사항
                    <ul>
                        <li>문의 사항 작성</li>
                        <li>문의 사항 목록</li>
                    </ul>
                </li>
            </ol>
        </section>
        <section id="right">
            <div id="main_div">
            <form action='/user/editEnd' name="modify_account_form" method="post">
            <%User u= (User)session.getAttribute("user");%>
                <label for="id">아이디</label>
                <input type="text" name="id" value="<%=u.getUser_id() %>" readonly disabled>
                <label for="pw">비밀번호</label>
                <input type="password" name="pw" placeholder="비밀번호를 입력해주세요">
                <label for="chpw">비밀번호 확인</label>
                <input type="password" name="chpw" placeholder="비밀번호를 입력해주세요">
                <label for="name">이름</label>
                <input type="text" name="name" placeholder="이름을 입력해주세요">
                <label for="nickname">닉네임</label>
                <input type="text" name="nickname" placeholder="닉네임을 입력해주세요">
                <label for="email">E-mail</label>
                <input type="email" name="email" placeholder="이메일을 입력해주세요"><br><br>
                <div>
                    <button onclick="editUserForm();">수정 완료</button>
                    <button>취소</button>
                </div>
                </form>
            </div>
        </section>	
	<script type="text/javascript">
	function editUserForm(){
		const form = document.modify_account_form;
		if(!form.id.value){
			alert("아이디를 확인하세요.");
			form.id.focus();
		}else if(!form.pw.value){
			alert("비밀번호를 입력하세요.")
			form.pw.focus();
		}else if(!form.chpw.value){
			alert("비밀번호 확인을 입력하세요.");
			form.chpw.focus();
		}else if(!form.name.value){
			alert("이름을 입력하세요.");
			form.name.focus();
		}else if(!form.nickname.value){
			alert("닉네임을 입력하세요.");
			form.nickname.focus();
		}else if(!form.email.value){
			alert("이메일을 확인을 입력하세요.");
			form.email.focus();
		}else{
			form.submit();	
			}
		}
</script>
</body>
</html>