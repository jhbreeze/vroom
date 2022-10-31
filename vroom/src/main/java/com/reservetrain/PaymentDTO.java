package com.reservetrain;

import java.util.List;

public class PaymentDTO {

	private int cusNum;
	private int tTotNum;
	private int tTotPrice;
	private String tPayDay;
	private int tPayPrice;
	private int tDisPrice;
	private int tDetailCodeEnd;
	private int tDetailCodeSta;
	private String tBoardDate;
	private List<Integer> tFee;
	private List<String> tPassinger;
	private String tSeat;
	private String tHoNum;
	private List<String> tSeatNum;
	
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
	public String gettPayDay() {
		return tPayDay;
	}
	public void settPayDay(String tPayDay) {
		this.tPayDay = tPayDay;
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
	public List<String> gettPassinger() {
		return tPassinger;
	}
	public void settPassinger(List<String> tPassinger) {
		this.tPassinger = tPassinger;
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
}
