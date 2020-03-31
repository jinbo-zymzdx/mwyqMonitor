package com.mwyq.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

/**
 * @Description: TODO(用一句话描述该文件做什么)
 * @Date: 2017年1月15日
 * @author: luoshao
 * @Copyright (c) 2017, www.panyixia.cn , 792435323@qq.com All Rights Reserved.
 */
public class searchServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		List<String> arrays = new ArrayList<String>();
		List<String> result = new ArrayList<String>();

		arrays.add("java");
		arrays.add("hodoop");

		String keyword = req.getParameter("keyword");
		resp.setCharacterEncoding("utf-8");
		req.setCharacterEncoding("utf-8");

		for (String array : arrays) {
			if (array.contains(keyword)) {
				result.add(array);
			}
		}

		resp.getWriter().write(JSONArray.fromObject(result).toString());
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}
