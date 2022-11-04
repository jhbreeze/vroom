package com.busReserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
	
	
	//busTk테이블 (버스예매)
	//bTkNum	cusNum	bTotNum	bTotPrice	bPayDay	bPayPrice	bDisPrice	bOperCode	bBoardDate
	//버스별예매번호	고객번호	총예매수	총금액	결제일	결제금액	할인금액	운행코드	탑승날짜
	
	
	
	
	// 해당시간대의 버스 예매정보 insert update delete? (busTkDetail 버스예매상세테이블)
	//(bNum(버스예매번호) bfee(운임요금)
	//bPassinger승객유형(어른, 어린이, 경로,장애인)) bSeatNum좌석번호
	//bNumId차량번호	bTkNum버스별예매번호

	
	// 해당시간대의 버스 예매정보 가져오기+ 버스좌석정보(select)
	// 운행테이블의 해당 버스 정보 : (세션정보가져옴)->(노선상세코드_출발역, 노선상세코드_도착역,버스구분) =>해당조건에 맞는 list반환
	//buslist에 필요한 정보
	//버스이름->고속사, 버스등급->등급
	
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
	
	//예약된 좌석
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
	// seat.do->버스예약 정보 받아서 db에 저장
	
	//////////// 버스예매 
	/*public int halfInsertPayInfo(PaymentDTO dto) {
		int result = 0;
		int bTkNumSeq = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;np
			
		try {
			conn.setAutoCommit(false);
			
			List<String> bPassenger = dto.getbPassenger();
			List<Integer> bFee = dto.getbFee();
			List<String> bSeatNum = dto.getbSeatNum();
			
			System.out.println("승객수 : " + bPassenger.size());
			
			
			
			for(int i=0; i<tPassenger.size(); i++) {
				String tNum;
				Date now = new Date(System.currentTimeMillis());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				tNum = sdf.format(now);
				int randomInt = (int)Math.random()*1000;
				tNum += randomInt;
				
				System.out.println(i+"--------");
				sql = "INSERT INTO trainTkDetail(tNum, tTkNum, tFee, tPassinger, tSeat, tHoNum, tSeatNum) "
						+ "	VALUES(?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, tNum);
				pstmt.setInt(2, tTkNumSeq);
				pstmt.setInt(3, tFee.get(i));
				pstmt.setString(4, tPassenger.get(i));
				pstmt.setString(5, dto.gettSeat());
				pstmt.setString(6, dto.gettHoNum());
				pstmt.setString(7, tSeatNum.get(i));
				
				System.out.println("실행 - "+i);
				System.out.println(tNum);
				System.out.println(tTkNumSeq);
				System.out.println(tFee.get(i));
				System.out.println(tPassenger.get(i));
				System.out.println(dto.gettSeat());
				System.out.println(dto.gettHoNum());
				System.out.println(tSeatNum.get(i));
				
				result += pstmt.executeUpdate();
				
				pstmt.close();
			}
			System.out.println("실행됨");

			
			
			
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
			
			sql = "SELECT tTkNum_seq.NEXTVAL FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				tTkNumSeq = rs.getInt(1);
			}
			pstmt.close();
			
			sql = "INSERT INTO trainTk(tTkNum, cusNum, tTotNum, tTotPrice, tPayDay, "
					+ "	tPayPrice, tDetailCodeSta, tDetailCodeEnd, tBoardDate) "
					+ "	VALUES( ?, ?, ?, ?, SYSDATE, ?, ?, ?, TO_DATE( ? , 'YYYY-MM-DD'))";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, tTkNumSeq);
			pstmt.setInt(2, cusNum);
			pstmt.setInt(3, dto.gettTotNum());
			pstmt.setInt(4, dto.gettTotPrice());
			pstmt.setInt(5, dto.gettPayPrice());
			pstmt.setInt(6, dto.gettDetailCodeSta());
			pstmt.setInt(7, dto.gettDetailCodeEnd());
			pstmt.setString(8, dto.gettBoardDate());
			
			result += pstmt.executeUpdate();
				
			pstmt.close();
			
			
			
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
	*/
	
	
	
	
	//2번째 페이지 왼쪽(할인적용전 버스요금)(가격): 노선코드 ->(busRoute+busFee테이블의 버스구분)-(노선의 버스종류별 요금)(bFee)
	
	//2번째 페이지 정보 테이블
	//잔여석: 버스운행정보+버스테이블(
	//가는날, 출발지,도착지 소요시간, 버스노선에 따른 요금(busFee테이블의)(bFeeCode+bFee), +역간거리(busRouteDetail-bDistance)
	//버스예매의 탑승날짜+버스운행정보 테이블 첫출발시간, 마지막 도착시간, 버스이름 bdiscern(필요없을듯?)
	
	
	
	//bus 첫선택화면 필요한 정보
	//버스 편도or왕복, 출발지,도착지, 
	//가는날(bBoardDate),2번째 오는날(bBoardDate),버스등급(bType)
	//승객유형별 탑승인원(bPassinger)을 리스트로 받아서 일반,초등학생,중고등학생별 인원
	//session에 저장?
	
	// insert 테이블 4개 만들기
	//버스예매
	//버스예매상세
	//버스예매 환불
	//버스결제
	
	
}
