package com.book.member.user.controller;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@WebServlet("/user/findid")
public class UserFindIdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserFindIdServlet() {
        super();
    }

    // GET 요청을 처리하도록 doGet 메소드 추가
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/user/findid.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        EmailSender emailSender = new EmailSender();
        UserSendVerificationEndCodeServlet verification = new UserSendVerificationEndCodeServlet();
        String code = verification.generateVerificationCode();
        emailSender.sendEmail(email, "인증 코드", "인증 코드는 " + code + " 입니다.");
        
        request.getSession().setAttribute("verificationCode", code);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/user/findid.jsp");
        dispatcher.forward(request, response);
    }
}