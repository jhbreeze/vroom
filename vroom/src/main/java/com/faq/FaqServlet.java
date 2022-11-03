package com.faq;

import java.io.IOException;
import java.net.URLDecoder;
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

@WebServlet("/faq/*")
public class FaqServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if (uri.indexOf("deleteList.do") != -1) {
			deleteList(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		MyUtil util = new MyUtilBootstrap();

		String cp = req.getContextPath();

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
			dataCount = dao.dataCount();

			// 전체 페이지 수
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			// 게시글 가져오기
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;
			
			String query = "";
			
			List<FaqDTO> list = null;
			list = dao.listFaq(offset, size);
			
			String listUrl = cp + "/faq/list.do";
			String articleUrl = cp + "/faq/article.do?page=" + current_page;
			if(query.length() != 0) {
				listUrl += "?"+query;
				articleUrl += "&" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("paging", paging);
			req.setAttribute("articleUrl", articleUrl);

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/faq/list.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/faq/list.do");
			return;
		}
		
		try {
			FaqDTO dto = new FaqDTO();
			
			dto.setUserId(info.getUserId());
			
			dto.setFaqSubject(req.getParameter("faqSubject"));
			dto.setFaqContent(req.getParameter("faqContent"));
			
			dao.insertFaq(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/faq/list.do");
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long faqNum = Long.parseLong(req.getParameter("faqNum"));
			
			FaqDTO dto = dao.readFaq(faqNum);
			if(dto == null) {
				resp.sendRedirect(cp + "/faq/list.do?"+query);
				return;
			}
			
			if (!info.getUserId().equals("admin")) {
				resp.sendRedirect(cp + "/faq/list.do?" + query);
				return;
			}
			
			dao.deleteFaq(faqNum, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/faq/list.do?"+query);
	}

	protected void deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		String cp = req.getContextPath();
		
		if(!info.getUserId().equals("admin")) {
			resp.sendRedirect(cp+"/faq/list.do");
			return;
		}
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "size="+size+"page=" + page;
		
		try {
			String[] nn = req.getParameterValues("faqNums");
			long faqNums[] = null;
			faqNums = new long[nn.length];
			for(int i=0;i<nn.length;i++) {
				faqNums[i] = Long.parseLong(nn[i]);
			}
			
			FaqDAO dao = new FaqDAO();
			
			dao.deleteFaqList(faqNums);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/faq/list.do?"+query);
	}

}
