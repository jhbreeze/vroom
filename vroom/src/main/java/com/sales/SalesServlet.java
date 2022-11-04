package com.sales;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;

@WebServlet("/sales/*")
public class SalesServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("transport.do")!=-1) {
			moveToTransport(req, resp);
		} else if (uri.indexOf("transport_ok.do")!=-1) {
			list(req, resp);
//		} else if (uri.indexOf("transdata.do")!=-1) {
//			datalist(req, resp);
		} else if (uri.indexOf("")!=-1) {
		}
		
	}
	
	protected void moveToTransport(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/sales/transport.jsp");
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		SalesDAO dao = new SalesDAO();
		
		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");

			String cp = req.getContextPath();
			
	        if(!info.getUserId().equals("admin") || info == null) {
				resp.sendRedirect(cp+"/member/login.do");
				return;
			}
	        
			int year = Integer.parseInt(req.getParameter("year").equals("년도") ? "0" : req.getParameter("year"));
			int month = Integer.parseInt(req.getParameter("month").equals("월") ? "0" : req.getParameter("month"));
			int date = Integer.parseInt(req.getParameter("date").equals("일") ? "0" : req.getParameter("date"));
			String mode = req.getParameter("mode"); // 구매내역 or 환불내역
			String tORb = req.getParameter("tORb");
			
			// 연도에 대한 내용이 없다면(검색이 아닌 경우), 오늘 날짜로
			if(year == 0) {
				Calendar cal = Calendar.getInstance();
				year = cal.get(Calendar.YEAR);
				month = cal.get(Calendar.MONTH)+1;
				date = cal.get(Calendar.DATE);
				mode = "구매내역";
			}
			
			String y = year + "";
			String m = month + "";
			String d;
			if(date < 10) {
				d = "0"+date;
			} else {
				d = date + "";
			}
			
			if(month < 10) {
				m = "0"+month;
			} else {
				m = month + "";
			}
			
			int dataCount = 0;
			if(tORb.equals("기차")) {
				dataCount = dao.dataCountTrain(y, m, d, mode);
			} else {
				dataCount = dao.dataCountBus(y, m, d, mode);
			}
			
			List<SalesDTO> list = new ArrayList<>();
			
			if(tORb.equals("기차")) {
				list = dao.listSalesTrain(y, m, d, mode);
			} else {
				list = dao.listSalesBus(y, m, d, mode);
			}
			
			req.setAttribute("list", list);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("mode", mode);
			req.setAttribute("tORb", tORb);
			
			forward(req, resp, "/WEB-INF/views/sales/transportlist.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendError(400);
	}
	
}
