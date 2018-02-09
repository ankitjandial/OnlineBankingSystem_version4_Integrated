package com.web.obs.entities;


public class MakeFundBean {
	private long from;
	private long payee;
	private double amount;
	private String pass;
	public MakeFundBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MakeFundBean(long from, long payee, double amount, String pass) {
		super();
		this.from = from;
		this.payee = payee;
		this.amount = amount;
		this.pass = pass;
	}
	public long getFrom() {
		return from;
	}
	public void setFrom(long from) {
		this.from = from;
	}
	public long getPayee() {
		return payee;
	}
	public void setPayee(long payee) {
		this.payee = payee;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	@Override
	public String toString() {
		return "MakeFundBean [from=" + from + ", payee=" + payee + ", amount="
				+ amount + ", pass=" + pass + "]";
	}
	
}
