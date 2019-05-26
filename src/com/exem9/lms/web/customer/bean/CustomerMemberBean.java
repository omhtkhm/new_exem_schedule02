package com.exem9.lms.web.customer.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CustomerMemberBean {
	private String cususerId;
	private String cususerNm;
	private String cususerPhone;
	private String cususerMail;
	private String cusId;
	private String proId;
	private String dbmsId;
	
	
	public String getProId() {
		return proId;
	}
	public void setProId(String proId) {
		this.proId = proId;
	}
	public String getDbmsId() {
		return dbmsId;
	}
	public void setDbmsId(String dbmsId) {
		this.dbmsId = dbmsId;
	}
	public String getCususerId() {
		return cususerId;
	}
	public void setCususerId(String cususerId) {
		this.cususerId = cususerId;
	}
	public String getCususerNm() {
		return cususerNm;
	}
	public void setCususerNm(String cususerNm) {
		this.cususerNm = cususerNm;		
	}
	public String getCususerPhone() {
		return cususerPhone;
	}
	public void setCususerPhone(String cususerPhone) {
		this.cususerPhone = cususerPhone;
	}
	public String getCususerMail() {
		return cususerMail;
	}
	public void setCususerMail(String cususerMail) {
		this.cususerMail = cususerMail;
	}
	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}

	
}

