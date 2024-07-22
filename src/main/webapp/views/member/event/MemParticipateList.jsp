<%@page import="com.book.admin.event.vo.Event"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%> 
<%@ page import="com.book.member.user.vo.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 이벤트 참여 내역</title>
<style>  
    body {
        background-color: rgb(247, 247, 247);
        -ms-overflow-style: none;
    }
    ::-webkit-scrollbar {
	  display: none;
	}
    
    .word h3 {
        font-family: 'LINESeedKR-Bd';
        margin: 30px 0px;
        text-align: center;
        font-size: 30px;
    }
    .event_list_table {
        margin-top: 30px;
        width: 100%;
        border-collapse: collapse;
        border-top: 2px solid #000;
    }
    .event_list_table th,
    .event_list_table td {
        padding: 15px 0;
        text-align: center;
        font-size: 1rem;
        border-bottom: 1px solid #ddd;
    }
    .event_list_table thead tr {
        border-bottom: 1px solid #999;
    }
    .event_list_table th {
        font-weight: 600;
        background: rgba(250, 237, 177, 0.6);
    }
    .event_list_table .num {
        width: 10%;
    }
    .event_list_table .title {
        width: 60%;
        text-align: left;
    }
    .event_list_table .title a {
        color: #2c2c2c;
        text-decoration: none;
    }
    .event_list_table thead .title {
        text-align: center;
    }
    .event_list_table .date {
        width: 10%;
    }
    .event_list_table .status {
        width: 10%;
    }
    
    .search-container {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 20px;
	}
	
	.search-form {
	    display: flex;
	    flex-grow: 1;
	    margin-right: 10px;
	}
	
	.search-input {
	    flex-grow: 1;
	    padding: 10px;
	    font-size: 16px;
	    border: 1px solid #ccc;
	    border-radius: 4px 0 0 4px;
	}
	
	.search-button,
	.all-button {
	    padding: 10px 20px;
	    font-size: 16px;
	    color: #fff;
	    background-color: #6c757d;
	    border: none;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	}
	
	.search-button {
	    border-radius: 0 4px 4px 0;
	}
	
	.all-button {
	    border-radius: 4px;
	}
	
	.search-button:hover,
	.all-button:hover {
	    background-color: #5a6268;
	}

    .center {
    	margin-top:50px;
        text-align: center;
    }
    .pagination {
        display: inline-block;
    }
    .pagination a {
        color: black;
        float: left;
        padding: 8px 16px;
        text-decoration: none;
        transition: background-color .3s;
        margin: 0 4px;
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
        padding: 10%;
    }  
    
    /* 사이드바 */
    .main_content {
	    max-width: 1300px; 
	    height: 680px;
	    margin: 5rem auto;
	    background-color: rgb(247, 247, 247);
	    display: flex;
	    flex-direction: row; 
	}
	/* 사이드바 */
	.section1{
	    width: 20%;
	    margin-right: 2rem;
	    height: 100%;
	    background-color: white;
	    font-family: 'BMHANNAPro';
	    background-color: white;
        box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
        border-radius: 20px;
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
	    font-family: 'BMHANNAPro';
	    font-size: 22px;
	}
	
	.menu-item a {
	    color: black;
	    text-decoration: none;
	    display: block;
	    padding: 20px;
	    padding-left: 30px;
	    background-color: white;
	    transition: background-color 0.3s ease;
	    font-family: 'BMHANNAPro';
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
	/* 나의 정보 form */
	.section2{
	    width: 100%;
	    background-color: white;
	    display: flex;
	    flex-direction: column;
	    justify-content: flex-start;
	    align-items: stretch;  
    	padding: 20px;
    	background-color: white;
        box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
        border-radius: 20px;
	}
	.container {
	    width: 100%;
	    max-width: 1300px;  
	    margin: 0 auto;
	} 
</style>
</head>
<body> 
	 <%@ include file="../../include/header.jsp" %>
	    <div class="main_content">
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
			<section>
        	<main>
            <div id="section_wrap" class="container">
                <%
                    User user_nick = (User) session.getAttribute("user");
                %>
                <div class="word">
                    <h3><%= (user_nick != null) ? user_nick.getUser_nickname() : "" %>님의 이벤트 참여 내역</h3>
                </div>
                <br>
				<div class="search-container">
				    <form action="/user/event/parList" method="get" class="search-form">
				        <input type="text" class="search-input" name="searchKeyword" placeholder="이벤트 제목 검색">
				        <button type="submit" class="search-button">검색</button>
				    </form>
				    <form action="/user/event/parList" method="get" class="all-form">
				        <button type="submit" class="all-button">전체</button>
				    </form>
				</div> 
                <div class="event_list">
                    <% if (request.getAttribute("userEvents") == null || ((List<Map<String, String>>) request.getAttribute("userEvents")).isEmpty()) { %>
                        <p id="list_empty">참여한 이벤트가 없습니다.</p>
                    <% } else { %>
                        <table class="event_list_table">
                            <thead class="table-light">
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">진행일</th>
                                    <th scope="col">참여 등록일</th>
                                    <th scope="col">등록 상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("userEvents");
                                    Event paging = (Event) request.getAttribute("paging");
                                    User user_par = (User) session.getAttribute("user");
                                    int userNo = user_par.getUser_no();
                                    int startRow = (paging.getNowPage() - 1) * paging.getNumPerPage();
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    Date currentDate = new Date();
                                    for (int i = 0; i < list.size(); i++) {
                                        Map<String, String> row = list.get(i);
                                        String eventEndDateStr = row.get("event_end");
                                        Date eventEndDate = sdf.parse(eventEndDateStr);
                                        long diffInMillies = Math.abs(currentDate.getTime() - eventEndDate.getTime());
                                        long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
                                %>
                                <tr style="cursor: pointer;" onclick="checkEventEndDate('<%=row.get("event_no")%>', <%=diffInDays%>)">
                                    <td><%=startRow + i + 1%></td>
                                    <td><%=row.get("event_title")%></td>
                                    <td><%=row.get("event_progress").substring(0, 10)%></td>
                                    <td><%=row.get("participate_date").substring(0, 10)%></td>
                                    <td>
                                        <%
                                            String participateState = row.get("participate_state");
                                            if ("0".equals(participateState)) {
                                                out.print("등록");
                                            } else if ("1".equals(participateState)) {
                                                out.print("대기");
                                            }
                                        %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } %>
                </div>
            </div>
        </main>
    </section>
    <%
        Event paging = (Event) request.getAttribute("paging");
        if (paging != null) {
    %>
    <div class="center">
        <div class="pagination">
            <%
                if (paging.isPrev()) {
            %>
                <a href="/user/event/parList?nowPage=<%=(paging.getPageBarStart() - 1)%>">
                    &laquo;
                </a>
            <%
                }

                for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) {
            %>
                <a href="/user/event/parList?nowPage=<%=i%>"
                    <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
                </a>
            <%
                }

                if (paging.isNext()) {
            %>
                <a href="/user/event/parList?nowPage=<%=(paging.getPageBarEnd() + 1)%>">&raquo;</a>
            <%
                }
            %>
        </div>
    </div>
    <%
        }
    %>
        </div> 
    </div>
    
    
    <script>
        function checkEventEndDate(eventNo, diffInDays) {
            if (diffInDays > 30) {
                alert("종료된 이벤트입니다.");
            } else {
                location.href = '/user/event/detail?eventNo=' + eventNo;
            }
        }
    </script>
    
    <!-- 마이페이지 드롭다운 -->
    <script>
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
