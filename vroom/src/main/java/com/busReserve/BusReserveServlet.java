package com.busReserve;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.MyServlet;

@WebServlet("/busreserve/*")
public class BusReserveServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("busreservelist.do")!=-1) {
			busReserveList(req,resp);
		} else if (uri.indexOf("busreserveseat.do")!=-1) {
			busReserveSeat(req,resp);
		}else if (uri.indexOf("busreserveseat2.do")!=-1) {
			busReserveSeat2(req,resp);
		} else if (uri.indexOf("businsertlist.do")!=-1) {
			businsertlist(req,resp);
		} else if (uri.indexOf("buslistbefore.do")!=-1) {
			buslistbefore(req,resp);
		}else if (uri.indexOf("buslistforward.do")!=-1) {
			buslistforward(req,resp);
		}
	}

	private void businsertlist(HttpServletRequest req, HttpServletResponse resp) {
		BusReserveDAO dao = new BusReserveDAO();
		try {
			List<BusReserveDTO> depList = dao.getDepStationList();
			if(req.getParameter("depbStationCode") == null) {
				JSONObject job = new JSONObject();
				JSONArray jarr = new JSONArray();
				for(BusReserveDTO dto : depList) {
					JSONObject jo = new JSONObject();
					
					jo.put("stationCode", dto.getbStationCode());
					jo.put("stationName", dto.getbStationName());
					
					jarr.put(jo);
				}
				job.put("list", jarr);
				
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();

				out.print(job.toString());
			} else {
				int depbStationCode = Integer.parseInt(req.getParameter("depbStationCode"));
				List<BusReserveDTO> dep = dao.getDesStationList(depbStationCode);
				
				JSONObject job = new JSONObject();
				JSONArray jarr = new JSONArray();
				
				for(BusReserveDTO dto : dep) {
					JSONObject jo = new JSONObject();
					
					jo.put("stationCode", dto.getbStationCode());
					jo.put("stationName", dto.getbStationName());
					
					jarr.put(jo);
				}
				job.put("list", jarr);
				
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.print(job.toString());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void busReserveSeat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveSeat.jsp");
	}
	private void busReserveSeat2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveSeat2.jsp");
	}
	
	protected void busReserveList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveList.jsp");
	}
	private void buslistbefore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		ReserveBusSessionInfo reserveInfo = new ReserveBusSessionInfo();

		reserveInfo.setBcycle(req.getParameter("bcycle"));
		reserveInfo.setDepbStationCode(Integer.parseInt(req.getParameter("depbStationCode")));
		reserveInfo.setDesbStationCode(Integer.parseInt(req.getParameter("desbStationCode")));
		reserveInfo.setDepbStationName(req.getParameter("depbStationName"));
		reserveInfo.setDesbStationName(req.getParameter("desbStationName"));
		reserveInfo.setbBoardDate1(req.getParameter("bBoardDate1"));
		reserveInfo.setbBoardDate2(req.getParameter("bBoardDate2"));
		reserveInfo.setBusstaDate(req.getParameter("busstaDate"));
		reserveInfo.setBusendDate(req.getParameter("busendDate"));
		reserveInfo.setBgrade(req.getParameter("bgrade"));
		System.out.print(reserveInfo);
		session.setAttribute("reserveBusInfo", reserveInfo);
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
		} else {
			busReserveList(req, resp);
		}
	}
	protected void buslistforward(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveListajax.jsp");
	}
	
	
}

