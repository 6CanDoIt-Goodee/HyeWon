package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.event.dao.EventDao;
import com.book.member.event.vo.Event;

@WebServlet("/event/detail")
public class EventDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public EventDetailServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int eventNo = Integer.parseInt(request.getParameter("eventNo"));  

		Connection conn = getConnection();
		 
        EventDao eventDao = new EventDao();
        Event event = eventDao.selectEventByNo(eventNo, conn);  
 
        request.setAttribute("event", event);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/event/eventDetail.jsp");
        dispatcher.forward(request, response);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
