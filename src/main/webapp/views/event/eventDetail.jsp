<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.book.event.vo.Event" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트 상세 정보</title> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <%@ include file="../include/header.jsp" %>

    <div class="container mt-4">
        <h2>이벤트 상세 정보</h2>
        <table class="table table-striped mt-4">
            <tbody>
                <%
                    Event event = (Event) request.getAttribute("event");
                %>
                <tr>
                    <th scope="row">이벤트 번호</th>
                    <td><%= event.getEvent_no() %></td>
                </tr>
                <tr>
                    <th scope="row">이벤트 카테고리</th>
                    <td><%= event.getEvent_category() %></td>
                </tr>
                <tr>
                    <th scope="row">이벤트 제목</th>
                    <td><%= event.getEv_title() %></td>
                </tr>
                <tr>
                    <th scope="row">이벤트 내용</th>
                    <td><%= event.getEv_content() %></td>
                </tr>
                <tr>
                    <th scope="row">이벤트 형식</th>
                    <td>
                        <% if (event.getEv_form() == 1) { %>
                            기본
                        <% } else if (event.getEv_form() == 2) { %>
                            선착순
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <th scope="row">이벤트 등록일</th>
                    <td>
                        <% 
                        String originalDateTime = event.getEv_regdate(); 
                        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = originalFormat.parse(originalDateTime);
 
                        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
                        String formattedDate = outputFormat.format(date);
                        out.println(formattedDate);
                        %>
                    </td>
                </tr>
                <tr>
                    <th scope="row">이벤트 시작일</th>
                    <td><%= event.getEv_start() %></td>
                </tr>
                <tr>
                    <th scope="row">이벤트 종료일</th>
                    <td><%= event.getEv_end() %></td>
                </tr>
                <tr>
                    <th scope="row">이벤트 기존 이미지</th>
                    <td><%= event.getOri_image() %></td>
                </tr>
                <tr>
                    <th scope="row">이벤트 새 이미지</th>
                    <td>
                        <img src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="새 이미지" class="event-image">
                    </td>
                </tr>
                <% if (event.getEv_form() == 2) { %>
                    <tr>
                        <th scope="row">이벤트 정원</th>
                        <td><%= event.getEvent_quota() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <a href="/event/list" class="btn btn-primary">이벤트 목록으로 돌아가기</a>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-K+5l5K5V6hbd40VzV3uLkOMspvq91b8Kwah2tx2KsPr2jp0QVxeEm+LXR82Av+37" crossorigin="anonymous"></script>

</body>
</html>
