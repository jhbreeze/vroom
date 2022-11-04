package com.busReserve;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.member.SessionInfo;
import com.reservetrain.ReserveTrainDAO;
import com.reservetrain.ReserveTrainSessionInfo;
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
		}else if (uri.indexOf("reserveSeatList.do")!=-1) {
			reserveSeatList(req,resp);
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
		reserveInfo.setBgrade(req.getParameter("bgrade"));
		reserveInfo.setDepbStationCode(Integer.parseInt(req.getParameter("depbStationCode")));
		reserveInfo.setDesbStationCode(Integer.parseInt(req.getParameter("desbStationCode")));
		reserveInfo.setDepbStationName(req.getParameter("depbStationName"));
		reserveInfo.setDesbStationName(req.getParameter("desbStationName"));
		reserveInfo.setbBoardDate1(req.getParameter("bBoardDate1"));
		reserveInfo.setbBoardDate2(req.getParameter("bBoardDate2"));
		reserveInfo.setBusstaDate(req.getParameter("busstaDate"));
		reserveInfo.setBusendDate(req.getParameter("busendDate"));
		
		System.out.print(reserveInfo);
		session.setAttribute("reserveBusInfo", reserveInfo);
		session.setAttribute("reserve", "버스");
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
		} else {
			busReserveList(req, resp);
		}
	}
	//운행코드
	protected void bOperCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		BusReserveDAO dao = new BusReserveDAO();
		String bTotalTimeString;
		ReserveBusSessionInfo reserveInfo = (ReserveBusSessionInfo)session.getAttribute("reserveBusInfo");

		
		try {
			String bcycle = reserveInfo.getBcycle();
			String bgrade = reserveInfo.getBgrade();
			String depbStationName = reserveInfo.getDepbStationName();
			String desbStationName = reserveInfo.getDesbStationName();
			int depbStationCode = reserveInfo.getDepbStationCode();
			int desbStationCode = reserveInfo.getDesbStationCode();
			int depbRouteDetailCode = dao.getbRouteDetailCode(depbStationCode, desbStationCode);
			//int desbRouteDetailCode = dao.getbRouteDetailCode(desbStationCode, depbStationCode);
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
			req.setAttribute("bgrade", bgrade);
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
	protected void busReserveList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		BusReserveDAO dao = new BusReserveDAO();
		String bTotalTimeString;
		ReserveBusSessionInfo reserveInfo = (ReserveBusSessionInfo)session.getAttribute("reserveBusInfo");

		
		try {
			String bcycle = reserveInfo.getBcycle();
			String bgrade = reserveInfo.getBgrade();                   
			String bBoardDate1 = reserveInfo.getbBoardDate1();
			String depbStationName = reserveInfo.getDepbStationName();
			String desbStationName = reserveInfo.getDesbStationName();
			int depbStationCode = reserveInfo.getDepbStationCode();
			int desbStationCode = reserveInfo.getDesbStationCode();
			int depbRouteDetailCode = dao.getbRouteDetailCode(depbStationCode, desbStationCode);
			//int desbRouteDetailCode = dao.getbRouteDetailCode(desbStationCode, depbStationCode);
			int takeTime = dao.getBTakeTime(depbRouteDetailCode);
			List<BusReserveDTO> bRouteInfoList = dao.getbRouteInfoList(depbRouteDetailCode) ;
			int bRouteDetailCode = dao.getbRouteDetailCode(depbStationCode, desbStationCode);
			int bRouteCode = dao.getRouteCode(depbStationCode, desbStationCode);
			String busstaDate = reserveInfo.getBusstaDate();
			String busendDate = null;
			if(bcycle.equals("full")) {
				busendDate = reserveInfo.getBusendDate();
			}
			
			bTotalTimeString = bTakeTime(depbStationCode, desbStationCode);
			req.setAttribute("bcycle", bcycle);
			req.setAttribute("bgrade", bgrade);
			req.setAttribute("busstaDate", busstaDate);
			req.setAttribute("busendDate", busendDate);
			req.setAttribute("depbStationName", depbStationName);
			req.setAttribute("desbStationName", desbStationName);
			req.setAttribute("btakeTime", takeTime);
			req.setAttribute("bTotalTimeString",bTotalTimeString);
			
			req.setAttribute("bRouteInfoList", bRouteInfoList);	
			req.setAttribute("bRouteDetailCode",bRouteDetailCode);
			req.setAttribute("bRouteCode",bRouteCode);
			req.setAttribute("bBoardDate1", bBoardDate1);
			
			//reservedSeats = dao.getReservedSeats(bNumId, bOperCode, bBoardDate1); 
			
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
		HttpSession session = req.getSession();
		BusReserveDAO dao = new BusReserveDAO();
		ReserveBusSessionInfo reserveInfo = (ReserveBusSessionInfo)session.getAttribute("reserveBusInfo");

		try {
			int bNumId =Integer.parseInt(req.getParameter("bNumId"));
			int bOperCode = Integer.parseInt(req.getParameter("bOperCode"));
			String busstaDate = req.getParameter("busstaDate");
			
			String busBoardDate = busstaDate.substring(0, busstaDate.length()-2);
			String[] sta = busBoardDate.split("[.]");
			if(Integer.parseInt(sta[1])<10){
				sta[1] = "0"+sta[1];
			}
			if(Integer.parseInt(sta[2])<10){
				sta[2] = "0"+sta[2];
			}
			busBoardDate = sta[0]+"-"+sta[1]+"-"+sta[2];
			
			String bgrade = req.getParameter("bType");
			
			int rows=0, cols=0, notSeat=0;
			
			if (bgrade.equals("우등")) {//우등
				cols = 4;
				rows = 9;
				notSeat = 3;
			} else if(bgrade.equals("일반")){//일반
				cols = 5;
				rows = 11;
				notSeat = 3;
			} else if(bgrade.equals("프리미엄")){//프리미엄
				cols = 4;
				rows = 7;
				notSeat = 3;
			}
			req.setAttribute("reservedSeat", req.getParameter("reservedSeat"));
			req.setAttribute("cols", cols);
			req.setAttribute("rows", rows);
			req.setAttribute("notSeat", notSeat);
			
			req.setAttribute("bNumId", bNumId);
			req.setAttribute("bOperCode", bOperCode);
			req.setAttribute("busstaDate", busstaDate);
			req.setAttribute("busBoardDate", busBoardDate); // yyyy-MM-dd
			
			req.setAttribute("bgrade", bgrade);
			req.setAttribute("bKidsale", req.getParameter("bKidsale"));
			req.setAttribute("bOldsale", req.getParameter("bOldsale"));
			req.setAttribute("bFirstStaTime", req.getParameter("bFirstStaTime"));
			req.setAttribute("bEndStaTime", req.getParameter("bEndStaTime"));
			req.setAttribute("bName", req.getParameter("bName"));
			req.setAttribute("bType", req.getParameter("bType"));
			req.setAttribute("bFee", req.getParameter("bFee"));
			req.setAttribute("seatNum", req.getParameter("seatNum"));
			
			/*req.setAttribute("busstaDate", busstaDate);
			String busendDate = req.getParameter("busendDate");
			busendDate = busendDate.substring(0, busendDate.length()-2);
			String[] end= busendDate.split("[.]");
			if(Integer.parseInt(end[1])<10){
				end[1] = "0"+end[1];
			}
			if(Integer.parseInt(sta[2])<10){
				end[2] = "0"+end[2];
			}
			busendDate = end[0]+"-"+end[1]+"-"+end[2];
			
			req.setAttribute("busendDate", req.getParameter("busendDate"));
			*/
			req.setAttribute("depbStationName", req.getParameter("depbStationName"));
			req.setAttribute("desbStationName", req.getParameter("desbStationName"));
			req.setAttribute("btakeTime", req.getParameter("btakeTime"));
			req.setAttribute("bTotalTimeString", req.getParameter("bTotalTimeString"));
			req.setAttribute("bRouteDetailCode", req.getParameter("bRouteDetailCode"));
			req.setAttribute("bRouteCode", req.getParameter("bRouteCode"));
			
			String bcycle = reserveInfo.getBcycle();
			int depbStationCode = reserveInfo.getDepbStationCode();
			int desbStationCode = reserveInfo.getDesbStationCode();
			int depbRouteDetailCode = dao.getbRouteDetailCode(depbStationCode, desbStationCode);
			//int desbRouteDetailCode = dao.getbRouteDetailCode(desbStationCode, depbStationCode);
/*		왕복	
 * 			String busstaDate = reserveInfo.getBusstaDate();
			String busendDate = null;
			if(bcycle.equals("full")) {
				busendDate = reserveInfo.getBusendDate();
			}
			req.setAttribute("busstaDate", busstaDate);
			req.setAttribute("busendDate", busendDate);
			*/
			
			//req.setAttribute("bseatNum", req.getParameter("bseatNum")); //좌석번호
			req.setAttribute("bcycle", bcycle);
			
			List<BusReserveDTO> bRouteInfoList = dao.getbRouteInfoList(depbRouteDetailCode);
			req.setAttribute("bRouteInfoList", bRouteInfoList);
			
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveSeat.jsp");
		return;
	} catch (Exception e) {
		e.printStackTrace(); 
	}
}/*
	protected void busbeforePay(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		BusReserveDAO dao = new BusReserveDAO();
		ReserveBusSessionInfo reserveInfo = (ReserveBusSessionInfo)session.getAttribute("reserveBusInfo");
		
		try {
			 let out = "${pageContext.request.contextPath}/busreserve/busPay.do?";
    	out += "bFirstStaTime="+bFirstStaTime+"&bEndStaTime="+bEndStaTime+"&bName="+bName+"&bType="+bType+"&bFee="+bFee+"&seatNum="+seatNum;
    	out += "&bcycle="+bcycle+"&busstaDate="+busstaDate+"&busendDate="+busendDate+"&depbStationName="+depbStationName;
    	out += "&desbStationName="+desbStationName+"&btakeTime="+btakeTime+"&bTotalTimeString="+bTotalTimeString;
    	out += "&bRouteDetailCode="+bRouteDetailCode+"&bRouteCode="+bRouteCode;
    	
승차권 정보 확인
2022.11.4 금KTX   105서대구  11:21    김천구미  11:44일반   1호차   B-4 (상행)어른  1명5,850 원아이  0명0 원일반요금 적용5,850 원
			 * 
				int totalCost = adultCost + childCost;
				DecimalFormat formatter = new DecimalFormat("###,###");
				req.setAttribute("staadultCost", formatter.format(adultCost));
				req.setAttribute("stachildCost", formatter.format(childCost));
				req.setAttribute("statotalCost", formatter.format(totalCost));
				req.setAttribute("adultCount", adultCount);
				req.setAttribute("childCount", childCount);
				
				
				forward(req, resp, "/WEB-INF/views/reservetrain/trainPay.jsp");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/
	
	private void reserveSeatList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 예약된 좌석 리스트
		
		BusReserveDAO dao = new BusReserveDAO();
		
		int bNumId =Integer.parseInt(req.getParameter("bNumId"));
		int bOperCode = Integer.parseInt(req.getParameter("bOperCode"));
		String busBoardDate = req.getParameter("busBoardDate");
		
		List<String> reservedList = dao.getReservedSeats(bNumId, bOperCode, busBoardDate);
		
		resp.setContentType("text/html; charset=utf-8");
		JSONObject job = new JSONObject();
		job.put("reservedList", reservedList);
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
}

