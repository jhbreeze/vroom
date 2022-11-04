package com.reserve;

public class ReserveDTO {
	// 기차 예매
	private int tDetailCode;
	private int tOperCode; 
	private int tRouteDetailCodeSta;
	private String tStaTime;
	private int tTakeTime;
	private String tStationName; 
	private int tStationCode; 
	private String tTkNum;
	private int cusNum;
	private int tTotNum; 
	private String tSeat;
	private String tSeatNum;
	private String tHoNum;
	private int tNumId;
	private int tDetailCodeSta;
	private int tDetailCodeEnd ;
	private String tStationNameEnd;
	private String tStationNameSta;
	private String tBoardDate;	
	private String userId;
	private int tDisPrice;
	

	// 시간계산
	private int tTaketimeCount;
	private String countTime;
	
	// 운임
	private int tFee;
	private int bFee;
	
	
	// 비회원
	private String tel;
	
	
	// 버스 예매 
	private int bNumId;
	private String bTkNum; 	
	private int bTotNum;
	private String bBoardDate;
	private String bSeatNum;
	private String bType;
	private String bName;	
	private String bFirstStaTime,bEndStaTime;	
	private String bStationNameSta;
	private String bStationNameEnd;
	private int bRouteDetailCodeSta,bRouteDetailCodeEnd; 
	private String bStationName; 
	private int bDisPrice;
	

	
	public int gettDetailCode() {
		return tDetailCode;
	}
	public void settDetailCode(int tDetailCode) {
		this.tDetailCode = tDetailCode;
	}
	public int gettOperCode() {
		return tOperCode;
	}
	public void settOperCode(int tOperCode) {
		this.tOperCode = tOperCode;
	}
	public int gettRouteDetailCodeSta() {
		return tRouteDetailCodeSta;
	}
	public void settRouteDetailCodeSta(int tRouteDetailCodeSta) {
		this.tRouteDetailCodeSta = tRouteDetailCodeSta;
	}
	public String gettStaTime() {
		return tStaTime;
	}
	public void settStaTime(String tStaTime) {
		this.tStaTime = tStaTime;
	}
	public int gettTakeTime() {
		return tTakeTime;
	}
	public void settTakeTime(int tTakeTime) {
		this.tTakeTime = tTakeTime;
	}
	public String gettStationName() {
		return tStationName;
	}
	public void settStationName(String tStationName) {
		this.tStationName = tStationName;
	}
	public int gettStationCode() {
		return tStationCode;
	}
	public void settStationCode(int tStationCode) {
		this.tStationCode = tStationCode;
	}
	public String gettTkNum() {
		return tTkNum;
	}
	public void settTkNum(String string) {
		this.tTkNum = string;
	}
	public int getCusNum() {
		return cusNum;
	}
	public void setCusNum(int cusNum) {
		this.cusNum = cusNum;
	}
	public int gettTotNum() {
		return tTotNum;
	}
	public void settTotNum(int tTotNum) {
		this.tTotNum = tTotNum;
	}
	public String gettSeat() {
		return tSeat;
	}
	public void settSeat(String tSeat) {
		this.tSeat = tSeat;
	}
	public String gettSeatNum() {
		return tSeatNum;
	}
	public void settSeatNum(String tSeatNum) {
		this.tSeatNum = tSeatNum;
	}
	public String gettHoNum() {
		return tHoNum;
	}
	public void settHoNum(String tHoNum) {
		this.tHoNum = tHoNum;
	}
	public int gettNumId() {
		return tNumId;
	}
	public void settNumId(int tNumId) {
		this.tNumId = tNumId;
	}
	public int gettDetailCodeSta() {
		return tDetailCodeSta;
	}
	public void settDetailCodeSta(int tDetailCodeSta) {
		this.tDetailCodeSta = tDetailCodeSta;
	}
	public int gettDetailCodeEnd() {
		return tDetailCodeEnd;
	}
	public void settDetailCodeEnd(int tDetailCodeEnd) {
		this.tDetailCodeEnd = tDetailCodeEnd;
	}
	public String gettStationNameEnd() {
		return tStationNameEnd;
	}
	public void settStationNameEnd(String tStationNameEnd) {
		this.tStationNameEnd = tStationNameEnd;
	}
	public String gettStationNameSta() {
		return tStationNameSta;
	}
	public void settStationNameSta(String tStationNameSta) {
		this.tStationNameSta = tStationNameSta;
	}
	public String gettBoardDate() {
		return tBoardDate;
	}
	public void settBoardDate(String tBoardDate) {
		this.tBoardDate = tBoardDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getbNumId() {
		return bNumId;
	}
	public void setbNumId(int bNumId) {
		this.bNumId = bNumId;
	}
	public String getbType() {
		return bType;
	}
	public void setbType(String bType) {
		this.bType = bType;
	}
	public String getbName() {
		return bName;
	}
	public void setbName(String bName) {
		this.bName = bName;
	}
	public String getbSeatNum() {
		return bSeatNum;
	}
	public void setbSeatNum(String bSeatNum) {
		this.bSeatNum = bSeatNum;
	}
	public String getbStationNameSta() {
		return bStationNameSta;
	}
	public void setbStationNameSta(String bStationNameSta) {
		this.bStationNameSta = bStationNameSta;
	}
	public String getbStationNameEnd() {
		return bStationNameEnd;
	}
	public void setbStationNameEnd(String bStationNameEnd) {
		this.bStationNameEnd = bStationNameEnd;
	}
	public String getbBoardDate() {
		return bBoardDate;
	}
	public void setbBoardDate(String bBoardDate) {
		this.bBoardDate = bBoardDate;
	}
	public int getbTotNum() {
		return bTotNum;
	}
	public void setbTotNum(int bTotNum) {
		this.bTotNum = bTotNum;
	}
	public String getbFirstStaTime() {
		return bFirstStaTime;
	}
	public void setbFirstStaTime(String bFirstStaTime) {
		this.bFirstStaTime = bFirstStaTime;
	}
	public String getbEndStaTime() {
		return bEndStaTime;
	}
	public void setbEndStaTime(String bEndStaTime) {
		this.bEndStaTime = bEndStaTime;
	}
	public String getbTkNum() {
		return bTkNum;
	}
	public void setbTkNum(String bTkNum) {
		this.bTkNum = bTkNum;
	}
	public int getbRouteDetailCodeSta() {
		return bRouteDetailCodeSta;
	}
	public void setbRouteDetailCodeSta(int bRouteDetailCodeSta) {
		this.bRouteDetailCodeSta = bRouteDetailCodeSta;
	}
	public int getbRouteDetailCodeEnd() {
		return bRouteDetailCodeEnd;
	}
	public void setbRouteDetailCodeEnd(int bRouteDetailCodeEnd) {
		this.bRouteDetailCodeEnd = bRouteDetailCodeEnd;
	}

	public int gettTaketimeCount() {
		return tTaketimeCount;
	}
	public void settTaketimeCount(int tTaketimeCount) {
		this.tTaketimeCount = tTaketimeCount;
	}
	public String getCountTime() {
		return countTime;
	}
	public void setCountTime(String countTime) {
		this.countTime = countTime;
	}
	public String getbStationName() {
		return bStationName;
	}
	public void setbStationName(String bStationName) {
		this.bStationName = bStationName;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int gettFee() {
		return tFee;
	}
	public void settFee(int tFee) {
		this.tFee = tFee;
	}
	public int getbFee() {
		return bFee;
	}
	public void setbFee(int bFee) {
		this.bFee = bFee;
	}
	public int gettDisPrice() {
		return tDisPrice;
	}
	public void settDisPrice(int tDisPrice) {
		this.tDisPrice = tDisPrice;
	}
	public int getbDisPrice() {
		return bDisPrice;
	}
	public void setbDisPrice(int bDisPrice) {
		this.bDisPrice = bDisPrice;
	}
	
	
	
}