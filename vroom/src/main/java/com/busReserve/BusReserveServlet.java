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
		
		
		if (uri.indexOf("businsertlist.do")!=-1) {
			busInsertList(req,resp);
		} else if (uri.indexOf("buslistbefore.do")!=-1) {
			busListBefore(req,resp);
		}else if(uri.indexOf("busreservelist.do")!=-1) {
			busReserveList(req,resp);
		}  else if (uri.indexOf("busreserveseat.do")!=-1) {
			busReserveSeat(req,resp);
		}else if (uri.indexOf("busreserveseat2.do")!=-1) {
			busReserveSeat2(req,resp);
		}
	}

	private void busInsertList(HttpServletRequest req, HttpServletResponse resp) {
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

	
	private void busListBefore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
		session.setAttribute("reserve", "버스");
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
		} else {
			busReserveList(req, resp);
		}
	}

	protected void busReserveList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		BusReserveDAO dao = new BusReserveDAO();
		String bTotalTimeString;
		ReserveBusSessionInfo reserveInfo = (ReserveBusSessionInfo)session.getAttribute("reserveBusInfo");
		

		
		try {
			
			String bcycle = reserveInfo.getBcycle();
			String depbStationName = reserveInfo.getDepbStationName();
			String desbStationName = reserveInfo.getDesbStationName();
			int depbStationCode = reserveInfo.getDepbStationCode();
			int desbStationCode = reserveInfo.getDesbStationCode();
			int depbRouteDetailCode = dao.getbRouteDetailCode(depbStationCode, desbStationCode);
			int desbRouteDetailCode = dao.getbRouteDetailCode(desbStationCode, depbStationCode);
			int takeTime = dao.getBTakeTime(depbRouteDetailCode);
			int bRouteDetailCode = dao.getbRouteDetailCode(depbStationCode, desbStationCode);
			int bRouteCode = dao.getRouteCode(depbStationCode, desbStationCode);
			String busstaDate = reserveInfo.getBusstaDate();
			String busendDate = null;
			if(bcycle.equals("full")) {
				busendDate = reserveInfo.getBusendDate();
			}
			bTotalTimeString = bTakeTime(depbStationCode, desbStationCode);
			
			req.setAttribute("bcycle", bcycle);
			req.setAttribute("busstaDate", busstaDate);
			req.setAttribute("busendDate", busendDate);
			req.setAttribute("depbStationName", depbStationName);
			req.setAttribute("desbStationName", desbStationName);
			req.setAttribute("btakeTime", takeTime);
			req.setAttribute("bTotalTimeString",bTotalTimeString);
			List<BusReserveDTO> bRouteInfoList = dao.getbRouteInfoList(depbRouteDetailCode) ;
			req.setAttribute("bRouteInfoList", bRouteInfoList);	
			req.setAttribute("bRouteDetailCode",bRouteDetailCode);
			req.setAttribute("bRouteCode",bRouteCode);
			
			/*
			 String hORf2 = req.getParameter("hORf"); // 없으면 null
			if(hORf2==null||hORf2.equals("1")) {//편도 or 왕복 가는날
				List<BusReserveDTO> bRouteInfoList = dao.getbRouteInfoList(depbRouteDetailCode) ;
				req.setAttribute("bRouteInfoList", bRouteInfoList);	
			} else if(hORf2.equals("2")) {
				List<BusReserveDTO> bRouteInfoList = dao.getbRouteInfoList(desbRouteDetailCode) ;
				req.setAttribute("bRouteInfoList", bRouteInfoList);	
			}
			*/
			
			forward(req, resp, "/WEB-INF/views/busReserve/busReserveList.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	protected String bTakeTime(int depbStationCode, int desbStationCode) {
		BusReserveDAO dao = new BusReserveDAO();
		int bRouteDetailCode = dao.getbRouteDetailCode(depbStationCode, desbStationCode);
		
		int bTakeTime = dao.getBTakeTime(bRouteDetailCode);
		String bTotalTimeString;
		String a = (bTakeTime/60)+"";//문자열변환
		String b = (bTakeTime%60)+"";
		if(Integer.parseInt(a)<10) {
			a = "0"+a;
		}
		bTotalTimeString = a+"시간"+b+"분 소요";
		
		return  bTotalTimeString;
	}

	
	private void busReserveSeat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveSeat.jsp");
	}
	
	private void busReserveSeat2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveSeat2.jsp");
	}
}

