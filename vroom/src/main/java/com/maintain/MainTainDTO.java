package com.maintain;

import java.math.BigDecimal;

public class MainTainDTO {
	// 회원 기차 예매
		private int tDetailCode;
		private int tOperCode; 
		private int tRouteDetailCodeSta;
		private String tStaTime;
		private int tTakeTime;
		private String tStationName; 
		private int tStationCode; 
		private BigDecimal tTkNum;
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

		private int tTaketimeCount;
		private String countTime;
		
		// 임시
		private String tFirstStaTime; 
		private String tEndStaTime;
		private String tDetailSta;
		private String tDetailEnd; 
		private int tDeptStationCode;
		private int tDestStationCode;
		private String tDiscern;	
		
		// 버스 예매 (최종)
		private int bNumId;
		private BigDecimal bTkNum; 	
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
		
		// 임시
		private String day;
		private String date;
		
		private String name;
		
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
		public BigDecimal gettTkNum() {
			return tTkNum;
		}
		public void settTkNum(BigDecimal tTkNum) {
			this.tTkNum = tTkNum;
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
		public String gettFirstStaTime() {
			return tFirstStaTime;
		}
		public void settFirstStaTime(String tFirstStaTime) {
			this.tFirstStaTime = tFirstStaTime;
		}
		public String gettEndStaTime() {
			return tEndStaTime;
		}
		public void settEndStaTime(String tEndStaTime) {
			this.tEndStaTime = tEndStaTime;
		}
		public String gettDetailSta() {
			return tDetailSta;
		}
		public void settDetailSta(String tDetailSta) {
			this.tDetailSta = tDetailSta;
		}
		public String gettDetailEnd() {
			return tDetailEnd;
		}
		public void settDetailEnd(String tDetailEnd) {
			this.tDetailEnd = tDetailEnd;
		}
		public int gettDeptStationCode() {
			return tDeptStationCode;
		}
		public void settDeptStationCode(int tDeptStationCode) {
			this.tDeptStationCode = tDeptStationCode;
		}
		public int gettDestStationCode() {
			return tDestStationCode;
		}
		public void settDestStationCode(int tDestStationCode) {
			this.tDestStationCode = tDestStationCode;
		}
		public String gettDiscern() {
			return tDiscern;
		}
		public void settDiscern(String tDiscern) {
			this.tDiscern = tDiscern;
		}
		public int getbNumId() {
			return bNumId;
		}
		public void setbNumId(int bNumId) {
			this.bNumId = bNumId;
		}
		public BigDecimal getbTkNum() {
			return bTkNum;
		}
		public void setbTkNum(BigDecimal bTkNum) {
			this.bTkNum = bTkNum;
		}
		public int getbTotNum() {
			return bTotNum;
		}
		public void setbTotNum(int bTotNum) {
			this.bTotNum = bTotNum;
		}
		public String getbBoardDate() {
			return bBoardDate;
		}
		public void setbBoardDate(String bBoardDate) {
			this.bBoardDate = bBoardDate;
		}
		public String getbSeatNum() {
			return bSeatNum;
		}
		public void setbSeatNum(String bSeatNum) {
			this.bSeatNum = bSeatNum;
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
		public String getbStationName() {
			return bStationName;
		}
		public void setbStationName(String bStationName) {
			this.bStationName = bStationName;
		}
		public String getDay() {
			return day;
		}
		public void setDay(String day) {
			this.day = day;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		
		
}
