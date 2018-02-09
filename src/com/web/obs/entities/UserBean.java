package com.web.obs.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;


@Entity
@Table(name="User_Account")
public class UserBean {
	@Min(value=1000000000,message="Invalid Account Number")
	@Column(name="Account_ID")
	private long accID;
	
	@Id
	@Column(name="user_id")
	@SequenceGenerator(name="seq",sequenceName="seq_user_id" ,allocationSize=200)
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="seq")
	private int userID;
	
	@Pattern(regexp="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20}",message="Minimum 8 characters required (one digit, one uppercase, one lowercase and one of (@ # $ %))")
	@Column(name="password")
	private String password;
	
	@Column(name="secret_question")
	@NotEmpty(message="Required")
	private String question;
	

	@Pattern(regexp="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20}",message="Minimum 8 characters required")
	@Column(name="Transaction_password")
	private String transactionPassword;
	
	@Column(name="lock_status")
	private String lockStatus;
	
	public long getAccID() {
		return accID;
	}
	public void setAccID(long accID) {
		this.accID = accID;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getTransactionPassword() {
		return transactionPassword;
	}
	public void setTransactionPassword(String transactionPassword) {
		this.transactionPassword = transactionPassword;
	}
	public String getLockStatus() {
		return lockStatus;
	}
	public void setLockStatus(String lockStatus) {
		this.lockStatus = lockStatus;
	}
	public UserBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "UserBean [accID=" + accID + ", userID=" + userID
				+ ", password=" + password + ", question=" + question
				+ ", transactionPassword=" + transactionPassword
				+ ", lockStatus=" + lockStatus + "]";
	}
	
	
	

}
