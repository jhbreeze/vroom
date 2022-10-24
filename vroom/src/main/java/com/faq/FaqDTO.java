package com.faq;

public class FaqDTO {
	private long faqNum;
	private String userId;
	private String faqSubject;
	private String faqContent;
	private String faqRegDate;
	
	public long getFaqNum() {
		return faqNum;
	}
	public void setFaqNum(long faqNum) {
		this.faqNum = faqNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFaqSubject() {
		return faqSubject;
	}
	public void setFaqSubject(String faqSubject) {
		this.faqSubject = faqSubject;
	}
	public String getFaqContent() {
		return faqContent;
	}
	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}
	public String getFaqRegDate() {
		return faqRegDate;
	}
	public void setFaqRegDate(String faqRegDate) {
		this.faqRegDate = faqRegDate;
	}

}
