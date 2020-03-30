package com.mwyq.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoSearchDan extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("utf-8");
		String key = req.getParameter("key");
		System.out.println("key:    " + key);
		req.setAttribute("key_words",key);
//		req.getRequestDispatcher("/baidu/doSearch").forward(req, resp);
		resp.sendRedirect("/baidu/doSearch?key_word="+key);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
