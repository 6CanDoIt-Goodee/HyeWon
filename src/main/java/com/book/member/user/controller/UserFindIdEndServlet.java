package com.book.member.user.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet("/user/findidend")
public class UserFindIdEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET 요청을 처리하도록 doGet 메소드 추가
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/user/findid.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String inputCode = request.getParameter("email_number");

        // 세션에서 인증 코드 가져오기
        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verificationCode");

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            Connection conn = getConnection();
            UserDao userDao = new UserDao();
            User user = null;
            try {
                user = userDao.getUserByNameAndEmail(name, email);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            close(conn);

            if (user != null) {
                response.getWriter().write("아이디: " + user.getUser_id());
            } else {
                response.getWriter().write("일치하는 사용자가 없습니다.");
            }
        } else {
            response.getWriter().write("인증 실패");
        }
    }
}