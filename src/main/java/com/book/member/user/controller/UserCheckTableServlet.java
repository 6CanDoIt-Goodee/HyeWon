package com.book.member.user.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;

@WebServlet("/user/check_table")
public class UserCheckTableServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   
    public UserCheckTableServlet() {
        super();
    }

   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       UserDao userDao = new UserDao();
       List<Map<String, Object>> user = userDao.getAllUsers();

       HttpSession session = request.getSession();
       session.setAttribute("user", user);

       RequestDispatcher view = request.getRequestDispatcher("/views/user/check_table.jsp");
      view.forward(request, response);
   }

   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      doGet(request, response);
   }

} 