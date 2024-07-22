package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.user.dao.LikeDao;
import com.book.member.user.vo.Like;

@WebServlet(name="insertLike", urlPatterns="/like/insert")
public class LikeInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LikeInsertServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 하트 색, 유저넘버, 카테고리넘버, 독후감 넘버 받아옴 
		String color = request.getParameter("color");
		int userNo = Integer.parseInt(request.getParameter("userNo"));
        int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
        int booktextNo = Integer.parseInt(request.getParameter("booktextNo"));
        // Like 객체에 받아온 값 저장 
        Like lk = new Like();
        lk.setUser_no(userNo);
        lk.setBook_category_no(categoryNo);
        lk.setBooktext_no(booktextNo);
        // 받아온 하트색이 gray색(하트를 누르지 않음)이라면 
        if(color.equals("gray")) {
        	// 해당 독후감번호&유저번호 Like테이블에 insert 
        	new LikeDao().insertLike(lk);
        	// color 재할당
        	color = "red";
        	// 하트가 gray색이 아니라면(이미 하트를 눌렀다면) 눌렀을 때 하트 취소 
        } else {
        	// like 테이블에서 해당 독후감번호&유저번호를 모두 충족하는 컬럼 delete 
        	new LikeDao().deleteLike(lk);
        	color = "gray";
        }
        // 좋아요 수 카운트 
        int lkCnt = new LikeDao().countLike(booktextNo);  
        
        request.setAttribute("color", color);
        request.setAttribute("lkCnt", lkCnt);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
    }
}

