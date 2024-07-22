<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>6캔두잇</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <link rel="stylesheet"
     href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * {
            background-color: rgb(247, 247, 247);
            box-sizing: border-box;
            margin: 0;
            font-family: 'Ownglyph_meetme-Rg';
        }
        body {
            background-color: rgb(247, 247, 247);
        }
        ul, ol {
            list-style: none;
        }
        #main_logo {
            font-size: 30px;
            color: rgb(146, 136, 107);
            text-decoration: none;
            font-family: "NanumSquare", sans-serif;
            background-color: rgb(255, 255, 255);
        }
        .header_list {
            text-decoration: none;
            color: #000000;
            font-size: 15px;
            font-weight: 800;
        }
        .main_header > header > #header_nav {
            background-color: rgb(255, 255, 255);
            border-bottom: #b3b3b3c4 1px solid;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }
        nav {
            width: 100%;
            height: 90px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .header_list {
            background-color: white;
        }
        #header_nav > a {
            font-weight: 900;
            padding: 0 30px;
            background-color: rgb(255, 255, 255);
        }
        #header_nav > ul {
            display: flex;
            background-color: rgb(255, 255, 255);
        }
        #header_nav > ul li {
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
        #section_wrap {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .center {
            text-align: center;
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
        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }



        /* 링크 스타일 */
        a {
            text-decoration: none;
            color: black;
            background-color: rgba(0, 0, 0, 0);
            transition: color 0.3s;
        }
        a:hover {
            color: #333;
        }
        /* 독후감 */
        .book_table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .book_table th, .book_table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .book_table th {
            background-color: #f2f2f2;
        }
        .search {
            display: flex;
            justify-content: center;
            align-items: left;
            margin-bottom: 20px;
            background-color:white;
            width:100%;
            gap:2vw;
        }
        .search_board_form {
            display: flex;
            gap: 10px;
            align-items: center;
                   background-color:white;
        }
        .search input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
              width:55vw;
        }
        .search select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .search input[type="submit"] {
            background-color: rgb(224, 195, 163);
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            text-align: center; /* 수평 중앙 정렬 */
             justify-content: center;
            border-radius: 4px;
            width: 6vw;
        }
        .search input[type="submit"]:hover {
            background-color: gray;

        }
        @media (max-width: 768px) {
            .book_table th, .book_table td {
                padding: 6px;
            }
            .search input[type="text"] {
                width: 100%;
            }
        }
       .fa-book-open {
          font-size: 12vw;
       }
       .apply_info {
          display: flex;
          flex-direction: column; /* 세로 방향으로 배치 */
          align-items: center; /* 수평 중앙 정렬 */
          justify-content: center; /* 수직 중앙 정렬 (높이에 따라) */
          background-color: white;
          text-align: center; /* 텍스트 중앙 정렬 */
        }
        .apply_info > div{
            background-color : white;
            }
        .search_board_form >button{
            width : 3vw;
            height : 3vw;
            border : none;
            border-radius : 2px;
        }
    </style>
</head>

<body>
<% Boolean success = (Boolean) request.getAttribute("success"); %>
<% if (success != null && success) { %>
    <script type="text/javascript">
        alert("도서신청이 완료되었습니다.");
    </script>
<% } %>
   <%@ include file="../../include/header.jsp" %>
<%@page import="com.book.admin.book.vo.ApplyBook, java.util.*" %>
<section>

    <div id="section_wrap" class="container">
        <div class="apply_info">
            <div>
                <i class="fa-solid fa-book-open" ></i>
            </div>
            <div>
                <p style="font-size : 1.5vw; background-color: white;">도서 신청하기 버튼을 누르고<br>원하시는 도서를 신청해보세요!</p>
                <p style="font-size : 0.8vw; background-color: white;">신청 전 등록 여부를 먼저 확인하신 후 신청하시길 바랍니다.</p>
            </div>
        </div>
        <div class="search">

            <form class="search_board_form" action="/book/applyList" method="get">
                <input type="text" name="apply_bk_title" placeholder="신청도서이름을 입력해주세요">
                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>
             <form class="search_board_form" action="/book/apply" method="get">
             <button type="submit"><i class="fa-solid fa-plus"></i></button>

             </form>
        </div>
        <table class="book_table">
            <thead>
                <tr>

                    <th>도서이름</th>
                     <th>저자</th>
                    <th>출판사</th>
                    <th>신청한 사용자</th>
                </tr>
            </thead>
            <tbody>
                <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
                 if (list != null && !list.isEmpty()) {
                   for (Map<String, String> row : list) { %>
                    <tr>
                        <td><%= row.get("apply_bk_title") %></td>
                        <td><%= row.get("apply_bk_author") %></td>
                        <td><%= row.get("apply_bk_publisher") %></td>
                        <td><%= row.get("user_nickname") %></td>
                    </tr>
                <% }
                 } else {%>
                <div class="no-results">검색한 결과가 없습니다.</div>
            <% } %>
            </tbody>
        </table>
    </div>
</section>
<% ApplyBook paging = (ApplyBook)request.getAttribute("paging");%>
<% if(paging != null){ %>
    <div class="center">
        <div class="pagination">
            <% if(paging.isPrev()){ %>
                <a href="/book/applyList?nowPage=<%=(paging.getPageBarStart()-1)%>">&laquo;</a>
            <%}%>
            <% for(int i = paging.getPageBarStart() ; i <= paging.getPageBarEnd() ; i++) {%>
                <a href="/book/applyList?nowPage=<%=i%>"
                   <%=paging.getNowPage() == i ? "class='active'" : ""%>>
                    <%=i%>
                </a>
            <%}%>
            <% if(paging.isNext()){%>
                <a href="/book/applyList?nowPage=<%=(paging.getPageBarEnd()+1)%>">&raquo;</a>
            <%}%>
        </div>
    </div>
<% } %>
</body>
</html>
