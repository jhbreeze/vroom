package com.reserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ReserveDAO {
	private Connection conn = DBConn.getConnection();
	// 1. 예약내역 리스트 뿌리기부터 하기 (여러가지 하면 머리 아프다 .. ) 
			// (비회원)전화번호로 가져오는 셀렉트문 하나 짜야함 .. . . . .. . .
			// 해당하는 예매번호 가져오기 
			
			// 회원용 예매내역리스트 따로 가져오기 
			// 비회원용 예매내역리스트 따로가져오기 
			// -> 그다음 info 있으면 회원용 정보 가ㅕ오기, 비회원이면 두개의 입력을 받아오기.. 
		
	// 선생님께 받은 답변 
		// 전화번호로 가져오는 셀렉트문 하나 짜야함 .. . . . .. . .
		// 해당하는 예매번호 가져오기 
		// 회원용 따로 가져오기 // 비회원용 따로가져오기 -> 그다음 info 있으면 회원용 정보 가ㅕ오기, 비회원이면 두개의 입력을 받아오기.. 
		// 버스,비회원 다 지우고 기차부터 시작하기 
		// 기차만 되면 다른건 복붙해서 할 수 있으니까 일단 회원 기차만 해봐라
	
	
	// [회원] 기차 예매내역 리스트
	public List<ReserveDTO> memberTReserve(String userId) {
		List<ReserveDTO> list = new ArrayList<>();
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
				+ "	  SELECT tt.tTkNum, m.cusNum, tTotNum, tSeatNum, tSeat , t1.tStaTime, t1.tTakeTime, hc.tHoNum, hc.tNumId, "
				+ "	  tDetailCodeEnd, t2.tStationName tStationNameEnd, "  
				+ "	        tDetailCodeSta, t1.tStationName tStationNameSta, "  
				+ "	         TO_CHAR(tBoardDate, 'YY/MM/DD(DY)') tBoardDate, tDisPrice" 
				+ "	  	FROM trainTk tt "
				+ "		JOIN tb t2 ON tt.tDetailCodeEnd = t2.tDetailCode "
				+ "		JOIN tb t1 ON tt.tDetailCodeSta = t1.tDetailCode "
				+ " 	JOIN (  "
				+ "	    SELECT tSeat, tHoNum, tTkNum, LISTAGG(tSeatNum, ',') WITHIN GROUP(ORDER BY tSeatNum) tSeatNum "
				+ "		FROM trainTkDetail  "
				+ "		GROUP BY tSeat, tTkNum, tHoNum  "
				+ "	) tdt ON tdt.tTkNum = tt.tTkNum  "
				// + "	  	JOIN trainTkDetail tdt ON tdt.tTkNum = tt.tTkNum  "
				+ "	  	JOIN hocha hc ON hc.tHoNum = tdt.tHoNum "
				+ "	  	JOIN member1 m ON m.cusNum = tt.cusNum " 
				+ "		WHERE tDisPrice is null AND userId = ? "	
				+ "  	ORDER BY tBoardDate DESC ";
		
		
		
		
		
				pstmt = conn.prepareStatement(sql);
		
				pstmt.setString(1, userId);
		
				rs = pstmt.executeQuery();
				

				
			while (rs.next()) {
				ReserveDTO dto = new ReserveDTO();
		
				dto.settTkNum(rs.getString("tTkNum"));
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
				dto.settDisPrice(rs.getInt("tDisPrice"));
				
				list.add(dto);
		
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
		return list;
	}
	
	// 소요시간 계산
	public int tTaketimeCount(int tDetailCodeSta,int tDetailCodeEnd) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql; 

		try {
			sql = " SELECT SUM(tTakeTime) tTakeTime"
				+ " FROM trainDetail " 
				+ "	WHERE tdetailCode > ? AND tdetailCode <=? "; 
			
			pstmt = conn.prepareStatement(sql); 
			
			pstmt.setInt(1, tDetailCodeSta);
			pstmt.setInt(2, tDetailCodeEnd);
					
			rs = pstmt.executeQuery();
			
			
			if (rs.next()) {
				
				result = rs.getInt("tTakeTime");
				System.out.println("걸리는시간:"+result);
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
	
	
	// [회원] 버스 예매내역 리스트
	public List<ReserveDTO> memberBReserve(String userId) {
		List<ReserveDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		
	
		try {
			
		sql = 
			"  SELECT bt.bTkNum, bt.bTotNum, bt.cusNum,  TO_CHAR(bt.bBoardDate, 'YY/MM/DD(DY)') bBoardDate,  " 
			 + "    bd.bSeatNum, bd.bNumId,  " 
			 + "    b.bType, b.bName, " 
			 + " 	TO_CHAR(bFirstStaTime, '\"\"HH24\":\"MI\"') bFirstStaTime, "
			 + " 	TO_CHAR(bEndStaTime, '\"\"HH24\":\"MI\"') bEndStaTime, "
			 + "	br.bRouteDetailCodeSta, br.bRouteDetailCodeEnd, " 
			 + "    bs1.bStationName bStationNameSta, bs2.bStationName bStationNameEnd, bDisPrice " 
			 + "    FROM BusTk bt " 
			 + "    JOIN ( " 
			 + " SELECT bTkNum, bNumId, LISTAGG(bSeatNum, ',') WITHIN GROUP(ORDER BY bSeatNum) bSeatNum " 
			 + "    FROM busTkDetail " 
			 + "    GROUP BY bTkNum, bNumId " 
			 + "	) bd ON bt.bTkNum = bd.bTkNum " 
			 + "	JOIN bus b ON b.bNumId = bd.bNumId "
			 + "	JOIN busRouteInfo br ON bt.bOperCode = br.bOperCode " 
			 + "	JOIN busRouteDetail brd1 ON brd1.bRouteDetailCode = br.bRouteDetailCodeSta " 
			 + "	JOIN busStation bs1 ON brd1.bStationCode = bs1.bStationCode "
			 + "	JOIN busRouteDetail brd2 ON brd2.bRouteDetailCode = br.bRouteDetailCodeEnd " 
			 + "	JOIN busStation bs2 ON brd2.bStationCode = bs2.bStationCode " 
			 + "	JOIN customer c ON c.cusNum = bt.cusNum " 
			 + " 	JOIN member1 m ON m.cusNum = c.cusNum " 
			 + "	WHERE bt.bDisPrice is null AND userId = ? "	
			 + " 	ORDER BY bBoardDate DESC ";
			
		
				// TO_CHAR(bBoardDate, '""HH24":"MI"')  
		
		
				pstmt = conn.prepareStatement(sql);
		
				pstmt.setString(1, userId);
		
				rs = pstmt.executeQuery();
				
			


			while (rs.next()) {
				ReserveDTO dto = new ReserveDTO();
				// 여기부터 다시 한것임
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
				dto.setbTkNum(rs.getString("bTkNum")); 
				dto.setbDisPrice(rs.getInt("bDisPrice")); 
				
				
				/*
				dto.setbTkNum(rs.getInt("bTkNum"));
				dto.setbRouteDetailCodeSta(rs.getInt("bRouteDetailCodeSta"));
				dto.setbRouteDetailCodeEnd(rs.getInt("bRouteDetailCodeEnd"));
				dto.setbStationName(rs.getString("bStationName"));
				*/
	
				list.add(dto);
		
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
		return list;
	}
	
	
	
	// [비회원] 버스 예매내역 리스트
		public List<ReserveDTO> nonMemberBReserve(String tel, String bTkNum) {
			List<ReserveDTO> list = new ArrayList<>();
			PreparedStatement pstmt = null;
			String sql;
			ResultSet rs = null;
			
			
			try {

				sql = " SELECT bt.bTkNum, bt.bTotNum, bt.cusNum,  TO_CHAR(bt.bBoardDate, 'YY/MM/DD(DY)') bBoardDate,  "
						+ " bd.bSeatNum, bd.bNumId,  " 
						+ "		   b.bType, b.bName, "
						+ "		 	TO_CHAR(bFirstStaTime, '\"\"HH24\":\"MI\"') bFirstStaTime,  "
						+ "	 	TO_CHAR(bEndStaTime, '\"\"HH24\":\"MI\"') bEndStaTime,  "
						+ "		br.bRouteDetailCodeSta, br.bRouteDetailCodeEnd,   "
						+ "	     bs1.bStationName bStationNameSta, bs2.bStationName bStationNameEnd , tel, bDisPrice   "
						+ "	     FROM BusTk bt  " 
						+ "	     JOIN (  "
						+ "	 	SELECT bTkNum, bNumId, LISTAGG(bSeatNum, ',') WITHIN GROUP(ORDER BY bSeatNum) bSeatNum "
						+ "    FROM busTkDetail " + "    GROUP BY bTkNum, bNumId " 
						+ " 	) bd ON bt.bTkNum = bd.bTkNum "
						+ " 	JOIN bus b ON b.bNumId = bd.bNumId "
						+ " 	JOIN busRouteInfo br ON bt.bOperCode = br.bOperCode  "
						+ "	 	JOIN busRouteDetail brd1 ON brd1.bRouteDetailCode = br.bRouteDetailCodeSta  "
						+ "	 	JOIN busStation bs1 ON brd1.bStationCode = bs1.bStationCode  "
						+ "	 	JOIN busRouteDetail brd2 ON brd2.bRouteDetailCode = br.bRouteDetailCodeEnd  "
						+ "	 	JOIN busStation bs2 ON brd2.bStationCode = bs2.bStationCode  "
						+ " 	JOIN customer c ON c.cusNum = bt.cusNum  "
						+ " 	WHERE bt.bDisPrice is null AND tel = ? AND bt.bTkNum = ?  "
						+ " 	ORDER BY bBoardDate DESC ";
				
				
						pstmt = conn.prepareStatement(sql);
			

						pstmt.setString(1, tel);
						pstmt.setString(2, bTkNum);
						
						rs = pstmt.executeQuery();
				

				
				while (rs.next()) {
					ReserveDTO dto = new ReserveDTO();
					
					dto.setbTkNum(rs.getString("bTkNum"));
					dto.setbTotNum(rs.getInt("bTotNum"));
					dto.setbBoardDate(rs.getString("bBoardDate"));
					dto.setbSeatNum(rs.getString("bSeatNum"));
					dto.setbName(rs.getString("bName"));
					dto.setbType(rs.getString("bType"));
					dto.setbFirstStaTime(rs.getString("bFirstStaTime"));
					dto.setbEndStaTime(rs.getString("bEndStaTime")); 
					dto.setbRouteDetailCodeSta(rs.getInt("bRouteDetailCodeSta"));
					dto.setbRouteDetailCodeEnd(rs.getInt("bRouteDetailCodeEnd"));
					dto.setbStationNameEnd(rs.getString("bStationNameEnd"));
					dto.setbStationNameSta(rs.getString("bStationNameSta"));
					dto.setbDisPrice(rs.getInt("bDisPrice")); 
					dto.setTel(rs.getString("tel"));
					dto.setbNumId(rs.getInt("bNumId"));
					dto.setCusNum(rs.getInt("cusNum"));
					
					
					
					list.add(dto);
			
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
			return list;
			
		}
		
		
		// [비회원] 기차예매내역 리스트
		public List<ReserveDTO> nonMemberTReserve(String tel, String tTkNum) {
			List<ReserveDTO> list = new ArrayList<>();
			PreparedStatement pstmt = null;
			String sql;
			ResultSet rs = null;

			try {

				
			sql = " WITH tb AS ( "
				+ "		SELECT td.tDetailCode, td.tOperCode, td.tRouteDetailCode, td.tStaTime , td.tTakeTime,  tr.tStationCode, ts.tStationName   "
				+ "				FROM trainDetail td  " 
				+ "				JOIN trainRouteDetail tr ON td.tRouteDetailCode = tr.tRouteDetailCode  "
				+ "				 JOIN trainStation ts ON tr.tStationCode = ts.tStationCode   "
				+ "				)  "
				+ "				SELECT tt.tTkNum, c.cusNum, tTotNum, tSeatNum, tSeat , t1.tStaTime, t1.tTakeTime, hc.tHoNum, hc.tNumId, " 
				+ "				tDetailCodeEnd, t2.tStationName tStationNameEnd,  "
				+ "				tDetailCodeSta, t1.tStationName tStationNameSta,  "
				+ "				TO_CHAR(tBoardDate, 'YY/MM/DD(DY)') tBoardDate, tel, tDisPrice "
				+ "				FROM trainTk tt  "
				+ "				JOIN tb t2 ON tt.tDetailCodeEnd = t2.tDetailCode  "
				+ "				JOIN tb t1 ON tt.tDetailCodeSta = t1.tDetailCode  "
				+ "				JOIN (   "
				+ "				SELECT tSeat, tHoNum, tTkNum, LISTAGG(tSeatNum, ',') WITHIN GROUP(ORDER BY tSeatNum) tSeatNum  "
				+ "				FROM trainTkDetail 	GROUP BY tSeat, tTkNum, tHoNum   "
				+ "				) tdt ON tdt.tTkNum = tt.tTkNum   	JOIN hocha hc ON hc.tHoNum = tdt.tHoNum  "
				+ "				JOIN customer c ON c.cusNum = tt.cusNum  "
				+ "				WHERE tel = ? AND tt.tTkNum = ? AND tDisPrice is null "
				+ "  			ORDER BY tBoardDate DESC " ;
				
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, tel);
				pstmt.setString(2, tTkNum);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					ReserveDTO dto = new ReserveDTO();

					dto.settTkNum(rs.getString("tTkNum"));
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
					dto.settDisPrice(rs.getInt("tDisPrice"));
					
					list.add(dto);

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

			return list;
		}

		

		// 비회원 기차예매번호 조회 
		public ReserveDTO searchTrainNum(String tTkNum, String tel) {
			PreparedStatement pstmt = null;
			String sql; 
			ResultSet rs = null;
			ReserveDTO dto = null;
			
			
			try {
				sql = " SELECT tTkNum, tel "
					+ " FROM trainTk tk "
					+ " JOIN customer c ON tk.cusNum = c.cusNum "
					+ " WHERE tel= ? AND tTkNum= ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, tTkNum);
				pstmt.setString(2, tel);
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					dto = new ReserveDTO();

					dto.setbTkNum(rs.getString(tTkNum));
					dto.setTel(rs.getString(rs.getString(tel)));
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
			return dto;
			
		}
		
		
		
		// 비회원 버스예매번호 조회
		public ReserveDTO searchBusNum(int bTkNum, String tel) {
			PreparedStatement pstmt = null;
			String sql;
			ResultSet rs = null;
			ReserveDTO dto = new ReserveDTO();
			
			try {
				sql = " SELECT bTkNum, tel "
						+ " FROM busTk bt "
						+ " JOIN customer c ON bt.cusNum = c.cusNum "
						+ " WHERE tel= ? AND bTkNum= ? ";
					
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, bTkNum);
				pstmt.setString(2, tel);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					dto.setbTkNum(rs.getString(bTkNum));
					dto.setTel(rs.getString(rs.getString(tel)));
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
			return dto;
		}
	

		
		// 기차 운임요금 
		public int tPayPrice(ReserveDTO dto) throws SQLException {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql; 

			try {
				sql = " SELECT tPayPrice FROM trainTk WHERE tTkNum = ? "; 
				
				pstmt = conn.prepareStatement(sql); 
				pstmt.setString(1, dto.gettTkNum());
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					result = rs.getInt("tPayPrice");
				}
				
				System.out.println(result);
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
		
		// 예매취소(기차)
		public void cancelReservet(ReserveDTO dto, int tPayPrice) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				conn.setAutoCommit(false);

				sql = " UPDATE trainTk set tDisPrice = 0 WHERE tTkNum = ? ";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, dto.gettTkNum());

				pstmt.executeUpdate();
				pstmt.close();
				pstmt = null;

				sql = " INSERT INTO trainRefund(tTkNum, tRefDate, tRefPrice, tRefFee) VALUES(?, SYSDATE, ?, 0)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, dto.gettTkNum());
				pstmt.setInt(2, tPayPrice); // 임의로 넣음

				pstmt.executeUpdate();
				conn.commit();

			} catch (SQLException e) {
				try {
					conn.rollback();
				} catch (SQLException e2) {
				}
				e.printStackTrace();
				throw e;
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}

				try {
					conn.setAutoCommit(true);
				} catch (SQLException e2) {
				}
			}

		}
		
		// 버스 운임요금
		public int bPayPrice(ReserveDTO dto) throws SQLException {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql; 

			try {
				sql = " SELECT bPayPrice FROM busTK WHERE bTkNum = ? "; 
				
				pstmt = conn.prepareStatement(sql); 
				pstmt.setString(1, dto.getbTkNum());
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					result = rs.getInt("bPayPrice");
				}
				
				System.out.println(result);
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

		// 에매취소(버스)
		public void cancelReserveb(ReserveDTO dto, int bPayPrice) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				conn.setAutoCommit(false);

				sql = " UPDATE busTk set bDisPrice = 0 WHERE bTkNum = ? ";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, dto.getbTkNum());

				pstmt.executeUpdate();
				pstmt.close();
				pstmt = null;

				sql = " INSERT INTO busRefund(bTkNum, bRefDate, bRefPrice, bRefFee) VALUES(?, SYSDATE, ?, 0)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, dto.getbTkNum());
				pstmt.setInt(2, bPayPrice); 

				pstmt.executeUpdate();
				conn.commit();

			} catch (SQLException e) {
				try {
					conn.rollback();
				} catch (SQLException e2) {
				}
				e.printStackTrace();
				throw e;
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}

				try {
					conn.setAutoCommit(true);
				} catch (SQLException e2) {
				}
			}
		}

}