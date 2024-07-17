<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.book.admin.event.vo.Event" %>
<%@ page import = "com.book.member.user.vo.User" %>
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
            max-width: 900px;
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
         
        #event_btn {
            width: 100%;
            display: block;
            margin: 0 auto;
            padding: 10px 20px;
            font-size: 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            box-sizing: border-box;
        }

        #event_btn:hover {
            background-color: #0056b3;
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
                    <%-- 기본 이벤트일 경우 등록일만 출력 --%>
                    <div class="item">
                        <%= event.getEv_start() %>  ~ <%= event.getEv_end() %>
                    </div>
                </div>
                <% } %>
                <hr>
                <div class="event_content"> 
                <pre id="content_area"><%= event.getEv_content() %></pre>
                    <img src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="새 이미지" class="event-image">
                </div> 
            </div>
            <% 
                User user_event = (User) session.getAttribute("user");
                if (user_event != null) {
            %>
            <button type="button" id="event_btn" onclick="registerEvent('<%= user.getUser_id() %>')">등록</button>
            <% } %>
        </main>
    </section>
 
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
 
</body>
<script>
        function registerEvent(userId) {
            console.log("사용자 번호: " + userId);
            console.log("등록 성공");
        }
 </script>
</html>
