package com.sales;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class SalesDAO {
	private Connection conn = DBConn.getConnection();
	
	// 기차데이터 개수 셈
	public int dataCountTrain(String year, String month, String date, String mode) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String form;
		String form2;
		String searchDate;
		String bORr;
		
		try {
			if(month.equals("00")) {
				searchDate = year;
				form = "'YYYY'";
				form2 = "'YYYY-MM-DD'";
			} else if(date.equals("00")) {
				searchDate = year + month;
				form = "'YYYYMM'";
				form2 = "'YYYY-MM-DD'";
			} else {
				searchDate = year + month + date;
				form = "'YYYYMMDD'";
				form2 = "'YYYY-MM-DD HH24:MI:SS'";
			}
			
			if(mode.equals("환불내역")) {
				bORr = " = 0 ";
			} else {
				bORr = " IS NULL ";
			}
			
			sql = " SELECT COUNT(*) FROM (SELECT tPayDay FROM ( "
					+ " SELECT TO_CHAR(tPayDay, "+form2+") tPayDay FROM trainTk "
					+ " WHERE tDisPrice "+bORr+" AND TO_CHAR(tPayDay, "+form+")= ? ) "
					+ " GROUP BY tPayDay) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchDate);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

		return result;
	}
	
	// 기차데이터 리스트
	public List<SalesDTO> listSalesTrain(String year, String month, String date, String mode) {
		List<SalesDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String form;
		String form2;
		String searchDate;
		String bORr;
		
		try {
			if(month.equals("00")) {
				searchDate = year;
				form = "'YYYY'";
				form2 = "'YYYY-MM-DD'";
			} else if(date.equals("00")) {
				searchDate = year + month;
				form = "'YYYYMM'";
				form2 = "'YYYY-MM-DD'";
			} else {
				searchDate = year + month + date;
				form = "'YYYYMMDD'";
				form2 = "'YYYY-MM-DD HH24:MI:SS'";
			}
			
			if(mode.equals("환불내역")) {
				bORr = " = 0 ";
			} else {
				bORr = " IS NULL ";
			}
			
			sql = " SELECT TO_CHAR(tPayDay, "+form2+"), TO_CHAR(NVL(SUM(tPayPrice),0),'999,999,999')  "
					+ " FROM trainTk "
					+ " WHERE tDisPrice "+bORr+" AND TO_CHAR(tPayDay, "+form+")= ? "
					+ " GROUP BY ROLLUP(TO_CHAR(tPayDay, "+form2+")) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchDate);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SalesDTO dto = new SalesDTO();
				dto.setPayDay(rs.getString(1));
				dto.setPayPrice(rs.getString(2));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
	}
	
	// 버스데이터 개수 셈
	public int dataCountBus(String year, String month, String date, String mode) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String form;
		String form2;
		String searchDate;
		String bORr;

		try {
			if (month.equals("00")) {
				searchDate = year;
				form = "'YYYY'";
				form2 = "'YYYY-MM-DD'";
			} else if (date.equals("00")) {
				searchDate = year + month;
				form = "'YYYYMM'";
				form2 = "'YYYY-MM-DD'";
			} else {
				searchDate = year + month + date;
				form = "'YYYYMMDD'";
				form2 = "'YYYY-MM-DD HH24:MI:SS'";
			}

			if (mode.equals("환불내역")) {
				bORr = " = 0 ";
			} else {
				bORr = " IS NULL ";
			}

			sql = " SELECT COUNT(*) FROM (SELECT bPayDay FROM ( " + " SELECT TO_CHAR(bPayDay, " + form2
					+ ") bPayDay FROM busTk " + " WHERE bDisPrice " + bORr + " AND TO_CHAR(bPayDay, " + form + ")= ? "
					+ " GROUP BY bPayDay)) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchDate);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

		return result;
	}

	// 버스데이터 리스트
	public List<SalesDTO> listSalesBus(String year, String month, String date, String mode) {
		List<SalesDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String form;
		String form2;
		String searchDate;
		String bORr;

		try {
			if (month.equals("00")) {
				searchDate = year;
				form = "'YYYY'";
				form2 = "'YYYY-MM-DD'";
			} else if (date.equals("00")) {
				searchDate = year + month;
				form = "'YYYYMM'";
				form2 = "'YYYY-MM-DD'";
			} else {
				searchDate = year + month + date;
				form = "'YYYYMMDD'";
				form2 = "'YYYY-MM-DD HH24:MI:SS'";
			}

			if (mode.equals("환불내역")) {
				bORr = " = 0 ";
			} else {
				bORr = " IS NULL ";
			}

			sql = " SELECT TO_CHAR(bPayDay, " + form2 + "), TO_CHAR(NVL(SUM(bPayPrice),0),'999,999,999')  "
					+ " FROM busTk " + " WHERE bDisPrice " + bORr + " AND TO_CHAR(bPayDay, " + form + ")= ? "
					+ " GROUP BY ROLLUP(TO_CHAR(bPayDay, " + form2 + ")) ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchDate);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SalesDTO dto = new SalesDTO();
				dto.setPayDay(rs.getString(1));
				dto.setPayPrice(rs.getString(2));
				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

		return list;
	}
}
