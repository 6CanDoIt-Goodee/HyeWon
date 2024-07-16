<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.book.member.event.vo.Event" %>
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
    	 	border-radius : 15px;
    	 	padding : 1% 1.2% 0.7% 1.2%; 
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
            font-size : 100%;
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
                 
                <div class="event_header">
                    <h2 id="event_title"><%= event.getEv_title() %></h2>
                    <p id="event_regdate"><%= event.getEv_regdate().substring(0, 10) %></p>
                    <p id="event_category"><strong>카테고리:</strong> <%= event.getEv_category_name() %></p>
                </div>

                <% if (event.getEv_form() == 2) { %>
                <div class="event_details">
                    <div class="item">
                        <strong>모집 인원:</strong> <%= event.getEvent_quota() %> 명
                    </div>
                    <div class="item">
                        <strong>모집 기간:</strong> <%= event.getEv_start() %> ~ <%= event.getEv_end() %>
                    </div>
                    <div class="item">
                        <strong>이벤트 진행일:</strong> <%= event.getEv_progress() %>
                    </div>
                </div>
                <% } %>
                <hr>
                <div class="event_content">
                    <%= event.getEv_content() %>
                    <img src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="새 이미지" class="event-image">
                </div> 
            </div>
        </main>
    </section>
</body>
</html>
