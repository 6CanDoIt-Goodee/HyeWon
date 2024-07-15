package com.book.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.event.dao.EventDao;
import com.book.event.vo.Event;
 
@WebServlet("/event/list")
public class EventListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public EventListServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		String title = request.getParameter("eventTitle1");
	    Event option = new Event();
	    option.setEv_title(title);
	  
	    Connection conn = getConnection();
	    List<Event> list = new EventDao().selectEventList(option, conn); 
        close(conn); 
        
        System.out.println("list : " + list);
	    request.setAttribute("resultList", list);
	    RequestDispatcher view = request.getRequestDispatcher("/views/event/eventList.jsp");
	    view.forward(request, response); 
	      
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
