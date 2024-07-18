package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.event.dao.MemEventDao;
import com.book.member.user.vo.User;
 
@WebServlet("/user/event/parList")
public class MemEventParListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public MemEventParListServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
		HttpSession session = request.getSession(false); 
		int userNo = 0;
		User u = new User();
		if(session != null) {
			u =(User)session.getAttribute("user");  
			userNo = u.getUser_no();
		}
        Connection conn = getConnection();
        List<Map<String, String>> userEvents = new MemEventDao().getUserEventParticipations(userNo, conn);
        close(conn);

        request.setAttribute("userEvents", userEvents);

        RequestDispatcher rd = request.getRequestDispatcher("/views/member/event/MemParticipateList.jsp");
        rd.forward(request, response);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
