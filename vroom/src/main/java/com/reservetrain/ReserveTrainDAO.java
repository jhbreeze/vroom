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
			sql = " SELECT DISTINCT tStationCode, tStationName FROM ( "
					+ " SELECT ts.tStationCode, ts.tStationName "
					+ " FROM trainRouteDetail trd "
					+ " LEFT OUTER JOIN trainStation ts ON trd.tStationCode = ts.tStationCode "
					+ " WHERE tRouteCode IN ( "
					+ " SELECT DISTINCT tRouteCode FROM trainRouteDetail "
					+ " WHERE tStationCode = ? )) ";
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
				sent.append("(" + list.get(i)+", ");
			} else if(i>0 && i<list.size()-1) {
				sent.append(list.get(i) + ", ");
			} else {
				sent.append(list.get(i)+")");
			}
		}
		
		try {
			sql = "SELECT tri.tNumId, tri.tOperCode "
					+ "FROM train t "
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
	
	/* 
	 * 필요한 변수 : 역 2개, 운행코드, 등급 
	 * 역 두 개 -> 노선상세코드(이미 있음)
	 * 운행코드와 노선상세코드 -> 기차상세코드
	 * 운행코드 -> 열차번호 알아내기
	 * 운행코드, 등급, 호차리스트 -> 호차번호, 총 좌석수 알아내기
	 * 출발상세코드, 도착상세코드, 일자 -> YYYY년 MM월 DD일 호차번호(List)에 예매된 좌석들 List뽑아내기
	 * 예매된 좌석 수는 length()로 처리
	 * 호차번호 -> 등급
	 */
	
	
	// 운행코드와 노선상세코드 -> 기차상세코드
	public int getTDetailCode(int tOperCode, int tRouteDetailCode) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT tDetailCode FROM trainDetail "
					+ "WHERE tOperCode = ? AND tRouteDetailCode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tOperCode);
			pstmt.setInt(2, tRouteDetailCode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("tDetailCode");
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
	
	// 운행코드 -> 열차번호
	public int getTNumId(int tOperCode) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT tNumId FROM trainRouteInfo "
					+ "WHERE tOperCode = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tOperCode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("tNumId");
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
	
	// 운행코드, 등급, 열차번호 -> 호차번호(List) 알아내기
	public List<HochaDTO> getTHochaList(int tOperCode, String grade, int tNumId) {
		List<HochaDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		String query;
		HochaDTO dto = null;
		if(grade.equals("all")) {
			query = "";
		} else if(grade.equals("premium")) {
			query = "AND hoDiv = '특실' ";
		} else {
			query = "AND hoDiv = '일반' ";
		}
		
		try {
			sql = "SELECT tHoNum, tNumId, hoNum, hoDiv "
					+ "FROM hocha "
					+ "WHERE tNumId = (SELECT tNumId FROM trainRouteInfo "
					+ "    WHERE tOperCode = ?) "
					+ query
					+ "    AND tNumId = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tOperCode);
			pstmt.setInt(2, tNumId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new HochaDTO();
				dto.settHoNum(rs.getString("tHoNum"));
				dto.settNumId(rs.getInt("tNumId"));
				dto.setHoNum(rs.getInt("hoNum"));
				dto.setHoDiv(rs.getString("hoDiv"));
				
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
	
	// 호차번호, 출발상세코드, 도착상세코드, 일자 -> YYYY년 MM월 DD일 호차번호에 예매된 좌석들 List뽑아내기
	public List<String> getReservedSeats(String tHoNum, int staDetailCode, int endDetailCode, String date){
		List<String> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		String result;
		
		try {
			sql = "SELECT tSeatNum "
					+ "FROM trainTkDetail "
					+ "WHERE tHoNum = ? AND "
					+ "    tTkNum IN ( SELECT tTkNum FROM trainTk "
					+ "    WHERE ((tDetailCodeSta >= ? AND tDetailCodeSta <= ?) "
					+ "    OR (tDetailCodeSta < ? AND tDetailCodeEnd > ?)) "
					+ "    AND TO_CHAR(tBoardDate, 'YYYY-MM-DD') = ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tHoNum);
			pstmt.setInt(2, staDetailCode);
			pstmt.setInt(3, endDetailCode);
			pstmt.setInt(4, staDetailCode);
			pstmt.setInt(5, staDetailCode);
			pstmt.setString(6, date);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				result = rs.getString("tSeatNum");
				list.add(result);
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
	
	// 호차번호, 출발상세코드, 도착상세코드, 일자 -> YYYY년 MM월 DD일 호차번호(List)에 예매된 좌석들 List뽑아내기
	public List<HochaDTO> getReservedSeatsList(List<String> hochaList, int staDetailCode, int endDetailCode, String date){
		List<HochaDTO> list = new ArrayList<>();
		List<String> li = null;
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		
		try {
			sql = "SELECT tSeatNum "
					+ "FROM trainTkDetail "
					+ "WHERE tHoNum = ? AND "
					+ "    tTkNum IN ( SELECT tTkNum FROM trainTk "
					+ "    WHERE (tDetailCodeSta >= ? AND tDetailCodeSta <= ?) "
					+ "    OR (tDetailCodeSta < ? AND tDetailCodeEnd > ?) "
					+ "    AND tBoardDate = TO_DATE( ? , 'YYYY-MM-DD')) ";
			for(String thoNum : hochaList) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, thoNum);
				pstmt.setInt(2, staDetailCode);
				pstmt.setInt(3, endDetailCode);
				pstmt.setInt(4, staDetailCode);
				pstmt.setInt(5, staDetailCode);
				pstmt.setString(6, date);
				
				rs = pstmt.executeQuery();
				
				li = new ArrayList<>();
				while(rs.next()) {
					li.add(rs.getString("tSeatNum"));
				}
				HochaDTO dto = new HochaDTO();
				dto.settHoNum(thoNum);
				dto.settSeatNumList(li);
				list.add(dto);
				pstmt.close();
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
	
	// 호차번호 -> 등급
	public String getGrade(String tHoNum) {
		String grade = "";
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		
		try {
			sql = "SELECT hoDiv FROM hocha WHERE tHoNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tHoNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grade = rs.getString("hoDiv");
			}
			if(grade.equals("특실")) {
				grade = "premium";
			} else {
				grade = "basic";
			}
		}  catch (Exception e) {
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
		return grade;
	}
	
	// 역간 거리 구하는 법(노선상세코드 출발역, 도착역 필요)
	public int getTDistance(int deptRouteDetailCode, int destRouteDetailCode) {
		int tDistance = 0;
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		
		try {
			sql = "SELECT SUM(tDistance) FROM trainRouteDetail "
					+ "WHERE tRouteDetailCode > ? AND tRouteDetailCode <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, deptRouteDetailCode);
			pstmt.setInt(2, destRouteDetailCode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				tDistance = rs.getInt(1);
			}
		}  catch (Exception e) {
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
		return tDistance;
	}
}
