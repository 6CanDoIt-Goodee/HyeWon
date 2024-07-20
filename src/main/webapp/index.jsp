<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.book.admin.event.vo.Event"%>
<%@ page import="com.book.admin.event.dao.EventDao" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>6캔두잇</title>
<link href="resources/css/include/main.css" rel="stylesheet" type="text/css">
<link href="resources/css/include/main_event.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file="views/include/header.jsp" %> 
    <!-- 검색 -->
    <section>
        <main>
            <section class="event-section">
	        <div class="event-container">
	            <%
	                List<Map<String, String>> events = EventDao.getAllEvents();
	                if (events != null && !events.isEmpty()) {
	                    for (int i = 0; i < events.size(); i++) {
	                        Map<String, String> event = events.get(i);
	                        String eventNo = event.get("event_no");
	                        String imageUrl = request.getContextPath() + "/upload/event/" + event.get("event_new_image");
	                        String eventTitle = event.get("event_title");
	                        String eventStart = event.get("event_start").substring(0, 10);
	                        String eventEnd = event.get("event_end").substring(0, 10);
	                        String eventForm = event.get("event_form"); 
	            %> 
	            
                    <div class="slide fade">
                        <a href="<%= request.getContextPath() %>/user/event/detail?eventNo=<%= eventNo %>&eventType=<%= eventForm %>">
                            <div class="slide-image-container"> 
                                <img src="<%= imageUrl %>" alt="Image <%= i + 1 %>" class="slide-image">
                            </div>
                            <div class="event_content">
                                <div class="event_title"><%= eventTitle %></div>
                                <div class="event_date">
                                    <%= eventStart.equals(eventEnd) ? eventStart : eventStart + " ~ " + eventEnd %>
                                </div>
                                <% if ("2".equals(eventForm)) { %>
                                    <div class="event_form">선착순</div>
                                <% } %>
                            </div>
                        </a>
                    </div>
	            <%
	                    }  
	                } else {
	            %>
	                    <p>진행 중인 이벤트가 없습니다.</p>
	            <%
	                }
	            %>
	            <a class="prev" onclick="plusSlides(-1)">&#60;</a>
	            <a class="next" onclick="plusSlides(1)">&#62;</a>
	        </div>
	    </section>
	        </main>
    </section>
    
    <script> 
	    let slideIndex = 0;
	    let slides = document.getElementsByClassName("slide");
	    let intervalId;
	
	    function startSlideShow() {
	        showSlides(slideIndex);
	        intervalId = setInterval(() => {
	            slideIndex++;
	            showSlides(slideIndex);
	        }, 3000);
	    }
	
	    function showSlides(n) {
	        if (n >= slides.length) {
	            slideIndex = 0;
	        } else if (n < 0) {
	            slideIndex = slides.length - 1;
	        }
	
	        for (let i = 0; i < slides.length; i++) {
	            slides[i].style.display = "none";
	        }
	
	        slides[slideIndex].style.display = "block";
	    }
	
	    function plusSlides(n) {
	        clearInterval(intervalId);
	        let newIndex = slideIndex + n;
	
	        if (newIndex >= slides.length) {
	            slideIndex = 0;
	        } else if (newIndex < 0) {
	            slideIndex = slides.length - 1;
	        } else {
	            slideIndex = newIndex;
	        }
	
	        showSlides(slideIndex);
	        startSlideShow(); // 이전/다음 버튼 클릭 시 자동 슬라이드 재시작
	    }
	
	    startSlideShow();
    </script>
</body>
</html>
