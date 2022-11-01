package com.reservetrain;

import java.util.List;

public class PaymentDTO {

	private int cusNum;
	private int tTotNum;
	private int tTotPrice;
	private int tPayPrice;
	private int tDisPrice;
	private int tDetailCodeEnd;
	private int tDetailCodeSta;
	private String tBoardDate;
	private List<Integer> tFee;
	private List<String> tPassenger;
	private String tSeat;
	private String tHoNum;
	private List<String> tSeatNum;
	private String name;
	private String tel;
	private String email;
	
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
	public int gettTotPrice() {
		return tTotPrice;
	}
	public void settTotPrice(int tTotPrice) {
		this.tTotPrice = tTotPrice;
	}
	public int gettPayPrice() {
		return tPayPrice;
	}
	public void settPayPrice(int tPayPrice) {
		this.tPayPrice = tPayPrice;
	}
	public int gettDisPrice() {
		return tDisPrice;
	}
	public void settDisPrice(int tDisPrice) {
		this.tDisPrice = tDisPrice;
	}
	public int gettDetailCodeEnd() {
		return tDetailCodeEnd;
	}
	public void settDetailCodeEnd(int tDetailCodeEnd) {
		this.tDetailCodeEnd = tDetailCodeEnd;
	}
	public int gettDetailCodeSta() {
		return tDetailCodeSta;
	}
	public void settDetailCodeSta(int tDetailCodeSta) {
		this.tDetailCodeSta = tDetailCodeSta;
	}
	public String gettBoardDate() {
		return tBoardDate;
	}
	public void settBoardDate(String tBoardDate) {
		this.tBoardDate = tBoardDate;
	}
	public List<Integer> gettFee() {
		return tFee;
	}
	public void settFee(List<Integer> tFee) {
		this.tFee = tFee;
	}
	public List<String> gettPassenger() {
		return tPassenger;
	}
	public void settPassenger(List<String> tPassinger) {
		this.tPassenger = tPassinger;
	}
	public String gettSeat() {
		return tSeat;
	}
	public void settSeat(String tSeat) {
		this.tSeat = tSeat;
	}
	public String gettHoNum() {
		return tHoNum;
	}
	public void settHoNum(String tHoNum) {
		this.tHoNum = tHoNum;
	}
	public List<String> gettSeatNum() {
		return tSeatNum;
	}
	public void settSeatNum(List<String> tSeatNum) {
		this.tSeatNum = tSeatNum;
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
}
