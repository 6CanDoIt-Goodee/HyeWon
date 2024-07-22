package com.book.member.user.controller;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.AttendDao;
import com.book.member.user.dao.MypageDao;
import com.book.member.user.vo.User;

@WebServlet("/user/mypage")
public class mypageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public mypageServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User thisUser = (User)session.getAttribute("user");
        // 유저 넘
        int userNo = thisUser.getUser_no();
        System.out.println(userNo);
        MypageDao mpd = new MypageDao();
        AttendDao atd = new AttendDao();
        // 이벤트 참여 수, 독후감 수, 문의사항 수, 출석일 수, 마지막 접속일
        int evCount = mpd.eventCount(userNo);
        int btCount = mpd.btCount(userNo);
        int sgCount = mpd.sgCount(userNo);
        int atCount = atd.attendCount(userNo);
        String lastAt = atd.lastAttend(userNo);
        System.out.println(lastAt);

        String year = "0";
        String month = "0";
        String date = "0";

        if (lastAt != null) {
            String[] lastAtArr = lastAt.split("-");
            if (lastAtArr.length == 3) {
                year = lastAtArr[0];
                month = lastAtArr[1];
                date = lastAtArr[2];
            }
        }

        System.out.println(lastAt);
        request.setAttribute("evCount", evCount);
        request.setAttribute("btCount", btCount);
        request.setAttribute("sgCount", sgCount);
        request.setAttribute("atCount", atCount);
        request.setAttribute("year", year);
        request.setAttribute("month", month);
        request.setAttribute("date", date);

        RequestDispatcher view = request.getRequestDispatcher("/views/member/user/mypage.jsp");
        view.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}