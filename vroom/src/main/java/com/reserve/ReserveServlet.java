package com.reserve;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;

@WebServlet("/reserve/*")
public class ReserveServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		if (uri.indexOf("check.do") != -1) {
			checkForm(req, resp);
		} else if (uri.indexOf("check_ok.do") != -1) {
			checkSubmit(req, resp);
		} else if (uri.indexOf("") != -1) {
		} else if (uri.indexOf("") != -1) {
		}

	}

	private void checkForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/reserve/check.jsp");
	}
	
	private void checkSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/reserve/check.jsp");
	}
}
