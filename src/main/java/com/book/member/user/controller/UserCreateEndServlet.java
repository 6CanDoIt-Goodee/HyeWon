package com.book.member.user.controller;
 
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;



@WebServlet(name="usercreateEnd",urlPatterns="/user/createEnd")
public class UserCreateEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String email_prefix = request.getParameter("email_prefix");
        String email_domain = request.getParameter("email_domain");
        String email = email_prefix + "@" + email_domain;
        String nickname = request.getParameter("nickname");

        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verificationCode");
        String inputCode = request.getParameter("email_number");

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            UserDao userDao = new UserDao();
            User user = new User();
            user.setUser_name(name);
            user.setUser_id(id);
            user.setUser_pw(pw);
            user.setUser_email(email);
            user.setUser_nickname(nickname);
            int result = UserDao.createUser(user);

            if (result > 0) {
                response.sendRedirect("/");
            } else {
                response.getWriter().write("fail");
            }
        } else {
            response.getWriter().write("인증번호가 일치하지 않습니다.");
        }
    }
}