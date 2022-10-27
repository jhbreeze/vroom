package com.qna;

public class ReplyDTO {
	private long replyNum;
	private long qnaNum;
	private String userId;
	private String name;
	private String qnaReplyCont;
	private String qnaReplyDate;
	private String qnaReplyModDate;
	
	public long getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(long replyNum) {
		this.replyNum = replyNum;
	}
	public long getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(long qnaNum) {
		this.qnaNum = qnaNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getQnaReplyCont() {
		return qnaReplyCont;
	}
	public void setQnaReplyCont(String qnaReplyCont) {
		this.qnaReplyCont = qnaReplyCont;
	}
	public String getQnaReplyDate() {
		return qnaReplyDate;
	}
	public void setQnaReplyDate(String qnaReplyDate) {
		this.qnaReplyDate = qnaReplyDate;
	}
	public String getQnaReplyModDate() {
		return qnaReplyModDate;
	}
	public void setQnaReplyModDate(String qnaReplyModDate) {
		this.qnaReplyModDate = qnaReplyModDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	

}
