package com.reservetrain;

public class ReserveListDetailDTO {
	private String tStationName;
	private int tStationCode;
	private int tRouteDetailCode;
	private int tRouteCode;
	private int tOreder;
	private int tDistance;
	private int tTakeTime;
	private String tRouteName;
	
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
	public int gettRouteDetailCode() {
		return tRouteDetailCode;
	}
	public void settRouteDetailCode(int tRouteDetailCode) {
		this.tRouteDetailCode = tRouteDetailCode;
	}
	public int gettRouteCode() {
		return tRouteCode;
	}
	public void settRouteCode(int tRouteCode) {
		this.tRouteCode = tRouteCode;
	}
	public int gettOreder() {
		return tOreder;
	}
	public void settOreder(int tOreder) {
		this.tOreder = tOreder;
	}
	public int gettDistance() {
		return tDistance;
	}
	public void settDistance(int tDistance) {
		this.tDistance = tDistance;
	}
	public int gettTakeTime() {
		return tTakeTime;
	}
	public void settTakeTime(int tTakeTime) {
		this.tTakeTime = tTakeTime;
	}
	public String gettRouteName() {
		return tRouteName;
	}
	public void settRouteName(String tRouteName) {
		this.tRouteName = tRouteName;
	}
}
