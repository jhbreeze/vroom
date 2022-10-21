package com.busReserve;

public class BusReserveDAO {

	//버스예매시에 필요한 정보 select insert update delete
	
	//bus 첫선택화면 필요한 정보
	//버스 편도or왕복, 출발지,도착지, 
	//가는날(bBoardDate),2번째 오는날(bBoardDate),버스등급(bType)
	//승객유형별 탑승인원(bPassinger)을 리스트로 받아서 일반,초등학생,중고등학생별 인원
	//session에 저장?
	
	//buslist에 필요한 정보
	//버스이름->고속사, 버스등급->등급
	//(할인적용전 버스요금)(가격): 출발지-도착지 연결하면 노선명찾기(노선코드) ->(busRoute+busFee테이블의 버스구분)-(노선의 버스종류별 요금)(bFee)
	//잔여석: 버스운행정보+버스테이블(
	//가는날, 출발지,도착지 소요시간, 버스노선에 따른 요금(busFee테이블의)(bFeeCode+bFee), +역간거리(busRouteDetail-bDistance)
	//버스예매의 탑승날짜+버스운행정보 테이블 첫출발시간, 마지막 도착시간, 버스이름 bdiscern(필요없을듯?)
	
}
