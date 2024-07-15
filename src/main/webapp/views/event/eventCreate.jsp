<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 추가</title>
<!-- <link href="../resources/css/event/eventCreate.css" rel="stylesheet" type="text/css"> -->
<style>  
	.form-section {
	    display: none;
	}
	
	#form-section1 {
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
	    display: none;
	}
	
	.image-box.default::before {
	    content: "JPG / JPEG / PNG";
	    position: absolute;
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
	<%@ include file="../include/header.jsp" %>
	 
	<form name="create_evnt_form" action="/event/createEnd" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="eventType">이벤트 유형</label>
            <select id="eventType" name="eventType" onchange="showFormSection()"> 
                <option value="1" selected>기본 이벤트</option>
                <option value="2">선착순 이벤트</option> 
            </select>
        </div>

        <div id="form-section1" class="form-section">
	        <div class="form-group">
	           <label for="eventCategory1">카테고리</label>
	           <select id="eventCategory1" name="eventCategory1"> 
	               <option value="1" selected>신간 도서</option>
	               <option value="2">독서 마라톤</option>
	               <option value="3">챌린지</option>
	               <option value="4">작가 초청</option> 
	           </select>
	       	</div>
            <div class="form-group">
                <label for="eventTitle1">제목</label>
                <input type="text" id="eventTitle1" name="eventTitle1">
            </div>
            <div class="form-group">
                <label for="startDate1">기간</label>
                <div>
                    <input type="date" id="startDate1" name="startDate1" onchange="toggleEndDate(1)"><br>
                    <input type="date" id="endDate1" name="endDate1" disabled>
                </div>
            </div>
            <div class="form-group">
                <label for="eventContent1">내용</label>
                <textarea id="eventContent1" name="eventContent1"></textarea>
            </div>
            <div class="form-group">
                <label for="eventimage1">이미지</label>
                <div>
                    <div class="image-box default" id="imageBox1" onclick="document.getElementById('eventimage1').click()">
                        <img id="imagePreview1" alt="Image Preview">
                    </div>
                    <div class="delete-button" id="deleteButton1" onclick="deleteImage(1)">이미지 삭제</div>
                    <input type="file" id="eventimage1" name="eventimage1"  accept=".png,.jpg,.jpeg" onchange="previewImage(event, 1)">
                </div>
            </div>  
            <button id="eventCancelBtn" onclick="eventCancelBtn();">취소</button>
            <button id="eventInsertBtn"  onclick="eventInsertBtn();">등록</button>
        </div>

        <div id="form-section2" class="form-section">
            <div class="form-group">
                <label for="eventCategory2">카테고리</label>
                <select id="eventCategory2" name="eventCategory2"> 
                    <option value="1" selected>신간 도서</option>
                    <option value="2">독서 마라톤</option>
                    <option value="3">챌린지</option>
                    <option value="4">작가 초청</option> 
                </select>
            </div>
            <div class="form-group">
                <label for="eventTitle2">제목</label>
                <input type="text" id="eventTitle2" name="eventTitle2"><br>
            </div>
            <div class="form-group">
                <label for="startDate2">모집 기간</label>
                <input type="datetime-local" id="startDate2" name="startDate2" onchange="setMinValue()">
                <input type="datetime-local" id="endDate2" name="endDate2" disabled onchange="setMinValue()">
            </div>
            <div class="form-group">
                <label for="progressDate2">이벤트 진행일</label>
                <input type="date" id="progressDate2" name="progressDate2"><br>
            </div>
            <div class="form-group">
                <label for="eventQuota2">정원</label>
                <input type="number" id="eventQuota2" name="eventQuota2" min="1"><br>
            </div> 
            <div class="form-group">
                <label for="eventContent2">내용</label>
                <textarea id="eventContent2" name="eventContent2"></textarea>
            </div>
            <div class="form-group">
                <label for="eventimage2">이미지</label>
                <div>
                    <div class="image-box default" id="imageBox2" onclick="document.getElementById('eventimage2').click()">
                        <img id="imagePreview2" alt="Image Preview">
                    </div>
                    <div class="delete-button" id="deleteButton2" onclick="deleteImage(2)">이미지 삭제</div>
                    <input type="file" id="eventimage2" name="eventimage2"  accept=".png,.jpg,.jpeg" onchange="previewImage(event, 2)">
                </div>
            </div>
            <button id="eventCancelBtn" onclick="eventCancelBtn();">취소</button>
            <button id="eventInsertBtn"  onclick="eventInsertBtn();">등록</button>
        </div> 
    </form>

    <script src="../js/eventCreate.js"></script> 
    <!-- <script>
    	if(form.eventimage1.value){ 
			const val = form.eventimage1.value;
			const idx = val.lastIndexOf('.');
			const type = val.substring(idx+1,val.length);
			if(type == 'jpg' || type == 'jpeg' || type == "png"){
				form.submit();
			} else{
				alert("JPG, JPEG, PNG 파일만 업로드 가능합니다.");
				form.eventimage1.value = '';
			}
    	}
		
    	if(form.eventimage2.value){ 
	   		const val = form.eventimage2.value;
	   		const idx = val.lastIndexOf('.');
	   		const type = val.substring(idx+1,val.length);
	   		if(type == 'jpg' || type == 'jpeg' || type == "png"){
	   			form.submit();
	   		} else{
	   			alert("JPG, JPEG, PNG 파일만 업로드 가능합니다.");
	   			form.eventimage2.value = '';
	   		}
    	}
    </script> -->
</body>
</html>