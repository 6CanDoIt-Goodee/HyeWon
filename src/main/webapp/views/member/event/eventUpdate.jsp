<%@ page import="com.book.member.event.vo.Event" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 수정</title>
<style>  
    .form-section {
        display: none;
    }
    
    .form-section.active {
        display: block;
    }
    
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }
    
    .form-group label {
        width: 150px;  
        text-align: left;
        margin-left: 2%;
        margin-right: 3%; 
    }
    
    #eventTitle1, #eventTitle2 {
        width: 35%; 
    }
    
    #startDate1, #endDate1, #startDate2, #endDate2 {
        width: 200px; 
    }
    
    #eventContent1, #eventContent2 {  
        width: 35%;
        height: 15em; 
        resize: none; 
    }
    
    .image-box {
        width: 10vw;
        height: 10vw;
        border: 1px solid #ccc;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        overflow: hidden;
        background-color: #f0f0f0;
        position: relative;
        text-align: center;
        font-size: 0.8vw;  
        color: #666;
    }
    
    .image-box img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    input[type="file"] {
        display: none;
    }
    
    .delete-button {
        display: none;
        margin-top: 10px; 
        color: #f44336;  
        cursor: pointer;
        font-size: 12px;
        font-weight: 600;
    }
</style>
</head>
<body>
    <%@ include file="../../include/header.jsp" %>
    
    <%
        Event event = (Event) request.getAttribute("event");
        String formAction = "/event/update";
        int eventType = event.getEv_form(); 
        System.out.println("수정 2 : " + event);
    %>
    
    
    
    <form name="update_event_form" action="/event/updateEnd?eventNo=<%= event.getEvent_no() %>&eventType=<%= event.getEv_form() %>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="eventNo" value="<%= event.getEvent_no()%>">
        
        <% if (eventType == 1) { %>
        <div id="form-section1" class="form-section active">
            <div class="form-group">
               <label for="eventCategory1">카테고리</label>
               <select id="eventCategory1" name="eventCategory1"> 
                   <option value="1" <%= event.getEv_category_name().equals("신간 도서") ? "selected" : "" %>>신간 도서</option>
                   <option value="2" <%= event.getEv_category_name().equals("독서 마라톤") ? "selected" : "" %>>독서 마라톤</option>
                   <option value="3" <%= event.getEv_category_name().equals("챌린지") ? "selected" : "" %>>챌린지</option>
                   <option value="4" <%= event.getEv_category_name().equals("작가 초청") ? "selected" : "" %>>작가 초청</option> 
               </select>
            </div>
            <div class="form-group">
                <label for="eventTitle1">제목</label>
                <input type="text" id="eventTitle1" name="eventTitle1" value="<%= event.getEv_title() %>">
            </div>
            <div class="form-group">
                <label for="startDate1">기간</label>
                <div>
                    <input type="date" id="startDate1" name="startDate1" value="<%= event.getEv_start() %>"><br>
                    <input type="date" id="endDate1" name="endDate1" value="<%= event.getEv_end() %>">
                </div>
            </div>
            <div class="form-group">
                <label for="eventContent1">내용</label>
                <textarea id="eventContent1" name="eventContent1" wrap="hard"><%= event.getEv_content() %></textarea>
            </div>
            <div class="form-group">
                <label for="eventimage1">이미지</label>
                <div>
                    <div class="image-box" id="imageBox1" onclick="document.getElementById('eventimage1').click()">
                        <img id="imagePreview1" src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="Image Preview">
                    </div>
                    <div class="delete-button" id="deleteButton1" onclick="deleteImage(1)">이미지 삭제</div>
                    <input type="file" id="eventimage1" name="eventimage1" accept=".png,.jpg,.jpeg" onchange="previewImage(event, 1)">
                </div>
            </div>  
            <button id="eventCancelBtn" type="button" onclick="eventCancelBtn();">취소</button>
            <button id="eventUpdateBtn" type="submit">수정</button>
        </div>
        <% } else if (eventType == 2) { %>
        <div id="form-section2" class="form-section active">
            <div class="form-group">
                <label for="eventCategory2">카테고리</label>
                <select id="eventCategory2" name="eventCategory2"> 
                    <option value="1" <%= event.getEv_category_name().equals("신간 도서") ? "selected" : "" %>>신간 도서</option>
                    <option value="2" <%= event.getEv_category_name().equals("독서 마라톤") ? "selected" : "" %>>독서 마라톤</option>
                    <option value="3" <%= event.getEv_category_name().equals("챌린지") ? "selected" : "" %>>챌린지</option>
                    <option value="4" <%= event.getEv_category_name().equals("작가 초청") ? "selected" : "" %>>작가 초청</option> 
                </select>
            </div>
            <div class="form-group">
                <label for="eventTitle2">제목</label>
                <input type="text" id="eventTitle2" name="eventTitle2" value="<%= event.getEv_title() %>"><br>
            </div>
            <div class="form-group">
                <label for="startDate2">모집 기간</label>
                <input type="datetime-local" id="startDate2" name="startDate2" value="<%= event.getEv_start() %>">
                <input type="datetime-local" id="endDate2" name="endDate2" value="<%= event.getEv_end() %>">
            </div>
            <div class="form-group">
                <label for="progressDate2">이벤트 진행일</label>
                <input type="date" id="progressDate2" name="progressDate2" value="<%= event.getEv_progress() %>"><br>
            </div>
            <div class="form-group">
                <label for="eventQuota2">정원</label>
                <input type="number" id="eventQuota2" name="eventQuota2" min="1" value="<%= event.getEvent_quota() %>"><br>
            </div> 
            <div class="form-group">
                <label for="eventContent2">내용</label>
                <textarea id="eventContent2" name="eventContent2" wrap="hard"><%= event.getEv_content() %></textarea>
            </div>
            <div class="form-group">
                <label for="eventimage2">이미지</label>
                <div>
                    <div class="image-box" id="imageBox2" onclick="document.getElementById('eventimage2').click()">
                        <img id="imagePreview2" src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="Image Preview">
                    </div>
                    <div class="delete-button" id="deleteButton2" onclick="deleteImage(2)">이미지 삭제</div>
                    <input type="file" id="eventimage2" name="eventimage2" accept=".png,.jpg,.jpeg" onchange="previewImage(event, 2)">
                </div>
            </div>
            <button id="eventCancelBtn" type="button" onclick="eventCancelBtn();">취소</button>
            <button id="eventUpdateBtn" type="submit">수정</button>
        </div>
        <% } %>
    </form>
 
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
	        const form = document.update_event_form;
	        form.submit();
	    }
	    
		function previewImage(event, section) {
	        const inputFile = event.target;
	        const file = inputFile.files[0];
	        const fileType = file.type;
	        const validImageTypes = ['image/jpeg', 'image/png', 'image/jpg'];
	        
	        if (!validImageTypes.includes(fileType)) {
	            alert("JPG, JPEG, PNG 파일만 업로드 가능합니다.");
	            inputFile.value = '';
	            return;
	        }
	
	        const reader = new FileReader();
	        reader.onload = function() {
	            const preview = document.getElementById('imagePreview' + section);
	            preview.src = reader.result;
	            preview.style.display = 'block';
	
	            const imageBox = document.getElementById('imageBox' + section);
	            imageBox.classList.remove('default');
	
	            const deleteButton = document.getElementById('deleteButton' + section);
	            deleteButton.style.display = 'block';
	        };
	        reader.readAsDataURL(file);
	        
	        validateForm(); // 이미지 파일을 변경한 후 폼을 유효성 검사 
	    }
	
	    function deleteImage(section) {
	        const preview = document.getElementById('imagePreview' + section);
	        preview.src = '';
	        preview.style.display = 'none';
	
	        const imageBox = document.getElementById('imageBox' + section);
	        imageBox.classList.add('default');
	
	        const deleteButton = document.getElementById('deleteButton' + section);
	        deleteButton.style.display = 'none';
	
	        const inputFile = document.getElementById('eventimage' + section);
	        inputFile.value = '';
	        
	        validateForm(); // 이미지 파일을 삭제한 후 폼을 유효성 검사 
	    }
	    
	    <%-- document.getElementById('eventUpdateBtn').addEventListener('click', function(event) {
	        event.preventDefault(); // 기본 동작 방지
	        
	        const eventType = <%= eventType %>;  
	         
	        let updateUrl = '/event/updateEnd?eventNo=<%= event.getEvent_no() %>&eventType=' + eventType;
	        console.log(updateUrl); 
	        window.location.replace(updateUrl);
	    }); --%>
	    
</script>
</body>
</html>
