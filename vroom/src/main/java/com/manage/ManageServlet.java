package com.manage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;

@WebServlet("/manage/*")
public class ManageServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("member.do")!=-1) {
			manageMem(req,resp);
		} else if (uri.indexOf("")!=-1) {
		} else if (uri.indexOf("")!=-1) {
		} else if (uri.indexOf("")!=-1) {
		}
	}

	private void manageMem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ManageDAO dao = new ManageDAO();
		List<ManageDTO> list = dao.listMember();
		
		req.setAttribute("list", list);
		
		String path = "/WEB-INF/views/manage/manage.jsp";
		forward(req, resp, path);
		
	}
	
}
