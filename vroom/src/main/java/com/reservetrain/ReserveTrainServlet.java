package com.reservetrain;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.util.MyServlet;

@WebServlet("/reservetrain/*")
public class ReserveTrainServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("traininsertDepList.do")!=-1) {
			insertDepList(req, resp);
		} else if (uri.indexOf("traininsertDesList.do")!=-1) {
			insertDesList(req, resp);
		} else if (uri.indexOf("trainsteptwo_ok.do")!=-1) {
			beforeMoveToStepTwo(req, resp);
		} else if (uri.indexOf("trainsteptwo.do")!=-1) {
			moveToStepTwo(req, resp);
		} else if (uri.indexOf("reloadsteptwolist.do")!=-1) {
			reploadStepTwoListHTML(req, resp);
		} else if (uri.indexOf("")!=-1) {
		} else if (uri.indexOf("")!=-1) {
		} else if (uri.indexOf("")!=-1) {
		}
	}
	
	protected void insertDepList(HttpServletRequest req, HttpServletResponse resp) {
		ReserveTrainDAO dao = new ReserveTrainDAO();
		try {
			List<ReserveListDetailDTO> depList = dao.getDepStationList();
			
			JSONObject job = new JSONObject();
			JSONArray jarr = new JSONArray();
			for(ReserveListDetailDTO dto : depList) {
				JSONObject jo = new JSONObject();
				
				jo.put("stationCode", dto.gettStationCode());
				jo.put("stationName", dto.gettStationName());
				
				jarr.put(jo);
			}
			job.put("list", jarr);
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.print(job.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void insertDesList(HttpServletRequest req, HttpServletResponse resp) {
		ReserveTrainDAO dao = new ReserveTrainDAO();
		try {
			int deptStationCode = Integer.parseInt(req.getParameter("deptStationCode"));
			List<ReserveListDetailDTO> depList = dao.getDesStationList(deptStationCode);
			
			JSONObject job = new JSONObject();
			JSONArray jarr = new JSONArray();
			for(ReserveListDetailDTO dto : depList) {
				JSONObject jo = new JSONObject();
				
				jo.put("stationCode", dto.gettStationCode());
				jo.put("stationName", dto.gettStationName());
				
				jarr.put(jo);
			}
			job.put("list", jarr);
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.print(job.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	protected void beforeMoveToStepTwo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		ReserveTrainSessionInfo reserveInfo = new ReserveTrainSessionInfo();
		
		reserveInfo.setCycle(req.getParameter("cycle"));
		reserveInfo.setAdultCount(Integer.parseInt(req.getParameter("adultCount")));
		reserveInfo.setChildCount(Integer.parseInt(req.getParameter("childCount")));
		reserveInfo.setDeptStationCode(Integer.parseInt(req.getParameter("deptStationCode")));
		reserveInfo.setDestStationCode(Integer.parseInt(req.getParameter("destStationCode")));
		reserveInfo.setDeptStationName(req.getParameter("deptStationName"));
		reserveInfo.setDestStationName(req.getParameter("destStationName"));
		reserveInfo.settBoardDate1(req.getParameter("tBoardDate1"));
		reserveInfo.settBoardDate2(req.getParameter("tBoardDate2"));
		reserveInfo.setStaDate(req.getParameter("staDate"));
		reserveInfo.setEndDate(req.getParameter("endDate"));
		reserveInfo.setGrade(req.getParameter("grade"));
		reserveInfo.setStaEnd(1);
		
		session.setAttribute("reserveTrainInfo", reserveInfo);
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
		} else {
			moveToStepTwo(req, resp);
		}
	}
	
	protected void moveToStepTwo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		ReserveTrainSessionInfo reserveInfo = (ReserveTrainSessionInfo)session.getAttribute("reserveTrainInfo");
		try {
			String staDate = reserveInfo.getStaDate();
			String endDate = reserveInfo.getEndDate();
			req.setAttribute("staDate", staDate);
			req.setAttribute("endDate", endDate);
			forward(req, resp, "/WEB-INF/views/reservetrain/trainsteptwo.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void reploadStepTwoListHTML(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		String cp = req.getContextPath();
		ReserveTrainDAO dao = new ReserveTrainDAO();
		List<ReserveListDetailDTO> list = new ArrayList<>(); // 편도일 때
		List<ReserveListDetailDTO> list2 = new ArrayList<>(); // 왕복일 때 추가됨
		
		ReserveTrainSessionInfo reserveInfo = (ReserveTrainSessionInfo)session.getAttribute("reserveTrainInfo");
		if(reserveInfo == null) {
			resp.sendRedirect(cp + "/");
			return;
		}
		
		try {
			// 편도 / 왕복, 출발역, 출발시간, 기차번호, 총 소요시간, 도착역, 도착시간, 날짜, 가는날/오는날, 상행/하행, 탑승자 수(어른 / 아이), 좌석 등급
			String cycle = reserveInfo.getCycle(); // half / full
			int deptStationCode = reserveInfo.getDeptStationCode(); // 출발지 코드
			int destStationCode = reserveInfo.getDestStationCode(); // 도착지 코드
			String deptStationName = reserveInfo.getDeptStationName(); // 출발역 이름
			String destStationName = reserveInfo.getDestStationName(); // 도착역 이름
			List<Integer> tRouteDetailCode = dao.getTRouteDetailCode(deptStationCode, destStationCode);
			int deptRouteDetailCode = tRouteDetailCode.get(0); // 출발 노선상세코드
			int destRouteDetailCode = tRouteDetailCode.get(1); // 도착 노선상세코드
			String tDiscern = deptRouteDetailCode > destRouteDetailCode ? "상행" : "하행"; // 상행 / 하행
			String tDiscern2 = deptRouteDetailCode > destRouteDetailCode ? "하행" : "상행"; // 상행 / 하행
			String staDate = reserveInfo.getStaDate();
			String endDate = null;
			if(cycle.equals("full")) {
				endDate = reserveInfo.getEndDate();
			}
			int tTotalTime = dao.getTTakeTime(deptStationCode, destStationCode, tDiscern); // 총 소요시간
			
			String tTotalTimeString;
			String a = (tTotalTime/60)+"";
			String b = (tTotalTime%60)+"";
			if(Integer.parseInt(a)<10) {
				a = "0"+a;
			}
			tTotalTimeString = a+":"+b;
			List<String> tStaTimeList = dao.getTStaTime(deptStationCode, destStationCode, tDiscern); // 출발시간 리스트(출발역 기준) - 가는날
			List<String> tendTimeList = dao.getTEndTime(deptStationCode, destStationCode, tDiscern); // 도착시간 리스트(도착역 기준) - 가는날
			List<Integer> tNumIdList = dao.getTNumId(deptStationCode, destStationCode, tDiscern); // 열차번호 리스트 - 가는날
			if(cycle.equals("full")) {
				List<String> tStaTimeList2 = dao.getTStaTime(destStationCode, deptStationCode, tDiscern2); // 출발시간 리스트(출발역 기준) - 오는날
				List<String> tEndTimeList2 = dao.getTEndTime(destStationCode, deptStationCode, tDiscern2); // 도착시간 리스트(도착역 기준) - 오는날
				List<Integer> tNumIdList2 = dao.getTNumId(destStationCode, deptStationCode, tDiscern2); // 열차번호 리스트 - 오는날
				for(int i=0; i<tStaTimeList2.size(); i++ ) {
					ReserveListDetailDTO dto2 = new ReserveListDetailDTO();
					dto2.settStaTime(tStaTimeList2.get(i));
					dto2.setTendTime(tEndTimeList2.get(i));
					dto2.settNumId(tNumIdList2.get(i));
					
					list2.add(dto2);
				}
			}
			for(int i=0; i<tStaTimeList.size(); i++) {
				ReserveListDetailDTO dto = new ReserveListDetailDTO();
				
				dto.settStaTime(tStaTimeList.get(i));
				dto.setTendTime(tendTimeList.get(i));
				dto.settNumId(tNumIdList.get(i));
				
				list.add(dto);
			}
			req.setAttribute("cycle", cycle);
			req.setAttribute("deptStationName", deptStationName);
			req.setAttribute("destStationName", destStationName);
			req.setAttribute("tDiscern", tDiscern);
			req.setAttribute("staDate", staDate);
			req.setAttribute("endDate", endDate);
			req.setAttribute("tTotalTimeString",tTotalTimeString);
			req.setAttribute("tStaTimeList", tStaTimeList);
			req.setAttribute("tendTimeList", tendTimeList);
			req.setAttribute("tNumIdList", tNumIdList);
			
			req.setAttribute("list", list);
			forward(req, resp, "/WEB-INF/views/reservetrain/trainsteptwoList.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendError(400);
	}
	
	protected void beforeMoveToChoiceSeats(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		ReserveTrainSessionInfo reserveInfo = (ReserveTrainSessionInfo)session.getAttribute("reserveTrainInfo");
		
		String tStaTime = (String)req.getAttribute("tStaTime");
		String tEndTime = (String)req.getAttribute("tEndTime");
	}
}