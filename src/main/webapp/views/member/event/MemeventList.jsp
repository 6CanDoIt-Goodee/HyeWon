<%@page import="com.book.admin.event.vo.Event"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 목록</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

.header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.header h1 {
	margin: 0;
	margin-right: 20px;
}

.filter-button {
	padding: 10px 20px;
	background-color: #f0f0f0;
	border: none;
	cursor: pointer;
}

.filter-button.active {
	background-color: #007bff;
	color: white;
}

.event-grid {
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	gap: 20px;
}

.event-item {
	border: 1px solid #ccc;
	padding: 10px;
	width: 300px;
}

.event-image {
	background-color: #f0f0f0;
	height: 150px;
	width: 300px;
	margin-bottom: 10px;
}

.event-title {
	font-weight: bold;
	margin-bottom: 5px;
}

.event-date {
	color: #666;
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

#list_empty {
	text-align: center;
	padding: 10%;
}
</style>
</head>
<body>
<%@ include file="../../include/header.jsp" %>
	<div class="header">
		<h1>이벤트 목록</h1>
		<button
			class="filter-button <%= "ongoing".equals(request.getParameter("status")) ? "active" : "" %>"
			onclick="location.href='/user/event/list?status=ongoing'">진행중</button>
		<button
			class="filter-button <%= "ended".equals(request.getParameter("status")) ? "active" : "" %>"
			onclick="location.href='/user/event/list?status=ended'">종료</button>
	</div>

	<div class="event-grid">
		<%
    List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
    if (list != null) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date now = new Date();  

        for (Map<String, String> row : list) {
            Date eventStart = format.parse(row.get("event_start"));
            Date eventEnd = format.parse(row.get("event_end"));
            boolean isOngoing = !now.before(eventStart) && !now.after(eventEnd);
            String eventForm = row.get("event_form");
            long daysRemaining = (eventEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
            String dday = (daysRemaining >= 0) ? "D-" + daysRemaining : "모집 기간 종료";
            String eventNo = row.get("event_no");
            String eventEndDateStr = format.format(eventEnd); // 종료일 문자열 
    %>
		<div class="event-item">
			<a href="javascript:void(0);"
				onclick="return handleEventClick('<%= eventNo %>', '<%= eventEndDateStr %>');"
				style="cursor: pointer;">
				<div class="event-image">
					<img class="event-image"
						src="<%= request.getContextPath() %>/upload/event/<%= row.get("event_new_image") %>"
						alt="이벤트 이미지">
				</div>
				<div class="event_form">
					<% 
                    if ("1".equals(eventForm)) {
                        out.print("기본");
                    } else if ("2".equals(eventForm)) {
                        out.print("선착순");
                    }  
                %>
				</div>
				<div class="event-dday">
					<%= dday %>
				</div>
				<div class="event-title"><%= row.get("event_title") %></div>
				<div class="event-date">
					<%= eventStart.equals(eventEnd) ? format.format(eventStart) : format.format(eventStart) + " ~ " + format.format(eventEnd) %>
				</div>
			</a>
		</div>
		<%
        }
    } else {
%>
		<div id="list_empty">이벤트가 없습니다.</div>
		<%
    }
%>
	</div>

	<%
    Event paging = (Event) request.getAttribute("paging");
    if (paging != null && paging.getTotalData() > 0) {
%>
	<div class="center">
		<div class="pagination">
			<%
        if (paging.isPrev()) {
        %>
			<a
				href="/user/event/list?status=<%= request.getParameter("status") %>&listCategory=<%= request.getParameter("listCategory") %>&nowPage=<%=(paging.getPageBarStart() - 1)%>">&laquo;</a>
			<%
        }
        for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) {
        %>
			<a
				href="/user/event/list?status=<%= request.getParameter("status") %>&listCategory=<%= request.getParameter("listCategory") %>&nowPage=<%=i%>"
				<%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
			</a>
			<%
        }
        if (paging.isNext()) {
        %>
			<a
				href="/user/event/list?status=<%= request.getParameter("status") %>&listCategory=<%= request.getParameter("listCategory") %>&nowPage=<%=(paging.getPageBarEnd() + 1)%>">&raquo;</a>
			<%
        }
        %>
		</div>
	</div>
	<%
    }
%>

<script>
	function handleEventClick(eventNo, eventEndDate) {
	    // 현재 날짜를 기준으로 종료일 기준 30일 초과 여부 확인
	    var today = new Date();
	    var endDate = new Date(eventEndDate);
	
	    // 30일 차이 계산
	    var timeDiff = endDate.getTime() - today.getTime();
	    var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
	
	    if (daysDiff < -30) {
	        alert('종료된 이벤트입니다.');
	        return false; // 페이지 이동 차단
	    } else {
	        // 이벤트 상세 페이지로 이동
	        window.location.href = '/user/event/detail?eventNo=' + eventNo;
	    }
	    return false; // 페이지 이동 차단
	}
</script>
</body>
</html>
