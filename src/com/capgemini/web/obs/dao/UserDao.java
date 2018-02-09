package com.capgemini.web.obs.dao;

import java.util.Date;
import java.util.List;

import com.capgemini.web.obs.entities.CustomerBean;
import com.capgemini.web.obs.entities.FundBean;
import com.capgemini.web.obs.entities.PayeeBean;
import com.capgemini.web.obs.entities.ServiceTrackerBean;
import com.capgemini.web.obs.entities.TransactionBean;
import com.capgemini.web.obs.entities.UserBean;
import com.capgemini.web.obs.exception.OnlineBankingException;

public interface UserDao {
	
	/* Create a new User from 'User' table*/
	public int newUser(UserBean user) throws OnlineBankingException;
	
	/*To validate userLogin for ID and password */
	public UserBean validateLogin(int userId,String password) throws OnlineBankingException;
	
	/*To change password*/
	public String changePassword(int userId,String oldPass,String newPass) throws OnlineBankingException;
	
	/*To retrieve user Details from Customer Table */
	public CustomerBean getUserInfo(long accountId) throws OnlineBankingException;
	
	/* Returns Only 10 Transactions from 'Transaction' table */
	public List<TransactionBean> getMiniStatement(long accountId) throws OnlineBankingException;
	
	/* Returns All Transactions from 'Transaction' table */
	public List<TransactionBean> getAllStatements(long accountId, Date fromDate, Date toDate) throws OnlineBankingException;

	/* Update 'Customer' table */
	public void updateCustomerProfile (CustomerBean customer) throws OnlineBankingException;
	
	/* Update 'User' table */
	public boolean updatePassword(long accountId,String oldPassword,String newPassword) throws OnlineBankingException;
	
	/* Take "ServiceDescription" input from user 
	 * Set a new 'ServiceTrackerBean' and pass the bean to the RequestCheckBook(ServiceTrackerBean)
	 * Generate and set the remaining bean entities in database('ServiceTracker' table) 
	 * Return new ServiceId.
	 * "A cheque book request is always in Open state. Other valid states are dispatched, issued or returned"
	 */
	public int requestChequeBook(ServiceTrackerBean newService) throws OnlineBankingException;
	/* Return a list of 'requestIds' for all Service Requests yet */
	public List<ServiceTrackerBean> getAllServiceRequestsId(long accountId) throws OnlineBankingException;
	public ServiceTrackerBean trackServiceRequest(int serviceRequestId) throws OnlineBankingException;
	/* Only the latest 20 Service Requests raised in last 180 days will be returned. */
	public List<ServiceTrackerBean> getAllServiceRequests(long accountId) throws OnlineBankingException;
	
	public List<Long> getUsersOwnAccount(long sessionAccount) throws OnlineBankingException;
	
	public long fundTransfer(FundBean newFund) throws OnlineBankingException;
	
				// Fund transfer to other accounts
	/* The maximum amount of funds that can be transferred per day is Rs. 10 lakhs.
	 */
	public List<PayeeBean> getAllPayee(long accountId) throws OnlineBankingException;
	public boolean validatePayeeReg(String urn);
	public boolean regPayee(PayeeBean newPayee) throws OnlineBankingException;
	
	/* Validate transactionAmount from 'Account_Master' table and transactionPassword from user table */
	public boolean validateUserTransaction(long sessionAccount, String transactionPassword) throws OnlineBankingException;
	
	
	
}
