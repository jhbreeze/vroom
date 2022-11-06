package com.busReserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.util.DBConn;

public class BusReserveDAO {
private Connection conn = DBConn.getConnection();
	
	// 출발지 구하기 (도착지가 선택가능한경우)
public List<BusReserveDTO> getDepStationList() {
	List<BusReserveDTO> list = new ArrayList<>();
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql;
	
	try {
		sql = " SELECT DISTINCT bs.bStationCode, bs.bStationName  "
				+ " FROM busRouteDetail brd "
				+ " LEFT OUTER JOIN busStation bs ON brd.bStationCode = bs.bStationCode ";
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			BusReserveDTO dto = new BusReserveDTO();
			
			dto.setbStationName(rs.getString("bStationName"));
			dto.setbStationCode(rs.getInt("bStationCode"));			
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
	
	// 출발지 토대로 도착지 구하기 -main 페이지  +  세션
	public List<BusReserveDTO> getDesStationList(int depStationCode) {
		List<BusReserveDTO> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT bs.bStationCode, bs.bStationName  "
					+ " FROM busRouteDetail brd "
					+ " LEFT OUTER JOIN busStation bs ON brd.bStationCode = bs.bStationCode "
					+ " WHERE bRouteCode IN ( "
					+ "    SELECT DISTINCT bRouteCode FROM busRouteDetail "
					+ "    WHERE bStationCode = ? )";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, depStationCode);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt("bStationCode") == depStationCode) {
					continue;
				}
				BusReserveDTO dto = new BusReserveDTO();
				
				dto.setbStationCode(rs.getInt("bStationCode"));
				dto.setbStationName(rs.getString("bStationName"));
				
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
	
	//역 이름->노선코드구하기 
		public int getRouteCode(int depbStationCode, int desbStationCode) {
			int RouteCode=0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				sql = " SELECT bRouteCode "
						+ " FROM busRouteDetail "
						+ " WHERE bStationCode IN (?, ?)"
						+ " GROUP BY bRouteCode";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, depbStationCode);
				pstmt.setInt(2, desbStationCode);
				
				rs = pstmt.executeQuery();
		
				if(rs.next()) {
					RouteCode = rs.getInt("bRouteCode");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs !=null) {
					try {
						rs.close();
					} catch (Exception e2) {
					}
				}
				if(pstmt !=null) {
					try {
						pstmt.close();
					} catch (Exception e2) {
					}
				}
			}
			return RouteCode;
		}
		
	// 역코드의 각 노선 상세코드 불러오기
	public int getbRouteDetailCode(int depbStationCode, int desbStationCode) {
		int bRouteDetailCode=0;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		
		try {
			sql = " SELECT bRouteDetailCode FROM busRouteDetail "
					+ "	WHERE bStationCode = ?"
					+ "	 AND bRouteCode = (SELECT bRouteCode FROM ("
					+ "	  SELECT bRouteCode, COUNT(*) FROM ( "
					+ "	   SELECT bRouteCode "
					+ "	   FROM busRouteDetail "
					+ "       WHERE bStationCode IN (?, ?)) "
					+ " GROUP BY bRouteCode "
					+ " HAVING COUNT(*) >= 2))";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, depbStationCode);
			pstmt.setInt(2, depbStationCode);
			pstmt.setInt(3, desbStationCode);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bRouteDetailCode= rs.getInt("bRouteDetailCode");
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
		return bRouteDetailCode;
	}

	//상세노선코드->출발지및 운행정보리스트
	public List<BusReserveDTO> getbRouteInfoList(int bRouteDetailCode){
		List<BusReserveDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		BusReserveDTO dto = null;
		try {
			sql=" SELECT bRouteDetailCodeSta, reservedSeat,bRouteDetailCodeEnd,bs.bStationName, b.bNumId , brd.bRouteCode, bDistance,bTakeTime, bf.bDiv, bOperCode, TO_CHAR(bFirstStaTime,'HH24:MI') bFirstStaTime, TO_CHAR(bEndStaTime,'HH24:MI')bEndStaTime, bName, bType, bFee,bKidsale, bOldsale, seatNum,bri.bDiscern"
					+ " FROM busRouteDetail brd"
					+ " LEFT OUTER JOIN busStation bs on brd.bStationCode = bs.bStationCode"
					+ " LEFT OUTER JOIN busRoute br on brd.bRouteCode = br.bRouteCode"
					+ " LEFT OUTER JOIN busFee bf on br.bRouteCode = bf.bRouteCode"
					+ " LEFT OUTER JOIN busRouteInfo bri on  brd.bRouteDetailCode= bri.bRouteDetailCodeSta"
					+ " LEFT OUTER JOIN bus b on bri.bNumId = b.bNumId "
					+ " LEFT OUTER JOIN  (SELECT COUNT(*) reservedSeat, bNumId  FROM bustkDetail group by bNumId) btd on b.bNumId=btd.bNumId"
					+ " WHERE b.bNumId IN ("
					+ " SELECT bNumId FROM busRouteInfo WHERE bri.bRouteDetailCodeSta= ?) and bf.bDiv = b.bType";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bRouteDetailCode);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new BusReserveDTO();
				dto.setbRouteDetailCodeSta(rs.getInt("bRouteDetailCodeSta"));
				dto.setReservedSeat(rs.getInt("reservedSeat"));
				dto.setbRouteDetailCodeEnd(rs.getInt("bRouteDetailCodeEnd"));
				dto.setbStationName(rs.getString("bStationName"));
				dto.setbNumId(rs.getInt("bNumId"));
				dto.setbRouteCode(rs.getInt("bRouteCode"));
				dto.setbDistance(rs.getInt("bDistance"));
				dto.setbTakeTime(rs.getInt("bTakeTime"));
				dto.setbDiv(rs.getString("bDiv"));
				dto.setbOperCode(rs.getInt("bOperCode"));
				dto.setbFirstStaTime(rs.getString("bFirstStaTime"));
				dto.setbEndStaTime(rs.getString("bEndStaTime"));
				dto.setbName(rs.getString("bName"));
				dto.setbType(rs.getString("bType"));
				dto.setbFee(rs.getLong("bFee"));
				dto.setbKidsale(rs.getInt("bKidsale"));
				dto.setbOldsale(rs.getInt("bOldsale"));
				dto.setSeatNum(rs.getInt("seatNum"));//버스총좌석수 
				dto.setbDiscern(rs.getString("bDiscern"));
				
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
	
	//소요시간
	public int getBTakeTime(int bRouteDetailCode){
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		
		int takeTime = 0;
		
		try {
			sql = "SELECT bTakeTime FROM busRouteDetail WHERE bRouteDetailCode = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bRouteDetailCode);		
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				takeTime = rs.getInt("btakeTime");
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
		return takeTime;
	}
	//운행거리
	public int getBDistance(int bRouteDetailCode){
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		
		int bDistance= 0;
		
		try {
			sql = "SELECT bDistance FROM busRouteDetail WHERE bRouteDetailCode = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bRouteDetailCode);		
			rs = pstmt.executeQuery();
			bDistance = rs.getInt("bDistance");
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
		return bDistance;
	}
	
	//예약된 좌석 리스트
	public List<String> getReservedSeats(int bNumId, int bOperCode, String bBoardDate){
		List<String> reservedSeat = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		
		try {
			sql = "SELECT bSeatNum FROM busTkDetail WHERE bNumId = ? AND "
					+ " BTkNum IN ( SELECT bTkNum FROM busTk WHERE (bOperCode =?)"
					+ " AND TO_CHAR(bBoardDate, 'YYYY-MM-DD') = ?) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bNumId);
			pstmt.setInt(2, bOperCode);
			pstmt.setString(3, bBoardDate);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reservedSeat.add(rs.getString("bSeatNum"));
			
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
		return reservedSeat;
	}
	// seat.do->버스예약 정보 받아서 db에 저장x ->예매-> 예매자 정보 페이지 입력후 db에 정보 입력해야함
	
	// 버스예매 
	public String InsertPayInfo(BusReserveDTO dto) {
		String bTkNumList = null;
		String result = "";

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
			
		try {
			conn.setAutoCommit(false);
			
			List<String> bPassenger = dto.getbPassenger();
			List<Integer> bFee = dto.getbFeefinal();
			List<String> bSeatNum = dto.getbSeatNum();
			
			System.out.println("승객수 : " + bPassenger.size());
			
			int cusNum = dto.getCusNum();
			
			if(cusNum == 0) {
				
				sql = "SELECT customer_seq.NEXTVAL FROM dual";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					cusNum = rs.getInt(1);
				}
				pstmt.close();
				pstmt = null;
				rs.close();
				
				sql = "INSERT INTO customer(cusNum, name, tel, email) VALUES(?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cusNum);
				pstmt.setString(2, dto.getName());
				pstmt.setString(3, dto.getTel());
				pstmt.setString(4, dto.getEmail());
				
				result += pstmt.executeUpdate();
					
				pstmt.close();
				pstmt = null;
			}
			
			String bTkNum;
			Date now = new Date(System.currentTimeMillis());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			int random = (int)Math.random()*1000;
			bTkNum = sdf.format(now)+random;
			bTkNumList = bTkNum;
			
			//busTk
			sql = "INSERT INTO busTk(bTkNum, cusNum, bTotNum, bTotPrice, bPayDay, "
					+ "	bPayPrice, bOperCode, bBoardDate, bDisPrice) "
					+ "	VALUES( ?, ?, ?, ?, SYSDATE, ?, ?, TO_DATE( ? , 'YYYY-MM-DD'),NULL)";
			pstmt = conn.prepareStatement(sql);
			
			//버스별예매번호 랜덤생성 return값 bTkNum
			pstmt.setString(1, bTkNumList);
			pstmt.setInt(2, cusNum);
			pstmt.setInt(3, dto.getbTotNum());
			pstmt.setLong(4, dto.getbTotPrice());//int가 아니라 Long
			pstmt.setLong(5, dto.getbPayPrice());//int가 아니라 Long
			pstmt.setInt(6, dto.getbOperCode());
			pstmt.setString(7, dto.getbBoardDate());
			
			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;
			//버스예매상세
			for(int i=0; i<bPassenger.size(); i++) {
				sql = " INSERT INTO busTkDetail(bNum, bFee, bPassinger, bSeatNum, bNumId,  bTkNum) "
						+ "	VALUES(bTkNum_seq.NEXTVAL,?, ?, ?, ?, ? )";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, bFee.get(i));
				pstmt.setString(2, bPassenger.get(i));
				pstmt.setString(3, bSeatNum.get(i));
				pstmt.setInt(4, dto.getbNumId());//String이 아니라 Int로 설정
				pstmt.setString(5, bTkNumList);
				
				result =bTkNumList;
				
				pstmt.executeUpdate();
				
				pstmt.close();
			}
			System.out.println("실행됨");
			
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
			}
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
			try {
				conn.setAutoCommit(true);
			} catch (Exception e2) {
			}
		}
		return result;
	}
	
}
