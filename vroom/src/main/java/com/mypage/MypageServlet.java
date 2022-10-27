package com.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.util.MyServlet;

@WebServlet("/mypage/*")
public class MypageServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("update.do")!=-1) {
			updateForm(req, resp);
		} else if (uri.indexOf("")!=-1) {
			reserveList(req,resp);
		} 
	}

	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		forward(req, resp, "/WEB-INF/views/mypage/mypage.jsp");
		
	}

	
	private void reserveList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}


}
