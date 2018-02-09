package com.capgemini.web.obs.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Customer")
public class CustomerBean {
	
	@Id
	@Column(name="Account_ID")
	private long acc_id;
	@Column(name="customer_name")
	private String name;
	@Column(name="Email")
	private String email;
	@Column(name="Address")
	private String address;
	@Column(name="Pancard")
	private String pancard;
	@Column(name="Contact")
	private long phone;
	
	public CustomerBean() {
		
	}

	public long getAcc_id() {
		return acc_id;
	}

	public void setAcc_id(long acc_id) {
		this.acc_id = acc_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPancard() {
		return pancard;
	}

	public void setPancard(String pancard) {
		this.pancard = pancard;
	}

	public long getPhone() {
		return phone;
	}

	public void setPhone(long phone) {
		this.phone = phone;
	}

	
}
