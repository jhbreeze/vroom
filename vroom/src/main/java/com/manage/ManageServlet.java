package com.manage;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;
import com.util.MyUtilBootstrap;

@WebServlet("/manage/*")
public class ManageServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("member.do")!=-1) {
			list(req,resp);
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원정보 리스트
		ManageDAO dao = new ManageDAO();
		MyUtil util = new MyUtilBootstrap();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		String cp = req.getContextPath();
		
        if(!info.getUserId().equals("admin") || info == null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {
				condition = "cusNum";
				keyword = "";
			}
			
			if(req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			
			int dataCount;
			if(keyword.length() == 0) {
				dataCount = dao.dataCount();
			} else {
				dataCount = dao.dataCount(condition, keyword);
			}
			
			int size = 15;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
		
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<ManageDTO> list = null;
			if(keyword.length() == 0) {
				list = dao.listMember(offset, size);
			} else {
				list = dao.listMember(offset, size, condition, keyword);
			}
			
			String query = "";
			if(keyword.length() != 0) {
				query = "condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
			}
			
			String listUrl = cp + "/manage/member.do";
			if(query.length() != 0) {
				listUrl += "?" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("paging", paging);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String path = "/WEB-INF/views/manage/manage.jsp";
		forward(req, resp, path);
		
	}
	
}
