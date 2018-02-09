package com.web.obs.services;

import java.util.Date;
import java.util.List;

import com.web.obs.entities.CustomerBean;
import com.web.obs.entities.FundBean;
import com.web.obs.entities.PayeeBean;
import com.web.obs.entities.ServiceTrackerBean;
import com.web.obs.entities.TransactionBean;
import com.web.obs.entities.UserBean;
import com.web.obs.exception.OnlineBankingException;

public interface UserService {
	
	public int newUser(UserBean user) throws OnlineBankingException;
	
	public UserBean validateLogin(int userId,String password) throws OnlineBankingException;
	
	public String changePassword(int userId,String oldPass,String newPass) throws OnlineBankingException;
	
	public CustomerBean getUserInfo(long accountId) throws OnlineBankingException;
	
	public List<TransactionBean> getMiniStatement(long accountId) throws OnlineBankingException;
	
	public List<TransactionBean> getAllStatements(long accountId, Date fromDate, Date toDate) throws OnlineBankingException;

	public void updateCustomerProfile (CustomerBean customer) throws OnlineBankingException;
	
	public boolean updatePassword(long accountId,String oldPassword,String newPassword) throws OnlineBankingException;
	
	public int requestChequeBook(ServiceTrackerBean newService) throws OnlineBankingException;
	public List<ServiceTrackerBean> getAllServiceRequestsId(long accountId) throws OnlineBankingException;
	public ServiceTrackerBean trackServiceRequest(int serviceRequestId) throws OnlineBankingException;
	public List<ServiceTrackerBean> getAllServiceRequests(long accountId) throws OnlineBankingException;
	
	public List<Long> getUsersOwnAccount(long sessionAccount) throws OnlineBankingException;
	
	public long fundTransfer(FundBean newFund) throws OnlineBankingException;
	
	public List<PayeeBean> getAllPayee(long accountId) throws OnlineBankingException;
	public boolean validatePayeeReg(String urn);
	public boolean regPayee(PayeeBean newPayee) throws OnlineBankingException;
	
	public boolean validateUserTransaction(long sessionAccount, String transactionPassword) throws OnlineBankingException;
}
