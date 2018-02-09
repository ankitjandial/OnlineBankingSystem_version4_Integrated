package com.capgemini.web.obs.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Min;

@Entity
@Table(name="Transactions")
public class TransactionBean {
	
	@Id
	@Column(name="Transaction_ID")
	private long tranId;
	
	@Column(name="Tran_description")
	private String transDescription;
	
	@Column(name="DateofTransaction")
	private Date transDate;
	
	@Column(name="TransactionType")
	private String transType;
	
	@Column(name="TranAmount")
	private double transAmount;
	
	@Column(name="Account_No")
	@Min(value=1000000000l, message="Invalid account number")
	private long accNo;
	
	
	public long getTranId() {
		return tranId;
	}
	public void setTranId(long tranId) {
		this.tranId = tranId;
	}
	public String getTransDescription() {
		return transDescription;
	}
	public void setTransDescription(String transDescription) {
		this.transDescription = transDescription;
	}
	public Date getTransDate() {
		return transDate;
	}
	public void setTransDate(Date transDate) {
		this.transDate = transDate;
	}
	public String getTransType() {
		return transType;
	}
	public void setTransType(String transType) {
		this.transType = transType;
	}
	public double getTransAmount() {
		return transAmount;
	}
	public void setTransAmount(double transAmount) {
		this.transAmount = transAmount;
	}
	public long getAccNo() {
		return accNo;
	}
	public void setAccNo(long accNo) {
		this.accNo = accNo;
	}
	public TransactionBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Transaction Id:\t\t\t"+ tranId + "\n\t\tTransaction Description:\t"
				+ transDescription+ "\n\t\tTransaction Date:\t\t" + transDate+"\n\t\tTransaction Type:\t\t"+ transType + "\n\t\tTransaction Amount:\t\t" + transAmount+"\n\t\tAccount No:\t\t\t" + accNo;
	}
	
	

}
