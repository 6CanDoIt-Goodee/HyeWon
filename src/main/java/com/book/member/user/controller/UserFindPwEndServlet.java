package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet("/user/findpwend")
public class UserFindPwEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET 요청을 처리하도록 doGet 메소드 추가
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/user/findpw.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        System.out.println(id);
        System.out.println(email);
        // 세션에서 인증 코드 가져오기
        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verificationCode");
        String inputCode = request.getParameter("email_number");

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            User user = new UserDao().findpw(id,email);
            
            if (user != null) {
            	response.sendRedirect("/views/member/user/changepw.jsp");
            } else {
            	response.sendRedirect("/views/member/user/findpw_fail.jsp");
            }
        } else {
            response.getWriter().write("인증 실패");
        }
    }
}