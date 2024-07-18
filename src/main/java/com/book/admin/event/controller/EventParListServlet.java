package com.book.admin.event.controller;

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

import com.book.admin.event.dao.EventDao;
import com.book.member.user.vo.User;
 
@WebServlet("/event/parList")
public class EventParListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public EventParListServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {   
		Connection conn = getConnection();
		
		// 진행 중, 진행 예정이벤트 제목
        List<Map<String, String>> eventTitles = new EventDao().getEventTitles(conn);
        List<Map<String, String>> userEvents;
  
        String eventTitle = request.getParameter("eventTitle");

        if (eventTitle != null && !eventTitle.isEmpty()) {
            userEvents = new EventDao().getEventParticipationsByTitle(eventTitle, conn);
        } else {
            userEvents = new EventDao().getEventParticipations(conn);
        }

        // 선택된 이벤트 정보 설정
        Map<String, String> selectedEvent = null;
        if (eventTitle != null && !eventTitle.isEmpty()) {
            selectedEvent = new EventDao().getEventInfoByTitle(eventTitle, conn);
        }
        
        close(conn);

        request.setAttribute("eventTitles", eventTitles);
        request.setAttribute("userEvents", userEvents);
        request.setAttribute("selectedEvent", selectedEvent); 

        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/event/eventParList.jsp");
        rd.forward(request, response);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
