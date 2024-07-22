<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ page import="com.book.member.book.vo.BookText, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>독후감 세부 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    *{
   font-family: 'Ownglyph_meetme-Rg';
    }
        body {
            background-color: rgb(247, 247, 247);
        }
        #detail_container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;s
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .detail_section {
            margin-bottom: 20px;
        }
        .detail_section h4 {
            font-weight: bold;
            margin-bottom: 10px;
        }
        .detail_section p {
            margin: 0;
            font-size: 16px;
        }
        .detail_image {
            text-align: center;
        }
        .detail_image img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }
        
       .replyCount{
margin-bottom: 20px;
} 
       
        .bkReplyContainer {
   width: 900px;
   margin: auto;
   overflow: hidden;
   padding: 20px;
   position: relative;
}

.replyDiv {
   width: 900px;
   height: 200px;
}

.btUser{
margin-top:15px
}

.btParentReply{
border-top:1px solid #ddd;
}

.btChildReply{
margin-left: 50px;
border-top:1px solid #ddd;
}

.write {
   width: 95%;
   padding: 20px;
   border-radius: 5px;
   border: 1px solid #ccc;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   resize: none;
   margin-top: 20px
}

.write:focus {
   outline: none;
   border: none;
}

.btReplyContent {
   width: 95%;
   height: 100px;
   padding: 10px;
   resize: none;
   margin-top: 10px;
}

#reBtn{
border:none;
margin-bottom: 10px;
display:flex;
justify-content:right;
}

.replyBtns {
   margin-left: 10px;
   width: 50px;
   height: 30px;
   border-radius: 15%;
   text-align: center;
   background: #575756;
   color: #fffbfb;
   font-size: 14px;
   justify-content: center;
   align-items: center;
   cursor: pointer;
   text-decoration: none;
   border: none;
}

.btn_gr {
   margin-top: 10px;
   display: flex;
   justify-content: flex-end;
   margin-bottom: 10px;
}


.replyBtns:hover {
   background-color: #e0e0e0;
}
    </style>
</head>
<body>
 <%@ include file="../../../views/include/header.jsp" %>

    <div id="detail_container" class="container">
        <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
           for (Map<String, String> detail : list) { %>
            <div class="detail_section">
                <h4>책 이름</h4>
                <p><%= detail.get("bk_title") %></p>
            </div>
            <div class="detail_section">
                <h4>카테고리</h4>
                <p><%= detail.get("bk_cate") %></p>
            </div>
            <div class="detail_section">
                <h4>작성자</h4>
                <p><%= detail.get("bt_writer") %></p>
            </div>
            <div class="detail_section">
                <h4>출판사</h4>
                <p><%= detail.get("bk_publisher") %></p>
            </div>
            <div class="detail_section">
                <h4>추천도</h4>
                <p><%= detail.get("recommendation") %></p>
            </div>
            <div class="detail_section">
                <h4>읽기 시작한 날짜</h4>
                <p><%= detail.get("bt_start") %></p>
            </div>
            <div class="detail_section">
                <h4>읽기 종료한 날짜</h4>
                <p><%= detail.get("bt_end") %></p>
            </div>
            <div class="detail_section">
                <h4>독후감</h4>
                <p><%= detail.get("bt_content") %></p>
            </div>
            <div class="detail_section detail_image">
                <h4>책 이미지</h4>
                <img src="<%= detail.get("bk_img") %>" alt="책 이미지" width="300px">
            </div>

            <% User user_bt = (User) session.getAttribute("user");
               if (user_bt != null) {
                   int userNumber = user_bt.getUser_no(); %>

                   <form action="/like/insert" name="insert_like" method="post">
                       <input type="hidden" name="like_bool" id="like_bool" value="${likeChecked}">
                       <input type="hidden" name="user_no" id="user_no" value="<%= userNumber %>">
                       <input type="hidden" name="category_no" id="category_no" value="<%= detail.get("bk_cate_no") %>">
                       <input type="hidden" name="booktext_no" id="booktext_no" value="<%= detail.get("bt_no") %>">

                       <!-- 하트 버튼 -->
                       <span class="heart" href="#" id="insertLike">
                           <!-- 하트 이미지 경로 -->
                           <svg xmlns="http://www.w3.org/2000/svg" id="likeBtn" viewBox="0 0 512 512" style="width: 20px; fill: ${color};">
                               <path class="heartBtn" d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
                           </svg>
                       </span>

                       <span id="like_count" style="font-size: 20px; width: 25px;">${lkCn}</span>
                   </form>
                   <script type="text/javascript">
                       $(document).ready(function(){
                           $('#insertLike').click(function(event){
                               event.preventDefault();
                               const userNo = $('#user_no').val();
                               const categoryNo = $('#category_no').val();
                               const booktextNo = $('#booktext_no').val();
                               // 위에서 받아온 value 값
                               let likeVal = parseInt($('#like_bool').val());
                               // 하트버튼
                               const likeBtn = $('#likeBtn');
                               $.ajax({
                                   type: 'post',
                                   url: '/like/insert',
                                   dataType: 'json',
                                   data: {
                                       "userNo": userNo,
                                       "categoryNo": categoryNo,
                                       "booktextNo": booktextNo,
                                       "likeVal": likeVal
                                   },
                                   success: function(data){
                                       if (likeVal === 0) {
                                           $('#likeBtn').find('.heartBtn').css('fill', 'red');
                                           $('#like_bool').val(1);
                                       } else {
                                           $('#likeBtn').find('.heartBtn').css('fill', 'gray');
                                           $('#like_bool').val(0);
                                       }
                                       $('#like_count').text(data.likeCount);
                                   }
                               });
                           });
                       });
                   </script>

                   <% String a = detail.get("user_no");
                      String str = Integer.toString(user_bt.getUser_no());
                      if (a.equals(str)) { %>
                       <form action="/user/editCheck" method="post">
						    <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
						    <button type="submit" class="btn btn-primary">수정</button>
						</form>
						<form action="/user/textDelete" method="post">
						    <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
						    <button type="submit" class="btn btn-danger">삭제</button>
						</form>
                   <% } %>

               <% } %>
           <% } %>
    </div>
    
    
    
    
    
    <section class="bkReplyContainer">
    <% Integer replyCnt = (Integer) request.getAttribute("btReplyCnt"); %>
	<div id="replyCount">댓글 수 : <%= (replyCnt != null ? replyCnt : 0) %></div><br>
    
    <% 
    // 독후감 댓글 가져오기
    List<Map<String, String>> bkReplyList = (List<Map<String, String>>) request.getAttribute("bkReplyList");
    // 세션에서 가져온 유저 번호
    User bt_userNo = (User) session.getAttribute("user");
    int userNo = (bt_userNo != null) ? bt_userNo.getUser_no() : -1;

    boolean isLoggedIn = bt_userNo != null;
    boolean isNotUserOne = userNo != 1;
    
    if (bkReplyList != null && !bkReplyList.isEmpty()) {
        for (Map<String, String> bre : bkReplyList) {
        	for (Map<String, String> detail : list) {
            String btReplyNo = bre.get("br_no");
            int btReplyUserNo = Integer.parseInt(bre.get("br_user_no"));
            String btNickName = bre.get("br_userNickName");
            String btContent = (bre.get("br_delete").equals("1")) ? "삭제된 댓글입니다." : bre.get("br_content");
            int btParentNo = Integer.parseInt(bre.get("br_parent"));
            String btRegDate = bre.get("br_regDate");
            String btModDate = bre.get("br_modDate");
            String btParentClass = (btParentNo == 0) ? "btParentReply" : "btChildReply";
    %>
    <div id="allreply"  class="<%=btParentClass%>">
    <div id="btReply_<%= btReplyNo %>" >
       <div class="btUser" style="display: flex; justify-content: space-between;">
          <span><%= btNickName %></span>
          <div style="text-align: right;">
          <span style="font-size:15px"><%= btRegDate %></span>
          <% if (!btModDate.equals(btRegDate)) { %>
          <span style="font-size:15px">수정됨(<%= btModDate %>)</span>
          <% } %>
          </div>
       </div>
           </div>
       <div id="btReplyContent_<%= btReplyNo %>" class="btReplyContent"><%= btContent %></div>
       <form action="/member/book/btUpdateReply" id="btUpdateForm_<%= btReplyNo %>" class="btUpdateForm" style="display:none;">
           <!-- 독후감 번호 -->
           <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
           <!-- 댓글번호 -->
           <input type="hidden" name="bt_reply_no" value="<%= btReplyNo %>">
           <input class="btReplyContent" id="btReplyUpdate_<%= btReplyNo %>" name="btUpdateContent" type="text" value="<%= btContent %>">
           <% if (userNo == btReplyUserNo && !bre.get("br_delete").equals("1")) { %>
               <div class="btn_gr">
                   <input type="submit" id="btUpdate_<%= btReplyNo %>" class="replyBtns" value="등록">
                   <input type="button" id="btCancel_<%= btReplyNo %>" class="replyBtns" value="취소" onclick="btCancelReplyForm('<%= btReplyNo %>')">
               </div>
           <% } %>
       </form>
       <% if (userNo == btReplyUserNo && !bre.get("br_delete").equals("1")) { %>
           <form action="/member/book/btDeleteReply" method="post" style="display: inline;">
               <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
               <input type="hidden" name="bt_reply_no" value="<%= btReplyNo %>">
               <input type="hidden" name="bt_user_no" value="<%= userNo %>">
               <span class="btn_gr">
                   <input type="button" id="btChange_<%= btReplyNo %>" class="replyBtns" value="수정" onclick="btChangeReplyForm('<%= btReplyNo %>')">
                   <input class="replyBtns" type="submit" id="btDelete_<%= btReplyNo %>" value="삭제">
               </span>
           </form>
       <% } %>
       <% if (btParentNo == 0 && !bre.get("br_delete").equals("1")) { %>
       	<% if (isLoggedIn && isNotUserOne) { %> 
           <span class="btn_gr">
               <button type="button" id="reBtn" onclick="btShowReplyForm('<%= btReplyNo %>')">답글하기</button>
           </span>
           <% } %>
       <% } %>
       <div id="btReplyForm_<%= btReplyNo %>" class="reply-form" style="display:none;">
           <form action="/member/book/btChildReply" method="post">
               <input type="hidden" name="bt_no" value="<%= detail.get("bt_no")  %>">
               <input type="hidden" name="bt_reply_no" value="<%= btReplyNo %>">
               <input type="hidden" name="bt_user_no" value="<%= userNo %>">
               <input type="hidden" name="br_parent" value="<%= btReplyNo %>">
               <textarea class="write" name="br_content" placeholder="답글을 입력해주세요."></textarea>
               <span class="btn_gr">
                   <input class="replyBtns" type="submit" value="등록">
                   <input class="replyBtns" type="button" value="취소" onclick="btHideReplyForm('<%= btReplyNo %>')">
               </span>
           </form>
       </div>
   
    </div>
    <% 	}
      }
    } else { 
    %> 
        <div class="replyContent">등록된 댓글이 없습니다.</div>
    <% } %>
    
	<%
	if(isLoggedIn && isNotUserOne) {
		for (Map<String, String> detail : list) { %>
	    <!-- 새 댓글 작성 폼 (부모 댓글) -->
    <form action="/member/book/brAddReply" method="post">
        <div id="replyDiv">
            <input type="hidden" name="bt_no" value="<%= detail.get("bt_no")  %>">
            <input type="hidden" name="bt_user_no" value="<%= userNo %>">
            <textarea class="write" name="br_content" placeholder="댓글을 입력해주세요."></textarea>
            <div class="btn_gr">
                <input class="replyBtns" type="submit" value="등록">
                <input class="replyBtns" type="button" value="취소" onclick="btClearReplyForm()">
            </div>
        </div>
    </form>
    <%} 
	}%>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYv5YK4SUWv+gILgOapg2bO9y3PikFNWhs5Ew5fawGr10o57kegBR7MXu" crossorigin="anonymous"></script>
<script>
function btShowReplyForm(btReplyNo) {
    document.getElementById('btReplyForm_' + btReplyNo).style.display = 'block';
}

function btHideReplyForm(btReplyNo) {
    document.getElementById('btReplyForm_' + btReplyNo).style.display = 'none';
}

function btClearReplyForm() {
    document.querySelector('#replyDiv .write').value = '';
}

function btChangeReplyForm(btReplyNo) {
    document.getElementById('btReplyContent_' + btReplyNo).style.display = 'none';
    document.getElementById('btUpdateForm_' + btReplyNo).style.display = 'block';
    document.getElementById('btChange_' + btReplyNo).style.display = 'none';
    document.getElementById('btCancel_' + btReplyNo).style.display = 'inline-block';
    document.getElementById('btDelete_' + btReplyNo).style.display = 'none';
}

function btCancelReplyForm(btReplyNo) {
    document.getElementById('btReplyContent_' + btReplyNo).style.display = 'block';
    document.getElementById('btUpdateForm_' + btReplyNo).style.display = 'none';
    document.getElementById('btChange_' + btReplyNo).style.display = 'inline-block';
    document.getElementById('btCancel_' + btReplyNo).style.display = 'none';
    document.getElementById('btDelete_' + btReplyNo).style.display = 'inline-block';
}
</script>
</body>
</html>