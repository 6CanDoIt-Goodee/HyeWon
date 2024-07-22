<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>회원 테이블</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .search {
            margin-bottom: 20px;
        }
        .search input[type="text"] {
            width: 80%;
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .search input[type="submit"] {
            padding: 10px 20px;
            border: none;
            background-color: #5cb85c;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .search input[type="submit"]:hover {
            background-color: #4cae4c;
        }
        .book_list {
            margin-top: 20px;
        }
        .book_table {
            width: 100%;
            border-collapse: collapse;
        }
        .book_table th, .book_table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .book_table th {
            background-color: #f8f8f8;
        }
        .center {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            padding: 10px 15px;
            margin: 0 5px;
            border: 1px solid #ddd;
            color: #333;
            text-decoration: none;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: #5cb85c;
            color: white;
            border-color: #5cb85c;
        }
        .pagination a:hover {
            background-color: #4cae4c;
            color: white;
        }
    </style>
</head>
<body>
<section>
    <div id="section_wrap" class="container">
         <form action="/user/check_table" method="get">
            <input type="submit" value="Load Users">
        </form>
        

        <div class="book_list">
            <table class="book_table">
                <thead>
                    <tr>
                        <th>이미지</th>
                        <th>닉네임</th>
                        <th>아이디</th>
                        <th>이메일</th>
                        <th>회원가입 일시</th>
                        <th>비활성화 여부</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Map<String, Object>> list = (List<Map<String, Object>>) session.getAttribute("user");

                        if (list != null) {
                            for (Map<String, Object> row : list) { 
                    %>
                    <tr>
                        <td><%= row.get("user_name") %></td>
                        <td><%= row.get("user_nickname") %></td>
                        <td><%= row.get("user_id") %></td>
                        <td><%= row.get("user_email") %></td>
                        <td><%= row.get("user_create") %></td>
                        <td><%= row.get("user_active") %></td>
                    </tr>
                    <% 
                            } 
                        } else { 
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center;">No data found.</td>
                    </tr>
                    <% 
                        } 
                    %>
                </tbody>
            </table>
        </div>
    </div>
</section>
<%-- <% BookText paging = (BookText)request.getAttribute("paging");%>

<% if(paging != null){ %>
    <div class="center">
        <div class="pagination">
            <% if(paging.isPrev()){ %>
                <a href="/user/saveTextList?nowPage=<%=(paging.getPageBarStart()-1)%>">&laquo;</a>
            <%}%>
            <% for(int i = paging.getPageBarStart() ; i <= paging.getPageBarEnd() ; i++) {%>
                <a href="/user/saveTextList?nowPage=<%=i%>"
                   <%=paging.getNowPage() == i ? "class='active'" : ""%>>
                    <%=i%>
                </a>
            <%}%>
            <% if(paging.isNext()){%>
                <a href="/user/saveTextList?nowPage=<%=(paging.getPageBarEnd()+1)%>">&raquo;</a>
            <%}%>
        </div>
    </div>
<% } %> --%>
</body>
</html>