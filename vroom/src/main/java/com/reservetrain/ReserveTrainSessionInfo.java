package com.reservetrain;

public class ReserveTrainSessionInfo {
	private String cycle;
	private int adultCount;
	private int childCount;
	private int deptStationCode;
	private int destStationCode;
	private String tBoardDate1;
	private String tBoardDate2;
	private String grade;
	
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
}
