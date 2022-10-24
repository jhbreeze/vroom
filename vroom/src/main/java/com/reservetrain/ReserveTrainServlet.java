package com.reservetrain;

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
		reserveInfo.setDeptStationName(req.getParameter("setDeptStationName"));
		reserveInfo.setDestStationName(req.getParameter("setDestStationName"));
		reserveInfo.settBoardDate1(req.getParameter("tBoardDate1"));
		reserveInfo.settBoardDate2(req.getParameter("tBoardDate2"));
		reserveInfo.setStaDate(req.getParameter("staDate"));
		reserveInfo.setEndDate(req.getParameter("endDate"));
		reserveInfo.setGrade(req.getParameter("grade"));
		
		session.setAttribute("reserveInfo", reserveInfo);
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
		} else {
			moveToStepTwo(req, resp);
		}
	}
	
	protected void moveToStepTwo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String cp = req.getContextPath();
		ReserveTrainDAO dao = new ReserveTrainDAO();
		
		ReserveTrainSessionInfo reserveInfo = (ReserveTrainSessionInfo)session.getAttribute("reserveInfo");
		if(reserveInfo == null) {
			resp.sendRedirect(cp + "/");
			return;
		}
		try {
			// 편도 / 왕복, 출발역, 출발시간, 기차번호, 총 소요시간, 도착역, 도착시간, 날짜, 가는날/오는날, 상행/하행, 탑승자 수(어른 / 아이), 좌석 등급
			String cycle = reserveInfo.getCycle(); // 편도 / 왕복
			int deptStationCode = reserveInfo.getDeptStationCode(); // 출발지 코드
			int destStationCode = reserveInfo.getDestStationCode(); // 도착지 코드
			String deptStationName = reserveInfo.getDeptStationName(); // 출발역 이름
			String destStationName = reserveInfo.getDestStationName(); // 도착역 이름
			List<Integer> tRouteDetailCode = dao.getTRouteDetailCode(deptStationCode, destStationCode);
			int deptRouteDetailCode = tRouteDetailCode.get(0); // 출발 노선상세코드
			int destRouteDetailCode = tRouteDetailCode.get(1); // 도착 노선상세코드
			String tDiscern = deptRouteDetailCode > destRouteDetailCode ? "상행" : "하행"; // 상행 / 하행
			String tBoardDate1 = reserveInfo.gettBoardDate1(); // 출발일
			String tBoardDate2 = null;
			if(cycle.equals("full")) {
				tBoardDate2 = reserveInfo.gettBoardDate2(); // 도착일
			}
			int adultCount = reserveInfo.getAdultCount();
			int childCount = reserveInfo.getChildCount();
			String grade = reserveInfo.getGrade();
			int tTotalTime = dao.getTTakeTime(deptStationCode, destStationCode, tDiscern); // 총 소요시간
			List<String> tStaTimeList = dao.getTStaTime(deptStationCode, destStationCode, tDiscern); // 출발시간 리스트(출발역 기준)
			List<String> tendTimeList = dao.getTEndTime(deptStationCode, destStationCode, tDiscern); // 도착시간 리스트(도착역 기준)
			List<Integer> tNumIdList = dao.getTNumId(deptStationCode, destStationCode, tDiscern); // 열차번호 리스트
			
			session.removeAttribute("reserveInfo");
			req.setAttribute("cycle", cycle);
			req.setAttribute("deptStationCode", deptStationCode);
			req.setAttribute("deptStationCode", deptStationCode);
			req.setAttribute("destStationCode", destStationCode);
			req.setAttribute("deptStationName", deptStationName);
			req.setAttribute("destStationName", destStationName);
			req.setAttribute("tRouteDetailCode", tRouteDetailCode);
			req.setAttribute("deptRouteDetailCode", deptRouteDetailCode);
			req.setAttribute("destRouteDetailCode", destRouteDetailCode);
			req.setAttribute("tDiscern", tDiscern);
			req.setAttribute("tBoardDate1", tBoardDate1);
			req.setAttribute("tBoardDate2", tBoardDate2);
			req.setAttribute("adultCount", adultCount);
			req.setAttribute("childCount", childCount);
			req.setAttribute("grade", grade);
			req.setAttribute("tTotalTime", tTotalTime);
			req.setAttribute("tStaTimeList", tStaTimeList);
			req.setAttribute("tendTimeList", tendTimeList);
			req.setAttribute("tNumIdList", tNumIdList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		forward(req, resp, "/WEB-INF/views/reserveTrain/trainsteptwo.jsp");
	}
	
}