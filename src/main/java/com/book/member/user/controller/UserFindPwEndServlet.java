//package com.book.member.user.controller;
//
//import java.io.IOException;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import com.book.member.user.dao.UserDao;
//import com.book.member.user.vo.User;
//
//@WebServlet(name="userFindPwEnd",urlPatterns="/user/findPwEnd")
//public class UserFindPwEndServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    
//    public UserFindPwEndServlet() {
//        super();
//    }
//
//	
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    	String name =request.getParameter("name");
//    	
//		String emailPrefix = request.getParameter("email_prefix");
//        String emailDomain = request.getParameter("email_domain");
//		String email = emailPrefix + "@" + emailDomain;
//		
//		User u = new User();
//		u.setUser_name(name);
//		u.setUser_email(email);
//
//		
//        
//		UserDao ud = new UserDao();
//		int result = new UserDao().findId(u);
//		// 아이디랑 다오 양식 어차피 똑같으니까
//		if(result >0) {
//			EmailSender emailSender = new EmailSender("rushnkash@gmail.com","alswo5615!@");
//			String vertificationLink = "http://localhost:8080/user/verify?email=" + email;
//			emailSender.sendVerificationEmail(email, vertificationLink);
//			
//			// 세션에 인증 코드 저장
//			HttpSession session = request.getSession();
//			session.setAttribute("verificationCode", generateVerificationCode());
//			session.setAttribute("email", email);
//			
//			System.out.println("이메일 전송 성공");
//		}else {
//			System.out.println("실패");
//		}
//		
//		
//		
//		
//	}
//    private String generateVerificationCode() {
//		int code = (int)(Math.random()*999999)+100000;
//		return String.valueOf(code);
//	}
//
////		RequestDispatcher view = request.getRequestDispatcher("/views/user/create_success.jsp");
////		if(result > 0) {
////			view = request.getRequestDispatcher("/views/user/create_success.jsp");
////		}
////		view.forward(request, response);
//////		if(result >0) System.out.println("성공");
//////		else System.out.println("실패");
//	
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doGet(request, response);
//	}
//
//}