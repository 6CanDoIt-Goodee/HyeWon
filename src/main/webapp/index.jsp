<%-- <%@page import="com.book.member.user.dao.PopularBookDao"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.book.admin.event.vo.Event"%>
<%@ page import="com.book.admin.event.dao.EventDao" %>
<%@ page import="java.util.Map" %> 
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>6캔두잇</title> 
<style>
	@charset "UTF-8";
	 
	main {
	    max-width: 1200px;
	    margin: 2rem auto;
	    padding: 0 1rem; 
	}
	
	.search_section {
	    margin-top: 50px; 
	} 
	
	.search_title {
	    font-size: 22px;
	    font-weight: 600;
	    text-align: center;
	    color: #2c2c2c; 
	    margin-bottom: 20px;
	    font-family: 'Freesentation-9Black';
	}
	
	.search_input {
	    width: 100%;
	    padding: 15px 24px;
	    background-color: transparent;
	    transition: transform 250ms ease-in-out;
	    font-size: 14px;
	    line-height: 18px;
	    color: #575756;
	    background-color: transparent;
	    background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'%3E%3Cpath d='M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z'/%3E%3Cpath d='M0 0h24v24H0z' fill='none'/%3E%3C/svg%3E");
	    background-repeat: no-repeat;
	    background-size: 18px 18px;
	    background-position: 95% center;
	    border-radius: 50px;
	    border: 1px solid #575756;
	    transition: all 250ms ease-in-out;
	    backface-visibility: hidden;
	    transform-style: preserve-3d;
	}
	
	.search_input:hover,
	.search_input:focus {
	    padding: 12px 0;
	    outline: 0;
	    border: 1px solid transparent;
	    border-bottom: 1px solid #575756;
	    border-radius: 0;
	    background-position: 100% center;
	}
	
	.slide-image-container {
	    width: 40%;
	    height: 90%; 
	    border-radius: 30px;
	    background-color: rgba(181, 181, 181, 0);
	}
	
	.slide-image {
	    width: 80%;
	    height: 100%;
	    object-fit: cover;
	    border-radius: 20px;
	    margin-top: 3%;
	    margin-bottom: 3%;
	    margin-left: 3%;
	}
	
	.event-section {
    	margin-top: 40px; 
	    position: relative;
	    max-width: 1200px;
	    margin-left: auto;
	    margin-right: auto;
	}

	.event_container {  
	    max-width: 100%; 
	    overflow: hidden;
	    height : 280px;
	}
	
	.slide {
	    display: none;
	    width: 100%;
	    height: 100%;
	    display: flex;
	    position: relative;
	    background-color: rgba(237, 237, 233);
	    border-radius: 30px;
	}
	
	.prev, .next {
	    cursor: pointer;
	    position: absolute;
	    top: 50%;
	    width: 30px;
	    height: 30px;
	    margin-top: -15px;  
	    color: rgb(56, 56, 56,0.3);
	    font-weight: lighter;
	    font-size: 18px;
	    border-radius: 50%; 
	    text-align: center;
	    line-height: 30px;
	    user-select: none;
	    border: 1px solid rgb(56, 56, 56,0.3);
	    text-decoration: none;
	    z-index: 10; 
	}
	
	.next {
	    right: -15px; 
	}
	
	.prev {
	    left: -15px;  
	}
	 
	@media (max-width: 768px) {
	    .event_container {
	        height: 200px; 
	    }
	    
	    .prev, .next {
	        width: 25px;
	        height: 25px;
	        font-size: 16px;
	        line-height: 25px;
	    }
	}
	
	@media (max-width: 480px) {
	    .event_container {
	        height: 150px;  
	    }
	    
	    .prev, .next {
	        width: 20px;
	        height: 20px;
	        font-size: 14px;
	        line-height: 20px;
	    }
	}
	
	.fade {
	    animation-name: fade;
	    animation-duration: 1.5s;
	}
	
	@keyframes fade {
	    from {opacity: .4}
	    to {opacity: 1}
	}
	
	.event_content {
	    position: absolute;
	    right: 5%;
	    top: 50%;
	    transform: translateY(-50%); 
	    padding: 20px;
	    border-radius: 10px;
	    width: 50%;  
	    color: rgb(0, 0, 0);
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    background-color: rgba(255, 255, 255, 0);
	    align-items: center;  
	    text-align: center; 
	}
	
	.event_title {
	    font-size: 2.5vw;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: rgb(0, 0, 0);
	    background-color: rgba(255, 255, 255, 0);
	    font-family: 'LeferiPoint-BlackA';
	}
	
	.event_form {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	}
	
	.event_form_text {
	    background-color: rgba(248, 224, 119, 0.65);
	    font-family: 'LeferiPoint-BlackA';
	    font-size: 1.3vw;
	    padding: 7px 7px 0px 7px;
	}
	
	.event-dday {
	    font-weight: bold;
	    font-size: 1.7vw;
	    color: #edbb45;
	    margin-left: 15px;  
	} 
	
	.event_date {
	    margin-top: 5%;
	    font-size: 1.3vw;
	    color: rgb(0, 0, 0);
	    background-color: rgba(255, 255, 255, 0);
	    font-family: 'LeferiPoint-BlackA';
	}
	
	.main {
	    margin-top: 50px;  
	}
	
	.recoBook .pRecoB {
	    font-size: 24px;
	    font-weight: bold;
	    text-align: center;
	    margin-bottom: 20px;
	    font-family: 'LeferiPoint-BlackA';
	}
	
	.bDiv {
	    margin: 20px 0;
	    text-align: center;
	}
	
	.bTitle {
	    font-size: 18px;
	    margin-bottom: 10px;
	    font-family: 'LeferiPoint-BlackA';
	}
	
	.bImg {
	    width: 150px;
	    height: auto;
	    border-radius: 10px;
	}
</style>

</head>
<body>
    <%@ include file="views/include/header.jsp" %> 
    <section>
        <main>
		    <!-- 검색 -->
            <section class="search_section">
                <div class="search_container">
                    <p class="search_title">
                        Welcome to Knock Book!<br>Knock the door to endless stories.
                    </p>
                    <input class="search_input" type="text" placeholder="독후감을 작성할 도서를 검색해 보세요!">
                </div>
            </section>  
            
            <!-- 이벤트 -->
            <section class="event-section">
		        <div class="event_container">
		            <% 
		                boolean isAdmin = user != null && user.getUser_no() == 1;
		                List<Map<String, String>> events = EventDao.getAllEvents();
		                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				        Date now = new Date(); 
		                if (events != null && !events.isEmpty()) {
		                    for (int i = 0; i < events.size(); i++) {
		                    	Map<String, String> event = events.get(i);
		                        String eventNo = event.get("event_no");
		                        String imageUrl = request.getContextPath() + "/upload/event/" + event.get("event_new_image");
		                        String eventTitle = event.get("event_title");
		                        String eventStart = event.get("event_start").substring(0, 10);
		                        String eventEnd = event.get("event_end").substring(0, 10);
		                        String eventForm = event.get("event_form");
		                        String detailUrl = isAdmin ? request.getContextPath() + "/event/detail?eventNo=" + eventNo + "&eventType=" + eventForm
		                                                   : request.getContextPath() + "/user/event/detail?eventNo=" + eventNo + "&eventType=" + eventForm;
		                        Date eventEndDate = format.parse(eventEnd);
		                        long daysRemaining = (eventEndDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
		                        String dday = (daysRemaining > 0) ? "D-" + daysRemaining : (daysRemaining == 0) ? "모집중" : "모집 기간 종료";
		            %>  
					        <div class="slide fade">
					            <a href="<%= detailUrl %>">
					                <div class="slide-image-container"> 
					                    <img src="<%= imageUrl %>" alt="Image <%= i + 1 %>" class="slide-image">
					                </div>
					                <div class="event_content">
					                    <div class="event_title"><%= eventTitle %></div>
					                    <% if ("2".equals(eventForm)) { %>
					                        <div class="event_form">
					                            <span class="event_form_text">선착순 모집</span>
					                            <span class="event-dday"><%= dday %></span>
					                        </div>
					                    <% } %>
					                    <div class="event_date">
					                        <%= eventStart.equals(eventEnd) ? eventStart : eventStart + " ~ " + eventEnd %>
					                    </div> 
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
		    
		   <%--  <!-- 추천 도서 -->
		    <div class="main">
		 		<div class="main_cont">
			 		<div class="recoBook">
			 			<div class="pRecoB">추천 도서</div> 
			 			<%
			 			    List<Map<String, String>> pblist = new PopularBookDao().popularBookList();
			 			%>	
		
			 			<% for(Map<String, String> pbMap : pblist) { %>
			 			    <div class="bDiv">
			 			        <p class="bTitle"><%= pbMap.get("titles") %></p>
			 			        <img src="<%= pbMap.get("images") %>" 
			 			        alt="<%= pbMap.get("titles") %>" class="bImg">
			 			    </div>
			 			<% } %>
			 		</div> 
		 		</div>
 			</div> --%>
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
	        startSlideShow();  
	    }
	
	    startSlideShow();
	     
    </script>
</body>
</html>
