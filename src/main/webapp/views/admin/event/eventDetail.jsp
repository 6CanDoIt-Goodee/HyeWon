<%@page import="com.book.common.Paging"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.book.admin.event.vo.Event" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트 상세 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

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

        #event_Type {
            background-color: rgb(255, 232, 186);
            border-radius: 15px;
            padding: 1% 1.2% 0.7% 1.2%;
            margin-right: 2%;
        }

        #event_category {
            background-color: rgba(0,0,0,0);
        }

        .eventDeatil_main {
            padding: 2% 4%;
            background-color: rgba(0,0,0,0);
        }

        #event_title {
            text-align: center;
            margin-bottom: 1rem;
            background-color: rgba(0,0,0,0);
        }

        .event_header {
            text-align: center;
            margin-bottom: 3%;
            background-color: rgba(0,0,0,0);
        }

        #event_regdate {
            text-align: right;
            margin-bottom: 3%;
            font-size: 100%;
            background-color: rgba(0,0,0,0);
        }

        .event_details {
            margin-bottom: 3%;
            background-color: rgba(0,0,0,0);
        }

        .event_details .item {
            margin-bottom: 10px;
        }

        .event_content {
            margin-top: 3%;
            background-color: rgba(0,0,0,0);
        }

        .event-image {
            display: block;
            margin: 5% auto 2% auto;
            max-width: 100%;
            height: auto;
        }

        .btn-group {
            text-align: center;
            margin-top: 20px;
        }

        .btn {
            margin-right: 10px;
        }
        
        #content_area {
        	font-size : 1vw;
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
</head>
<body>
    <%@ include file="../../include/header.jsp" %>

    <section id="detail_box">
        <main>
            <div class="eventDeatil_main">
                <span id="event_Type">
                    <%
                        Event event = (Event)request.getAttribute("event");  
                    %>
                    <% if (event.getEv_form() == 1) { %>
                         기본
                     <% } else if (event.getEv_form() == 2) { %>
                         선착순
                     <% } %>
                </span>
                <span id="event_category"><%= event.getEv_category_name() %></span>

                <div class="event_header">
                    <h2 id="event_title"><%= event.getEv_title() %></h2>
                    <p id="event_regdate">등록일 : <%= event.getEv_regdate().substring(0, 10) %></p>
                </div>

                <% if (event.getEv_form() == 2) { %>
                <div class="event_details">
                    <div class="item">
                        <strong>모집 인원:</strong> <%= event.getEvent_quota() %> 명
                    </div>
                    <div class="item">
                        <strong>모집 기간:</strong> <%= formatDateString(event.getEv_start()) %> ~ <%= formatDateString(event.getEv_end()) %>
                    </div>
                    <div class="item">
                        <strong>이벤트 진행일:</strong> <%= event.getEv_progress() %>
                    </div>
                </div>
                <% } else { %>
                <div class="event_details">
                    <div class="item"><strong>기간:</strong>
                        <% 
                            if (event.getEv_start().equals(event.getEv_end())) {
                                out.print(event.getEv_start());
                            } else {
                                out.print(event.getEv_start() + " ~ " + event.getEv_end());
                            }
                        %> 
                    </div>
                </div>
                <% } %>
                <hr>
                <div class="event_content"> 
				<pre id="content_area"><%= event.getEv_content() %></pre>
                    <img src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="새 이미지" class="event-image">
                </div>

                <!-- 수정, 삭제 버튼 -->
                <div class="btn-group">
                    <button class="btn btn-primary" onclick="location.href='/event/update?eventNo=<%= event.getEvent_no() %>&eventType=<%= event.getEv_form() %>'">수정</button>
                    <button class="btn btn-danger" onclick="deleteEvent(<%= event.getEvent_no() %>)">삭제</button>
                </div>
            </div>
        </main>
    </section>
    <% if (event.getEv_form() == 2) { %>
   	 	<main id="parUser_box"> 
	        <div class="partic_list">
	            <% 
		        List<Map<String, String>> parUserList = (List<Map<String, String>>) request.getAttribute("parUserList");
		        if (parUserList == null || parUserList.isEmpty()) { 
		    %>
		        <p id="list_empty">참여자가 존재하지 않습니다.</p>
	            <% } else { %>
	                <table class="table table-striped table-bordered">
	                    <thead class="table-light">
	                        <tr>
	                            <th scope="col">번호</th>
	                            <th scope="col">이름</th>  
	                            <th scope="col">참여 등록일</th>
	                            <th scope="col">등록 상태</th>
	                        </tr>
	                    </thead>
	                    <tbody> 
	                        <% 
	                            List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("parUserList"); 
	                            int pageSize = 3; // 한 페이지에 표시할 항목 수
	                            int nowPage = request.getParameter("nowPage") == null ? 1 : Integer.parseInt(request.getParameter("nowPage"));
	                            int startNo = (nowPage - 1) * pageSize + 1;
	                            for (int i = 0; i < list.size(); i++) {
	                                Map<String, String> row = list.get(i);
	                        %>
	                        <tr>
	                            <td><%= startNo + i %></td>
	                            <td><%= row.get("user_name") %></td> 
	                            <td><%= row.get("participate_date") %></td>
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
	                    <a href="/event/detail?eventNo=<%= request.getParameter("eventNo") %>&eventType=<%= request.getParameter("eventType") %>&nowPage=<%= startPage - 1 %>">&laquo;</a> 
	                <% } %>
	                <% for (int i = startPage; i <= endPage; i++) { %>
	                    <a href="/event/detail?eventNo=<%= request.getParameter("eventNo") %>&eventType=<%= request.getParameter("eventType") %>&nowPage=<%= i %>"
	                       <%= paging.getNowPage() == i ? "class='active'" : "" %>> <%= i %>
	                    </a> 
	                <% } %>
	                <% if (endPage < totalPage) { %> 
	                    <a href="/event/detail?eventNo=<%= request.getParameter("eventNo") %>&eventType=<%= request.getParameter("eventType") %>&nowPage=<%= endPage + 1 %>">&raquo;</a> 
	                <% } %>
	                <% } %>
	            </div> 
	        </div> 
		</main>
	    <% } %>

    
 
    <%!
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd a hh:mm");

        String formatDateString(String input) {
            try {
                Date date = inputFormat.parse(input);
                return outputFormat.format(date);
            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }
    %>

    <script> 
      
        // 삭제 버튼 클릭 시 재확인 및 삭제 함수
        function deleteEvent(eventNo) {
            if (confirm('이벤트를 삭제하시겠습니까?')) {
                location.href = '/event/delete?eventNo=' + eventNo;
            }
        }
    </script>
</body>
</html>
