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

import com.book.admin.event.dao.EventDao;
import com.book.admin.event.vo.Event;
import com.book.member.event.dao.MemEventDao;

@WebServlet("/user/event/list")
public class MemEventListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MemEventListServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
    	 String evTitle = request.getParameter("evTitle");
         String categoryParam = request.getParameter("listCategory");
         String status = request.getParameter("status");
         if (status == null || status.isEmpty()) {
             status = "ongoing"; // 기본값 설정
         }
  
         Event option = new Event();
         option.setEv_title(evTitle); 

         Connection conn = getConnection();

         String nowPage = request.getParameter("nowPage");
         if (nowPage != null) {
             option.setNowPage(Integer.parseInt(nowPage));
         } 
         
         MemEventDao dao = new MemEventDao();
         List<Map<String, String>> list = null;

         if ("ongoing".equals(status)) {
        	 option.setTotalData(new MemEventDao().selectOngoingCount(option, conn));
             list = dao.selectOngoingEvents(option, conn);
         } else if ("ended".equals(status)) {
        	 option.setTotalData(new MemEventDao().selectEndedCount(option, conn));
             list = dao.selectEndedEvents(option, conn);
         } else {
             list = dao.selectEventList(option, conn);
         }

         close(conn);

         request.setAttribute("paging", option);
         request.setAttribute("resultList", list);
         request.setAttribute("status", status); 

         RequestDispatcher rd = request.getRequestDispatcher("/views/member/event/MemeventList.jsp");
         rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
