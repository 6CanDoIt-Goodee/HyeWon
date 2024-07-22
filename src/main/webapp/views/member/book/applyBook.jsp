<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>6캔두잇</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"
    />
    <style>
    body{
     background-color: rgb(247, 247, 247);
    }

.main_content {
    max-width: 1300px;
    height: 750px;
    margin: 5rem auto;
    display: flex;
    flex-direction: row;
}
/* 사이드바 */
.section1{
    width: 20%;
    margin-right: 2rem;
    height: 100%;
    background-color: white;
}
.section2 {
    width: 80%;
    margin-right: 2rem;
     display: flex;
       justify-content: center;

}
.section2 > form {
    height : 350px;

}

.menu {
    list-style-type: none;
    padding: 0;
    height: 600px;
    background-color: white;
}

.menu-item {
    width: 100%;
    background-color: white;
}

.menu-item a {
    color: black;
    text-decoration: none;
    display: block;
    padding: 20px;
    padding-left: 30px;
    background-color: white;
    transition: background-color 0.3s ease;
}

.menu-item a:hover {
    background-color: rgb(247, 247, 247);
}
@keyframes slide-down {
    0% {
        opacity: 0;
        transform: translateY(-10px);
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes slide-up {
    0% {
        opacity: 1;
        height: auto;
    }
    100% {
        opacity: 0;
        height: 0;
        padding: 0;
        margin: 0;
        border: 0;
    }
}
.submenu {
    display: none;
    list-style-type: none;
    padding: 0;
    margin-top: 5px;
    overflow: hidden;
}

.submenu li a {
    color: black;
    text-decoration: none;
    padding: 20px;
    display: block;
    transition: background-color 0.3s ease;
}
.submenu li a:hover {
    background-color: white;
}
.write_container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50vh;
        }
        .form_write {

            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            width: 50%;
        }
        .form_write input, .form_write textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 1rem;
            border: 1px solid #ced4da;
            border-radius: 5px;
            transition: border-color 0.2s;
        }
        .form_write input:focus, .form_write textarea:focus {
            border-color: #80bdff;
            outline: none;
        }
        .bw_btn {
            text-align: right;
        }
        .btn-custom {
            background-color: #6c757d;
            color: white;
        }
        .btn-custom:hover {
            background-color: #5a6268;
        }

</style>
  </head>

  <body>
<% Boolean success = (Boolean) request.getAttribute("success"); %>
<% if (success != null && success) { %>
    <script type="text/javascript">
        alert("신청이 완료되었습니다");
    </script>
<% } %>
   <%@ include file="../../include/header.jsp" %>
            <div class="main_content">
            <!-- 이 선 위는 변경 X -->
            <!-- 아래에 추가 -->
            <div class="section1">
                <ul class="menu">
	                <li class="menu-item"><a href="/user/mypage">나의 정보</a></li>
	                <li class="menu-item">
	                    <a href="#">독후감 목록</a>
	                    <ul class="submenu">
	                        <li><a href="/user/bookList">&nbsp;&nbsp;&nbsp;&nbsp; 작성된 독후감</a></li>
	                        <li><a href="/user/saveTextList">&nbsp;&nbsp;&nbsp;&nbsp; 나만보기</a></li>
	                    </ul>
	                </li>
	                <li class="menu-item"><a href="/user/event/parList">이벤트 참여 내역</a></li>
	                <li class="menu-item"><a href="/book/apply">도서 신청</a></li>
	                <li class="menu-item">
	                    <a href="#">문의 사항</a>
	                    <ul class="submenu">
	                        <li><a href="/member/sg/create">&nbsp;&nbsp;&nbsp;&nbsp; 문의 사항 작성</a></li>
	                        <li><a href="/member/sg/list">&nbsp;&nbsp;&nbsp;&nbsp; 문의 사항 목록</a></li>
	                    </ul>
	                </li>
	            </ul>
            </div>
            <div class="section2">
                   <form class="form_write" id="create_account_form" name="create_account_form" action="/book/applyEnd" method="post">
                     <div class="apply">
                          <div>
                          <label for ="apply_bk_title">도서이름</label>
                               <input type="text"
                                name="apply_bk_title"
                                id="apply_bk_title"
                                placeholder="ex) 돼지가족"
                                style="width: 100%" required/>

                          </div>
                          <div>
                          <label for ="apply_bk_publisher">출판사</label>
                          <input type="text"
                          id="apply_bk_publisher"
                          name="apply_bk_publisher"
                          placeholder="ex) 샘율출판사"
                           style="width: 100%" required
                          />
                          </div>
                          <div>
                           <label for ="apply_bk_author">저자</label>
                             <input type="text"
                              id="apply_bk_author"
                              name="apply_bk_author"
                              placeholder="ex) 브라이언"
                                style="width: 100%" required/>
                          </div>
                       <div class="bw_btn">
                         <button type="submit" class="btn btn-secondary">신청</button>
                       </div>
                     </div>
                   </form>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                var form = document.getElementById('create_account_form');

                form.addEventListener('submit', function(event) {
                    var inputs = form.querySelectorAll('input[required]');
                    var allFilled = Array.from(inputs).every(input => input.value.trim() !== '');

                    if (!allFilled) {
                        alert('모든 필드를 작성해 주세요.');
                        event.preventDefault(); // 폼 제출을 막음
                    }
                });
            });
             
        	  document.addEventListener("DOMContentLoaded", function() {
        	      const menuItems = document.querySelectorAll(".menu-item > a");
        	
        	      menuItems.forEach(function(item) {
        	          const submenu = item.nextElementSibling;
        	          let isOpen = false;
        	
        	          item.addEventListener("click", function(event) {
        	              if (submenu) {
        	
        	                  if (isOpen) {
        	                      submenu.style.animation = "slide-up 0.3s ease";
        	                      
        	                      setTimeout(function(){
        	                          submenu.style.display = "none";
        	                          submenu.style.animation = "";
        	                      }, 300);
        	
        	                      isOpen = false;
        	                  } else {
        	                      submenu.style.display = "block";
        	                      submenu.style.height = "auto";
        	                      void submenu.offsetWidth;
        	                      submenu.style.animation = "slide-down 0.3s ease";
        	                      submenu.style.height = submenu.scrollHeight + "px";
        	
        	                      isOpen = true;
        	                  }
        	              }
        	          });
        	      });
        	
        	      const submenuLinks = document.querySelectorAll(".submenu li a");
        	      submenuLinks.forEach(function(link) {
        	          link.addEventListener("click", function(event) {
        	          });
        	      });
        	  }); 
        </script>
  </body>
</html>
