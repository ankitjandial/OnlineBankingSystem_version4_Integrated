package com.capgemini.web.obs.entities;

import java.util.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class TransactionDeatiled {

	
	private long accNo;
	
	private Date frmDate;
	
	private Date toDate;

	public long getAccNo() {
		return accNo;
	}

	public void setAccNo(long accNo) {
		this.accNo = accNo;
	}

	public Date getFrmDate() {
		return frmDate;
	}

	public void setFrmDate(Date frmDate) {
		this.frmDate = frmDate;
	}

	public Date getToDate() {
		return toDate;
	}

	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}

	public TransactionDeatiled(long accNo, Date frmDate, Date toDate) {
		super();
		this.accNo = accNo;
		this.frmDate = frmDate;
		this.toDate = toDate;
	}

	public TransactionDeatiled() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	

}
