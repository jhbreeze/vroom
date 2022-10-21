package com.busReserve;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		} else if (uri.indexOf("busreservelist.do")!=-1) {
			busReserveSeat(req,resp);
		} else if (uri.indexOf("")!=-1) {
		} else if (uri.indexOf("")!=-1) {
		}		
	}

	private void busReserveSeat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveSeat.jsp");
		
	}

	protected void busReserveList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/busReserve/busReserveList.jsp");
	}
}

