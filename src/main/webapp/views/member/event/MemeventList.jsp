<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.book.admin.event.vo.Event" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 목록</title> 
</head>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
<style>
	body { 
            font-family: 'LINESeedKR-Bd';
            background-color: rgb(247, 247, 247);  
     }
     
     main {
         max-width: 1200px;
         margin: 2rem auto;
         padding: 1rem 1rem; 
         background-color: white; 
         box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
         border-radius: 20px;
     }
	/* Heading styling */
	.event_list table tbody td a {
	    text-decoration: none; /* 밑줄 제거 */
	    color: black; /* 글자 색상 검은색으로 설정 */
	    background-color:rgba(0, 0, 0, 0);
	}
	
	#section_wrap {
		background-color:rgba(0, 0, 0, 0);
	}
		
	/* Heading styling */
	.book_list table tbody td a {
	    text-decoration: none; /* 밑줄 제거 */
	    color: black; /* 글자 색상 검은색으로 설정 */
	}
	
	/* Heading styling */
	.word h3 {
	    color: black;
	    font-size: 24px;
	    margin-bottom: 10px;
	}
	
	/* Table styling */
	.event_list table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
	    background-color: white; /* 테이블 배경색을 흰색으로 설정 */
	}
	
	.event_list table th, .book_list table td {
	    padding: 10px;
	    text-align: center;
	    border: 1px solid #ddd;
	}
	
	.event_list table th {
	    background-color: #f2f2f2;
	    font-weight: bold;
	}
	
	.event_list table tr {
	    color: black;
	}
	
	/* paging */
	@charset "UTF-8";
	
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
	
	#list_empty {
		text-align: center;
		padding : 10%;
	}
</style>
<body>
    <%@ include file="../../include/header.jsp" %>
    <li><a href="/event/list" class="header_list">목록</a></li> 
    <li><a href="/event/create" class="header_list">등록</a></li> 
    <section>
    	<main>
	        <div id="section_wrap" class="container">
	            <div class="word">
	                <h3>이벤트 목록</h3>
	            </div>
	            <br>
	            <form action="/event/list" method="get">
	                <label for="listCategory">카테고리:</label>
	                <select name="listCategory" id="listCategory">
	                    <option value="">전체</option>
	                    <option value="1" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("1")) ? "selected" : "" %>>기본</option>
	                    <option value="2" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("2")) ? "selected" : "" %>>선착순</option>
	                    <option value="3" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("3")) ? "selected" : "" %>>신간도서</option>
	                    <option value="4" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("4")) ? "selected" : "" %>>독서 마라톤</option>
	                    <option value="5" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("5")) ? "selected" : "" %>>챌린지</option>
	                    <option value="6" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("6")) ? "selected" : "" %>>작가 초청</option>
	                </select> 
	                <input type="text" id="evTitle" name="evTitle">
	                <button type="submit">검색</button>
	            </form>
	            <div class="event_list">
	                <% if (request.getAttribute("resultList") == null || ((List<Map<String, String>>) request.getAttribute("resultList")).isEmpty()) { %>
	                    <p id="list_empty">존재하는 이벤트가 없습니다.</p>
	                <% } else { %>
	                    <table class="table table-striped table-bordered">
	                        <thead class="table-blight">
	                            <tr>
	                                <th scope="col">번호</th>
	                                <th scope="col">제목</th>
	                                <th scope="col">등록일</th>
	                                <th scope="col">유형</th>
	                                <th scope="col">카테고리명</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <%
	                                List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
	                                int pageSize = 10; // 한 페이지에 표시할 항목 수
	                                int nowPage = request.getParameter("nowPage") == null ? 1 : Integer.parseInt(request.getParameter("nowPage"));
	                                int startNo = (nowPage - 1) * pageSize + 1;
	                                for (int i = 0; i < list.size(); i++) {
	                                    Map<String, String> row = list.get(i);
	                            %>
	                            <tr style="cursor: pointer;" onclick="location.href='/user/event/detail?eventNo=<%=row.get("event_no")%>&eventType=<%=row.get("event_form")%>'">
	                                <td><%=startNo + i%></td>
	                                <td><%=row.get("event_title")%></td>
	                                <td><%=row.get("event_regdate")%></td>
	                                <td>
	                                    <%
	                                        int evForm = Integer.parseInt(row.get("event_form"));
	                                        if (evForm == 1) {
	                                            out.print("기본");
	                                        } else if (evForm == 2) {
	                                            out.print("선착순");
	                                        }
	                                    %>
	                                </td>
	                                <td><%=row.get("event_category_name")%></td>
	                            </tr>
	                            <% } %>
	                        </tbody>
	                    </table>
	                <% } %>
	            </div>
	        </div>
	      </main>
    </section>
    <%
	    Event paging = (Event) request.getAttribute("paging");
	    if (paging != null) {
	%>
	<div class="center">
	    <div class="pagination">
	        <%
	            String listCategory = request.getParameter("listCategory");
	            if (listCategory == null) {
	                listCategory = "";
	            }
	
	            if (paging.isPrev()) {
	        %>
	            <a href="/event/list?listCategory=<%=listCategory%>&nowPage=<%=(paging.getPageBarStart() - 1)%>">
	                &laquo;
	            </a>
	        <%
	            }
	
	            for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) {
	        %>
	            <a href="/event/list?listCategory=<%=listCategory%>&nowPage=<%=i%>"
	                <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
	            </a>
	        <%
	            }
	
	            if (paging.isNext()) {
	        %>
	            <a href="/event/list?listCategory=<%=listCategory%>&nowPage=<%=(paging.getPageBarEnd() + 1)%>">&raquo;</a>
	        <%
	            }
	        %>
	    </div>
	</div>
	<%
	    }
	%>

</body>
</html>
