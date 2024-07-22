package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet(name="userEditEnd",urlPatterns="/user/editEnd")
public class UserEditEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public UserEditEndServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); // 없는걸 등록할때는 true 있는걸 볼떄는 false;
		int no = 0;
		User u = new User();
		if(session != null) {
			u =(User)session.getAttribute("user"); // 로그인 할때 속성값(값)을 User 객체에 User로 다운그레이드해서 넣어줌
			no = u.getUser_no();
			}
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		int result = new UserDao().editUser(no,pw,name,nickname,email);
		if(result > 0) {
			response.sendRedirect("/");
		}else {
			System.out.println("실패");
		}
	}
		

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
