<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.book.admin.event.vo.Event" %>
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

                <!-- 수정, 삭제 버튼 -->
                <div class="btn-group">
                    <button class="btn btn-primary" onclick="location.href='/event/update?eventNo=<%= event.getEvent_no() %>&eventType=<%= event.getEv_form() %>'">수정</button>
                    <button class="btn btn-danger" onclick="deleteEvent(<%= event.getEvent_no() %>)">삭제</button>
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
        document.addEventListener('DOMContentLoaded', function() {
            // 페이지 로드 시 startDate2의 기본 min 값을 내일로 설정
            setInitialMinValue();
    
            // startDate2 값이 변경될 때마다 min 속성 업데이트
            document.getElementById('startDate2').addEventListener('change', function() {
                setMinValue();
            });
        });
    
        function setInitialMinValue() {
            const startDate2 = document.getElementById('startDate2');
            const endDate2 = document.getElementById('endDate2');
            const progressDate2 = document.getElementById('progressDate2');
    
            const today = new Date();
            today.setDate(today.getDate() + 1); // 현재 날짜에 1일을 더하여 내일로 설정
    
            // 내일 날짜를 `datetime-local` 형식에 맞게 변환
            const tomorrow = today.toISOString().slice(0, 16);
    
            startDate2.min = tomorrow; // startDate2의 기본 min 속성을 내일 날짜로 설정
    
            // 기본 설정 후, endDate2와 progressDate2의 초기 상태 설정
            endDate2.disabled = true;
            progressDate2.disabled = true;
        }
    
        function setMinValue() {
            const startDate2 = document.getElementById('startDate2');
            const endDate2 = document.getElementById('endDate2');
            const progressDate2 = document.getElementById('progressDate2');
    
            // startDate2의 선택된 값으로 min 속성 업데이트
            if (startDate2.value) {
                endDate2.disabled = false;
                endDate2.min = startDate2.value;
    
                // endDate2의 값이 변경될 때 progressDate2의 min 속성 업데이트
                endDate2.addEventListener('change', function() {
                    if (endDate2.value) {
                        const endDate = new Date(endDate2.value);
                        endDate.setDate(endDate.getDate() + 1);
                        const dayAfterEnd = endDate.toISOString().slice(0, 10); // YYYY-MM-DD 형식으로 변환
                        progressDate2.min = dayAfterEnd;
                        progressDate2.disabled = false;
                    } else {
                        progressDate2.disabled = true;
                        progressDate2.value = '';
                    }
                });
            } else {
                endDate2.disabled = true;
                endDate2.value = '';
                progressDate2.disabled = true;
                progressDate2.value = '';
            }
    
            validateForm(); // 변경된 값으로 폼 유효성 검사 수행
        }
    
        function validateForm() {
            const eventType = document.getElementById('eventType').value;
            let isValid = true;
    
            if (eventType === '1') { // 기본 이벤트
                const title = document.getElementById('eventTitle1').value.trim();
                const startDate = document.getElementById('startDate1').value.trim();
                const content = document.getElementById('eventContent1').value.trim();
                const image = document.getElementById('eventimage1').value.trim();
    
                if (!title || !startDate || !content || !image) {
                    isValid = false;
                }
            } else if (eventType === '2') { // 선착순 이벤트
                const title = document.getElementById('eventTitle2').value.trim();
                const startDate = document.getElementById('startDate2').value.trim();
                const endDate = document.getElementById('endDate2').value.trim();
                const progressDate = document.getElementById('progressDate2').value.trim();
                const quota = document.getElementById('eventQuota2').value.trim();
                const content = document.getElementById('eventContent2').value.trim();
                const image = document.getElementById('eventimage2').value.trim();
    
                if (!title || !startDate || !endDate || !progressDate || !quota || !content || !image) {
                    isValid = false;
                }
    
                if (progressDate && endDate && progressDate <= endDate) {
                    isValid = false;
                    alert('이벤트 진행일은 모집 종료일 이후여야 합니다.');
                }
            }
    
            const insertBtn = document.getElementById('eventInsertBtn');
            if (isValid) {
                insertBtn.disabled = false;
                insertBtn.classList.add('enabled');
            } else {
                insertBtn.disabled = true;
                insertBtn.classList.remove('enabled');
            }
    
            const insertBtn2 = document.getElementById('eventInsertBtn2');
            if (isValid) {
                insertBtn2.disabled = false;
                insertBtn2.classList.add('enabled');
            } else {
                insertBtn2.disabled = true;
                insertBtn2.classList.remove('enabled');
            }
        }
    
        function eventInsertBtn() {
            const form = document.create_evnt_form;
            form.submit();
        }
        
        // 삭제 버튼 클릭 시 재확인 및 삭제 함수
        function deleteEvent(eventNo) {
            if (confirm('이벤트를 삭제하시겠습니까?')) {
                location.href = '/event/delete?eventNo=' + eventNo;
            }
        }
    </script>
</body>
</html>
