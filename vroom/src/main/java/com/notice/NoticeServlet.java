package com.notice;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;
import com.util.MyUtilBootstrap;

@MultipartConfig
@WebServlet("/notice/*")
public class NoticeServlet extends MyServlet {
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
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} 
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
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

			String pageSize = req.getParameter("size");
			int size = pageSize == null ? 10 : Integer.parseInt(pageSize);

			int dataCount, total_page;

			if (keyword.length() != 0) {
				dataCount = dao.dataCount(condition, keyword);
			} else {
				dataCount = dao.dataCount();
			}
			total_page = util.pageCount(dataCount, size);

			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<NoticeDTO> list;
			if (keyword.length() != 0) {
				list = dao.listNotice(offset, size, condition, keyword);
			} else {
				list = dao.listNotice(offset, size);
			}

			List<NoticeDTO> listNotice = null;
			listNotice = dao.listNotice();
			for (NoticeDTO dto : listNotice) {
				dto.setBoDate(dto.getBoDate().substring(0, 10));
			}

			long gap;
			Date curDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			for (NoticeDTO dto : list) {
				Date date = sdf.parse(dto.getBoDate());
				gap = (curDate.getTime() - date.getTime()) / (1000 * 60 * 60);
				dto.setGap(gap);

				dto.setBoDate(dto.getBoDate().substring(0, 10));

			}

			String query = "";
			String listUrl;
			String articleUrl;

			listUrl = cp + "/notice/list.do?size=" + size;
			articleUrl = cp + "/notice/article.do?page=" + current_page + "&size=" + size;
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");

				listUrl += "&" + query;
				articleUrl += "&" + query;
			}

			String paging = util.paging(current_page, total_page, listUrl);
			req.setAttribute("list", list);
			req.setAttribute("listNotice", listNotice);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/notice/list.jsp");
	}

	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		String size = req.getParameter("size");

		if (!info.getUserId().equals("admin")) {
			resp.sendRedirect(cp + "/notice/list.do?size=" + size);
			return;
		}

		req.setAttribute("mode", "write");
		req.setAttribute("size", size);
		forward(req, resp, "/WEB-INF/views/notice/write.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/notice/list.do");
			return;
		}

		NoticeDAO dao = new NoticeDAO();

		String size = req.getParameter("size");
		try {
			NoticeDTO dto = new NoticeDTO();

			dto.setUserId(info.getUserId());
			if (req.getParameter("notice") != null) {
				dto.setNotice(Integer.parseInt(req.getParameter("notice")));
			}
			dto.setBoSubject(req.getParameter("boSubject"));
			dto.setBoCont(req.getParameter("boCont"));
			dto.setCategoryNum(Long.parseLong(req.getParameter("categoryNum")));

			dao.insertNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/notice/list.do?size=" + size);
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;

		NoticeDAO dao = new NoticeDAO();

		try {
			long boardNum = Long.parseLong(req.getParameter("boardNum"));

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

			NoticeDTO dto = dao.readNotice(boardNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/notice/list.do?" + query);
				return;
			}

			dto.setBoCont(dto.getBoCont().replaceAll("\n", "<br>"));

			NoticeDTO preReadDto = dao.preReadNotice(dto.getBoardNum(), condition, keyword);
			NoticeDTO nextReadDto = dao.nextReadNotice(dto.getBoardNum(), condition, keyword);

			req.setAttribute("dto", dto);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
			req.setAttribute("query", query);
			req.setAttribute("page", page);
			req.setAttribute("size", size);

			forward(req, resp, "/WEB-INF/views/notice/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/notice/list.do?" + query);
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		if (!info.getUserId().equals("admin")) {
			resp.sendRedirect(cp + "/notice/list.do");
			return;
		}

		NoticeDAO dao = new NoticeDAO();

		String page = req.getParameter("page");
		String size = req.getParameter("size");

		try {
			long boardNum = Long.parseLong(req.getParameter("boardNum"));

			NoticeDTO dto = dao.readNotice(boardNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/notice/list.do?page=" + page + "&size=" + size);
				return;
			}
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("size", size);

			req.setAttribute("mode", "update");

			forward(req, resp, "/WEB-INF/views/notice/write.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/notice/list.do?page=" + page + "&size=" + size);
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/notice/list.do");
			return;
		}

		if (!info.getUserId().equals("admin")) {
			resp.sendRedirect(cp + "/notice/list.do");
			return;
		}

		NoticeDAO dao = new NoticeDAO();

		String page = req.getParameter("page");
		String size = req.getParameter("size");

		try {
			NoticeDTO dto = new NoticeDTO();

			dto.setBoardNum(Long.parseLong(req.getParameter("boardNum")));
			if (req.getParameter("notice") != null) {
				dto.setNotice(Long.parseLong(req.getParameter("notice")));
			}
			dto.setBoSubject(req.getParameter("boSubject"));
			dto.setBoCont(req.getParameter("boCont"));
			dto.setCategoryNum(Long.parseLong(req.getParameter("categoryNum")));

			dao.updatetNotice(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/notice/list.do?page=" + page + "&size=" + size);
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		if (!info.getUserId().equals("admin")) {
			resp.sendRedirect(cp + "/notice/list.do");
			return;
		}

		NoticeDAO dao = new NoticeDAO();

		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;

		try {
			long boardNum = Long.parseLong(req.getParameter("boardNum"));
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

			NoticeDTO dto = dao.readNotice(boardNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/notice/list.do?" + query);
				return;
			}
			
			if (!info.getUserId().equals("admin")) {
				resp.sendRedirect(cp + "/event/list.do?" + query);
				return;
			}

			dao.deleteNotice(boardNum, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/notice/list.do?" + query);
	}

}
