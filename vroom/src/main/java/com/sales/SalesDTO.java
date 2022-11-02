package com.sales;

public class SalesDTO {
	private String payDay; // 구매날짜 혹은 환불날짜
	private String payPrice;
	
	public String getPayDay() {
		return payDay;
	}
	public void setPayDay(String payDay) {
		this.payDay = payDay;
	}
	public String getPayPrice() {
		return payPrice;
	}
	public void setPayPrice(String payPrice) {
		this.payPrice = payPrice;
	}
}
