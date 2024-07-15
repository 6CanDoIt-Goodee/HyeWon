<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <section class="search_section">
                <div class="search_container">
                    <p class="search_title">
                        Welcome to Knock Book!<br>Knock the door to endless stories.
                    </p>
                    <input class="search_input" type="text" placeholder="독후감을 작성할 도서를 검색해 보세요!">
                </div>
            </section> 
            
            <!-- 이벤트 -->
            <section>
                <div class="event_container">
                    <div class="slide fade">
                        <div class="slide-image-container"> 
                            <img src="/semi_test/src/main/webapp/resources/eventImage/a1.jpg" alt="Image 1" class="slide-image">
                        </div>
                        <div class="event_content">
                            <div class="event_title">6캔두잇 출간 기념 무료 나눔</div>
                            <div class="event_date">2024-07-15 ~ 2024-07-22</div>
                        </div>
                    </div>
                    <div class="slide fade">
                        <div class="slide-image-container">
                            <img src="../resources/a2.jpg" alt="Image 2" class="slide-image">
                        </div> 
                        <div class="event_content">
                            <div class="event_title">독서 마라톤</div>
                            <div class="event_date">2024-08-17 ~ 2024-08-22</div>
                        </div>
                    </div>
                    <div class="slide fade">
                        <div class="slide-image-container">
                            <img src="../resources/a3.jpg" alt="Image 3" class="slide-image">
                        </div>
                        <div class="event_content">
                            <div class="event_title">김채앵 작가 온라인 강연</div>
                            <div class="event_date">2024-09-27</div>
                        </div>
                    </div>
                    
                    <a class="prev" onclick="plusSlides(-1)">&#60;</a>
                    <a class="next" onclick="plusSlides(1)">&#62;</a>
                </div>
                
                <script src="../js/mainEvent.js"></script>
            </section>

        </main>
        
    </section>
</body>
</html>