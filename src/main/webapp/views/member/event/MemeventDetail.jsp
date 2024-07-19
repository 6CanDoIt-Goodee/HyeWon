<%@page import="java.io.Console"%>
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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
					    Event event = (Event) request.getAttribute("event");  
					    User user_event = (User) session.getAttribute("user");
					    boolean isRegistered = (boolean) request.getAttribute("isRegistered");
					    int registeredCount = event.getEvent_registered();
					    int participateState = (int) request.getAttribute("participateState");  
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
				
					<!-- 참여 버튼 -->
				    <%
					    System.out.println("등록 인원: " + registeredCount);
					    System.out.println("정원: " + event.getEvent_quota());
					%>
					<% if (user_event != null && event.getEv_form() == 2) { %>
					    <button id="event_btn" type="button" style="display:none;"
					        <% if (isRegistered) { %>
					            style="display:block;"
					        <% } else if (registeredCount >= event.getEvent_quota() && participateState == 1) { %>
					            style="display:block;"
					        <% } else { %>
					            style="display:block;"
					        <% } %>
					        	onclick="toggleRegistration(<%= event.getEvent_no() %>, <%= user_event.getUser_no() %>, <%= participateState %>);">
					        <% if (participateState == 0) { %>
					            참여 취소
					        <% } else if (participateState == 1) { %>
					            대기 취소
					        <% } else if (registeredCount >= event.getEvent_quota()) { %>
					            대기
					        <% } else { %>
					            등록
					        <% } %>
					    </button>
					<% } %> 
				</div>
            </div> 
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


	<script> 
	    // 참여 등록 및 취소 함수
	    function toggleRegistration(eventNo, userNo, participateState) {
	    var button = $("#event_btn");
	    var action = button.text().trim();
	
	    $.ajax({
	        type: "POST",
	        url: "<%=request.getContextPath()%>/user/event/par",
	        data: { 
	            "event_no": eventNo, 
	            "user_no": userNo, 
	            "action": action,
	            "participate_state": participateState 
	        },
	        success: function(response) {
	            // 버튼 상태 업데이트
	            if (action === "등록") {
	                button.text("참여 취소");
	                button.attr("onclick", `toggleRegistration(${eventNo}, ${userNo}, ${participateState})`);
	            } else if (action === "참여 취소") {
	                button.text("등록");
	                button.attr("onclick", `toggleRegistration(${eventNo}, ${userNo}, ${participateState})`);
	            } else if (action === "대기") {
	                button.text("대기 취소");
	                button.attr("onclick", `toggleRegistration(${eventNo}, ${userNo}, ${participateState})`);
	            } else if (action === "대기 취소") {
	                button.text("대기");
	                button.attr("onclick", `toggleRegistration(${eventNo}, ${userNo}, ${participateState})`);
	            }
	            alert(action + " 성공");
	            location.reload(); // 페이지 새로고침
	        }
	    });
	}

    
	    $(document).ready(function() {
	        // 콘솔 출력
	        console.log("등록 인원:", <%= registeredCount %>);
	        console.log("정원:", <%= event.getEvent_quota() %>); 

	        // 모집 기간 확인
	        var eventStart = new Date("<%= event.getEv_start() %>");
	        var eventEnd = new Date("<%= event.getEv_end() %>");
	        var currentDate = new Date();

	        // 이벤트 유형이 2인 경우 모집 기간에만 버튼 표시
	        if (<%= event.getEv_form() %> === 2) {
	            if (currentDate >= eventStart && currentDate <= eventEnd) {
	                $("#event_btn").show();
	            } else {
	                $("#event_btn").hide();
	            }
	        }
	    });
	</script> 


</body>
</html>
