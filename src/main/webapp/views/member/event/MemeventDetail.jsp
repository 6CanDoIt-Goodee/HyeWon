<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.book.admin.event.vo.Event"%>
<%@ page import="com.book.member.user.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트 상세 정보</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'LINESeedKR-Bd';
            background-color: rgb(247, 247, 247);
            margin : 0;
        }

        main {
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem 1rem;
            background-color: white;
            box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
        }

        #event_Type {
            background-color: rgb(255, 232, 186);
            border-radius: 15px;
            padding: 1% 1.2% 0.7% 1.5%;
            margin-right: 2%;
        } 
        
        .eventDeatil_main {
            padding: 2% 4%; 
        }

        #event_title {
            text-align: center;
            margin-bottom: 1rem; 
        }

        .event_header {
            text-align: center;
            margin-bottom: 3%; 
        }

        #event_regdate {
            text-align: right;
            margin-bottom: 3%;
            font-size: 85%;
            color : rgba(28, 28, 28, 1); 
        } 

		.event_details .item {
		    margin-bottom: 8px;  
		}
		
        .event_details .item2 {
		    margin-bottom: 10px; 
		    display: flex;
		    align-items: center;
		    justify-content: space-between; 
		}
        
        .details_content { 
        	margin-left:10%;
        } 
        
        .details_content2 { 
        	margin-left:6%;
        } 
        
        .event_content {
            margin-top: 5%;   
            text-align : center; 
        }

        .event-image {
        	width: 30vw; 
    		height:25vw;
            display: block;
            margin: 5% auto 5% auto; 
            height: auto;
        }  
        
        #content_area {  
        	font-size : 17px;  
        	font-family: 'LINESeedKR-Bd';
        } 
        
		/* paging */
		@charset "UTF-8";
		
		.center {
		    text-align: center; s
		}
		
		.pagination {
		    display: inline-block; 
		}
		
		.pagination a {
		    color: black;
		    float: left;
		    padding: 8px 15px 6px 15px;
		    text-decoration: none;
		    transition: background-color .3s;
		    margin: 2px 4px 0px 4px; 
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
		    padding-top: 60px;
		    background-color: white;
		}
		
		#event_btn {
            width: 100%;
            display: block;
            margin: 0 auto;
            padding: 10px 20px;
            font-size: 17px;
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
        
        #notification_btn {
		    background-color: transparent;
		    border: none;
		    font-size: 1.5rem;
		    cursor: pointer;
		    transition: color 0.3s;
		    align-self: flex-end;
		    margin-left: auto;
		}

		#notification_btn:hover {
		    color: #ffd700;
		}
		
		#notification_btn.active {
		    color: #ffd700;
		}
		
		/* 툴팁 스타일 */
		#notification_btn {
		    position: relative;
		}
		
		#notification_btn::after {
		    content: attr(title);
		    position: absolute;
		    bottom: 100%;
		    left: 50%;
		    transform: translateX(-50%);
		    background-color: rgba(0, 0, 0, 0.8);
		    color: white;
		    padding: 5px 10px;
		    border-radius: 4px;
		    font-size: 12px;
		    white-space: nowrap;
		    opacity: 0;
		    visibility: hidden;
		    transition: opacity 0.3s, visibility 0.3s;
		}
		
		#notification_btn:hover::after {
		    opacity: 1;
		    visibility: visible;
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
                    <p id="event_regdate">등록 &nbsp&nbsp <%= event.getEv_regdate().substring(0, 10) %></p>
                </div>
                 
                <% if (event.getEv_form() == 2) { %>
                    <div class="event_details">
					    <div class="item">
					        모집 인원<span class="details_content"><%= event.getEvent_quota() %> 명</span>
					    </div>
					    <div class="item">
					        모집 기간<span class="details_content"><%= formatDateString(event.getEv_start()) %> ~ <%= formatDateString(event.getEv_end()) %></span>
					    </div>
					    <div class="item2">
					        이벤트 진행일<span class="details_content2"><%= event.getEv_progress() %></span>
					        <!-- 알림 버튼 -->
					        <% if (user_event != null && event.getEv_form() == 2) { %>
					            <button id="notification_btn" type="button" onclick="toggleNotification(<%= event.getEvent_no() %>, <%= user_event.getUser_no() %>);" title="선착순 오픈 1시간 전 이메일 알림이 발송됩니다.">
					                <i id="bell_icon" class="fa-regular fa-bell"></i>
					            </button>
					        <% } %>
					    </div>
					</div>
                <% } else { %>
                <div class="event_details">
                    <div class="event_start">진행 기간 &nbsp&nbsp&nbsp&nbsp
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
                    <% if (user_event != null && event.getEv_form() == 2) { %>
                        <button id="event_btn" type="button"
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
        SimpleDateFormat inputFormat1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        SimpleDateFormat outputFormat1 = new SimpleDateFormat("yyyy-MM-dd a hh:mm");

        String formatDateString1(String input) {
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
        // 참여 등록 및 취소 
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
                    } else if (action === "참여 취소") {
                        button.text("등록");
                    } else if (action === "대기") {
                        button.text("대기 취소");
                    } else if (action === "대기 취소") {
                        button.text("대기");
                    }
                    alert(action + " 성공");
                    location.reload(); // 페이지 새로고침
                }
            });
        }

        $(document).ready(function() {  
            var eventStart = new Date("<%= event.getEv_start() %>");
            var eventEnd = new Date("<%= event.getEv_end() %>");
            var currentDate = new Date();
 
            var eventButton = $("#event_btn");
            var notificationButton = $("#notification_btn");
            
            // 이벤트 시작 1시간 전 시간 계산
            var oneHourBeforeStart = new Date(eventStart.getTime() - (60 * 60 * 1000));

            if (currentDate < eventStart) {
                eventButton.text("모집 예정");
                eventButton.prop("disabled", true);
                
                if (currentDate < oneHourBeforeStart) {
                    notificationButton.show();
                } else {
                    notificationButton.hide();
                }
            } else if (currentDate > eventEnd) {
                eventButton.text("모집 종료");
                eventButton.prop("disabled", true);
                notificationButton.hide();
            } else if (currentDate >= eventStart && currentDate <= eventEnd) {
                if (<%= event.getEv_form() %> === 2) {
                    eventButton.show();
                }
                notificationButton.hide();
            }
            
            /* 알림 버튼 상태 확인 */
            /* 알림 버튼 상태 확인 */
            if (<%= user_event != null %> && currentDate < oneHourBeforeStart) {
                $.ajax({
                    type: "GET",
                    url: "<%=request.getContextPath()%>/user/event/checkNotification",
                    data: { 
                        "event_no": <%= event.getEvent_no() %>, 
                        "user_no": <%= user_event != null ? user_event.getUser_no() : 0 %>
                    },
                    success: function(response) {
                        if (response === "true") {
                            $("#bell_icon").removeClass("fa-regular").addClass("fa-solid");
                            $("#notification_btn").addClass("active");
                        } else {
                            $("#bell_icon").removeClass("fa-solid").addClass("fa-regular");
                            $("#notification_btn").removeClass("active");
                        }
                    } 
                });
            }
        });

        /* 알림 버튼 */
        function toggleNotification(eventNo, userNo) {
            var bellIcon = $("#bell_icon");
            var notificationBtn = $("#notification_btn");
            var action = bellIcon.hasClass("fa-regular") ? "set" : "cancel";

            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/user/event/notification",
                data: { 
                    "event_no": eventNo, 
                    "user_no": userNo, 
                    "action": action
                },
                success: function(response) {
                    if (action === "set") {
                        bellIcon.removeClass("fa-regular").addClass("fa-solid");
                        notificationBtn.addClass("active");
                        alert("알림이 설정되었습니다. 모집 1시간 전 이메일로 알려드릴게요!");
                    } else {
                        bellIcon.removeClass("fa-solid").addClass("fa-regular");
                        notificationBtn.removeClass("active");
                        alert("알림이 취소되었습니다.");
                    }
                } 
            });
        }
    </script>  
</body>
</html>