package com.web.obs.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
@Entity
@Table(name="AccountMaster")
public class AccountBean {
	@Id
	@SequenceGenerator(name="accountSeq",sequenceName="seq_accnt_No")
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="accountSeq")
	@Column(name="Account_ID")
	private long accId;
	@Column(name="Account_Type")
	private String accType;
	@Column(name="Account_Balance")
	private double accBalance;
	@Column(name="Open_Date")
	private Date openDate;
	
	public long getAccId() {
		return accId;
	}
	public void setAccId(long accId) {
		this.accId = accId;
	}
	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	public double getAccBalance() {
		return accBalance;
	}
	public void setAccBalance(double accBalance) {
		this.accBalance = accBalance;
	}
	public Date getOpenDate() {
		return openDate;
	}
	public void setOpenDate(Date openDate) {
		this.openDate = openDate;
	}
	public AccountBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	
	
	
	
}
