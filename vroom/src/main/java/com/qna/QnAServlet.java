package com.qna;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;
import com.util.MyUtilBootstrap;

@MultipartConfig
@WebServlet("/qna/*")
public class QnAServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		} else if (uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		} else if (uri.indexOf("write2.do") != -1) {
			writeForm2(req, resp);
		} else if (uri.indexOf("write_ok2.do") != -1) {
			writeSubmit2(req, resp);
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("article1.do") != -1) {
			article1(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if (uri.indexOf("delete2.do") != -1) {
			delete2(req, resp);
		} else if (uri.indexOf("insertReply.do") != -1) {
			insertReply(req, resp);
		} else if (uri.indexOf("listReply.do") != -1) {
			listReply(req, resp);
		} else if (uri.indexOf("deleteReply.do") != -1) {
			deleteReply(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();
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
			if (keyword.length() == 0) {
				dataCount = dao.dataCount();
			} else {
				dataCount = dao.dataCount(condition, keyword);
			}

			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			
			int reCount = 0;
			//long qnaNum = Long.parseLong(req.getParameter("qnaNum"));
			//reCount = dao.dataCountReply(qnaNum);
			
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<QnADTO> list = null;
			if (keyword.length() == 0) {
				list = dao.listQna(offset, size);
			} else {
				list = dao.listQna(offset, size, condition, keyword);
			}

			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}

			String listUrl = cp + "/qna/list.do";
			String articleUrl = cp + "/qna/article.do?page=" + current_page;
			if (query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);

			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);
			req.setAttribute("reCount", reCount);

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/qna/list.jsp");
	}

	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/qna/write.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/qna/list.do");
			return;
		}

		try {
			QnADTO dto = new QnADTO();

			if(info==null) {
				
			} else {
				dto.setUserId(info.getUserId());
				
			}

			dto.setQnaSubject(req.getParameter("qnaSubject"));
			dto.setQnaContent(req.getParameter("qnaContent"));

			dao.insertQna(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do");
	}
	
	protected void writeForm2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/qna/write2.jsp");
	}

	protected void writeSubmit2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/qna/list.do");
			return;
		}

		try {
			QnADTO dto = new QnADTO();

			dto.setQnaSubject(req.getParameter("qnaSubject"));
			dto.setQnaContent(req.getParameter("qnaContent"));
			dto.setQnaName(req.getParameter("qnaName"));
			dto.setQnaPwd(req.getParameter("qnaPwd"));

			dao.insertQnaN(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do");
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long qnaNum = Long.parseLong(req.getParameter("qnaNum"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");

			if (keyword.length() != 0) {
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}

			QnADTO dto = dao.readQna(qnaNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/qna/list.do?" + query);
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);

			forward(req, resp, "/WEB-INF/views/qna/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do?" + query);
	}
	
	protected void article1(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long qnaNum = Long.parseLong(req.getParameter("qnaNum"));
			String qnaPwd = req.getParameter("qnaPwd");
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");

			if (keyword.length() != 0) {
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}

			QnADTO dto = dao.readQna1(qnaNum);
			
			if (dto == null) {
				resp.sendRedirect(cp + "/qna/list.do?" + query);
				return;
			}
			
			if(!dto.getQnaPwd().equals(qnaPwd)) {
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.print("<script>alert('패스워드가 일치하지 않습니다.'); history.back();</script>");
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);

			forward(req, resp, "/WEB-INF/views/qna/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do?" + query);
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long qnaNum = Long.parseLong(req.getParameter("qnaNum"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");

			if (keyword.length() != 0) {
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}

			QnADTO dto = dao.readQna(qnaNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/qna/list.do?" + query);
				return;
			}

			if (!info.getUserId().equals(dto.getUserId()) && !info.getUserId().equals("admin")) {
				resp.sendRedirect(cp + "/qna/list.do?" + query);
				return;
			}

			dao.deleteQna1(qnaNum, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do?" + query);
	}
	protected void delete2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long qnaNum = Long.parseLong(req.getParameter("qnaNum"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");

			if (keyword.length() != 0) {
				query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}

			QnADTO dto = dao.readQna(qnaNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/qna/list.do?" + query);
				return;
			}

			dao.deleteQna2(qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do?" + query);
	}

	protected void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "false";
		try {
			ReplyDTO dto = new ReplyDTO();

			dto.setQnaNum(Long.parseLong(req.getParameter("qnaNum")));
			dto.setQnaReplyCont(req.getParameter("qnaReplyCont"));
			dto.setUserId(info.getUserId());

			dao.insertReply(dto);

			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject job = new JSONObject();
		job.put("state", state);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

	protected void listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();
		MyUtil util = new MyUtilBootstrap();

		try {
			long qnaNum = Long.parseLong(req.getParameter("qnaNum"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if (pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}

			int size = 5;
			int total_page = 0;
			int replyCount = 0;

			replyCount = dao.dataCountReply(qnaNum);
			total_page = util.pageCount(replyCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<ReplyDTO> listReply = dao.listReply(qnaNum, offset, size);

			for (ReplyDTO dto : listReply) {
				dto.setQnaReplyCont(dto.getQnaReplyCont().replace("\n", "<br>"));
			}

			String paging = util.pagingMethod(current_page, total_page, "listPage");

			req.setAttribute("listReply", listReply);
			req.setAttribute("pageNo", current_page);
			req.setAttribute("replyCount", replyCount);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);

			forward(req, resp, "/WEB-INF/views/qna/listReply.jsp");
			return;
		} catch (Exception e) {
		}
		resp.sendError(400);
	}

	protected void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnADAO dao = new QnADAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";

		try {
			long replyNum = Long.parseLong(req.getParameter("replyNum"));

			dao.deleteReply(replyNum, info.getUserId());

			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject job = new JSONObject();
		job.put("state", state);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

}
