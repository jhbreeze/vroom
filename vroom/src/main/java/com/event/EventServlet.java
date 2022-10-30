package com.event;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.FileManager;
import com.util.MyUploadServlet;
import com.util.MyUtil;
import com.util.MyUtilBootstrap;

@MultipartConfig
@WebServlet("/event/*")
public class EventServlet extends MyUploadServlet {
	private static final long serialVersionUID = 1L;

	private String pathname;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();
		HttpSession session = req.getSession();

		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "photo";

		if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("list2.do") != -1) {
			list2(req, resp);
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
		} else if (uri.indexOf("insertReply.do") != -1) {
			insertReply(req, resp);
		} else if (uri.indexOf("listReply.do") != -1) {
			listReply(req, resp);
		} else if (uri.indexOf("deleteReply.do") != -1) {
			deleteReply(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();
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

			int size = 8;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<EventDTO> list = null;
			if (keyword.length() == 0) {
				list = dao.listEvent(offset, size);
			} else {
				list = dao.listEvent(offset, size, condition, keyword);
			}

			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}

			String listUrl = cp + "/event/list.do";
			String articleUrl = cp + "/event/article.do?page=" + current_page;
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

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/event/list.jsp");
	}
	
	protected void list2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();
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
				dataCount = dao.dataCount2();
			} else {
				dataCount = dao.dataCount(condition, keyword);
			}

			int size = 8;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<EventDTO> list = null;
			if (keyword.length() == 0) {
				list = dao.listEvent(offset, size);
			} else {
				list = dao.listEvent(offset, size, condition, keyword);
			}

			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}

			String listUrl = cp + "/event/list.do";
			String articleUrl = cp + "/event/article.do?page=" + current_page;
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

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/event/list2.jsp");
	}

	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) { // 로그인 되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/event/write.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/event/list.do");
			return;
		}

		try {
			EventDTO dto = new EventDTO();

			dto.setEveTitle(req.getParameter("eveTitle"));
			dto.setEveCont(req.getParameter("eveCont"));
			if(req.getParameter("event")!= null) {
				dto.setEvent(Long.parseLong(req.getParameter("event")));				
			}

			String filename = null;
			Part p = req.getPart("selectFile");
			Map<String, String> map = doFileUpload(p, pathname);
			if (map != null) {
				filename = map.get("saveFilename");
			}

			if (filename != null) {
				dto.setImageFilename(filename);
				dao.insertEvent(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/event/list.do");
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long eveNum = Long.parseLong(req.getParameter("eveNum"));
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

			EventDTO dto = dao.readList(eveNum);
			if (dto == null) { // 게시물이 없으면 다시 리스트로
				resp.sendRedirect(cp + "/event/list.do?" + query);
				return;
			}

			dto.setEveCont(dto.getEveCont().replaceAll("\n", "<br>"));

			EventDTO preReadDto = dao.preReadEvent(dto.getEveNum(), condition, keyword);
			EventDTO nextReadDto = dao.nextReadEvent(dto.getEveNum(), condition, keyword);

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);

			forward(req, resp, "/WEB-INF/views/event/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/event/list.do?" + query);
	}

	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String size = req.getParameter("size");

		try {
			long eveNum = Long.parseLong(req.getParameter("eveNum"));
			EventDTO dto = dao.readList(eveNum);

			if (dto == null) {
				resp.sendRedirect(cp + "/event/list.do?page=" + page);
				return;
			}

			if (!dto.getUserId().equals(info.getUserId())) {
				resp.sendRedirect(cp + "/sbbs/list.do?page=" + page);
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);

			req.setAttribute("mode", "update");

			forward(req, resp, "/WEB-INF/views/event/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/event/list.do?page=" + page);
	}

	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/event/list.do");
			return;
		}

		String page = req.getParameter("page");

		try {
			EventDTO dto = new EventDTO();
			dto.setEveNum(Long.parseLong(req.getParameter("eveNum")));
			dto.setEveTitle(req.getParameter("eveTitle"));
			dto.setEveCont(req.getParameter("eveCont"));
			if(req.getParameter("event")!= null) {
				dto.setEvent(Long.parseLong(req.getParameter("event")));				
			}

			String imageFilename = req.getParameter("imageFilename");
			dto.setImageFilename(imageFilename);

			Part p = req.getPart("selectFile");
			Map<String, String> map = doFileUpload(p, pathname);
			if (map != null) {
				String filename = map.get("saveFilename");

				FileManager.doFiledelete(pathname, imageFilename);
				dto.setImageFilename(filename);
			}

			dao.updateEvent(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/event/list.do?page=" + page);
	}

	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long eveNum = Long.parseLong(req.getParameter("eveNum"));
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

			EventDTO dto = dao.readList(eveNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/event/list.do?" + query);
				return;
			}

			if (!info.getUserId().equals("admin")) {
				resp.sendRedirect(cp + "/event/list.do?" + query);
				return;
			}

			FileManager.doFiledelete(pathname, dto.getImageFilename());

			dao.deleteEvent(eveNum, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/event/list.do?" + query);
	}
	


	protected void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "false";
		try {
			ReplyDTO dto = new ReplyDTO();

			dto.setEveNum(Long.parseLong(req.getParameter("eveNum")));
			dto.setEvReplyContent(req.getParameter("evReplyContent"));
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

		EventDAO dao = new EventDAO();
		MyUtil util = new MyUtilBootstrap();

		try {
			long eveNum = Long.parseLong(req.getParameter("eveNum"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if (pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}

			int size = 5;
			int total_page = 0;
			int replyCount = 0;

			replyCount = dao.dataCountReply(eveNum);
			total_page = util.pageCount(replyCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;
			
			List<ReplyDTO> listReply = dao.listReply(eveNum, offset, size);
			
			for(ReplyDTO dto : listReply) {
				dto.setEvReplyContent(dto.getEvReplyContent().replace("\n", "<br>"));
			}
			String paging = util.pagingMethod(current_page, total_page, "listPage");
			
			req.setAttribute("listReply", listReply);
			req.setAttribute("pageNo", current_page);
			req.setAttribute("replyCount", replyCount);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);
			
			forward(req, resp, "/WEB-INF/views/event/listReply.jsp");
			return;
		} catch (Exception e) {
		}
		resp.sendError(400);
	}

	protected void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EventDAO dao = new EventDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "false";
		
		try {
			long replyNum = Long.parseLong(req.getParameter("replyNum"));
			
			dao.deleteRely(replyNum, info.getUserId());
			
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
