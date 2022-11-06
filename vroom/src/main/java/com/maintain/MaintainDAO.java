package com.maintain;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class MaintainDAO {
	private Connection conn = DBConn.getConnection();

	public List<MainTainDTO> TReserveList(int offset, int size) {
		List<MainTainDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		try {
			
			sql = "	WITH tb AS ( "
					+ "	   SELECT td.tDetailCode, td.tOperCode, td.tRouteDetailCode, td.tStaTime , td.tTakeTime,  tr.tStationCode, ts.tStationName   "
					+ "	  	   FROM trainDetail td "
					+ "	  	   JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode  "
					+ "	  	   JOIN trainStation ts ON tr.tStationCode = ts.tStationCode  " 
					+ "	  	) "
					+ "	  SELECT tt.tTkNum, tt.cusNum, tTotNum, tSeatNum, tSeat , t1.tStaTime, t1.tTakeTime, hc.tHoNum, hc.tNumId, c.name, tt.tDisPrice, m.userId, "
					+ "	  tDetailCodeEnd, t1.tStationName tStationNameEnd, "
					+ "	        tDetailCodeSta, t2.tStationName tStationNameSta, "
					+ "	         TO_CHAR(tBoardDate, 'YY/MM/DD(DY)') tBoardDate" 
					+ "	  	FROM trainTk tt "
					+ "	  	JOIN tb t2 ON tt.tDetailCodeEnd = t2.tDetailCode "
					+ "	  	JOIN tb t1 ON tt.tDetailCodeSta = t1.tDetailCode " 
					+ " JOIN (  "
					+ "	    SELECT tSeat, tHoNum, tTkNum, LISTAGG(tSeatNum, ',') WITHIN GROUP(ORDER BY tSeatNum) tSeatNum "
					+ "		FROM trainTkDetail  " 
					+ "		GROUP BY tSeat, tTkNum, tHoNum  "
					+ "	) tdt ON tdt.tTkNum = tt.tTkNum  " 
					+ "	  	JOIN hocha hc ON hc.tHoNum = tdt.tHoNum "
					+ "   LEFT OUTER  JOIN customer c ON tt.cusNum = c.cusNum "
					+ "   LEFT OUTER JOIN member1 m ON c.cusNum = m.cusNum "
					+ " WHERE tDisPrice IS null "
					+ " ORDER BY tt.tboarddate DESC, tStaTime DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.settTkNum(rs.getBigDecimal("tTkNum"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.settSeatNum(rs.getString("tSeatNum"));
				dto.settSeat(rs.getString("tSeat"));
				dto.settStaTime(rs.getString("tStaTime"));
				dto.settHoNum(rs.getString("tHoNum"));
				dto.settNumId(rs.getInt("tNumId"));
				dto.settDetailCodeEnd(rs.getInt("tDetailCodeEnd"));
				dto.settStationNameEnd(rs.getString("tStationNameEnd"));
				dto.settDetailCodeSta(rs.getInt("tDetailCodeSta"));
				dto.settStationNameSta(rs.getString("tStationNameSta"));
				dto.settBoardDate(rs.getString("tBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setName(rs.getString("name"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.setUserId(rs.getString("userId"));
				
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

	public List<MainTainDTO> TReserveList(int offset, int size, String condition, String keyword) {
		List<MainTainDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;

		try {
			sql = "	WITH tb AS ( "
					+ "	   SELECT td.tDetailCode, td.tOperCode, td.tRouteDetailCode, td.tStaTime , td.tTakeTime,  tr.tStationCode, ts.tStationName   "
					+ "	  	   FROM trainDetail td "
					+ "	  	   JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode  "
					+ "	  	   JOIN trainStation ts ON tr.tStationCode = ts.tStationCode  " 
					+ "	  	) "
					+ "	  SELECT tt.tTkNum, tt.cusNum, tTotNum, tSeatNum, tSeat , t1.tStaTime, t1.tTakeTime, hc.tHoNum, hc.tNumId, c.name, tt.tDisPrice, m.userId, "
					+ "	  tDetailCodeEnd, t1.tStationName tStationNameEnd, "
					+ "	        tDetailCodeSta, t2.tStationName tStationNameSta, "
					+ "	         TO_CHAR(tBoardDate, 'YY/MM/DD(DY)') tBoardDate" 
					+ "	  	FROM trainTk tt "
					+ "	  	JOIN tb t2 ON tt.tDetailCodeEnd = t2.tDetailCode "
					+ "	  	JOIN tb t1 ON tt.tDetailCodeSta = t1.tDetailCode " 
					+ " JOIN (  "
					+ "	    SELECT tSeat, tHoNum, tTkNum, LISTAGG(tSeatNum, ',') WITHIN GROUP(ORDER BY tSeatNum) tSeatNum "
					+ "		FROM trainTkDetail  " 
					+ "		GROUP BY tSeat, tTkNum, tHoNum  "
					+ "	) tdt ON tdt.tTkNum = tt.tTkNum  " 
					+ "	  	JOIN hocha hc ON hc.tHoNum = tdt.tHoNum "
					+ "   LEFT OUTER JOIN customer c ON tt.cusNum = c.cusNum "
					+ "   LEFT OUTER JOIN member1 m ON c.cusNum = m.cusNum ";
			if (condition.equals("name")) {
				sql += " WHERE tDisPrice IS NULL AND INSTR(name, ?) >= 1 ";
			} else if (condition.equals("tBoardDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE tDisPrice IS NULL AND TO_CHAR(tBoardDate, 'YYYYMMDD') = ? ";
			} else if(condition.equals("cusNum")) {
				sql += " WHERE tDisPrice IS NULL AND TO_CHAR(tt.cusNum)  = ? ";
			} else if(condition.equals("tStationName")){
				sql += " WHERE tDisPrice IS NULL AND INSTR(t1.tStationName, ?) >= 1 ";
			}
			sql += " ORDER BY tt.tboarddate DESC, tStaTime DESC ";
			sql += " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			if (condition.equals("all")) {
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.settTkNum(rs.getBigDecimal("tTkNum"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.settSeatNum(rs.getString("tSeatNum"));
				dto.settSeat(rs.getString("tSeat"));
				dto.settStaTime(rs.getString("tStaTime"));
				dto.settHoNum(rs.getString("tHoNum"));
				dto.settNumId(rs.getInt("tNumId"));
				dto.settDetailCodeEnd(rs.getInt("tDetailCodeEnd"));
				dto.settStationNameEnd(rs.getString("tStationNameEnd"));
				dto.settDetailCodeSta(rs.getInt("tDetailCodeSta"));
				dto.settStationNameSta(rs.getString("tStationNameSta"));
				dto.settBoardDate(rs.getString("tBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setName(rs.getString("name"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.setUserId(rs.getString("userId"));

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

	public int tDataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM trainTk"
					+ " WHERE tDisPrice IS null ";
			pstmt = conn.prepareStatement(sql);

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

	public int tDataCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM trainTk tk LEFT OUTER JOIN customer c ON tk.cusNum = c.cusNum "
					+ " LEFT OUTER JOIN trainDetail td ON tk.tDetailCodeEnd = td.tDetailCode "
					+ " LEFT OUTER JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode "
					+ " LEFT OUTER JOIN trainStation ts ON tr.tStationCode = ts.tStationCode "
					+ " LEFT OUTER JOIN customer c ON tk.cusNum = c.cusNum ";
			if (condition.equals("name")) {
				sql += " WHERE tDisPrice IS null AND INSTR(c.name, ?) >= 1 ";
			} else if (condition.equals("tBoardDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE tDisPrice IS null AND TO_CHAR(tBoardDate, 'YYYYMMDD') = ? ";
			} else if(condition.equals("cusNum")) {
				sql += " WHERE tDisPrice IS null AND TO_CHAR(tk.cusNum)  = ? ";
			} else if(condition.equals("tStationName")){
				sql += " WHERE tDisPrice IS NULL AND INSTR(ts.tStationName, ?) >= 1 ";
			}
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if (condition.equals("all")) {
				pstmt.setString(2, keyword);
			}

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

	public List<MainTainDTO> TReserveList2(int offset, int size) {
		List<MainTainDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;

		try {
			sql = "	WITH tb AS ( "
					+ "	   SELECT td.tDetailCode, td.tOperCode, td.tRouteDetailCode, td.tStaTime , td.tTakeTime,  tr.tStationCode, ts.tStationName   "
					+ "	  	   FROM trainDetail td "
					+ "	  	   JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode  "
					+ "	  	   JOIN trainStation ts ON tr.tStationCode = ts.tStationCode  " 
					+ "	  	) "
					+ "	  SELECT tt.tTkNum, tt.cusNum, tTotNum, tSeatNum, tSeat , t1.tStaTime, t1.tTakeTime, hc.tHoNum, hc.tNumId, c.name, tt.tDisPrice, m.userId, "
					+ "	  tDetailCodeEnd, t1.tStationName tStationNameEnd, "
					+ "	        tDetailCodeSta, t2.tStationName tStationNameSta, "
					+ "	         TO_CHAR(tBoardDate, 'YY/MM/DD(DY)') tBoardDate" 
					+ "	  	FROM trainTk tt "
					+ "	  	JOIN tb t2 ON tt.tDetailCodeEnd = t2.tDetailCode "
					+ "	  	JOIN tb t1 ON tt.tDetailCodeSta = t1.tDetailCode " 
					+ " JOIN (  "
					+ "	    SELECT tSeat, tHoNum, tTkNum, LISTAGG(tSeatNum, ',') WITHIN GROUP(ORDER BY tSeatNum) tSeatNum "
					+ "		FROM trainTkDetail  " 
					+ "		GROUP BY tSeat, tTkNum, tHoNum  "
					+ "	) tdt ON tdt.tTkNum = tt.tTkNum  " 
					+ "	  	JOIN hocha hc ON hc.tHoNum = tdt.tHoNum "
					+ "   LEFT OUTER  JOIN customer c ON tt.cusNum = c.cusNum "
					+ "   LEFT OUTER JOIN member1 m ON c.cusNum = m.cusNum "
					+ " WHERE tDisPrice = 0 "
					+ " ORDER BY tt.tboarddate DESC, tStaTime DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.settTkNum(rs.getBigDecimal("tTkNum"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.settSeatNum(rs.getString("tSeatNum"));
				dto.settSeat(rs.getString("tSeat"));
				dto.settStaTime(rs.getString("tStaTime"));
				dto.settHoNum(rs.getString("tHoNum"));
				dto.settNumId(rs.getInt("tNumId"));
				dto.settDetailCodeEnd(rs.getInt("tDetailCodeEnd"));
				dto.settStationNameEnd(rs.getString("tStationNameEnd"));
				dto.settDetailCodeSta(rs.getInt("tDetailCodeSta"));
				dto.settStationNameSta(rs.getString("tStationNameSta"));
				dto.settBoardDate(rs.getString("tBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setName(rs.getString("name"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.setUserId(rs.getString("userId"));
				
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

	public List<MainTainDTO> TReserveList2(int offset, int size, String condition, String keyword) {
		List<MainTainDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;

		try {
			sql = "	WITH tb AS ( "
					+ "	   SELECT td.tDetailCode, td.tOperCode, td.tRouteDetailCode, td.tStaTime , td.tTakeTime,  tr.tStationCode, ts.tStationName   "
					+ "	  	   FROM trainDetail td "
					+ "	  	   JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode  "
					+ "	  	   JOIN trainStation ts ON tr.tStationCode = ts.tStationCode  " 
					+ "	  	) "
					+ "	  SELECT tt.tTkNum, tt.cusNum, tTotNum, tSeatNum, tSeat , t1.tStaTime, t1.tTakeTime, hc.tHoNum, hc.tNumId, c.name, tt.tDisPrice, m.userId, "
					+ "	  tDetailCodeEnd, t1.tStationName tStationNameEnd, "
					+ "	        tDetailCodeSta, t2.tStationName tStationNameSta, "
					+ "	         TO_CHAR(tBoardDate, 'YY/MM/DD(DY)') tBoardDate" 
					+ "	  	FROM trainTk tt "
					+ "	  	JOIN tb t2 ON tt.tDetailCodeEnd = t2.tDetailCode "
					+ "	  	JOIN tb t1 ON tt.tDetailCodeSta = t1.tDetailCode " 
					+ " JOIN (  "
					+ "	    SELECT tSeat, tHoNum, tTkNum, LISTAGG(tSeatNum, ',') WITHIN GROUP(ORDER BY tSeatNum) tSeatNum "
					+ "		FROM trainTkDetail  " 
					+ "		GROUP BY tSeat, tTkNum, tHoNum  "
					+ "	) tdt ON tdt.tTkNum = tt.tTkNum  " 
					+ "	  	JOIN hocha hc ON hc.tHoNum = tdt.tHoNum "
					+ "   LEFT OUTER JOIN customer c ON tt.cusNum = c.cusNum "
					+ "   LEFT OUTER JOIN member1 m ON c.cusNum = m.cusNum ";
			if (condition.equals("name")) {
				sql += " WHERE tDisPrice = 0 AND INSTR(name, ?) >= 1 ";
			} else if (condition.equals("tBoardDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE tDisPrice = 0 AND TO_CHAR(tBoardDate, 'YYYYMMDD') = ? ";
			} else if(condition.equals("cusNum")) {
				sql += " WHERE tDisPrice = 0 AND TO_CHAR(tt.cusNum)  = ? ";
			} else if(condition.equals("tStationName")){
				sql += " WHERE tDisPrice = 0 AND INSTR(t1.tStationName, ?) >= 1 ";
			}
			sql += " ORDER BY tt.tboarddate DESC, tStaTime DESC ";
			sql += " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			if (condition.equals("all")) {
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.settTkNum(rs.getBigDecimal("tTkNum"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.settSeatNum(rs.getString("tSeatNum"));
				dto.settSeat(rs.getString("tSeat"));
				dto.settStaTime(rs.getString("tStaTime"));
				dto.settHoNum(rs.getString("tHoNum"));
				dto.settNumId(rs.getInt("tNumId"));
				dto.settDetailCodeEnd(rs.getInt("tDetailCodeEnd"));
				dto.settStationNameEnd(rs.getString("tStationNameEnd"));
				dto.settDetailCodeSta(rs.getInt("tDetailCodeSta"));
				dto.settStationNameSta(rs.getString("tStationNameSta"));
				dto.settBoardDate(rs.getString("tBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setName(rs.getString("name"));
				dto.settTotNum(rs.getInt("tTotNum"));
				dto.setUserId(rs.getString("userId"));

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

	public int tDataCount2() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM trainTk"
					+ " WHERE tDisPrice = 0 ";
			pstmt = conn.prepareStatement(sql);

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

	public int tDataCount2(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM trainTk tk LEFT OUTER JOIN customer c ON tk.cusNum = c.cusNum "
					+ " LEFT OUTER JOIN trainDetail td ON tk.tDetailCodeEnd = td.tDetailCode "
					+ " LEFT OUTER JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode "
					+ " LEFT OUTER JOIN trainStation ts ON tr.tStationCode = ts.tStationCode "
					+ " LEFT OUTER JOIN customer c ON tk.cusNum = c.cusNum ";
			if (condition.equals("name")) {
				sql += " WHERE tDisPrice = 0 AND INSTR(c.name, ?) >= 1 ";
			} else if (condition.equals("tBoardDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE tDisPrice = 0 AND TO_CHAR(tBoardDate, 'YYYYMMDD') = ? ";
			} else if(condition.equals("cusNum")) {
				sql += " WHERE tDisPrice = 0 AND TO_CHAR(tk.cusNum)  = ? ";
			} else if(condition.equals("tStationName")){
				sql += " WHERE tDisPrice = 0 AND INSTR(ts.tStationName, ?) >= 1 ";
			}
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if (condition.equals("all")) {
				pstmt.setString(2, keyword);
			}

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

	
	public List<MainTainDTO> BReserveList(int offset, int size) {
		List<MainTainDTO> list = new ArrayList<MainTainDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "  SELECT bt.bTkNum, bt.bTotNum, bt.cusNum,  TO_CHAR(bt.bBoardDate, 'YY/MM/DD(DY)') bBoardDate, c.name, m.userId,  "
					+ "    bd.bSeatNum, bd.bNumId,  " 
					+ "    b.bType, b.bName, "
					+ " 	TO_CHAR(bFirstStaTime, '\"\"HH24\":\"MI\"') bFirstStaTime, "
					+ " 	TO_CHAR(bEndStaTime, '\"\"HH24\":\"MI\"') bEndStaTime, "
					+ "	br.bRouteDetailCodeSta, br.bRouteDetailCodeEnd, "
					+ "    bs1.bStationName bStationNameSta, bs2.bStationName bStationNameEnd " 
					+ "    FROM BusTk bt "
					+ "    JOIN ( "
					+ " SELECT bTkNum, bNumId, LISTAGG(bSeatNum, ',') WITHIN GROUP(ORDER BY bSeatNum) bSeatNum "
					+ "    FROM busTkDetail " 
					+ "    GROUP BY bTkNum, bNumId " + "	) bd ON bt.bTkNum = bd.bTkNum "
					+ "	LEFT OUTER JOIN bus b ON b.bNumId = bd.bNumId "
					+ "	LEFT OUTER JOIN busRouteInfo br ON bt.bOperCode = br.bOperCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd1 ON brd1.bRouteDetailCode = br.bRouteDetailCodeSta "
					+ "	LEFT OUTER JOIN busStation bs1 ON brd1.bStationCode = bs1.bStationCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd2 ON brd2.bRouteDetailCode = br.bRouteDetailCodeEnd "
					+ "	LEFT OUTER JOIN busStation bs2 ON brd2.bStationCode = bs2.bStationCode "
					+ "	LEFT OUTER JOIN customer c ON c.cusNum = bt.cusNum " 
					+ " LEFT OUTER JOIN member1 m ON m.cusNum = c.cusNum "
					+ " WHERE bDisPrice IS NULL "
			        + " ORDER BY bBoardDate DESC, bFirstStaTime DESC "
			        + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.setbSeatNum(rs.getString("bSeatNum"));
				dto.setbNumId(rs.getInt("bNumId"));
				dto.setbType(rs.getString("bType"));
				dto.setbName(rs.getString("bName"));
				dto.setbFirstStaTime(rs.getString("bFirstStaTime"));
				dto.setbEndStaTime(rs.getString("bEndStaTime"));
				dto.setbRouteDetailCodeSta(rs.getInt("bRouteDetailCodeSta"));
				dto.setbRouteDetailCodeEnd(rs.getInt("bRouteDetailCodeEnd"));
				dto.setbStationNameSta(rs.getString("bStationNameSta"));
				dto.setbStationNameEnd(rs.getString("bStationNameEnd"));
				dto.setbTotNum(rs.getInt("bTotNum"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setbTkNum(rs.getBigDecimal("bTkNum"));
				dto.setName(rs.getString("name"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setUserId(rs.getString("userId"));

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

	public List<MainTainDTO> BReserveList(int offset, int size, String condition, String keyword) {
		List<MainTainDTO> list = new ArrayList<MainTainDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "  SELECT bt.bTkNum, bt.bTotNum, bt.cusNum,  TO_CHAR(bt.bBoardDate, 'YY/MM/DD(DY)') bBoardDate, c.name, m.userId, "
					+ "    bd.bSeatNum, bd.bNumId,  " 
					+ "    b.bType, b.bName, "
					+ " 	TO_CHAR(bFirstStaTime, '\"\"HH24\":\"MI\"') bFirstStaTime, "
					+ " 	TO_CHAR(bEndStaTime, '\"\"HH24\":\"MI\"') bEndStaTime, "
					+ "	br.bRouteDetailCodeSta, br.bRouteDetailCodeEnd, "
					+ "    bs1.bStationName bStationNameSta, bs2.bStationName bStationNameEnd " + "    FROM BusTk bt "
					+ "    JOIN ( "
					+ " SELECT bTkNum, bNumId, LISTAGG(bSeatNum, ',') WITHIN GROUP(ORDER BY bSeatNum) bSeatNum "
					+ "    FROM busTkDetail " + "    GROUP BY bTkNum, bNumId " + "	) bd ON bt.bTkNum = bd.bTkNum "
					+ " LEFT OUTER JOIN bus b ON b.bNumId = bd.bNumId "
					+ "	LEFT OUTER JOIN busRouteInfo br ON bt.bOperCode = br.bOperCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd1 ON brd1.bRouteDetailCode = br.bRouteDetailCodeSta "
					+ "	LEFT OUTER JOIN busStation bs1 ON brd1.bStationCode = bs1.bStationCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd2 ON brd2.bRouteDetailCode = br.bRouteDetailCodeEnd "
					+ "	LEFT OUTER JOIN busStation bs2 ON brd2.bStationCode = bs2.bStationCode "
					+ "	LEFT OUTER JOIN customer c ON c.cusNum = bt.cusNum " 
					+ " LEFT OUTER JOIN member1 m ON m.cusNum = c.cusNum ";
					if (condition.equals("name")) {
						sql += " WHERE bDisPrice IS null AND INSTR(c.name, ?) >= 1 ";
					} else if (condition.equals("bBoardDate")) {
						keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
						sql += " WHERE bDisPrice IS null AND TO_CHAR(bBoardDate, 'YYYYMMDD') = ? ";
					} else if(condition.equals("cusNum")){
						sql += " WHERE bDisPrice IS null AND TO_CHAR(bt.cusNum) = ? ";
					} else if(condition.equals("bStationName")){
						sql += " WHERE bDisPrice IS NULL AND INSTR(bs1.bStationName, ?) >= 1 ";
					}
					sql+= " ORDER BY bBoardDate DESC, bFirstStaTime DESC ";
			        sql+= " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);
			
			if (condition.equals("all")) {
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.setbSeatNum(rs.getString("bSeatNum"));
				dto.setbNumId(rs.getInt("bNumId"));
				dto.setbType(rs.getString("bType"));
				dto.setbName(rs.getString("bName"));
				dto.setbFirstStaTime(rs.getString("bFirstStaTime"));
				dto.setbEndStaTime(rs.getString("bEndStaTime"));
				dto.setbRouteDetailCodeSta(rs.getInt("bRouteDetailCodeSta"));
				dto.setbRouteDetailCodeEnd(rs.getInt("bRouteDetailCodeEnd"));
				dto.setbStationNameSta(rs.getString("bStationNameSta"));
				dto.setbStationNameEnd(rs.getString("bStationNameEnd"));
				dto.setbTotNum(rs.getInt("bTotNum"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setbTkNum(rs.getBigDecimal("bTkNum"));
				dto.setName(rs.getString("name"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setUserId(rs.getString("userId"));

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

	public int bDataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM busTk"
					+ " WHERE bDisPrice IS null ";
			pstmt = conn.prepareStatement(sql);

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

	public int bDataCount(String condition, String keyword) {

		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM busTk bt "
					+ " JOIN customer c ON bt.cusNum = c.cusNum "
					+ " JOIN busRouteInfo bi ON bt.bOperCode = bi.bOperCode "
					+ " JOIN busRouteDetail bd ON bi.bRouteDetailCodeSta = bd.bRouteDetailCode "
			        + " JOIN busStation bs ON bd.bStationCode = bs.bStationCode ";
			if (condition.equals("name")) {
				sql += " WHERE bDisPrice IS NULL AND INSTR(c.name, ?) >= 1 ";
			} else if (condition.equals("bBoardDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE bDisPrice IS NULL AND TO_CHAR(bBoardDate, 'YYYYMMDD') = ? ";
			} else if(condition.equals("cusNum")) {
				sql += " WHERE bDisPrice IS null AND TO_CHAR(bt.cusNum)  = ? ";
			} else if(condition.equals("bStationName")){
				sql += " WHERE bDisPrice IS NULL AND INSTR(bs.bStationName, ?) >= 1 ";
			}
            pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if (condition.equals("all")) {
				pstmt.setString(2, keyword);
			}

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
	
	public List<MainTainDTO> BReserveList2(int offset, int size) {
		List<MainTainDTO> list = new ArrayList<MainTainDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "  SELECT bt.bTkNum, bt.bTotNum, bt.cusNum,  TO_CHAR(bt.bBoardDate, 'YY/MM/DD(DY)') bBoardDate, c.name, m.userId,  "
					+ "    bd.bSeatNum, bd.bNumId,  " 
					+ "    b.bType, b.bName, "
					+ " 	TO_CHAR(bFirstStaTime, '\"\"HH24\":\"MI\"') bFirstStaTime, "
					+ " 	TO_CHAR(bEndStaTime, '\"\"HH24\":\"MI\"') bEndStaTime, "
					+ "	br.bRouteDetailCodeSta, br.bRouteDetailCodeEnd, "
					+ "    bs1.bStationName bStationNameSta, bs2.bStationName bStationNameEnd " 
					+ "    FROM BusTk bt "
					+ "    JOIN ( "
					+ " SELECT bTkNum, bNumId, LISTAGG(bSeatNum, ',') WITHIN GROUP(ORDER BY bSeatNum) bSeatNum "
					+ "    FROM busTkDetail " 
					+ "    GROUP BY bTkNum, bNumId " + "	) bd ON bt.bTkNum = bd.bTkNum "
					+ "	LEFT OUTER JOIN bus b ON b.bNumId = bd.bNumId "
					+ "	LEFT OUTER JOIN busRouteInfo br ON bt.bOperCode = br.bOperCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd1 ON brd1.bRouteDetailCode = br.bRouteDetailCodeSta "
					+ "	LEFT OUTER JOIN busStation bs1 ON brd1.bStationCode = bs1.bStationCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd2 ON brd2.bRouteDetailCode = br.bRouteDetailCodeEnd "
					+ "	LEFT OUTER JOIN busStation bs2 ON brd2.bStationCode = bs2.bStationCode "
					+ "	LEFT OUTER JOIN customer c ON c.cusNum = bt.cusNum " 
					+ " LEFT OUTER JOIN member1 m ON m.cusNum = c.cusNum "
					+ " WHERE bDisPrice = 0 "
			        + " ORDER BY bBoardDate DESC, bFirstStaTime DESC "
			        + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.setbSeatNum(rs.getString("bSeatNum"));
				dto.setbNumId(rs.getInt("bNumId"));
				dto.setbType(rs.getString("bType"));
				dto.setbName(rs.getString("bName"));
				dto.setbFirstStaTime(rs.getString("bFirstStaTime"));
				dto.setbEndStaTime(rs.getString("bEndStaTime"));
				dto.setbRouteDetailCodeSta(rs.getInt("bRouteDetailCodeSta"));
				dto.setbRouteDetailCodeEnd(rs.getInt("bRouteDetailCodeEnd"));
				dto.setbStationNameSta(rs.getString("bStationNameSta"));
				dto.setbStationNameEnd(rs.getString("bStationNameEnd"));
				dto.setbTotNum(rs.getInt("bTotNum"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setbTkNum(rs.getBigDecimal("bTkNum"));
				dto.setName(rs.getString("name"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setUserId(rs.getString("userId"));

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

	public List<MainTainDTO> BReserveList2(int offset, int size, String condition, String keyword) {
		List<MainTainDTO> list = new ArrayList<MainTainDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql =  "  SELECT bt.bTkNum, bt.bTotNum, bt.cusNum,  TO_CHAR(bt.bBoardDate, 'YY/MM/DD(DY)') bBoardDate, c.name, m.userId, "
					+ "    bd.bSeatNum, bd.bNumId,  " + "    b.bType, b.bName, "
					+ " 	TO_CHAR(bFirstStaTime, '\"\"HH24\":\"MI\"') bFirstStaTime, "
					+ " 	TO_CHAR(bEndStaTime, '\"\"HH24\":\"MI\"') bEndStaTime, "
					+ "	br.bRouteDetailCodeSta, br.bRouteDetailCodeEnd, "
					+ "    bs1.bStationName bStationNameSta, bs2.bStationName bStationNameEnd " + "    FROM BusTk bt "
					+ "    JOIN ( "
					+ " SELECT bTkNum, bNumId, LISTAGG(bSeatNum, ',') WITHIN GROUP(ORDER BY bSeatNum) bSeatNum "
					+ "    FROM busTkDetail " + "    GROUP BY bTkNum, bNumId " + "	) bd ON bt.bTkNum = bd.bTkNum "
					+ " LEFT OUTER JOIN bus b ON b.bNumId = bd.bNumId "
					+ "	LEFT OUTER JOIN busRouteInfo br ON bt.bOperCode = br.bOperCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd1 ON brd1.bRouteDetailCode = br.bRouteDetailCodeSta "
					+ "	LEFT OUTER JOIN busStation bs1 ON brd1.bStationCode = bs1.bStationCode "
					+ "	LEFT OUTER JOIN busRouteDetail brd2 ON brd2.bRouteDetailCode = br.bRouteDetailCodeEnd "
					+ "	LEFT OUTER JOIN busStation bs2 ON brd2.bStationCode = bs2.bStationCode "
					+ "	LEFT OUTER JOIN customer c ON c.cusNum = bt.cusNum " 
					+ " LEFT OUTER JOIN member1 m ON m.cusNum = c.cusNum ";
			if (condition.equals("name")) {
				sql += " WHERE bDisPrice = 0 AND INSTR(c.name, ?) >= 1 ";
			} else if (condition.equals("bBoardDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE bDisPrice = 0 AND TO_CHAR(bBoardDate, 'YYYYMMDD') = ? ";
			} else if(condition.equals("cusNum")){
				sql += " WHERE bDisPrice = 0 AND TO_CHAR(bt.cusNum) = ? ";
			} else if(condition.equals("bStationName")){
				sql += " WHERE bDisPrice = 0 AND INSTR(bs1.bStationName, ?) >= 1 ";
			}
					sql+= " ORDER BY bBoardDate DESC, bFirstStaTime DESC ";
			        sql+= " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);
			
			if (condition.equals("all")) {
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MainTainDTO dto = new MainTainDTO();

				dto.setbSeatNum(rs.getString("bSeatNum"));
				dto.setbNumId(rs.getInt("bNumId"));
				dto.setbType(rs.getString("bType"));
				dto.setbName(rs.getString("bName"));
				dto.setbFirstStaTime(rs.getString("bFirstStaTime"));
				dto.setbEndStaTime(rs.getString("bEndStaTime"));
				dto.setbRouteDetailCodeSta(rs.getInt("bRouteDetailCodeSta"));
				dto.setbRouteDetailCodeEnd(rs.getInt("bRouteDetailCodeEnd"));
				dto.setbStationNameSta(rs.getString("bStationNameSta"));
				dto.setbStationNameEnd(rs.getString("bStationNameEnd"));
				dto.setbTotNum(rs.getInt("bTotNum"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setbTkNum(rs.getBigDecimal("bTkNum"));
				dto.setName(rs.getString("name"));
				dto.setbBoardDate(rs.getString("bBoardDate"));
				dto.setUserId(rs.getString("userId"));

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

	public int bDataCount2() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM busTk"
		        + " WHERE bDisPrice = 0 ";
			pstmt = conn.prepareStatement(sql);

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

	public int bDataCount2(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT NVL(COUNT(*),0) FROM busTk bt "
					+ " LEFT OUTER JOIN customer c ON bt.cusNum = c.cusNum "
					+ " LEFT OUTER JOIN busRouteInfo bi ON bt.bOperCode = bi.bOperCode "
					+ " LEFT OUTER JOIN busRouteDetail bd ON bi.bRouteDetailCodeSta = bd.bRouteDetailCode "
			        + " LEFT OUTER JOIN busStation bs ON bd.bStationCode = bs.bStationCode ";
			if (condition.equals("name")) {
				sql += " WHERE bDisPrice = 0 AND INSTR(c.name, ?) >= 1 ";
			} else if (condition.equals("bBoardDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE bDisPrice = 0 AND TO_CHAR(bBoardDate, 'YYYYMMDD') = ? ";
			} else if(condition.equals("cusNum")) {
				sql += " WHERE bDisPrice = 0 AND TO_CHAR(bt.cusNum)  = ? ";
			} else if(condition.equals("bStationName")){
				sql += " WHERE bDisPrice = 0 AND INSTR(bs.bStationName, ?) >= 1 ";
			}
            pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if (condition.equals("all")) {
				pstmt.setString(2, keyword);
			}

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

	public int tTaketimeCount(int tDetailCodeSta, int tDetailCodeEnd) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT SUM(tTakeTime) tTakeTime" + " FROM trainDetail "
					+ "	WHERE tdetailCode >? AND tdetailCode <=? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, tDetailCodeSta);
			pstmt.setInt(2, tDetailCodeEnd);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				result = rs.getInt("tTakeTime");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e2) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
				}
			}
		}
		return result;
	}

}
