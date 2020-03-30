package com.mwyq.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class userService extends HttpServlet{
	@Autowired
	private NewsService newsService = new NewsService();
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String username = req.getParameter("userName");
		String passwd = req.getParameter("password");
		System.out.println("papapaapap");
		System.out.println(username);
		System.out.println(passwd);
		System.out.println("papapaapap");
		
		
		boolean is = newsService.getUser(username, passwd);
		
		
		
		System.out.println(is);
		
		if(is)
			resp.sendRedirect("/mwyqMonitor/main/");
		
//			redict();
		
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
//	
//		public ModelAndView redict(){
//			ModelAndView view = new ModelAndView("main");
//			return view;
//		}
}

