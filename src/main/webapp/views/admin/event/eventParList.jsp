<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
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
	            <div class="event_list">
	                <% if (request.getAttribute("userEvents") == null || ((List<Map<String, String>>) request.getAttribute("userEvents")).isEmpty()) { %>
	                    <p id="list_empty">참여한 이벤트가 없습니다.</p>
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
	                            <tr style="cursor: pointer;" onclick="location.href='/event/detail?eventNo=<%=row.get("event_no")%>'">
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
	                                        } else {
	                                            out.print("알 수 없음");
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
</body>
</html>
