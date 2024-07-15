<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 목록</title>
</head>
<body>
    <%@ include file="../include/header.jsp" %> 
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>이벤트 목록</h3>
			</div><br>
			<div class="event_list">
				<table>
					<colgroup>
						<col width="10%">
						<col width="50%">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>등록일</th>
							<th>유형</th>
						</tr>
					</thead>
					<tbody>
						<%@page import="com.book.event.vo.Event, java.util.*" %>
						<%
							List<Event> list = (List<Event>)request.getAttribute("resultList");
							for(int i = 0 ; i < list.size(); i++){ %>
								<tr>
									<td><%=list.get(i).getEvent_no()%></td>
									<td><%=list.get(i).getEv_title()%></td>
									<td><%=list.get(i).getEv_regdate()%></td>
									<td><%=list.get(i).getEv_form()%></td>
								</tr>
						<%}%>
					</tbody>
				</table>
			</div>
		</div>
	</section>	
</body>
</html>