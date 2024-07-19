<%@page import="com.book.common.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.book.admin.event.vo.Event" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>참여자 목록</title> 
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
	            <!-- Select Box 추가 -->
	            <div>
	                <form action="/event/parList" method="post">
	                    <label for="eventTitle">이벤트 제목 선택:</label>
	                    <select name="eventTitle" id="eventTitle">
	                        <option value="">전체</option>
	                        <% 
	                            LocalDate currentDate = LocalDate.now();
	                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	                            List<Map<String, String>> eventTitles = (List<Map<String, String>>) request.getAttribute("eventTitles");
	                            for (Map<String, String> event : eventTitles) {
	                                LocalDate eventDate = LocalDate.parse(event.get("event_progress").substring(0, 10), formatter);
	                                if (eventDate.isAfter(currentDate) || eventDate.isEqual(currentDate)) {
	                        %>
	                        <option value="<%=event.get("event_title")%>" <%= event.get("event_title").equals(request.getAttribute("eventTitles")) ? "selected" : "" %>><%=event.get("event_title")%></option>
	                        <%  
	                                }
	                            }
	                        %>
	                    </select>
	                    <input type="submit" value="검색">
	                </form>
	            </div> 

	            <div class="event_info">
				    <% if (request.getAttribute("selectedEvent") != null) { %>
				        <h4>선택된 이벤트 정보</h4>
				        <% Map<String, String> selectedEvent = (Map<String, String>) request.getAttribute("selectedEvent"); %>
				        <p>이벤트 제목: <%= selectedEvent.get("event_title") %></p>
				        <p>모집 기간: <%= selectedEvent.get("event_start").substring(0, 10) %> ~ <%= selectedEvent.get("event_end").substring(0, 10) %></p>
				        <p>참여 현황: <%= selectedEvent.get("event_registered") %> / <%= selectedEvent.get("event_quota") %></p>
				        <p>대기 인원: <%= selectedEvent.get("event_waiting") %></p>
				    <% } %>
				</div>

	             
	            <div class="event_list">
	                <% if (request.getAttribute("userEvents") == null || ((List<Map<String, String>>) request.getAttribute("userEvents")).isEmpty()) { %>
	                    <p id="list_empty">참여자가 존재하지 않습니다.</p>
	                <% } else { %>
	                    <table class="table table-striped table-bordered">
	                        <thead class="table-light">
	                            <tr>
	                                <th scope="col">번호</th>
	                                <th scope="col">이름</th>
	                                <th scope="col">제목</th>
	                                <th scope="col">진행일</th>
	                                <th scope="col">참여 등록일</th>
	                                <th scope="col">등록 상태</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <% 
	                                List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("userEvents"); 
	                                for (int i = 0; i < list.size(); i++) {
	                                    Map<String, String> row = list.get(i);
	                            %>
	                            <tr style="cursor: pointer;" onclick="location.href='/event/detail?eventNo=<%=row.get("event_no")%>&eventType=<%=row.get("event_form")%>'">
	                                <td><%=i + 1%></td>
	                                <td><%=row.get("user_name")%></td>
	                                <td><%=row.get("event_title")%></td>
	                                <td><%=row.get("event_progress").substring(0, 10)%></td>
	                                <td><%=row.get("participate_date")%></td>
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
   <div class="center">
    	<div class="pagination">
        	<% 
	            Paging paging = (Paging) request.getAttribute("paging");
	            if (paging != null) {
	                int nowPage = paging.getNowPage();
	                int totalPage = paging.getTotalPage();
	                int pageBlock = 5;  
	                int startPage = ((nowPage - 1) / pageBlock) * pageBlock + 1;
	                int endPage = startPage + pageBlock - 1;
	                if (endPage > totalPage) {
	                    endPage = totalPage;
	                }
	        %> 
                <% if (startPage > 1) { %> 
                    <a href="/event/parList?nowPage=<%= startPage - 1 %>">&laquo;</a> 
                <% } %>
                <% for (int i = startPage; i <= endPage; i++) { %>
	                 <a href="/event/parList?nowPage=<%= i %>"
		                <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
		            </a> 
                <% } %>
                <% if (endPage < totalPage) { %> 
                	<a href="/event/parList?nowPage=<%= endPage + 1 %>">&raquo;</a> 
                <% } %>
            </ul>
        </nav>
        <% } %>
    </div>
</div>

</body>
</html>
