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
@Table(name="ServiceTracker")
public class ServiceTrackerBean {
	@Id
	@SequenceGenerator(name="trackerSeq",sequenceName="seq_req_id")
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="trackerSeq")
	@Column(name="Service_ID")
	private int servID;
	
	@Column(name="Service_Description")
	private String servDesc;
	
	@Column(name="Account_ID")
	private long accID;
	
	@Column(name="Service_Raised_Date")
	private Date servDate;
	
	@Column(name="Service_status")
	private String servStatus;
	
	public ServiceTrackerBean() {
		
	}

	public int getServID() {
		return servID;
	}

	public void setServID(int servID) {
		this.servID = servID;
	}

	public String getServDesc() {
		return servDesc;
	}

	public void setServDesc(String servDesc) {
		this.servDesc = servDesc;
	}

	public long getAccID() {
		return accID;
	}

	public void setAccID(long l) {
		this.accID = l;
	}

	public Date getServDate() {
		return servDate;
	}

	public void setServDate(Date servDate) {
		this.servDate = servDate;
	}

	public String getServStatus() {
		return servStatus;
	}

	public void setServStatus(String servStatus) {
		this.servStatus = servStatus;
	}

	@Override
	public String toString() {
		return "Service Id:\t\t" + servID + "\n\tService Description:\t"+ servDesc +"\n\tAccount Id:\t\t" + accID +"\n\tService Date:\t\t" + servDate
				+"\n\tService Status:\t\t" + servStatus+"\n";
	}
	
	

}
