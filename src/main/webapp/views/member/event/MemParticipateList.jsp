<%@page import="com.book.admin.event.vo.Event"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 이벤트 참여 내역</title>
</head>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
    
<style>
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
	                <h3>사용자 이벤트 참여 내역</h3>
	            </div>
	            <br>
	            <form action="/user/event/parList" method="get">
	                <div class="input-group mb-3">
	                    <input type="text" class="form-control" name="searchKeyword" placeholder="이벤트 제목 검색">
	                    <button class="btn btn-outline-secondary" type="submit">검색</button>
	                </div>
	            </form>
	            <form action="/user/event/parList" method="get" class="mb-3"> 
                    <button class="btn btn-outline-secondary" type="submit">전체</button>
                </form>
	            <div class="event_list">
	                <% if (request.getAttribute("userEvents") == null || ((List<Map<String, String>>) request.getAttribute("userEvents")).isEmpty()) { %>
	                    <p id="list_empty">참여한 이벤트가 없습니다.</p>
	                <% } else { %>
	                    <table class="table table-striped table-bordered">
	                        <thead class="table-light">
	                            <tr>
	                                <th scope="col">번호</th>
	                                <th scope="col">제목</th>
	                                <th scope="col">진행일</th>
	                                <th scope="col">참여 등록일</th>
	                                <th scope="col">등록 상태</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <%
                                    List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("userEvents");
	                            	Event paging = (Event) request.getAttribute("paging");
                                    User user_par = (User) session.getAttribute("user");
                                    int userNo = user_par.getUser_no();
                                    int startRow = (paging.getNowPage() - 1) * paging.getNumPerPage(); // 시작 로우 계산
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    Date currentDate = new Date();
                                    for (int i = 0; i < list.size(); i++) {
                                        Map<String, String> row = list.get(i);
                                        String eventEndDateStr = row.get("event_end");
                                        Date eventEndDate = sdf.parse(eventEndDateStr);
                                        long diffInMillies = Math.abs(currentDate.getTime() - eventEndDate.getTime());
                                        long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
                                %>
                                <tr style="cursor: pointer;" onclick="checkEventEndDate('<%=row.get("event_no")%>', <%=diffInDays%>)">
                                    <td><%=startRow + i + 1%></td>
	                                <td><%=row.get("event_title")%></td>
	                                <td><%=row.get("event_progress").substring(0, 10)%></td>
	                                <td><%=row.get("participate_date").substring(0, 10)%></td>
	                                <td>
	                                    <%
	                                        String participateState = row.get("participate_state");
	                                        if ("0".equals(participateState)) {
	                                            out.print("등록");
	                                        } else if ("1".equals(participateState)) {
	                                            out.print("대기");
	                                        }  
	                                    %>
	                                </td>
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
	            if (paging.isPrev()) {
	        %>
	            <a href="/user/event/parList?nowPage=<%=(paging.getPageBarStart() - 1)%>">
	                &laquo;
	            </a>
	        <%
	            }
	
	            for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) {
	        %>
	            <a href="/user/event/parList?nowPage=<%=i%>"
	                <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
	            </a>
	        <%
	            }
	
	            if (paging.isNext()) {
	        %>
	            <a href="/user/event/parList?nowPage=<%=(paging.getPageBarEnd() + 1)%>">&raquo;</a>
	        <%
	            }
	        %>
	    </div>
	</div>
	<%
	    }
	%>
	<script>
	    function checkEventEndDate(eventNo, diffInDays) {
	        if (diffInDays > 30) {
	            alert("종료된 이벤트입니다.");
	        } else {
	            location.href = '/user/event/detail?eventNo=' + eventNo;
	        }
	    }
	</script>
</body>
</html>
