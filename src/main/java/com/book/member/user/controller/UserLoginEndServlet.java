package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet(name="userLoginEnd",urlPatterns="/user/loginEnd")
public class UserLoginEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UserLoginEndServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 -> 비밀번호 확인(사용자 입력 == 회원가입)
		// 회원가입 비밀번호 암호화 == 사용자 입력 암호화
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		User u = new UserDao().loginUser(id,pw);
		//User u = new User(1,"admin","암호화된 비밀번호","관리자");
		// User u = null;
		// 1. User u = new UserService().loginUser(id,pw); 코드 주석처리
		// 2. User 객체의 매개변수 생성자에 데이터베이스 실제 값을 넣어서 User 구성
		// 예시) new User(1,"admin","암호화된 비밀번호","관리자");
		// 3. 매개변수 생성자로 만든 객체 주석 처리
		// 4. User u = null;로 실패 상황도 테스트해보기
		
		if(u != null) {
			HttpSession session = request.getSession(true);
			if(session.isNew() || session.getAttribute("user")==null) {
				session.setAttribute("user", u);
				session.setMaxInactiveInterval(60*30);
			}
			System.out.println("성공");
			response.sendRedirect("/");
		}else {
			RequestDispatcher view = request.getRequestDispatcher("/views/member/user/login_fail.jsp");
			view.forward(request, response);
			System.out.println("실패");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}