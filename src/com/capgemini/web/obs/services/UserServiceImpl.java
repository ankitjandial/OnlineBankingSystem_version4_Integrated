package com.capgemini.web.obs.services;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capgemini.web.obs.dao.UserDao;
import com.capgemini.web.obs.dao.UserDaoImpl;
import com.capgemini.web.obs.entities.CustomerBean;
import com.capgemini.web.obs.entities.FundBean;
import com.capgemini.web.obs.entities.PayeeBean;
import com.capgemini.web.obs.entities.ServiceTrackerBean;
import com.capgemini.web.obs.entities.TransactionBean;
import com.capgemini.web.obs.entities.UserBean;
import com.capgemini.web.obs.exception.OnlineBankingException;


@Transactional
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userdao;
	
	public UserDao getUserdao() {
		return userdao;
	}

	public void setUserdao(UserDao userdao) {
		this.userdao = userdao;
	}
	
	public UserServiceImpl() {
		userdao=new UserDaoImpl();
	}

	@Override
	public int newUser(UserBean user) throws OnlineBankingException {
		return userdao.newUser(user);
	}

	@Override
	public UserBean validateLogin(int userId, String password) throws OnlineBankingException {
		return userdao.validateLogin(userId, password);
	}

	@Override
	public CustomerBean getUserInfo(long accountId) throws OnlineBankingException {
		return userdao.getUserInfo(accountId);
	}

	@Override
	public List<TransactionBean> getMiniStatement(long accountId) throws OnlineBankingException {
		return userdao.getMiniStatement(accountId);
	}

	@Override
	public List<TransactionBean> getAllStatements(long accountId, Date fromDate, Date toDate) throws OnlineBankingException {
		return userdao.getAllStatements(accountId, fromDate, toDate);
	}


	@Override
	public void updateCustomerProfile(CustomerBean customer)throws OnlineBankingException {
		userdao.updateCustomerProfile(customer);
	}
	

	@Override
	public boolean updatePassword(long accountId,String oldPassword, String newPassword) throws OnlineBankingException {
		return userdao.updatePassword(accountId,oldPassword, newPassword);
	}

	@Override
	public int requestChequeBook(ServiceTrackerBean newService) throws OnlineBankingException {
		return userdao.requestChequeBook(newService);
	}

	@Override
	public List<ServiceTrackerBean> getAllServiceRequestsId(long accountId) throws OnlineBankingException {
		return userdao.getAllServiceRequestsId(accountId);
	}

	@Override
	public ServiceTrackerBean trackServiceRequest(int serviceRequestId) throws OnlineBankingException {
		return userdao.trackServiceRequest(serviceRequestId);
	}

	@Override
	public List<ServiceTrackerBean> getAllServiceRequests(long accountId) throws OnlineBankingException {
		return userdao.getAllServiceRequests(accountId);
	}

	@Override
	public List<Long> getUsersOwnAccount(long sessionAccount) throws OnlineBankingException {
		return userdao.getUsersOwnAccount(sessionAccount);
	}

	@Override
	public long fundTransfer(FundBean newFund) throws OnlineBankingException {
		return userdao.fundTransfer(newFund);
	}

	@Override
	public List<PayeeBean> getAllPayee(long accountId) throws OnlineBankingException {
		return userdao.getAllPayee(accountId);
	}

	@Override
	public boolean validatePayeeReg(String urn) {
		return userdao.validatePayeeReg(urn);
	}

	@Override
	public boolean regPayee(PayeeBean newPayee) throws OnlineBankingException {
		return userdao.regPayee(newPayee);
	}

	@Override
	public boolean validateUserTransaction(long sessionAccount, String transactionPassword) throws OnlineBankingException {
		return userdao.validateUserTransaction(sessionAccount, transactionPassword);
	}

	@Override
	public String changePassword(int userId, String oldPass, String newPass)
			throws OnlineBankingException {
		
		return userdao.changePassword(userId, oldPass, newPass);
	}


}
