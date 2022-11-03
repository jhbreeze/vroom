package com.reserve;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;

@WebServlet("/reserve/*")
public class ReserveServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();
		
	
		if(uri.indexOf("list.do")!=-1) {
			// 예매내역 리스트
			list(req,resp);
		} else if (uri.indexOf("check_ok.do") !=-1) {
			// 비회원 예매 조회 완료
			checkForm(req,resp); 
		} else if (uri.indexOf("cancel.do")!=-1) {
									// 예매 취소 
			cancle(req,resp);
		} else if (uri.indexOf("cancel_ok.do")!=-1) {
									// 예매 취소 완료
			cancleSubmit(req,resp);
		}
	}


	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원 기차 예매내역 리스트
		ReserveDAO dao = new ReserveDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		if(info == null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		
		try {
			String userId = info.getUserId();
			List<ReserveDTO> reserveTrainList = dao.memberTReserve(userId);
			
			int result;
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
			for(ReserveDTO dto : reserveTrainList) {
				result = dao.tTaketimeCount(dto.gettDetailCodeSta(), dto.gettDetailCodeEnd());
				Date date = sdf.parse(dto.gettStaTime());
				Date date2 = new Date(date.getTime()+result*60*1000);
				
				dto.settStaTime(dto.gettStaTime().substring(11, dto.gettStaTime().length()-3));
				dto.setCountTime(sdf2.format(date2));
				
				dto.settTaketimeCount(result);
			}
	
			List<ReserveDTO> reserveBusList = dao.memberBReserve(userId);
			
			// System.out.println(reserveBusList.size());
			req.setAttribute("reserveTrainList", reserveTrainList);
			req.setAttribute("reserveBusList", reserveBusList);			
			
			

			forward(req, resp, "/WEB-INF/views/reserve/list.jsp");
			
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	private void checkForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	// 비회원 예매 조회 완료
		
		ReserveDAO dao = new ReserveDAO();
		
		// String cp = req.getContextPath();
		
		try {
			
			String tel = null;
			String reserveNum = null;
			
			
			reserveNum = req.getParameter("reserveNum");
			tel = req.getParameter("tel");
			
			List<ReserveDTO> NonReserveTrainlist = dao.nonMemberTReserve(tel, reserveNum);

			int result;

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
			for (ReserveDTO dto : NonReserveTrainlist) {
				result = dao.tTaketimeCount(dto.gettDetailCodeSta(), dto.gettDetailCodeEnd());
				Date date = sdf.parse(dto.gettStaTime());
				Date date2 = new Date(date.getTime() + result * 60 * 1000);

				dto.settStaTime(dto.gettStaTime().substring(11, dto.gettStaTime().length() - 3));
				dto.setCountTime(sdf2.format(date2));

				dto.settTaketimeCount(result);
			}

			List<ReserveDTO> NonReserveBusList = dao.nonMemberBReserve(tel, reserveNum);

			req.setAttribute("reserveTrainList", NonReserveTrainlist);
			req.setAttribute("reserveBusList", NonReserveBusList);

			forward(req, resp, "/WEB-INF/views/reserve/list.jsp");
		} catch (Exception e) {
		}
	}
	
	
	
	
	/*	( 여기는 필요없음. 나중에 지울 예정 )  
	private void nomemcheckForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 비회원 예매조회 입력부분 을 예매리스트에서 하기  
		ReserveDAO dao = new ReserveDAO(); 
		
		String tel;
		int tTkNum, bTkNum; 
		
		
		try {
			ReserveDTO dto = new ReserveDTO();
			
			dto.setTel(req.getParameter("tel"));
			dto.settTkNum(req.getParameter("tTkNum"));
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		forward(req, resp, "/WEB-INF/views/reserve/check.jsp");	
	}
	
	 */
	
	private void nomemSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//
		forward(req, resp, "/WEB-INF/views/reserve/list.jsp");
	}

	
	private void cancle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 예매 취소(DB에서 삭제)
		forward(req, resp, "/WEB-INF/views/reserve/cancel.jsp");
	}
	
	private void cancleSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원 예매 취소 완료
		String cp = req.getContextPath(); 
	
		// 리다이렉트
		resp.sendRedirect( cp +  "/reserve/list.do?");
	}
	
	private void cancleSubmitNonMember(HttpServletRequest req, HttpServletResponse resp) throws ServletException , IOException {
		// 취소 멤버
	
	}


}

