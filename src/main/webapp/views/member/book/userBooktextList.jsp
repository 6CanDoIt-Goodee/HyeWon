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
    <style>
        * {
            background-color: rgb(247, 247, 247);
            box-sizing: border-box;
            margin: 0;
            font-family: 'Ownglyph_meetme-Rg';
        }
        body{
              background-color: rgb(247, 247, 247);
        }


        /* header */
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

        /* 검색 바 스타일 */
        .search {
            margin-bottom: 20px;
            text-align: center;
        }

        .search input[type="text"] {
            padding: 0.8vw;
            width: 5vw;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .search input[type="submit"] {
            background-color: rgb(224, 195, 163);
            color: white;
            border: none;
            padding: 8px 16px;
            text-decoration: none;
            margin-left: 5px;
            cursor: pointer;
            border-radius: 4px;
        }

        .search input[type="submit"]:hover {
            background-color: gray;
        }

        /* 링크 스타일 */
        a {
            text-decoration: none; /* 밑줄 제거 */
            color: black; /* 글자 색상 검은색으로 설정 */
            background-color: rgba(0, 0, 0, 0);
            transition: color 0.3s;
        }

        /* 독후감 */
        .book_image {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
             background-color: white;
            gap: 20px;
        }

        .ele_bw {
            width: calc(25% - 20px); /* 한 줄에 4개씩 정렬을 위한 너비 설정 */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: white;
        }
        .ele_bw >div > img{
        width:10vw;
        }
        .ele_bw > div{
            text-align:center;
            background-color: white;
        }
        .ele_bw a {
            display: block;
            margin-top: 1vw;
        }
.search {
    width:100%;
    display: flex;
    justify-content: center; /* 중앙 정렬 */
    align-items: center; /* 수직 정렬 */
    margin-bottom: 20px;
    background-color:white;
}

.search_board_form {
    display: flex;
    gap: 10px; /* 폼 요소 간의 간격 */
    align-items: center; /* 수직 정렬 */
    width:40vw;
    background-color:white;
}

.search input[type="text"] {
    padding: 10px;
    width: 30vw; /* 고정 너비 */
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.search select {
    padding: 10px;
    margin-left:15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    width: 8vw;
}

.search input[type="submit"] {
    background-color: rgb(224, 195, 163);
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 4px;
    width:5vw;
    font-size:1vw;
}
.search input[type="submit"]:hover {
    background-color: gray;
}

        @media (max-width: 768px) {
            .ele_bw {
                width: calc(50% - 20px); /* 화면이 작을 때는 2개씩 정렬 */
            }
        }

    </style>
 <script>
        $(document).ready(function() {
            $("select[name='recommendation']").change(function() {
                var recommendation = $(this).val();
                var url = "/user/textList";
                if (recommendation !== "") {
                    url += "?recommendation=" + recommendation;
                }
                window.location.href = url;
            });
        });
    </script>
</head>

<body>
<% Boolean success = (Boolean) request.getAttribute("success"); %>
<% if (success != null && success) { %>
    <script type="text/javascript">
        alert("작성이 완료되었습니다.");
    </script>
<% } %>
   <%@ include file="../../include/header.jsp" %>

<section>

    <div id="section_wrap" class="container">
        <div class="search">
            <form action="/user/textList" name="search_board_form" method="get" class="search_board_form">
                <input type="text" name="bw_content" value="<%= request.getAttribute("searchContent") %>" placeholder="검색하고자 하는 도서 이름을 검색하세요.">
                <input type="submit" value="검색">
                <select name="recommendation" onchange="this.form.submit()">
                                <option value="" <% if ("".equals(request.getParameter("recommendation"))) { %> selected <% } %>>추천도</option>
                                <option value="5" <% if ("5".equals(request.getParameter("recommendation"))) { %> selected <% } %>>매우좋음</option>
                                <option value="4" <% if ("4".equals(request.getParameter("recommendation"))) { %> selected <% } %>>좋음</option>
                                <option value="3" <% if ("3".equals(request.getParameter("recommendation"))) { %> selected <% } %>>보통</option>
                                <option value="2" <% if ("2".equals(request.getParameter("recommendation"))) { %> selected <% } %>>나쁘지않음</option>
                                <option value="1" <% if ("1".equals(request.getParameter("recommendation"))) { %> selected <% } %>>별로</option>
                            </select>
            </form>

        </div>
        <div class="book_list">
            <div class="book_image">
                <%@page import="com.book.member.book.vo.BookText, java.util.*" %>
                <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
                  if (list != null && !list.isEmpty()) {
                   for (Map<String, String> row : list) { %>

                    <div class="ele_bw">
                        <div><img src="<%= row.get("bk_img") %>" alt="책 이미지"></div>
                        <div><%= row.get("bt_writer") %></div>
                        <div><a href="/book/detail?bt_no=<%=row.get("bt_no")%>"><%= row.get("bk_title")%></a></div>
                    </div>
                <% }
                 }else {%>
                 <div class="no-results">검색한 결과가 없습니다.</div>
              <% } %>
            </div>
        </div>
    </div>
</section>
<% BookText paging = (BookText)request.getAttribute("paging");%>
<% if(paging != null){ %>
    <div class="center">
        <div class="pagination">
            <% if(paging.isPrev()){ %>
                <a href="/user/textList?nowPage=<%=(paging.getPageBarStart()-1)%>">&laquo;</a>
            <%}%>
            <% for(int i = paging.getPageBarStart() ; i <= paging.getPageBarEnd() ; i++) {%>
                <a href="/user/textList?nowPage=<%=i%>"
                   <%=paging.getNowPage() == i ? "class='active'" : ""%>>
                    <%=i%>
                </a>
            <%}%>
            <% if(paging.isNext()){%>
                <a href="/user/textList?nowPage=<%=(paging.getPageBarEnd()+1)%>">&raquo;</a>
            <%}%>
        </div>
    </div>
<% } %>
</body>
</html>