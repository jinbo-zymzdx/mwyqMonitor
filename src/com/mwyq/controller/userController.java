package com.mwyq.controller;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class userController extends HttpServlet{

	private static final long serialVersionUID = 8089174332204780172L;

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String username = req.getParameter("userName");
		String passwd = req.getParameter("password");
		req.getSession().setAttribute("username", username);
		req.getSession().setAttribute("passwd", passwd);
		resp.sendRedirect("/mwyqMonitor/main/");
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}


