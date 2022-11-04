package com.busReserve;

import java.util.List;

public class BusReserveDTO {
	private long bTotPrice;
	private int bStationCode;
	private String bStationName;
	private int bTkNum;
	private List<String> bPassenger;
	private Long bFee;
	private List<Long> bFeefinal; 
	private List<String> bSeatNum;
	private int cusNum;
	private int bseatTotNum;
	private	int reservedSeat;//예약된 좌석-> 1개
	private String bBoardDate;
	private String name;
	private String tel;
	private String email;
	private int bTotNum;
	private String bPayDay;
	private long bPayPrice;
	private long bDisPrice;
	private int bOperCode;
	private String bBoardString;
	private int bNum;
	private String bPassinger;
	private int bNumId;
	private String bType;
	private String bName;
	private int seatNum;
	private int bKidsale;
	private int bOldsale;
	private String bFirstStaTime;
	private String bEndStaTime;
	private String bDiscern;
	private int bRouteDetailCodeSta;
	private int bRouteDetailCodeEnd;
	private int bRouteDetailCode;
	private int bOrder;
	private int bDistance;
	private int bTakeTime;
	
	public Long getbFee() {
		return bFee;
	}
	public void setbFee(Long bFee) {
		this.bFee = bFee;
	}
	public List<Long> getbFeefinal() {
		return bFeefinal;
	}
	public void setbFeefinal(List<Long> bFeefinal) {
		this.bFeefinal = bFeefinal;
	}
	public List<String> getbPassenger() {
		return bPassenger;
	}
	public void setbPassenger(List<String> bPassenger) {
		this.bPassenger = bPassenger;
	}
	
	public List<String> getbSeatNum() {
		return bSeatNum;
	}
	public void setbSeatNum(List<String> bSeatNum) {
		this.bSeatNum = bSeatNum;
	}
	
	public int getReservedSeat() {
		return reservedSeat;
	}
	public void setReservedSeat(int reservedSeat) {
		this.reservedSeat = reservedSeat;
	}
	public int getBseatTotNum() {
		return bseatTotNum;
	}
	public void setBseatTotNum(int bseatTotNum) {
		this.bseatTotNum = bseatTotNum;
	}
	public String getbBoardDate() {
		return bBoardDate;
	}
	public void setbBoardDate(String bBoardDate) {
		this.bBoardDate = bBoardDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public long getbTotPrice() {
		return bTotPrice;
	}
	public void setbTotPrice(long bTotPrice) {
		this.bTotPrice = bTotPrice;
	}
	public int getbStationCode() {
		return bStationCode;
	}
	public void setbStationCode(int bStationCode) {
		this.bStationCode = bStationCode;
	}
	public String getbStationName() {
		return bStationName;
	}
	public void setbStationName(String bStationName) {
		this.bStationName = bStationName;
	}
	public int getbTkNum() {
		return bTkNum;
	}
	public void setbTkNum(int bTkNum) {
		this.bTkNum = bTkNum;
	}
	public int getCusNum() {
		return cusNum;
	}
	public void setCusNum(int cusNum) {
		this.cusNum = cusNum;
	}
	public int getbTotNum() {
		return bTotNum;
	}
	public void setbTotNum(int bTotNum) {
		this.bTotNum = bTotNum;
	}
	public String getbPayDay() {
		return bPayDay;
	}
	public void setbPayDay(String bPayDay) {
		this.bPayDay = bPayDay;
	}
	public long getbPayPrice() {
		return bPayPrice;
	}
	public void setbPayPrice(long bPayPrice) {
		this.bPayPrice = bPayPrice;
	}
	public long getbDisPrice() {
		return bDisPrice;
	}
	public void setbDisPrice(long bDisPrice) {
		this.bDisPrice = bDisPrice;
	}
	public int getbOperCode() {
		return bOperCode;
	}
	public void setbOperCode(int bOperCode) {
		this.bOperCode = bOperCode;
	}
	public String getbBoardString() {
		return bBoardString;
	}
	public void setbBoardString(String bBoardString) {
		this.bBoardString = bBoardString;
	}
	public int getbNum() {
		return bNum;
	}
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}

	public String getbPassinger() {
		return bPassinger;
	}
	public void setbPassinger(String bPassinger) {
		this.bPassinger = bPassinger;
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
	public int getSeatNum() {
		return seatNum;
	}
	public void setSeatNum(int seatNum) {
		this.seatNum = seatNum;
	}
	public int getbKidsale() {
		return bKidsale;
	}
	public void setbKidsale(int bKidsale) {
		this.bKidsale = bKidsale;
	}
	public int getbOldsale() {
		return bOldsale;
	}
	public void setbOldsale(int bOldsale) {
		this.bOldsale = bOldsale;
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
	public String getbDiscern() {
		return bDiscern;
	}
	public void setbDiscern(String bDiscern) {
		this.bDiscern = bDiscern;
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
	public int getbRouteDetailCode() {
		return bRouteDetailCode;
	}
	public void setbRouteDetailCode(int bRouteDetailCode) {
		this.bRouteDetailCode = bRouteDetailCode;
	}
	public int getbOrder() {
		return bOrder;
	}
	public void setbOrder(int bOrder) {
		this.bOrder = bOrder;
	}
	public int getbDistance() {
		return bDistance;
	}
	public void setbDistance(int bDistance) {
		this.bDistance = bDistance;
	}
	public int getbTakeTime() {
		return bTakeTime;
	}
	public void setbTakeTime(int bTakeTime) {
		this.bTakeTime = bTakeTime;
	}
	public String getbRouteName() {
		return bRouteName;
	}
	public void setbRouteName(String bRouteName) {
		this.bRouteName = bRouteName;
	}
	public int getbRouteCode() {
		return bRouteCode;
	}
	public void setbRouteCode(int bRouteCode) {
		this.bRouteCode = bRouteCode;
	}
	public int getbFeeCode() {
		return bFeeCode;
	}
	public void setbFeeCode(int bFeeCode) {
		this.bFeeCode = bFeeCode;
	}
	public String getbDiv() {
		return bDiv;
	}
	public void setbDiv(String bDiv) {
		this.bDiv = bDiv;
	}
	private String bRouteName;
	private int bRouteCode;
	private int bFeeCode;
	private String bDiv;
	//일반 우등 프리미엄
	

}

