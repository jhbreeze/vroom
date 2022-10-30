package com.event;

public class ReplyDTO {
	private long replyNum;
	private String evReplyContent;
	private String evReplyDate;
	private long eveNum;
	private String userId;
	private String name;
	
	public long getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(long replyNum) {
		this.replyNum = replyNum;
	}
	public String getEvReplyContent() {
		return evReplyContent;
	}
	public void setEvReplyContent(String evReplyContent) {
		this.evReplyContent = evReplyContent;
	}
	public String getEvReplyDate() {
		return evReplyDate;
	}
	public void setEvReplyDate(String evReplyDate) {
		this.evReplyDate = evReplyDate;
	}
	public long getEveNum() {
		return eveNum;
	}
	public void setEveNum(long eveNum) {
		this.eveNum = eveNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	

}
