package com.book.member.book.controller;

import com.book.member.book.dao.BookTextDao;
import com.book.member.book.dao.LikeDao;
import com.book.member.user.vo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

//작성된 독후감 세부 사항
@WebServlet("/book/detail")
public class BookTextDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookTextDetailServlet() {
        super();

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bt_no = Integer.parseInt(request.getParameter("bt_no"));
        List<Map<String, String>> list = new BookTextDao().detailBookText(bt_no);

        HttpSession session = request.getSession(false);
        int lkCn = 0;
        int likeChecked = 0;
        String color = "gray";

        if (session != null && session.getAttribute("user") != null) {
            User user_like = (User) session.getAttribute("user");
            System.out.println("dd"+user_like.getUser_no());
            // 해당 독후감의 좋아요 수
            lkCn = new LikeDao().countLike(bt_no);
            // 사용자의 해당 독후감 좋아요 여부
            likeChecked = new LikeDao().likeChecked(user_like.getUser_no(), bt_no);

            // 좋아요를 눌렀다면
            if (likeChecked == 1) {
                color = "red";
            }
        }

        // 가져온 값 보내기
        request.setAttribute("lkCn", lkCn);
        request.setAttribute("likeChecked", likeChecked);
        request.setAttribute("color", color);
        request.setAttribute("resultList", list);

        RequestDispatcher rd = request.getRequestDispatcher("/views/member/book/booktextDetail.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}