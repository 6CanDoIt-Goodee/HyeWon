package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.event.dao.EventDao;
 
@WebServlet("/event/delete")
public class EventDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public EventDeleteServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String eventNoStr = request.getParameter("eventNo");

	        if (eventNoStr != null && !eventNoStr.isEmpty()) {
	            try {
	                int eventNo = Integer.parseInt(eventNoStr);

	                Connection conn = getConnection();
	                EventDao eventDao = new EventDao();
	                int isDeleted = eventDao.deleteEvent(eventNo, conn);

	                if (isDeleted > 0) {  
	                    response.sendRedirect(request.getContextPath() + "/event/list");
	                } else {  
	                    response.sendRedirect(request.getContextPath() + "/event/list");
	                }
	            } catch (Exception e) {  
	                response.sendRedirect(request.getContextPath() + "/event/list");
	            }
	        } else { 
	            response.sendRedirect(request.getContextPath() + "/event/list");
	        } 
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
