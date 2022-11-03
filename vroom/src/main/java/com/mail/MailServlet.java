package com.mail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.util.MyServlet;

@WebServlet("/mail/*")
public class MailServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("send_ok.do") != -1) {
			sendSubmit(req, resp);
		} else if(uri.indexOf("complete.do") != -1) {
			complete(req, resp);
		}
	}

	
	
	protected void sendSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("실행됨 - 2");
		String cp = req.getContextPath();
		
		String content="";
		StringBuilder sb = new StringBuilder();
		String reserveNum = req.getParameter("reserveNum");
		sb.append("<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; background-color: #fff;\">");
		sb.append("<tbody><tr><td><div style=\"margin: 0 auto; max-width: 720px; background-color: #fff; font-family: Malgun Gothic, Dotum, Helvetica, 'Apple SD Gothic Neo', Sans-serif;\">");
		sb.append("<table cellpadding=\"0\" cellspacing=\"0\"style=\"width: 100%; margin: 0 auto; background-color: #fff; text-align: left; letter-spacing: -0.8px;\">");
		sb.append("<tbody><tr><td colspan=\"3\" height=\"24\"></td></tr><tr><td colspan=\"3\" height=\"40\"></td></tr><tr><td width=\"16\"></td><td><table cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; margin: 0; padding: 0\">");
		sb.append("<tbody><tr><td style=\"font-weight: 300; font-size: 26px; color: #000; line-height: 36px; \">예매내역 안내 메일입니다.</td></tr><tr><td style=\"padding-top: 24px; font-weight: 400; font-size: 14px; font-family: 'Noto Sans KR'; color: #666; line-height: 22px; letter-spacing: -0.8px;\">");
		sb.append("안녕하세요. ㈜부릉 입니다. <br> <br> 고객님의 예매번호 안내드립니다. 회원이신 고객님께서는 로그인을 통해 예매내역 조회가 가능합니다. 비회원이신 고객님께서는 아래 예매번호와 본 메일주소를 통해 예매내역 조회가 가능합니다. 본 메일은 예매정보에 기재하신 내용대로 발행되었으며, 잘못된 정보가 적혀있을 경우, 고객센터나 1:1문의를 통해 문의 부탁드립니다. 고객님들의 편안한 여정을 함께하겠습니다.");
		sb.append("</td></tr></tbody></table></td><td width=\"16\"></td></tr><tr><td colspan=\"3\" height=\"40\"></td></tr><tr><td width=\"16\"></td><td><table cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; margin: 0; padding: 0\">");
		sb.append("<tbody><tr><td height=\"1\" style=\"background-color: #ccc;\"></td></tr></tbody></table></td><td width=\"16\"></td></tr><tr><td width=\"16\"></td><td><table cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; margin: 0; padding: 0\">");
		sb.append("<tbody><tr><td valign=\"top\" width=\"104\" style=\"padding-top: 9px; padding-right: 10px; padding-bottom: 9px; padding-left: 10px; font-weight: 400; font-size: 14px; font-family: 'Noto Sans KR'; color: #000; line-height: 22px; letter-spacing: -0.8px; background-color: #fbfbfb;\">예매번호</td>");
		sb.append("<td style=\"padding-top: 9px; padding-right: 10px; padding-bottom: 9px; padding-left: 14px; font-weight: 400; font-size: 14px; font-family: 'Noto Sans KR'; color: #666; line-height: 22px; letter-spacing: -0.8px;\">");
		sb.append("<span style=\"font-family: 'Roboto'; font-size: 15px; letter-spacing: 0;\">"+reserveNum+"</span><!-- 예매번호 --></td></tr><tr><tr><td colspan=\"2\" height=\"1\" style=\"background-color: #eee;\"></td>");
		sb.append("</tr></tbody></table></td><td width=\"16\"></td></tr><tr><td colspan=\"3\" height=\"48\"></td></tr><tr><td width=\"16\"></td><td><a href=\"http://localhost:9090/vroom/member/login.do\" style=\"display: block; padding-top: 12px; padding-bottom: 12px; font-weight: 700; font-size: 16px; font-family: 'noto sans kr'; color: #fff; text-align: center; line-: 24px; letter-spacing: -0.8px; background-color: #0E6EFD; border-radius: 24px; text-decoration: none;\" target=\"_blank\" rel=\"noreferrer noopener\">부릉 로그인하기</a>");
		sb.append("</td><td width=\"16\"></td></tr><tr><td colspan=\"3\" height=\"48\"></td></tr><tr><td width=\"16\"></td><td><table cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; margin: 0; padding: 0\">");
		sb.append("<tbody><tr><td style=\"font-weight: 400; font-size: 14px; font-family: 'Noto Sans KR'; color: #666; line-height: 22px; letter-spacing: -0.8px;\">자세한 예매내역은 부릉홈페이지에서 확인 가능합니다. 탑승시간 24시간 전 까지 환불 가능합니다. <br>");
		sb.append("<br> <strong>환불을 원하시는 경우,</strong><br> 탑승시간을 확인하시어 환불 부탁드리며, 비회원이신 경우 예매번호가 필수적으로 요구됩니다.</td></tr></tbody></table></td><td width=\"16\"></td></tr><tr><td colspan=\"3\" height=\"60\"></td>");
		sb.append("</tr><tr><td colspan=\"3\" height=\"1\" style=\"background-color: #eee\"></td></tr><tr><td width=\"16\"></td><td><table cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; margin: 0; padding: 0\"><tbody>");
		sb.append("<tr><td height=\"23\"></td></tr><tr><td style=\"font-weight: 400; font-size: 12px; font-family: 'Noto Sans KR'; color: #888; line-height: 20px; letter-spacing: -0.8px;\">본 메일은 발신전용으로 회신이되지 않습니다.<br> 문의사항은 부릉 고객센터(<a href=\"tel:18119997\" name=\"ANCHOR4083\" style=\"font-weight: 700; text-decoration: underline;\" target=\"_blank\" rel=\"noreferrer noopener\"><font color=\"#888\">1121-0909</font></a>)를 이용해 주시기 바랍니다.");
		sb.append("</td></tr></tbody></table></td><td width=\"16\"></td></tr></tbody></table></div></td></tr></tbody></table>");
		content = sb.toString();
		
		String url = cp + "/mail/complete.do";
		
		try {
			Mail dto = new Mail();
			
			dto.setSenderName("고객님");
			dto.setSenderEmail("vroomvroomv@naver.com");
			dto.setReceiverEmail("vroomvroomv@naver.com");
			dto.setSubject("부릉부릉 예매내역 입니다.");
			dto.setContent(content);
			
			MailSender sender = new MailSender();
			boolean b = sender.mailSend(dto);
			
			if( ! b ) {
				url += "?fail";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			url += "?fail";
		}
		
		resp.sendRedirect(url);
	}
	
	protected void complete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fail = req.getParameter("fail");
		
		String msg = "";
		if(fail == null) {
			msg += "예매가 완료되었습니다.\n예매 정보는 기재하신 메일로 발송됩니다.";
		} else {
			msg += "메일 전송이 실패되었습니다.";
		}
		
		req.setAttribute("message", msg);
		forward(req, resp, "/WEB-INF/views/mail/complete.jsp");
	}
}
