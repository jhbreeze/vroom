package com.reservetrain;

import java.util.List;

public class HochaDTO {
	private int num;
	private String tHoNum;
	private int tNumId;
	private int hoNum;
	private String hoDiv;
	private List<String> tSeatNumList;
	private int leftSeats;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	public int getHoNum() {
		return hoNum;
	}
	public void setHoNum(int hoNum) {
		this.hoNum = hoNum;
	}
	public String getHoDiv() {
		return hoDiv;
	}
	public void setHoDiv(String hoDiv) {
		this.hoDiv = hoDiv;
	}
	public List<String> gettSeatNumList() {
		return tSeatNumList;
	}
	public void settSeatNumList(List<String> tSeatNumArr) {
		this.tSeatNumList = tSeatNumArr;
	}
	public int getLeftSeats() {
		return leftSeats;
	}
	public void setLeftSeats(int leftSeats) {
		this.leftSeats = leftSeats;
	}
}
