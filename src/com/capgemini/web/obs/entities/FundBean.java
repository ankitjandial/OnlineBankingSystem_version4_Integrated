package com.capgemini.web.obs.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="Fund_Transfer")
public class FundBean {
	
	@Id
	@SequenceGenerator(name="fundTransferSeq",sequenceName="seq_fund_id")
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="fundTransferSeq")
	@Column(name="FundTransfer_ID")
	private long fundTransferID;
	@Column(name="Account_ID")
	private long accID;
	@Column(name="Payee_Account_ID")
	private long payeeAccId;
	@Column(name="Date_Of_Transfer")
	private Date dateOfTransfer;
	@Column(name="Transfer_Amount")
	private double transferAmount;
	
	public FundBean() {
		
	}

	public long getFundTransferID() {
		return fundTransferID;
	}

	public void setFundTransferID(long fundTransferID) {
		this.fundTransferID = fundTransferID;
	}

	public long getAccID() {
		return accID;
	}

	public void setAccID(long accID) {
		this.accID = accID;
	}

	public long getPayeeAccId() {
		return payeeAccId;
	}

	public void setPayeeAccId(long payeeAccId) {
		this.payeeAccId = payeeAccId;
	}

	public Date getDateOfTransfer() {
		return dateOfTransfer;
	}

	public void setDateOfTransfer(Date dateOfTransfer) {
		this.dateOfTransfer = dateOfTransfer;
	}

	public double getTransferAmount() {
		return transferAmount;
	}

	public void setTransferAmount(double transferAmount) {
		this.transferAmount = transferAmount;
	}
	
	
	

}
