package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.user.dao.Mypagedao;
import com.book.member.user.vo.User;

@WebServlet("/user/mypage")
public class mypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public mypageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		User u = new User();
//		int evCount = new Mypagedao().eventCount(u);
//		int btCount = new Mypagedao().btCount(u);
//		int sgCount = new Mypagedao().sgCount(u);
//		
//		request.setAttribute("evCount", evCount);
//		request.setAttribute("btCount", btCount);
//		request.setAttribute("sgCount", sgCount);
		
		request.setAttribute("evCount", "33");
		request.setAttribute("btCount", "44");
		request.setAttribute("sgCount", "55");
		
		RequestDispatcher view = request.getRequestDispatcher("/views/member/user/mypage.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}