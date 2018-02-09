package com.web.obs.dao;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.stereotype.Repository;

import com.web.obs.entities.AccountBean;
import com.web.obs.entities.CustomerBean;
import com.web.obs.entities.FundBean;
import com.web.obs.entities.PayeeBean;
import com.web.obs.entities.ServiceTrackerBean;
import com.web.obs.entities.TransactionBean;
import com.web.obs.entities.UserBean;
import com.web.obs.exception.OnlineBankingException;
@Repository
public class UserDaoImpl implements UserDao {
	
	@PersistenceContext
	private EntityManager entityManager;
	
	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}
	
	

	/*==================================================================================================================================
	 * =================================================================================================================================
	 *                                          Author:	Anirban Chowdhury
	 * =================================================================================================================================
	 * =================================================================================================================================*/
	
	int count=0;
	
	@Override
	public int newUser(UserBean user) throws OnlineBankingException {
		AccountBean accountBean=null;
		List<UserBean> checkUser=null;
		try 
		{
			accountBean = entityManager.find(AccountBean.class, user.getAccID());
			
			if(accountBean!=null)
			{
				String sql2="select user from UserBean user where user.accID = ?2";
				TypedQuery<UserBean> tQuery2 = entityManager.createQuery(sql2, UserBean.class);
				tQuery2.setParameter(2,user.getAccID());
				
				checkUser= tQuery2.getResultList();
				
				PayeeBean payeeBean = new PayeeBean();
				payeeBean.setAccId(user.getAccID());
				payeeBean.setPayeeAccId(user.getAccID());
				payeeBean.setNickName("self");
				
				if(checkUser.isEmpty())
				{
					user.setLockStatus("n");

					entityManager.persist(user);
					entityManager.persist(payeeBean);
					entityManager.flush();

					return user.getUserID();
				}
				else{
					throw new OnlineBankingException("You are already registered...");
				}
			}
			else
				throw new Exception("Account Id does not exist with us");
		}
		catch (Exception e) 
		{
			throw new OnlineBankingException(e.getMessage());
		}
	}

	
	@Override
	public String changePassword(int userId, String oldPass, String newPass)
			throws OnlineBankingException 
	{
		String msg="";
		
		UserBean userBean;
		
		try {
			String query = "select userBean from UserBean userBean where userBean.userID = ?1";
			TypedQuery<UserBean> tQuery = entityManager.createQuery(query,UserBean.class);
			tQuery.setParameter(1, userId);
			
			try 
			{
				userBean = tQuery.getSingleResult();
			} 
			catch (Exception e) {
				throw new OnlineBankingException("Please check your id"); 
			}
			
			String pass = userBean.getPassword();
			
			if(oldPass.equals(pass))
			{	
				query = "UPDATE UserBean SET password=:newPassword WHERE userID =?1";

				Query que = entityManager.createQuery(query);
				que.setParameter("newPassword",newPass);
				que.setParameter(1, userId);
				
				que.executeUpdate();
				
				msg = "Password changed Successfully";
			}
			else
			{
				throw new Exception("Password Incorrect");
			}
			
		} catch (Exception e) {
			
			throw new OnlineBankingException(e.getMessage());
		}
		
		return msg;
	}

	
	
	
	@Override
	public UserBean validateLogin(int userId, String password)
			throws OnlineBankingException {
		UserBean userBean=null;
		try 
		{
			String query1="select user.lockStatus from UserBean user where user.userID = :userId";
			TypedQuery<String> tqQuery = entityManager.createQuery(query1,String.class);
			tqQuery.setParameter("userId",userId);
			String status = tqQuery.getSingleResult();
			
			if(status.charAt(0)=='y')
			{
				throw new Exception("Your account is locked! Please, contact to your nearest branch.");
			}
			
			
			String query = "select userBean from UserBean userBean where userBean.userID = :userId and userBean.password= :pass";
			TypedQuery<UserBean> tQuery = entityManager.createQuery(query,UserBean.class);
			tQuery.setParameter("userId",userId);
			tQuery.setParameter("pass", password);
			userBean = tQuery.getSingleResult();
			
		} 
		catch (Exception e) {
			
			count+=1;
			
			if(count==1 || count==2)
				throw new OnlineBankingException("Check your credentials");
			
			if(count==3)
			{	
				String query="update UserBean user set user.lockStatus = ?1 where user.userID = ?2";
				Query tQuery = entityManager.createQuery(query);
				tQuery.setParameter(1,"y");
				tQuery.setParameter(2, userId);
				tQuery.executeUpdate();
				
				count=0;
			}

			throw new OnlineBankingException(e.getMessage());
		}
		
		
		return userBean;
	}

	@Override
	public CustomerBean getUserInfo(long accountId)
			throws OnlineBankingException {
		CustomerBean customerBean=null;
		try 
		{
			customerBean = entityManager.find(CustomerBean.class, accountId);
		} 
		catch (Exception e) {
			
			throw new OnlineBankingException(e.getMessage());
			
		}
		
		return customerBean;
	}

	@Override
	public List<TransactionBean> getMiniStatement(long accountId)
			throws OnlineBankingException {
		
		List<TransactionBean> transactions ;
		try {
			
			String query = "select transactions from TransactionBean transactions "
					+ "where transactions.accNo= :accNO  order by transactions.transDate desc";
			
			TypedQuery<TransactionBean> tQuery = entityManager.createQuery(query,TransactionBean.class);
			
			tQuery.setParameter("accNO", accountId);
			tQuery.setMaxResults(10);
			transactions = tQuery.getResultList();
			
			if(transactions==null || transactions.isEmpty())
				throw new OnlineBankingException("Transaction not available with this account Id...");	
		} 
		
		catch (Exception e) {
			
			throw new OnlineBankingException(e.getMessage());
			
		}
		
	
		return transactions;
	}

	@Override
	public List<TransactionBean> getAllStatements(long accountId,
			Date fromDate, Date toDate) throws OnlineBankingException {
	
		List<TransactionBean> transactions;
		
		try {
			String query="select transactions from TransactionBean transactions where "
					+ "transactions.accNo= :AccountNo "
					+ "and transactions.transDate between :Date1  and :Date2  order by transactions.transDate desc";
		
			
			TypedQuery<TransactionBean> tQuery = entityManager.createQuery(query,TransactionBean.class);
			
			tQuery.setParameter("AccountNo", accountId);
			tQuery.setParameter("Date1", fromDate);
			tQuery.setParameter("Date2", toDate);
			
			transactions = tQuery.getResultList();
			
		} 
		catch (Exception e) {
			
			throw new OnlineBankingException(e.getMessage());
		}
		
		
		return transactions;
	}
	
	
	

	/*==================================================================================================================================
	 *                                           /Author:	Anirban Chowdhury
	 * =================================================================================================================================*/
	
	


	/***********************************************************************************************************************************
	 ***********************************************************************************************************************************
	 *                                          Author:	Thejeswini Mayakuntala
	 ***********************************************************************************************************************************
	 ************************************************************************************************************************************/
	

	@Override
	public void updateCustomerProfile(CustomerBean customer)
			throws OnlineBankingException {
		try
		{

			entityManager.merge(customer);
			entityManager.flush();
			
		}
		catch(Exception e)
		{
			throw new OnlineBankingException(e.getMessage());
		}
	}
	

	@Override
	public boolean updatePassword(long accountId,String oldPassword, String newPassword)
			throws OnlineBankingException {
		boolean status=false;
		try
		{
			String query1 = "SELECT password from UserBean WHERE Account_ID=?1";
			Query que1 = entityManager.createQuery(query1);
			que1.setParameter(1, accountId);

			String pass = (String)que1.getSingleResult();

			if(oldPassword.equals(pass))
			{	
				String query = "UPDATE UserBean SET password=:newPassword WHERE Account_ID =?1";

				Query que = entityManager.createQuery(query);
				que.setParameter("newPassword",newPassword);
				que.setParameter(1, accountId);

				que.executeUpdate();
				status=true;
			}
			else
			{
				throw new Exception("Password Incorrect");
			}
		}
		catch(Exception e)
		{
			throw new OnlineBankingException(e.getMessage());
		}
		return status;
	}

	/***********************************************************************************************************************************
	 *                                           /Author:	Thejeswini Mayakuntala
	 ************************************************************************************************************************************/


	/*==================================================================================================================================
	 * =================================================================================================================================
	 *                                          Author:	Harika Devu
	 * =================================================================================================================================
	 * =================================================================================================================================*/
	@Override
	public int requestChequeBook(ServiceTrackerBean newService)
			throws OnlineBankingException 
	{
		int requestId = 0;
		try{
			entityManager.persist(newService);
			entityManager.flush();
			requestId = newService.getServID();
		}
		catch(Exception e){
			throw new OnlineBankingException(e.getMessage());
		}
		return requestId;
	}

	@Override
	public List<ServiceTrackerBean> getAllServiceRequestsId(long accountId)
			throws OnlineBankingException {
		List<ServiceTrackerBean> services = null;
		try
		{
			
			System.out.println("Print page");
			String query = "select service from ServiceTrackerBean service where Account_ID=:accID";
			
			TypedQuery<ServiceTrackerBean> tQuery = entityManager.createQuery(query, ServiceTrackerBean.class);
			
			tQuery.setParameter("accID", accountId);
			services=tQuery.getResultList();
			
			return services;
			
		}
		catch(Exception e)
		{
			throw new OnlineBankingException(e.getMessage());
		}
	}



	/*==================================================================================================================================
	 *                                           /Author:	Harika Devu
	 * =================================================================================================================================*/


	/***********************************************************************************************************************************
	 ***********************************************************************************************************************************
	 *                                          Author:	Sayali Banjari
	 ***********************************************************************************************************************************
	 ************************************************************************************************************************************/
	
	@Override
	public ServiceTrackerBean trackServiceRequest(int serviceRequestId)
			throws OnlineBankingException {
		ServiceTrackerBean serviceTrackerBean = null;
		try
		{
			serviceTrackerBean = entityManager.find(ServiceTrackerBean.class, serviceRequestId);
			if(serviceTrackerBean == null)
				throw new Exception("Service Request Id not found");
			entityManager.flush();
		}
		catch(Exception e)
		{
			throw new OnlineBankingException(e.getMessage());
		}

		return serviceTrackerBean;
	}

	@Override
	public List<ServiceTrackerBean> getAllServiceRequests(long accountId)
			throws OnlineBankingException {
		List<ServiceTrackerBean> serviceTrackerBean = null;

		try{
			String query = "Select serv from ServiceTrackerBean serv where serv.accID=:aid";
			TypedQuery<ServiceTrackerBean> tQuery = entityManager.createQuery(query, ServiceTrackerBean.class);

			tQuery.setParameter("aid", accountId);
			serviceTrackerBean = tQuery.getResultList();

		}
		catch(Exception e){
			throw new OnlineBankingException(e.getMessage());
		}

		return serviceTrackerBean;
	}

	/***********************************************************************************************************************************
	 *                                           /Author:	Sayali Banjari
	 ************************************************************************************************************************************/
	

	/*==================================================================================================================================
	 * =================================================================================================================================
	 *                                          Author:	Gaurav Sahu
	 * =================================================================================================================================
	 * =================================================================================================================================*/
	
	@Override
	public List<Long> getUsersOwnAccount(long sessionAccount) throws OnlineBankingException {
		List<Long> otherAccounts;
		try {
			String query="Select payee.payeeAccId from PayeeBean payee where payee.nickName='self' and payee.accId=?1";
			TypedQuery<Long> tQuery=entityManager.createQuery(query,Long.class);
			tQuery.setParameter(1, sessionAccount);
			otherAccounts=tQuery.getResultList();
			
		} catch (Exception e) {
			throw new OnlineBankingException("Something went wrong while reteiving Accounts, Reason: "+e.getMessage());
		}
		return otherAccounts;
	}
	@Override
	public long fundTransfer(FundBean newFund) throws OnlineBankingException {
		long transactionId=0;
		try {
			//Query to Check Current Balance in payer's account
			String balanceQuery="Select account.accBalance from AccountBean account where account.accId=?1";
			
			TypedQuery<Double> tqQueryToGetBalance=entityManager.createQuery(balanceQuery,Double.class);
			tqQueryToGetBalance.setParameter(1, newFund.getAccID());
			double balance=tqQueryToGetBalance.getMaxResults();
			//Check Current Balance in payer's account
			if(balance<newFund.getTransferAmount())
				throw new Exception("Not enough Balance! Account Balance is Rs. "+balance);
			

			//Update Payer Balance in DB
			String updateQuery1="Update AccountBean set accBalance=accBalance-?1 where accId=?2";
			Query query=entityManager.createQuery(updateQuery1);
			query.setParameter(1, newFund.getTransferAmount());
			System.out.println(newFund.getTransferAmount());
			query.setParameter(2, newFund.getAccID());
			System.out.println(query.executeUpdate());
			query.executeUpdate();

			//Update Payee Balance in DB
			String updateQuery2="Update AccountBean set accBalance=accBalance+?1 where accId=?2";
			Query query1=entityManager.createQuery(updateQuery2);
			query1.setParameter(1, newFund.getTransferAmount());
			query1.setParameter(2, newFund.getPayeeAccId());
			System.out.println(query1.executeUpdate());
			query1.executeUpdate();
			
			
			entityManager.persist(newFund);
			entityManager.flush();
			transactionId=newFund.getFundTransferID();
		} catch (Exception e) {
			e.printStackTrace();
			throw new OnlineBankingException(e.getMessage());
		}
		return transactionId;
	}

	@Override
	public List<PayeeBean> getAllPayee(long accountId) throws OnlineBankingException {
		List<PayeeBean> payeeList=null;
		try {
			String query="Select payee from PayeeBean payee where payee.accId=:session and payee.nickName!='self'";
			TypedQuery<PayeeBean> tQuery=entityManager.createQuery(query,PayeeBean.class);
			tQuery.setParameter("session", accountId);
			payeeList=tQuery.getResultList();
		} catch (Exception e) {
			throw new OnlineBankingException(e.getMessage());
		}
		return payeeList;
	}

	@Override
	public boolean validatePayeeReg(String urn) {
		String newUrn="abc345";
		boolean status=false;
		
		if(urn.equals(newUrn))
			status=true;
		
		return status;
	}

	@Override
	public boolean regPayee(PayeeBean newPayee) throws OnlineBankingException {
		boolean status=false;
		List<PayeeBean> payeeList=new ArrayList<PayeeBean>();
		try {
			AccountBean checkAccount=new AccountBean();
			checkAccount=entityManager.find(AccountBean.class, newPayee.getPayeeAccId());

			if(checkAccount==null)
				throw new Exception("Account Id doesn't exist in our record!");
			String queryToCheckExistingPayee="Select payee from PayeeBean payee where payee.accId=:session and payee.payeeAccId=:payeeId";
			
			TypedQuery<PayeeBean> tQuery1=entityManager.createQuery(queryToCheckExistingPayee,PayeeBean.class);
			tQuery1.setParameter("session", newPayee.getAccId());
			tQuery1.setParameter("payeeId", newPayee.getPayeeAccId());
			payeeList=tQuery1.getResultList();
			
			if(payeeList.isEmpty())
			{
			System.out.println(newPayee);
			entityManager.persist(newPayee);
			entityManager.flush();
			status=true;
			}
			else
				throw new Exception("Payee is already added!");
		} catch (Exception e) {
			throw new OnlineBankingException(e.getMessage());
		}
		return status;
	}

	@Override
	public boolean validateUserTransaction(long sessionAccount, String transactionPassword) throws OnlineBankingException {
		boolean status=false;
		try {
			String query="Select user.transactionPassword from UserBean user where user.accID=:session";
			TypedQuery<String> tQuery=entityManager.createQuery(query,String.class);
			tQuery.setParameter("session", sessionAccount);
			String password=tQuery.getSingleResult();
			if(password.matches(transactionPassword))
				status=true;
		} catch (Exception e) {
			throw new OnlineBankingException(e.getMessage());
		}
		return status;
	}

	
	/*==================================================================================================================================
	 *                                           /Author:	Gaurav Sahu
	 * =================================================================================================================================*/
}
