<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.book.admin.event.vo.Event"%>

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
            <section>
                <div class="event_container">
                    <%
                        List<Event> events = (List<Event>) request.getAttribute("events");
                        if (events != null && !events.isEmpty()) {
                            for (int i = 0; i < events.size(); i++) {
                                Event event = events.get(i);
                                String imageUrl = request.getContextPath() + "/upload/event/" + event.getNew_image(); // 이미지 경로

                                // 서버 콘솔에 이벤트 정보 출력
                                System.out.println("Event: " + event);

                                // HTML로 이벤트 정보 출력
                                out.println("<div class='event_info'>");
                                out.println("<p>Event ID: " + event.getEvent_no() + "</p>");
                                out.println("<p>Title: " + event.getEv_title() + "</p>");
                                out.println("<p>Start Date: " + event.getEv_start() + "</p>");
                                out.println("<p>End Date: " + event.getEv_end() + "</p>");
                                out.println("</div>");
                    %>
                        <div class="slide fade">
                            <div class="slide-image-container"> 
                                <img src="<%= imageUrl %>" alt="Image <%= i + 1 %>" class="slide-image">
                            </div>
                            <div class="event_content">
                                <div class="event_title"><%= event.getEv_title() %></div>
                                <div class="event_date"><%= event.getEv_start() %> ~ <%= event.getEv_end() %></div>
                            </div>
                        </div>
                    <% 
                            } // for loop end
                        } else {
                            out.println("<p>No events available.</p>");
                        }
                    %>
                    
                    <a class="prev" onclick="plusSlides(-1)">&#60;</a>
                    <a class="next" onclick="plusSlides(1)">&#62;</a>
                </div>
                
                <script src="resources/js/mainEvent.js"></script>
            </section>
        </main>
    </section>
    
    <script>
    // 슬라이드쇼 스크립트 (이전과 동일)
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
