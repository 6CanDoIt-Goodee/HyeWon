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
		String title1 = request.getParameter("eventTitle1");
        String title2 = request.getParameter("eventTitle2");
        String title = title1 != null ? title1 : title2;
        
        Event option = new Event();
        option.setEv_title(title);
	  
        Connection conn = getConnection();
        
        String nowPage = request.getParameter("nowPage");
		if(nowPage != null) {
			option.setNowPage(Integer.parseInt(nowPage));
		}
		// 전체 목록 개수 -> 페이징바 구성
		option.setTotalData(new EventDao().selectEventCount(option, conn)); 
		
	    List<Event> list = new EventDao().selectEventList(option, conn); 
        close(conn); 
        
        request.setAttribute("paging", option);
	    request.setAttribute("resultList", list);
	     
	    RequestDispatcher rd = request.getRequestDispatcher("/views/event/eventList.jsp");
	    rd.forward(request, response); 
	      
	}
 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
