package com.reservetrain;

public class ReserveTrainSessionInfo {
	private String cycle;
	private int adultCount;
	private int childCount;
	private int deptStationCode;
	private int destStationCode;
	private String deptStationName;
	private String destStationName;
	private String tBoardDate1;
	private String tBoardDate2;
	private String grade;
	private String staDate;
	private String endDate;
	
	public String getCycle() {
		return cycle;
	}
	public void setCycle(String cycle) {
		this.cycle = cycle;
	}
	public int getAdultCount() {
		return adultCount;
	}
	public void setAdultCount(int adultCount) {
		this.adultCount = adultCount;
	}
	public int getChildCount() {
		return childCount;
	}
	public void setChildCount(int childCount) {
		this.childCount = childCount;
	}
	public int getDeptStationCode() {
		return deptStationCode;
	}
	public void setDeptStationCode(int deptStationCode) {
		this.deptStationCode = deptStationCode;
	}
	public int getDestStationCode() {
		return destStationCode;
	}
	public void setDestStationCode(int destStationCode) {
		this.destStationCode = destStationCode;
	}
	public String gettBoardDate1() {
		return tBoardDate1;
	}
	public void settBoardDate1(String tBoardDate1) {
		this.tBoardDate1 = tBoardDate1;
	}
	public String gettBoardDate2() {
		return tBoardDate2;
	}
	public void settBoardDate2(String tBoardDate2) {
		this.tBoardDate2 = tBoardDate2;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getStaDate() {
		return staDate;
	}
	public void setStaDate(String staDate) {
		this.staDate = staDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getDeptStationName() {
		return deptStationName;
	}
	public void setDeptStationName(String deptStationName) {
		this.deptStationName = deptStationName;
	}
	public String getDestStationName() {
		return destStationName;
	}
	public void setDestStationName(String destStationName) {
		this.destStationName = destStationName;
	}
}
