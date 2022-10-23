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
		
		if(uri.indexOf("insertDepList.do")!=-1) {
			insertDepList(req, resp);
		} else if (uri.indexOf("insertDesList.do")!=-1) {
			insertDesList(req, resp);
		} else if (uri.indexOf("steptwo_ok.do")!=-1) {
			beforeMoveToStepTwo(req, resp);
		} else if (uri.indexOf("steptwo.do")!=-1) {
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
		// 로그인이 되어있는지 확인(되어있지 않다면 로그인페이지로 넘김)
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		ReserveSessionInfo reserveInfo = new ReserveSessionInfo();
		
		reserveInfo.setCycle(req.getParameter("cycle"));
		reserveInfo.setAdultCount(Integer.parseInt(req.getParameter("adultCount")));
		reserveInfo.setChildCount(Integer.parseInt(req.getParameter("childCount")));
		reserveInfo.setDeptStationCode(Integer.parseInt(req.getParameter("deptStationCode")));
		reserveInfo.setDestStationCode(Integer.parseInt(req.getParameter("destStationCode")));
		reserveInfo.settBoardDate1(req.getParameter("tBoardDate1"));
		reserveInfo.settBoardDate2(req.getParameter("tBoardDate2"));
		reserveInfo.setGrade(req.getParameter("grade"));
		
		session.setAttribute("reserveInfo", reserveInfo);
		if(info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
		} else {
			forward(req, resp, "/WEB-INF/views/member/steptwo.do");
		}
	}
	
	protected void moveToStepTwo(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		
		ReserveSessionInfo reserveInfo = (ReserveSessionInfo)session.getAttribute("reserveInfo");
		
	}
}
