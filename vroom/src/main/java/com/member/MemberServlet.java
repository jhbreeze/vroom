package com.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.MyServlet;

@WebServlet("/member/*")
public class MemberServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		if (uri.indexOf("login.do") != -1) {
			loginForm(req, resp);
		} else if (uri.indexOf("login_ok.do") != -1) {
			loginSubmit(req, resp);
		} else if (uri.indexOf("logout.do") != -1) {
			logout(req, resp);
		} else if (uri.indexOf("member.do") != -1) {
			memberForm(req, resp);
		} else if (uri.indexOf("member_ok.do") != -1) {
			memberSubmit(req, resp);
		} else if (uri.indexOf("pwd.do") != -1) {
			pwdForm(req, resp);
		} else if (uri.indexOf("pwd_ok.do") != -1) {
			pwdSubmit(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("userIdCheck.do") != -1) {
			userIdCheck(req, resp);
		}
	}

	private void loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 폼
		String path = "/WEB-INF/views/member/login.jsp";
		forward(req, resp, path);
	}

	private void loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 처리
		HttpSession session = req.getSession();
		
		MemberDAO dao = new MemberDAO();
		String cp = req.getContextPath();
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/");
			return;
		}
		
		String userId = req.getParameter("userId");
		String userPwd = req.getParameter("userPwd");
		
		MemberDTO dto = dao.loginMember(userId, userPwd);
		
		if(dto != null) {
			session.setMaxInactiveInterval(60*60);
			
			SessionInfo info = new SessionInfo();
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			
			session.setAttribute("member", info);
			
			resp.sendRedirect(cp + "/");
			return;
		}
		
		String msg = " 아이디 또는 패스워드가 일치하지 않습니다😥";
		req.setAttribute("message", msg);
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}

	private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그아웃
		HttpSession session = req.getSession();
		String cp = req.getContextPath();

		// 세션에 저장된 정보를 지운다.
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보를 지우고 세션을 초기화 한다.
		session.invalidate();

		// 루트로 리다이렉트
		resp.sendRedirect(cp + "/");
	}

	private void memberForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

	private void memberSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

	private void pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

	private void pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

	private void userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
