package com.reservetrain;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ReserveTrainDAO {
	private Connection conn = DBConn.getConnection();
	
	public List<ReserveListDetailDTO> getDepStationList() {
		List<ReserveListDetailDTO> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT tStationCode, tStationName FROM trainStation ORDER BY tStationName";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReserveListDetailDTO dto = new ReserveListDetailDTO();
				dto.settStationCode(rs.getInt("tStationCode"));
				dto.settStationName(rs.getString("tStationName"));
				System.out.println();
				list.add(dto);
			}
		} catch (Exception e) {
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
	
	public List<ReserveListDetailDTO> getDesStationList(int deptStationCode) {
		List<ReserveListDetailDTO> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT ts.tStationCode, ts.tStationName  "
					+ " FROM trainRouteDetail trd\n"
					+ " LEFT OUTER JOIN trainStation ts ON trd.tStationCode = ts.tStationCode "
					+ " WHERE tRouteCode IN ( "
					+ "    SELECT DISTINCT tRouteCode FROM trainRouteDetail "
					+ "    WHERE tStationCode = ? "
					+ " ) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, deptStationCode);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt("tStationCode") == deptStationCode) {
					continue;
				}
				ReserveListDetailDTO dto = new ReserveListDetailDTO();
				dto.settStationCode(rs.getInt("tStationCode"));
				dto.settStationName(rs.getString("tStationName"));
				list.add(dto);
			}
		} catch (Exception e) {
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
}
