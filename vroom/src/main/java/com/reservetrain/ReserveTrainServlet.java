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
		} else if (uri.indexOf("trainChoiceSeats.do")!=-1) {
			moveToChoiceSeats(req, resp);
		} else if (uri.indexOf("choiceSeatsList.do")!=-1) {
			choiceSeatsListHTML(req, resp);
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
			String cycle = reserveInfo.getCycle();
			String staDate = reserveInfo.getStaDate();
			String endDate = reserveInfo.getEndDate();
			String deptStationName = reserveInfo.getDeptStationName();
			String destStationName = reserveInfo.getDestStationName();
			req.setAttribute("cycle", cycle);
			req.setAttribute("staDate", staDate);
			req.setAttribute("endDate", endDate);
			req.setAttribute("deptStationName", deptStationName);
			req.setAttribute("destStationName", destStationName);
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
		List<String> tStaTimeList = new ArrayList<>(); // 출발시간 리스트(출발역 기준) - 가는날
		List<String> tendTimeList = new ArrayList<>(); // 도착시간 리스트(도착역 기준) - 가는날
		List<Integer> tNumIdList = new ArrayList<>(); // 열차번호 리스트 - 가는날
		List<Integer> tOperCodeList = new ArrayList<>(); // 열차번호 리스트 - 가는날
		
		
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
			String hORf = req.getParameter("hORf"); // 없으면 null
			tTotalTimeString = a+":"+b;
			if(hORf==null||hORf.equals("1")) {
				tStaTimeList = dao.getTStaTime(deptStationCode, destStationCode, tDiscern); // 출발시간 리스트(출발역 기준) - 가는날
				tendTimeList = dao.getTEndTime(deptStationCode, destStationCode, tDiscern); // 도착시간 리스트(도착역 기준) - 가는날
				tNumIdList = dao.getTNumId(deptStationCode, destStationCode, tDiscern); // 열차번호 리스트 - 가는날
				tOperCodeList = dao.getTOperCode(deptStationCode, destStationCode, tDiscern); // 운행코드 리스트 - 가는날
				for(int i=0; i<tStaTimeList.size(); i++) {
					ReserveListDetailDTO dto = new ReserveListDetailDTO();
					dto.settStaTime(tStaTimeList.get(i));
					dto.setTendTime(tendTimeList.get(i));
					dto.settNumId(tNumIdList.get(i));
					dto.settOperCode(tOperCodeList.get(i));
					
					list.add(dto);
				}
			} else if(hORf.equals("2")) {
				tStaTimeList = dao.getTStaTime(destStationCode, deptStationCode, tDiscern2); // 출발시간 리스트(출발역 기준) - 오는날
				tendTimeList = dao.getTEndTime(destStationCode, deptStationCode, tDiscern2); // 도착시간 리스트(도착역 기준) - 오는날
				tNumIdList = dao.getTNumId(destStationCode, deptStationCode, tDiscern2); // 열차번호 리스트 - 오는날
				tOperCodeList = dao.getTOperCode(destStationCode, deptStationCode, tDiscern2); // 운행코드 리스트 - 오는날
				tDiscern = tDiscern.equals("상행") ? "하행" : "상행";
				for(int i=0; i<tStaTimeList.size(); i++ ) {
					ReserveListDetailDTO dto = new ReserveListDetailDTO();
					dto.settStaTime(tStaTimeList.get(i));
					dto.setTendTime(tendTimeList.get(i));
					dto.settNumId(tNumIdList.get(i));
					dto.settOperCode(tOperCodeList.get(i));
					
					list.add(dto);
				}
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
	
	protected void moveToChoiceSeats(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		ReserveTrainSessionInfo reserveInfo = (ReserveTrainSessionInfo)session.getAttribute("reserveTrainInfo");
		ReserveTrainDAO dao = new ReserveTrainDAO();
		try {
			if(reserveInfo.getCycle().equals("full")) {
				int deptStationCode = reserveInfo.getDeptStationCode();
				int destStationCode = reserveInfo.getDestStationCode();
				req.setAttribute("staDate", req.getParameter("staDate"));
				req.setAttribute("endDate", req.getParameter("endDate"));
				req.setAttribute("deptStaDateTime", req.getParameter("deptStaDateTime"));
				req.setAttribute("deptEndDateTime", req.getParameter("deptEndDateTime"));
				req.setAttribute("destStaDateTime", req.getParameter("destStaDateTime"));
				req.setAttribute("destEndDateTime", req.getParameter("destEndDateTime"));
				req.setAttribute("deptOperCode", req.getParameter("deptOperCode"));
				req.setAttribute("destOperCode", req.getParameter("destOperCode"));
				req.setAttribute("statDiscern", req.getParameter("statDiscern"));
				req.setAttribute("endtDiscern", req.getParameter("endtDiscern"));
				List<Integer> tRouteDetailCodeList = dao.getTRouteDetailCode(deptStationCode, destStationCode);
				int deptOperCode = Integer.parseInt(req.getParameter("deptOperCode"));
				int depstatDetailCode = dao.getTDetailCode(deptOperCode, tRouteDetailCodeList.get(0));
				int desstatDetailCode = dao.getTDetailCode(deptOperCode, tRouteDetailCodeList.get(1));
				req.setAttribute("depstatDetailCode", depstatDetailCode);
				req.setAttribute("desstatDetailCode", desstatDetailCode);
				List<Integer> tRouteDetailCodeList2 = dao.getTRouteDetailCode(deptStationCode, destStationCode);
				int destOperCode = Integer.parseInt(req.getParameter("deptOperCode"));
				int dependtDetailCode = dao.getTDetailCode(destOperCode, tRouteDetailCodeList2.get(0));
				int desendtDetailCode = dao.getTDetailCode(destOperCode, tRouteDetailCodeList2.get(1));
				req.setAttribute("dependtDetailCode", dependtDetailCode);
				req.setAttribute("desendtDetailCode", desendtDetailCode);
				req.setAttribute("cycle", reserveInfo.getCycle());
				req.setAttribute("grade", reserveInfo.getGrade());
				req.setAttribute("count", reserveInfo.getAdultCount()+reserveInfo.getChildCount());
				
			} else if(reserveInfo.getCycle().equals("half")) {
				int deptStationCode = reserveInfo.getDeptStationCode();
				int destStationCode = reserveInfo.getDestStationCode();
				req.setAttribute("staDate", req.getParameter("staDate"));
				req.setAttribute("tStaTime", req.getParameter("tStaTime"));
				req.setAttribute("tEndTime", req.getParameter("tEndTime"));
				req.setAttribute("tOperCode", req.getParameter("tOperCode"));
				req.setAttribute("tDiscern", req.getParameter("tDiscern"));
				List<Integer> tRouteDetailCodeList = dao.getTRouteDetailCode(deptStationCode, destStationCode);
				int tOperCode = Integer.parseInt(req.getParameter("tOperCode"));
				int statDetailCode = dao.getTDetailCode(tOperCode, tRouteDetailCodeList.get(0));// 출발 기차상세코드
				int endtDetailCode = dao.getTDetailCode(tOperCode, tRouteDetailCodeList.get(1));// 도착 기차상세코드
				req.setAttribute("statDetailCode", statDetailCode);
				req.setAttribute("endtDetailCode", endtDetailCode);
				req.setAttribute("cycle", reserveInfo.getCycle());
				req.setAttribute("grade", reserveInfo.getGrade());
				req.setAttribute("count", reserveInfo.getAdultCount()+reserveInfo.getChildCount());
			}
			
			forward(req, resp, "/WEB-INF/views/reservetrain/choiceseats.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendError(400);
	}
	
	protected void choiceSeatsListHTML(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 필요한 파라미터 : 운행코드, 노선상세코드, 등급, 호차번호, 출발상세코드, 도착상세코드, 일자
		ReserveTrainDAO dao = new ReserveTrainDAO();
		try {
			String hORf = req.getParameter("hORf");
			String cycle = req.getParameter("cycle");
			String grade = req.getParameter("grade");
			String staDate = req.getParameter("staDate");
			staDate = staDate.substring(0, staDate.length()-2).replace(".", "-");
			int count = Integer.parseInt(req.getParameter("count"));
			
			if(cycle.equals("half")) {
				int tOperCode = Integer.parseInt(req.getParameter("tOperCode"));
				int statDetailCode = Integer.parseInt(req.getParameter("statDetailCode"));
				int endtDetailCode = Integer.parseInt(req.getParameter("endtDetailCode"));
				int tNumId = dao.getTNumId(tOperCode); // 열차번호
				List<HochaDTO> tHoNumList = dao.getTHochaList(tOperCode, grade, tNumId); // 호차번호 List
				List<String> hochaList = new ArrayList<>(); // 호차번호 리스트
				
				for(HochaDTO dto : tHoNumList) {
					hochaList.add(dto.gettHoNum());
				}
				
				List<HochaDTO> reservedSeatsList = dao.getReservedSeatsList(hochaList, statDetailCode, endtDetailCode, staDate); // 모든 호차들의 예매된 좌석 리스트
				
				String tHoNum = req.getParameter("tHoNum");
				// 호차번호가 정해지지 않았을 경우, 호차중에 남은 좌석수가 선택한 인원수보다 크면 초기 호차를 해당호차로 정의
				if(tHoNum==null) {
					for(int i=0; i<reservedSeatsList.size(); i++) {
						List<String> tSeatNumList = reservedSeatsList.get(i).gettSeatNumList();
						int leftSeat = tHoNumList.get(i).getHoNum()-tSeatNumList.size();
						String honum = reservedSeatsList.get(i).gettHoNum();
						if(leftSeat > count) {
							tHoNum = honum;
							break;
						}
					}
				}
				List<String> reservedSeats = new ArrayList<>();
				reservedSeats = dao.getReservedSeats(tHoNum, statDetailCode, endtDetailCode, staDate); // 특정 호차의 예매된 좌석 리스트
				String[] reservedSeatsArr = reservedSeats.toArray(new String[0]);
				
				List<HochaDTO> selectHochaList = new ArrayList<>();
				for(int i=0; i<reservedSeatsList.size(); i++) {
					HochaDTO dto = new HochaDTO();
					List<String> tSeatNumList = reservedSeatsList.get(i).gettSeatNumList();
					int leftSeats = tHoNumList.get(i).getHoNum()-tSeatNumList.size();
					if(leftSeats > count) {
						dto.setHoNum(tHoNumList.get(i).getHoNum()); // 좌석수
						dto.settHoNum(reservedSeatsList.get(i).gettHoNum()); // 호차 이름
						String hochaName = reservedSeatsList.get(i).gettHoNum();
						int num = Integer.parseInt(hochaName.substring(4));
						dto.setNum(num); // 몇 호차인지(이름에서 열차번호 뺀거)
						dto.setLeftSeats(leftSeats);
						selectHochaList.add(dto);
					}
				}
				req.setAttribute("list", selectHochaList);
				req.setAttribute("grade", grade);
				req.setAttribute("reservedSeatsArr", reservedSeatsArr);
				req.setAttribute("tHoNum", tHoNum);
				
				forward(req, resp, "/WEB-INF/views/reservetrain/choiceseatsList.jsp");
				return;
				
			} else if(cycle.equals("full")) {
				if(hORf.equals("1")) {
					int deptOperCode = Integer.parseInt(req.getParameter("deptOperCode"));
					int depstatDetailCode = Integer.parseInt(req.getParameter("depstatDetailCode"));
					int desstatDetailCode = Integer.parseInt(req.getParameter("desstatDetailCode"));
					int tNumId = dao.getTNumId(deptOperCode);
					List<HochaDTO> tHoNumList = dao.getTHochaList(deptOperCode, grade, tNumId);
					List<String> hochaList = new ArrayList<>();
					
					for(HochaDTO dto : tHoNumList) {
						hochaList.add(dto.gettHoNum());
					}
					
					List<HochaDTO> reservedSeatsList = dao.getReservedSeatsList(hochaList, depstatDetailCode, desstatDetailCode, staDate);
					
					String tHoNum = req.getParameter("tHoNum");
					if(tHoNum==null) {
						for(int i=0; i<reservedSeatsList.size(); i++) {
							List<String> tSeatNumList = reservedSeatsList.get(i).gettSeatNumList();
							int leftSeat = tHoNumList.get(i).getHoNum()-tSeatNumList.size();
							String honum = reservedSeatsList.get(i).gettHoNum();
							if(leftSeat > count) {
								tHoNum = honum;
								break;
							}
						}
					}
					
					List<String> reservedSeats = new ArrayList<>();
					reservedSeats = dao.getReservedSeats(tHoNum, depstatDetailCode, desstatDetailCode, staDate); // 특정 호차의 예매된 좌석 리스트
					String[] reservedSeatsArr = reservedSeats.toArray(new String[0]);
					
					List<HochaDTO> selectHochaList = new ArrayList<>();
					for(int i=0; i<reservedSeatsList.size(); i++) {
						HochaDTO dto = new HochaDTO();
						List<String> tSeatNumList = reservedSeatsList.get(i).gettSeatNumList();
						int leftSeats = tHoNumList.get(i).getHoNum()-tSeatNumList.size();
						if(leftSeats >= count) {
							dto.setHoNum(reservedSeatsList.get(i).getHoNum()); // 좌석수
							dto.settHoNum(reservedSeatsList.get(i).gettHoNum()); // 호차 이름
							String hochaName = reservedSeatsList.get(i).gettHoNum();
							int num = Integer.parseInt(hochaName.substring(4));
							dto.setNum(num); // 몇 호차인지(이름에서 열차번호 뺀거)
							dto.setLeftSeats(leftSeats);
							selectHochaList.add(dto);
						}
					}
					req.setAttribute("list", selectHochaList);
					req.setAttribute("grade", grade);
					req.setAttribute("reservedSeatsArr", reservedSeatsArr);
					req.setAttribute("tHoNum", tHoNum);
					
					forward(req, resp, "/WEB-INF/views/reservetrain/choiceseatsList.jsp");
					return;
					
				} else if(hORf.equals("2")) {
					String endDate = req.getParameter("endDate");
					endDate = endDate.substring(0, endDate.length()-2).replace(".", "-");
					
					int destOperCode = Integer.parseInt(req.getParameter("destOperCode"));
					int dependtDetailCode = Integer.parseInt(req.getParameter("dependtDetailCode"));
					int desendtDetailCode = Integer.parseInt(req.getParameter("desendtDetailCode"));
					int tNumId = dao.getTNumId(destOperCode);
					List<HochaDTO> tHoNumList = dao.getTHochaList(destOperCode, grade, tNumId);
					List<String> hochaList = new ArrayList<>();
					
					for(HochaDTO dto : tHoNumList) {
						hochaList.add(dto.gettHoNum());
					}
					
					List<HochaDTO> reservedSeatsList = dao.getReservedSeatsList(hochaList, dependtDetailCode, desendtDetailCode, endDate);
					
					String tHoNum = req.getParameter("tHoNum");
					
					if(tHoNum==null) {
						for(int i=0; i<reservedSeatsList.size(); i++) {
							List<String> tSeatNumList = reservedSeatsList.get(i).gettSeatNumList();
							int leftSeat = tHoNumList.get(i).getHoNum()-tSeatNumList.size();
							String honum = reservedSeatsList.get(i).gettHoNum();
							if(leftSeat > count) {
								tHoNum = honum;
								break;
							}
						}
					}
					
					List<String> reservedSeats = new ArrayList<>();
					reservedSeats = dao.getReservedSeats(tHoNum, dependtDetailCode, desendtDetailCode, endDate);
					String[] reservedSeatsArr = reservedSeats.toArray(new String[0]);
					
					List<HochaDTO> selectHochaList = new ArrayList<>();
					for(int i=0; i<reservedSeatsList.size(); i++) {
						HochaDTO dto = new HochaDTO();
						List<String> tSeatNumList = reservedSeatsList.get(i).gettSeatNumList();
						int leftSeats = tHoNumList.get(i).getHoNum()-tSeatNumList.size();
						if(leftSeats > count) {
							dto.setHoNum(reservedSeatsList.get(i).getHoNum()); // 좌석수
							dto.settHoNum(reservedSeatsList.get(i).gettHoNum()); // 호차 이름
							String hochaName = reservedSeatsList.get(i).gettHoNum();
							int num = Integer.parseInt(hochaName.substring(4));
							dto.setNum(num); // 몇 호차인지(이름에서 열차번호 뺀거)
							dto.setLeftSeats(leftSeats);
							selectHochaList.add(dto);
						}
					}
					req.setAttribute("list", selectHochaList);
					req.setAttribute("grade", grade);
					req.setAttribute("reservedSeatsArr", reservedSeatsArr);
					req.setAttribute("tHoNum", tHoNum);
					
					forward(req, resp, "/WEB-INF/views/reservetrain/choiceseatsList.jsp");
					return;
				}
				
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendError(400);
	}
}