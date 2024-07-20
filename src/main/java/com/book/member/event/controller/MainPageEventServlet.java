package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.Console;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.util.List; 
import com.book.admin.event.dao.EventDao;
import com.book.admin.event.vo.Event;
import com.book.member.event.dao.MemEventDao;
 
@WebServlet("/")
public class MainPageEventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public MainPageEventServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		Connection conn = getConnection();
        List<Event> events = null;

        try {
            events = EventDao.getAllEvents(conn);
            if (events != null && !events.isEmpty()) { 
                StringBuilder eventIds = new StringBuilder();
                for (Event event : events) {
                    if (eventIds.length() > 0) {
                        eventIds.append(",");
                    }
                    eventIds.append(event.getEvent_no());
                }
                 
                System.out.println(eventIds);
                response.sendRedirect("/");
            } else {
            	response.sendRedirect("/");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } finally {
            close(conn);
        }
    }
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
