package com.maintain;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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

@WebServlet("/maintain/*")
public class MaintainServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		    req.setCharacterEncoding("utf-8");
		    
		    HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");

			String cp = req.getContextPath();
			
	        if(info == null || !info.getUserId().equals("admin")) {
				resp.sendRedirect(cp+"/member/login.do");
				return;
			}
		
			String uri = req.getRequestURI();
			if (uri.indexOf("reserve.do") != -1) {
				list(req, resp);
			} else if(uri.indexOf("reserve2.do") != -1) {
				list2(req, resp);
			} else if(uri.indexOf("reserve3.do") != -1) {
				list3(req, resp);
			} else if(uri.indexOf("reserve4.do") != -1) {
				list4(req, resp);
			}
		
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MaintainDAO dao = new MaintainDAO();
		MyUtil util = new MyUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		String cp = req.getContextPath();
		
		if(info == null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}

			if (req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			int dataCount;
			if(keyword.length() == 0) {
				dataCount = dao.tDataCount();
			} else {
				dataCount = dao.tDataCount(condition, keyword);
			}
			
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}		
			
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;
			
			List<MainTainDTO> list = null;
			if(keyword.length() == 0) {
				list = dao.TReserveList(offset, size);
			} else {
				list = dao.TReserveList(offset, size, condition, keyword);
			}
			
			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}
			
			String listUrl = cp + "/maintain/reserve.do";
			if (query.length() != 0) {
				listUrl += "?" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);
			int result;
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
			for(MainTainDTO dto : list) {
				result = dao.tTaketimeCount(dto.gettDetailCodeSta(), dto.gettDetailCodeEnd());
				Date date = sdf.parse(dto.gettStaTime());
				Date date2 = new Date(date.getTime()+result*60*1000);
				
				dto.settStaTime(dto.gettStaTime().substring(11, dto.gettStaTime().length()-3));
				dto.setCountTime(sdf2.format(date2));
			}
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
		forward(req, resp, "/WEB-INF/views/maintain/list.jsp");

	}
	
	protected void list2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MaintainDAO dao = new MaintainDAO();
		MyUtil util = new MyUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		String cp = req.getContextPath();
		
        if(info == null || !info.getUserId().equals("admin")) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}

			if (req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			int dataCount;
			if(keyword.length() == 0) {
				dataCount = dao.tDataCount2();
			} else {
				dataCount = dao.tDataCount2(condition, keyword);
			}
			
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}		
			
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;
			
			List<MainTainDTO> list = null;
			if(keyword.length() == 0) {
				list = dao.TReserveList2(offset, size);
			} else {
				list = dao.TReserveList2(offset, size, condition, keyword);
			}
			
			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}
			
			String listUrl = cp + "/maintain/reserve2.do";
			if (query.length() != 0) {
				listUrl += "?" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);
			int result;
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
			for(MainTainDTO dto : list) {
				result = dao.tTaketimeCount(dto.gettDetailCodeSta(), dto.gettDetailCodeEnd());
				Date date = sdf.parse(dto.gettStaTime());
				Date date2 = new Date(date.getTime()+result*60*1000);
				
				dto.settStaTime(dto.gettStaTime().substring(11, dto.gettStaTime().length()-3));
				dto.setCountTime(sdf2.format(date2));
			}
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
		forward(req, resp, "/WEB-INF/views/maintain/list2.jsp");

	}
	
	protected void list3(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MaintainDAO dao = new MaintainDAO();
		MyUtil util = new MyUtilBootstrap();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		String cp = req.getContextPath();
		
		if(info == null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}

			if (req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			
			int dataCount;
			if (keyword.length() == 0) {
				dataCount = dao.bDataCount();
			} else {
				dataCount = dao.bDataCount(condition, keyword);
			}
			
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}		
			
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;
			
			List<MainTainDTO> list = null;
			if(keyword.length() == 0) {
				list = dao.BReserveList(offset, size);
			} else {
				list = dao.BReserveList(offset, size, condition, keyword);
			}
			
			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}
			
			String listUrl = cp + "/maintain/reserve3.do";
			if(query.length() !=0) {
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
		
		forward(req, resp, "/WEB-INF/views/maintain/list3.jsp");

	}
	
	protected void list4(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MaintainDAO dao = new MaintainDAO();
		MyUtil util = new MyUtilBootstrap();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		String cp = req.getContextPath();
		
		if(info == null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}

			if (req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			
			int dataCount;
			if (keyword.length() == 0) {
				dataCount = dao.bDataCount2();
			} else {
				dataCount = dao.bDataCount2(condition, keyword);
			}
			
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}		
			
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;
			
			List<MainTainDTO> list = null;
			if(keyword.length() == 0) {
				list = dao.BReserveList2(offset, size);
			} else {
				list = dao.BReserveList2(offset, size, condition, keyword);
			}
			
			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}
			
			String listUrl = cp + "/maintain/reserve4.do";
			if(query.length() !=0) {
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
		
		forward(req, resp, "/WEB-INF/views/maintain/list4.jsp");
	}
}
