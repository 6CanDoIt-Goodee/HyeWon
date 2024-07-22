<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 도서 등록</title>

<body>
 <%@ include file="../../include/header.jsp" %>
<main>
    <section id="left">
        <ul id="my">
            <li>회원관리</li>
            <li>이벤트 관리</li>
            <li>도서 / 관리 페이지</li>
            <li>문의 사항 관리 페이지</li>
        </ul>
    </section>
    <section id="right">
        <div class="book_icon">
            <div class="book">
                <form action="/book/createEnd" name="book_request_form" method="post">

                    <label for="img_up">이미지 등록:</label>
                    <input type="text" name="img_up" placeholder="이미지url을 입력하세요">
                    <hr>
                    <label for="book_title">도서명: </label>
                    <input type="text" name="book_title" id="book_title" placeholder="도서명을 입력하세요">
                    <hr>
                    <label for="book_author">저자: </label>
                    <input type="text" name="book_author" id="book_author" placeholder="저자를 입력하세요">
                    <hr>
                    <label for="book_publihser">출판사: </label>
                    <input type="text" name="book_publihser" id="book_publihser" placeholder="출판사를 입력하세요">
                    <hr>
                    <label for="book_category">카테고리: </label>
                    <select name="book_category" id="book_category">
                        <option value="0">선택안함</option>
                        <option value="1">총류</option>
                        <option value="2">철학</option>
                        <option value="3">종교</option>
                        <option value="4">사회과학</option>
                        <option value="5">순수과학</option>
                        <option value="6">기술과학</option>
                        <option value="7">예술</option>
                        <option value="8">언어</option>
                        <option value="9">문학</option>
                        <option value="10">역사</option>
                    </select>
                    <hr>
                    <input type="button" value="등록" onclick="book_plus();">
                    <input type="button" value="취소">
                </form>
            </div>
        </div>
    </section>
</main>
<script>
function book_plus(){
    const form = document.book_request_form;
    if(!form.book_title.value){
        alert("도서명을 입력하세요");
    } else if(!form.book_author.value){
        alert("저자명을 입력하세요");
    } else if(!form.book_publihser.value){
        alert("출판사를 입력하세요");
    } else {
        form.submit();
    }
}
</script>
</body>
</html>