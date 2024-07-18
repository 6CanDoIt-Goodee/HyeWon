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
        int categoryNo = 0;
        if (categoryParam != null && !categoryParam.isEmpty()) {
            categoryNo = Integer.parseInt(categoryParam);
        }

        Event option = new Event();
        option.setEv_title(evTitle);
        option.setEvent_category(categoryNo);

        Connection conn = getConnection();

        String nowPage = request.getParameter("nowPage");
        if (nowPage != null) {
            option.setNowPage(Integer.parseInt(nowPage));
        }

        option.setTotalData(new EventDao().selectEventCount(option, conn));

        List<Map<String, String>> list = new EventDao().selectEventList(option, conn);

        close(conn);

        request.setAttribute("paging", option);
        request.setAttribute("resultList", list);

        RequestDispatcher rd = request.getRequestDispatcher("/views/member/event/MemeventList.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
