package com.busReserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class BusReserveDAO {
private Connection conn = DBConn.getConnection();
	
	// 출발지 구하기
public List<BusReserveDTO> getDepStationList() {
	List<BusReserveDTO> list = new ArrayList<>();
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql;
	
	try {
		sql = "SELECT bStationCode, bStationName FROM busStation ORDER BY bStationName";
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
	//역 이름->노선코드구하기
	public int getRouteCode(String bdepStationName, String bdesStationName) {
		int RouteCode=0;
		String bRouteName;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql="SELECT bRouteCode FROM busRoute WHERE bRouteName= ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			bRouteName = bdepStationName+"-"+bdesStationName;
			pstmt.setString(1, bRouteName);
			rs = pstmt.executeQuery();
	
			RouteCode = rs.getInt("bRouteCode");
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
	
	// 역코드의 각 노선 상세코드 불러오기(노선코드+ 역코드를 이용)
	public int getbRouteDetailCode(int bRouteCode, int bStationCode) {
		int bRouteDetailCode = 0;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		
		try {
			sql = " SELECT bRouteDetailCode FROM busRouteDetail "
					+ " WHERE bRouteCode = ? AND bStationCode = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bRouteCode);
			pstmt.setInt(2, bStationCode);
			
			rs = pstmt.executeQuery();
			
			bRouteDetailCode = rs.getInt("bRouteDetailCode");

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

	
	// 해당시간대의 버스 예매정보
	// 운행테이블의 해당 버스 정보 : (세션정보가져옴)->(노선상세코드_출발역, 노선상세코드_도착역,버스구분) =>해당조건에 맞는 list반환
	//buslist에 필요한 정보
		//버스이름->고속사, 버스등급->등급
	public List<BusReserveDTO> getbRouteInfoList(int bRouteDetailCodeSta, int bRouteDetailCodeEnd, String bgrade){
		List<BusReserveDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		
		try {
			sql="SELECT bFirstStaTime, bEndStaTime, bName, bType, bFee, seatNum "
					+ "";
			//출발시간  고속사(버스이름)  등급(버스등급) 가격(할인전 가격) 잔여석
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//rs.getString(1,"");
			
			if(rs.next()) {
				BusReserveDTO dto = new BusReserveDTO();
				
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
			takeTime = rs.getInt("btakeTime");
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
	
	
	
	
	
	
	//2번째 페이지 왼쪽(할인적용전 버스요금)(가격): 노선코드 ->(busRoute+busFee테이블의 버스구분)-(노선의 버스종류별 요금)(bFee)
	
	//2번째 페이지 정보 테이블
	//잔여석: 버스운행정보+버스테이블(
	//가는날, 출발지,도착지 소요시간, 버스노선에 따른 요금(busFee테이블의)(bFeeCode+bFee), +역간거리(busRouteDetail-bDistance)
	//버스예매의 탑승날짜+버스운행정보 테이블 첫출발시간, 마지막 도착시간, 버스이름 bdiscern(필요없을듯?)
	
	
	//버스예매시에 필요한 정보(좌석) selectㅇ insert update delete?
	
	
	//bus 첫선택화면 필요한 정보
	//버스 편도or왕복, 출발지,도착지, 
	//가는날(bBoardDate),2번째 오는날(bBoardDate),버스등급(bType)
	//승객유형별 탑승인원(bPassinger)을 리스트로 받아서 일반,초등학생,중고등학생별 인원
	//session에 저장?
	
	
	
}
