package com.reservetrain;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ReserveTrainDAO {
	private Connection conn = DBConn.getConnection();
	
	// 출발지 구하기
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
	
	// 출발지 토대로 도착지 구하기
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
	
	// 역코드의 각 노선 상세코드 불러오기
	public List<Integer> getTRouteDetailCode(int tDeptStationCode, int tDestStationCode) {
		List<Integer> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		
		try {
			sql = " SELECT tRouteDetailCode FROM trainRouteDetail "
					+ " WHERE tStationCode = ? "
					+ "    AND tRouteCode = (SELECT tRouteCode FROM ( "
					+ "    SELECT tRouteCode, COUNT(*) FROM ( "
					+ "        SELECT tRouteCode "
					+ "        FROM trainRouteDetail "
					+ "        WHERE tStationCode IN (?, ?)) "
					+ "    GROUP BY tRouteCode "
					+ "    HAVING COUNT(*) >= 2)) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, tDeptStationCode);
			pstmt.setInt(2, tDeptStationCode);
			pstmt.setInt(3, tDestStationCode);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list.add(rs.getInt("tRouteDetailCode"));
			}
			pstmt.close();
			pstmt = null;
			rs.close();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, tDestStationCode);
			pstmt.setInt(2, tDeptStationCode);
			pstmt.setInt(3, tDestStationCode);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list.add(rs.getInt("tRouteDetailCode"));
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

	// 역코드가 ?와 ?인 것의 소요시간
	public int getTTakeTime(int tDeptStationCode, int tDestStationCode, String tDiscern){
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int tTotalTime = 0;
		String tDiscern2 = tDiscern.equals("하행") ? "" : "DESC";
		String tDiscern3 = tDiscern.equals("하행") ? "FIRST" : "LAST";
		
		try {
			sql = "SELECT tDetailCode, tOperCode, tRouteDetailCode, tStaTime, tTakeTime, "
					+ "    ((SUM(tTakeTime) OVER(PARTITION BY tOperCode))- "
					+ "    ("+tDiscern3+"_VALUE(tTakeTime) OVER(PARTITION BY tOperCode ORDER BY tRouteDetailCode RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) tTotalTime "
					+ "FROM ( "
					+ "    SELECT tDetailCode, tOperCode, tRouteDetailCode, TO_CHAR(tStaTime,'HH24:MI') tStaTime, tTakeTime "
					+ "    FROM trainDetail "
					+ "    WHERE tOperCode IN (SELECT tOperCode FROM trainRouteInfo "
					+ "        WHERE tRouteDetailCodeSta = "
					+ "        (SELECT tRouteDetailCode FROM( "
					+ "            (SELECT tRouteDetailCode, ranking "
					+ "                FROM (SELECT tRouteDetailCode, RANK() OVER(ORDER BY tRouteDetailCode " + tDiscern2 + ") ranking "
					+ "                    FROM trainRouteDetail "
					+ "                    WHERE tRouteCode = ( "
					+ "                        SELECT tRouteCode FROM ( "
					+ "                        SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                            SELECT tRouteCode "
					+ "                            FROM trainRouteDetail "
					+ "                            WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "                WHERE ranking = 1)))) "
					+ "        AND tRouteDetailCode >= ( "
					+ "            SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "            WHERE tStationCode = ? "
					+ "                AND tRouteCode = (SELECT tRouteCode "
					+ "                    FROM (SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                        SELECT tRouteCode "
					+ "                        FROM trainRouteDetail "
					+ "                        WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "        AND tRouteDetailCode <= ( "
					+ "            SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "            WHERE tStationCode = ? "
					+ "                AND tRouteCode = (SELECT tRouteCode "
					+ "                    FROM (SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                        SELECT tRouteCode "
					+ "                        FROM trainRouteDetail "
					+ "                        WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "    ORDER BY tDetailCode)";
			
			pstmt = conn.prepareStatement(sql);
			
			if(tDiscern.equals("하행")) {
				pstmt.setInt(1, tDeptStationCode);
				pstmt.setInt(2, tDestStationCode);
				pstmt.setInt(3, tDeptStationCode);
				pstmt.setInt(4, tDeptStationCode);
				pstmt.setInt(5, tDestStationCode);
				pstmt.setInt(6, tDestStationCode);
				pstmt.setInt(7, tDeptStationCode);
				pstmt.setInt(8, tDestStationCode);
			} else {
				pstmt.setInt(1, tDestStationCode);
				pstmt.setInt(2, tDeptStationCode);
				pstmt.setInt(3, tDestStationCode);
				pstmt.setInt(4, tDestStationCode);
				pstmt.setInt(5, tDeptStationCode);
				pstmt.setInt(6, tDeptStationCode);
				pstmt.setInt(7, tDestStationCode);
				pstmt.setInt(8, tDeptStationCode);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				tTotalTime = rs.getInt("tTotalTime");
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
		return tTotalTime;
	}
	
	public List<String> getTStaTime(int tDeptStationCode, int tDestStationCode, String tDiscern) {
		List<String> tStaTimeList = new ArrayList<>();
		String staTime;
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		String tDiscern2 = tDiscern.equals("하행") ? "" : "DESC";
		
		try {
			sql = "SELECT tDetailCode, tOperCode, tRouteDetailCode, tStaTime "
					+ "FROM ( "
					+ "    SELECT tDetailCode, tOperCode, tRouteDetailCode, TO_CHAR(tStaTime,'HH24:MI') tStaTime, tTakeTime "
					+ "    FROM trainDetail "
					+ "    WHERE tOperCode IN (SELECT tOperCode FROM trainRouteInfo "
					+ "        WHERE tRouteDetailCodeSta = "
					+ "        (SELECT tRouteDetailCode FROM( "
					+ "            (SELECT tRouteDetailCode, ranking "
					+ "                FROM (SELECT tRouteDetailCode, RANK() OVER(ORDER BY tRouteDetailCode "+tDiscern2+" ) ranking "
					+ "                    FROM trainRouteDetail "
					+ "                    WHERE tRouteCode = ( "
					+ "                        SELECT tRouteCode FROM ( "
					+ "                        SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                            SELECT tRouteCode "
					+ "                            FROM trainRouteDetail "
					+ "                            WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "                WHERE ranking = 1)))) "
					+ "        AND tRouteDetailCode >= ( "
					+ "            SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "            WHERE tStationCode = ? "
					+ "                AND tRouteCode = (SELECT tRouteCode "
					+ "                    FROM (SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                        SELECT tRouteCode "
					+ "                        FROM trainRouteDetail "
					+ "                        WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "        AND tRouteDetailCode <= ( "
					+ "            SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "            WHERE tStationCode = ? "
					+ "                AND tRouteCode = (SELECT tRouteCode "
					+ "                    FROM (SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                        SELECT tRouteCode "
					+ "                        FROM trainRouteDetail "
					+ "                        WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "    ORDER BY tDetailCode) "
					+ "WHERE tRouteDetailCode = ( "
					+ "    SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "    WHERE tStationCode = ? "
					+ "        AND tRouteCode = (SELECT tRouteCode FROM ( "
					+ "        SELECT tRouteCode, COUNT(*) FROM ( "
					+ "            SELECT tRouteCode "
					+ "            FROM trainRouteDetail "
					+ "            WHERE tStationCode IN (?, ?)) "
					+ "        GROUP BY tRouteCode "
					+ "        HAVING COUNT(*) >= 2))) ";
			System.out.println(sql);
			System.out.println(tDiscern);
			System.out.println(tDeptStationCode);
			System.out.println(tDestStationCode);
			pstmt = conn.prepareStatement(sql);
			
			if(tDiscern.equals("하행")) {
				pstmt.setInt(1, tDeptStationCode);
				pstmt.setInt(2, tDestStationCode);
				pstmt.setInt(3, tDeptStationCode);
				pstmt.setInt(4, tDeptStationCode);
				pstmt.setInt(5, tDestStationCode);
				pstmt.setInt(6, tDestStationCode);
				pstmt.setInt(7, tDeptStationCode);
				pstmt.setInt(8, tDestStationCode);
				pstmt.setInt(9, tDeptStationCode);
				pstmt.setInt(10, tDeptStationCode);
				pstmt.setInt(11, tDestStationCode);
			} else {
				pstmt.setInt(1, tDeptStationCode);
				pstmt.setInt(2, tDestStationCode);
				pstmt.setInt(3, tDestStationCode);
				pstmt.setInt(4, tDeptStationCode);
				pstmt.setInt(5, tDestStationCode);
				pstmt.setInt(6, tDeptStationCode);
				pstmt.setInt(7, tDeptStationCode);
				pstmt.setInt(8, tDestStationCode);
				pstmt.setInt(9, tDeptStationCode);
				pstmt.setInt(10, tDeptStationCode);
				pstmt.setInt(11, tDestStationCode);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				staTime = rs.getString("tStaTime");
				tStaTimeList.add(staTime);
				System.out.println("출발시간 : "+staTime);
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
		return tStaTimeList;
	}
	
	public List<String> getTEndTime(int tDeptStationCode, int tDestStationCode, String tDiscern) {
		List<String> tEndTimeList = new ArrayList<>();
		String endTime;
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		String tDiscern2 = tDiscern.equals("하행") ? "" : "DESC";
		
		try {
			sql = "SELECT tDetailCode, tOperCode, tRouteDetailCode, tStaTime "
					+ "FROM ( "
					+ "    SELECT tDetailCode, tOperCode, tRouteDetailCode, TO_CHAR(tStaTime,'HH24:MI') tStaTime, tTakeTime "
					+ "    FROM trainDetail "
					+ "    WHERE tOperCode IN (SELECT tOperCode FROM trainRouteInfo "
					+ "        WHERE tRouteDetailCodeSta = "
					+ "        (SELECT tRouteDetailCode FROM( "
					+ "            (SELECT tRouteDetailCode, ranking "
					+ "                FROM (SELECT tRouteDetailCode, RANK() OVER(ORDER BY tRouteDetailCode "+tDiscern2+" ) ranking "
					+ "                    FROM trainRouteDetail "
					+ "                    WHERE tRouteCode = ( "
					+ "                        SELECT tRouteCode FROM ( "
					+ "                        SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                            SELECT tRouteCode "
					+ "                            FROM trainRouteDetail "
					+ "                            WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "                WHERE ranking = 1)))) "
					+ "        AND tRouteDetailCode >= ( "
					+ "            SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "            WHERE tStationCode = ? "
					+ "                AND tRouteCode = (SELECT tRouteCode "
					+ "                    FROM (SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                        SELECT tRouteCode "
					+ "                        FROM trainRouteDetail "
					+ "                        WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "        AND tRouteDetailCode <= ( "
					+ "            SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "            WHERE tStationCode = ? "
					+ "                AND tRouteCode = (SELECT tRouteCode "
					+ "                    FROM (SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                        SELECT tRouteCode "
					+ "                        FROM trainRouteDetail "
					+ "                        WHERE tStationCode IN (?, ?)) "
					+ "                        GROUP BY tRouteCode "
					+ "                        HAVING COUNT(*) >= 2))) "
					+ "    ORDER BY tDetailCode) "
					+ "WHERE tRouteDetailCode = ( "
					+ "    SELECT tRouteDetailCode FROM trainRouteDetail "
					+ "    WHERE tStationCode = ? "
					+ "        AND tRouteCode = (SELECT tRouteCode FROM ( "
					+ "        SELECT tRouteCode, COUNT(*) FROM ( "
					+ "            SELECT tRouteCode "
					+ "            FROM trainRouteDetail "
					+ "            WHERE tStationCode IN (?, ?)) "
					+ "        GROUP BY tRouteCode "
					+ "        HAVING COUNT(*) >= 2))) ";
			
			pstmt = conn.prepareStatement(sql);
			if(tDiscern.equals("하행")) {
				pstmt.setInt(1, tDeptStationCode);
				pstmt.setInt(2, tDestStationCode);
				pstmt.setInt(3, tDeptStationCode);
				pstmt.setInt(4, tDeptStationCode);
				pstmt.setInt(5, tDestStationCode);
				pstmt.setInt(6, tDestStationCode);
				pstmt.setInt(7, tDeptStationCode);
				pstmt.setInt(8, tDestStationCode);
				pstmt.setInt(9, tDestStationCode);
				pstmt.setInt(10, tDeptStationCode);
				pstmt.setInt(11, tDestStationCode);
			} else {
				pstmt.setInt(1, tDeptStationCode);
				pstmt.setInt(2, tDestStationCode);
				pstmt.setInt(3, tDestStationCode);
				pstmt.setInt(4, tDeptStationCode);
				pstmt.setInt(5, tDestStationCode);
				pstmt.setInt(6, tDeptStationCode);
				pstmt.setInt(7, tDeptStationCode);
				pstmt.setInt(8, tDestStationCode);
				pstmt.setInt(9, tDestStationCode);
				pstmt.setInt(10, tDeptStationCode);
				pstmt.setInt(11, tDestStationCode);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				endTime = rs.getString("tStaTime");
				tEndTimeList.add(endTime);
				System.out.println("도착시간 : "+endTime);
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
		return tEndTimeList;
	}
	
	// 운행코드 리스트
	public List<Integer> getTOperCode(int tDeptStationCode, int tDestStationCode, String tDiscern){
		List<Integer> tOperCodeList = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		String tDiscern2 = tDiscern.equals("하행") ? "" : "DESC";
		int tOrderCode = 0;
		
		try {
			sql = "SELECT tOperCode FROM trainRouteInfo "
					+ "WHERE tRouteDetailCodeSta = "
					+ "(SELECT tRouteDetailCode FROM( "
					+ "    (SELECT tRouteDetailCode, ranking "
					+ "        FROM (SELECT tRouteDetailCode, RANK() OVER(ORDER BY tRouteDetailCode "+tDiscern2+") ranking"
					+ "            FROM trainRouteDetail "
					+ "            WHERE tRouteCode = ( "
					+ "                SELECT tRouteCode FROM ( "
					+ "                SELECT tRouteCode, COUNT(*) FROM ( "
					+ "                    SELECT tRouteCode "
					+ "                    FROM trainRouteDetail "
					+ "                    WHERE tStationCode IN (?, ?)) "
					+ "                GROUP BY tRouteCode "
					+ "                HAVING COUNT(*) >= 2))) "
					+ "        WHERE ranking = 1)))";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tDeptStationCode);
			pstmt.setInt(2, tDestStationCode);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tOrderCode = rs.getInt("tOperCode");
				tOperCodeList.add(tOrderCode);
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
		return tOperCodeList;
	}
	
	// 운행코드 리스트를 받아, 열차번호 확인
	public List<Integer> getTNumId(int tDeptStationCode, int tDestStationCode, String tDiscern) {
		List<Integer> tNumIdList = new ArrayList<>();
		int tNumId = 0;
		String sql;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		List<Integer> list = getTOperCode(tDeptStationCode, tDestStationCode, tDiscern);
		StringBuilder sent = new StringBuilder();
		
		for(int i=0; i<list.size(); i++) {
			if(i==0) {
				sent.append("(");
			} else if(i>0 && i<list.size()-1) {
				sent.append(list.get(i) + ", ");
			} else {
				sent.append(list.get(i)+")");
			}
		}
		
		System.out.println(sent);
		
		try {
			sql = "SELECT tri.tNumId, tri.tOperCode"
					+ "FROM train t"
					+ "RIGHT OUTER JOIN trainRouteInfo tri ON tri.tNumId = t.tNumId "
					+ "WHERE tOperCode IN " + sent ;
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tNumId = rs.getInt("tNumId");
				tNumIdList.add(tNumId);
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
		return tNumIdList;
	}
}
