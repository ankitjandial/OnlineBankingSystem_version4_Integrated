package com.capgemini.web.obs.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="Payee")
public class PayeeBean {
	@Column(name="Account_Id")
	private long accId;
	
	@Id
	@Column(name="Payee_Account_Id")
	private long payeeAccId;
	
	@Column(name="Nickname")
	private String nickName;
	
	@Transient
	private String urn;
	
	public long getAccId() {
		return accId;
	}
	public void setAccId(long accId) {
		this.accId = accId;
	}
	public long getPayeeAccId() {
		return payeeAccId;
	}
	public void setPayeeAccId(long payeeAccId) {
		this.payeeAccId = payeeAccId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
	public String getUrn() {
		return urn;
	}
	public void setUrn(String urn) {
		this.urn = urn;
	}
	public PayeeBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "PayeeBean [accId=" + accId + ", payeeAccId=" + payeeAccId
				+ ", nickName=" + nickName + "]";
	}
	
	
	

}
