package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.admin.event.vo.Event;
import com.book.member.event.dao.MemEventDao;
import com.book.member.user.vo.User;

@WebServlet("/user/event/detail")
public class MemEventDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public MemEventDetailServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int eventNo = Integer.parseInt(request.getParameter("eventNo"));

        Connection conn = getConnection();

        MemEventDao memEventDao = new MemEventDao();
        Event event = memEventDao.selectEventByNo(eventNo, conn);

        
        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
  
        boolean isRegistered = false;
        if (user != null) {
            int userNo = user.getUser_no();
            isRegistered = memEventDao.checkRegistration(eventNo, userNo, conn);
        }
 
        System.out.println("사용자 번호: " + (user != null ? user.getUser_no() : "로그인되지 않음"));
        System.out.println("이벤트 번호: " + eventNo);
        System.out.println("참여 여부: " + isRegistered);
 
        request.setAttribute("event", event);
        request.setAttribute("isRegistered", isRegistered); 
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/event/MemeventDetail.jsp");
        dispatcher.forward(request, response);
 
        close(conn);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
