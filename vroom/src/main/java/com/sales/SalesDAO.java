package com.sales;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class SalesDAO {
	private Connection conn = DBConn.getConnection();
	
	public List<SalesDTO> TReserveList(int offset, int size) {
		List<SalesDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;

		try {
			sql = "	WITH tb AS ( "
					+ "	   SELECT td.tDetailCode, td.tOperCode, td.tRouteDetailCode, td.tStaTime , td.tTakeTime,  tr.tStationCode, ts.tStationName   "
					+ "	  	   FROM trainDetail td "
					+ "	  	   JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode  "
					+ "	  	   JOIN trainStation ts ON tr.tStationCode = ts.tStationCode  " + "	  	) "
					+ "	  SELECT tt.tTkNum, m.cusNum, tTotNum, tSeatNum, tSeat , t1.tStaTime, t1.tTakeTime, hc.tHoNum, hc.tNumId, "
					+ "	  tDetailCodeEnd, t1.tStationName tStationNameEnd, "
					+ "	        tDetailCodeSta, t2.tStationName tStationNameSta, "
					+ "	         TO_CHAR(tBoardDate, 'YY/MM/DD(DY)') tBoardDate" + "	  	FROM trainTk tt "
					+ "	  	JOIN tb t1 ON tt.tDetailCodeEnd = t1.tDetailCode "
					+ "	  	JOIN tb t2 ON tt.tDetailCodeSta = t2.tDetailCode " + " JOIN (  "
					+ "	    SELECT tSeat, tHoNum, tTkNum, LISTAGG(tSeatNum, ',') WITHIN GROUP(ORDER BY tSeatNum) tSeatNum "
					+ "		FROM trainTkDetail  " + "		GROUP BY tSeat, tTkNum, tHoNum  "
					+ "	) tdt ON tdt.tTkNum = tt.tTkNum  " + "	  	JOIN hocha hc ON hc.tHoNum = tdt.tHoNum "
					+ "	  	JOIN member1 m ON m.cusNum = tt.cusNum "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				SalesDTO dto = new SalesDTO();

				dto.settTkNum(rs.getInt("tTkNum"));
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

				list.add(dto);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
	}
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT NVL(COUNT(*),0) FROM trainTk";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return result;
	}

}
