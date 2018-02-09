package com.web.obs.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;



import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.web.obs.entities.CustomerBean;
import com.web.obs.entities.FundBean;
import com.web.obs.entities.MakeFundBean;
import com.web.obs.entities.PayeeBean;
import com.web.obs.entities.ServiceTrackerBean;
import com.web.obs.entities.TransactionBean;
import com.web.obs.entities.TransactionDeatiled;
import com.web.obs.entities.UserBean;
import com.web.obs.exception.OnlineBankingException;
import com.web.obs.services.UserService;

@Controller
@SessionAttributes("sessionUser")
public class OBSController {
	
	@Autowired
	private UserService userService;

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	
	//Get Login Registration Page
	@RequestMapping("/Login.mvc")
	public String getLoginPage(Model model)
	{
		model.addAttribute("userbean",new UserBean());
		return "index";
	}
	
	
	/*==================================================================================================================================
	 * =================================================================================================================================
	 *                                          Author:	Anirban Chowdhury
	 * =================================================================================================================================
	 * =================================================================================================================================*/
	
	
	/*================ Get Registration Page =======================*/
	
	
	@RequestMapping("/ProcessRegisterForm.mvc")
	public String processregister(
			@ModelAttribute("userbean") @Valid UserBean userBean,
			BindingResult bindingResult,
			Model model
			)
	{
		if(bindingResult.hasErrors())
			return "index";
		
		try 
		{
			int uid = userService.newUser(userBean);
			model.addAttribute("userId",uid);
			model.addAttribute("userbean",new UserBean());
			
			return "index";
		} 
		catch (OnlineBankingException e) 
		{
			model.addAttribute("errMsg",e.getMessage());
			model.addAttribute("userbean",new UserBean());
			return "index";
		}
		
	}
	
	//************************Forget Password **************************************************//
	
	@RequestMapping("/gotoForget.mvc")
	public String gotoForgetPassword()
	{
		//model.addAttribute("userBean",new UserBean());
		return "ForgetPassword";
	}
	

	@RequestMapping("/processForgetPassword.mvc")
	public String processForgetPassword(
			@RequestParam("userId") int uid,
			@RequestParam("oldPass") String oldPass,
			@RequestParam("newPass") String newPass,
			Model model
			)
	{
		
			try 
			{
				String msg = userService.changePassword(uid,oldPass,newPass);
				model.addAttribute("msgSuccess",msg);
				return "ForgetPassword";
			} 
			catch (Exception e) 
			{
				model.addAttribute("msg",e.getMessage());
				return "ForgetPassword";
			}
			
	}
	
	
	//*******************************Login Form Processing**************************************//
	
	@RequestMapping("ProcessLogin.mvc")
	public String validateUser(
			@RequestParam("userId") String uId, 
			@RequestParam("password") String pass,
			Model model
			)
	{	
		try 
		{
			int userId = Integer.parseInt(uId);
			UserBean uBean  = userService.validateLogin(userId, pass);
			long accId = uBean.getAccID(); 

			CustomerBean customerBean = userService.getUserInfo(accId);
			model.addAttribute("sessionUser",customerBean);
			return "home";
		} 
		catch (OnlineBankingException e) 
		{
			model.addAttribute("userbean",new UserBean());
			model.addAttribute("loginerrMsg",e.getMessage());
			return "index";
		}
	}

	//******************************************for logout and close the session*******************************************//
	@RequestMapping("/Logout.mvc")
	public String closeSession(Model model)
	{
		model.addAttribute("sessionUser", "");
		model.addAttribute("userbean",new UserBean());
		return "index";
	}
	
	
	//*****************Get Statement Page***********************************************// 
		
		@RequestMapping("/ViewStatement.mvc")
		public String getStatement(
				@RequestParam("name") String name,
				@RequestParam("id") String id,
				Model model
				)
		{
			model.addAttribute("accId",id);
			model.addAttribute("name",name);
			return "Statements"; 
		}
		

	//*****************Get Mini Statement Page**********************************//
		@RequestMapping("MiniStatement.mvc")
		public String getMiniStatement(
				@RequestParam("id") String id,
				Model model
				)
		{	
			List<TransactionBean> transactionList;
			try {
				long accNo= Long.parseLong(id);
				transactionList = userService.getMiniStatement(accNo);
				model.addAttribute("transactionList",transactionList);
				return "MiniStatement";
				
			} catch (OnlineBankingException e) {
				model.addAttribute("errMsg","Contact the admin. "+e.getMessage());
				return "ErrorPage";
			}
		}
		
	//************************************Get Detailed Statement Page******************************************//
		
		@RequestMapping("/DetailedStatement.mvc")
		public String getDetailedStatement(
				@RequestParam("id") long accId,
				Model model
				)
		{	
			model.addAttribute("accId",accId);
			model.addAttribute("transactionDetailed", new TransactionDeatiled());
			return "DetailedStatement";
		}
	
		@RequestMapping(value="/ProcessSearchforDetailedStatement.mvc",method=RequestMethod.POST)
		public String getDetailedStatements(
				@RequestParam("id") long accNo,
				@ModelAttribute("transactionDetailed") @Valid TransactionDeatiled transactionDeatiled,
				BindingResult bindingResult,
				Model model)
		{
			if(bindingResult.hasErrors())	
			{
				model.addAttribute("accId",accNo);
				return "DetailedStatement";
			}
			
			List<TransactionBean> transactionList;
			
			try {
				
				Date date1 = transactionDeatiled.getFrmDate();
				Date date2 = transactionDeatiled.getToDate();

				System.out.println("Before "+date1+" "+date2);
				if(date1.before(date2)){
					System.out.println(date1+" "+date2);
					transactionList = userService.getAllStatements(accNo, date1,date2);

					if(transactionList.isEmpty()){
						model.addAttribute("statementNotMessage","You have not made any transaction in the entered duration!");
						model.addAttribute("accId",accNo);
						return "DetailedStatement";
					}
					else{
						model.addAttribute("transactionList",transactionList);
						model.addAttribute("transactionDetailed", new TransactionDeatiled());
						model.addAttribute("accId",accNo);

						return "DetailedStatement";
					}
				}
				else
				{
					model.addAttribute("statementNotMessage","check your date");
					model.addAttribute("accId",accNo);
					model.addAttribute("transactionDetailed", new TransactionDeatiled());
					
					return "DetailedStatement";
				}
			}
			catch (OnlineBankingException e) {
				
				model.addAttribute("errMsg","Contact the admin. "+e.getMessage());
				return "ErrorPage";
				
			} 
			
		}
		
		
		@InitBinder("transactionDetailed")
		public void customizeBinding(WebDataBinder binder){
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			dateFormat.setLenient(false);
			
			binder.registerCustomEditor(Date.class, "frmDate",
										new CustomDateEditor(dateFormat, true));
			
			binder.registerCustomEditor(Date.class, "toDate",
					new CustomDateEditor(dateFormat, true));
			
		}
		
		//**********************************Redirect to Home Page**********************************//
		@RequestMapping("/goback.mvc")
		public String gotoOptions(
				@RequestParam("name") String name,
				Model model)
		{
			
			model.addAttribute("name",name);
			return "home";
		}
		
	
	/*==================================================================================================================================
	 *                                           /Author:	Anirban Chowdhury
	 * =================================================================================================================================*/
	
	
	
	/***********************************************************************************************************************************
	 ***********************************************************************************************************************************
	 *                                          Author:	Gaurav Sahu
	 ***********************************************************************************************************************************
	 ************************************************************************************************************************************/
	
	
	//Get Home Page for Fund Transfer
	
	@RequestMapping("/FundHomePage.mvc")
	public String getFundPage(){
		
		return "FundTransferHome";
	}
	
	//Get Page for fund Transfer to Own Page
	@RequestMapping("/FundTransferToOwnAccount.mvc")
	public String getFundTransferPage(@RequestParam("sessionId") long accountSession,Model model){
		try {
			List<Long> accountList=userService.getUsersOwnAccount(accountSession);						//Session Account
			if(accountList==null){
				model.addAttribute("fundMessage","Fund Transfer between single account is not possible!");
				return "FundTransferToOwn";
			}
			model.addAttribute("accountList",accountList);
			model.addAttribute("newFund",new MakeFundBean());
			return "FundTransferToOwn";
		} catch (OnlineBankingException e) {
			model.addAttribute("errMsg","Contact the admin. "+e.getMessage());
			return "ErrorPage";
		}
	}
	
	//Process the fund transfer between own accounts form in FundTransferToOwn.jsp page
	@RequestMapping(name="/ProcessFundTransfer.mvc",method=RequestMethod.POST)
	public String processFundTransfer(
			@ModelAttribute("newFund") @Valid MakeFundBean newFund,
			@RequestParam("sessionId") long accountSession,
			BindingResult bindingResult,
			Model model){
		try {
			if(bindingResult.hasErrors())
				return "FundTransferToOwn";
			
			//Validate the Transaction Password
			boolean verificationStatus=userService.validateUserTransaction(accountSession, newFund.getPass());					//sesssion Id
			if(verificationStatus==false){
				model.addAttribute("fundMessage","Wrong Transaction Password!");
				return "FundTransferToOwn";
			}
			
			//Set a bean to send to persist in DB
			FundBean fund=new FundBean();
			fund.setAccID(newFund.getFrom());
			fund.setPayeeAccId(newFund.getPayee());
			fund.setTransferAmount(newFund.getAmount());
			fund.setDateOfTransfer(new Date());
			//Get Transaction Id after inserting fund bean data into db table
			long transactionId=userService.fundTransfer(fund);
			
			//Return Transaction Id to the page
			model.addAttribute("transactionId",transactionId);
			return "FundTransferToOwn";
			
		} catch (OnlineBankingException e) {
			model.addAttribute("errMsg","Contact the admin. "+e.getMessage());
			return "ErrorPage";
		}
	}
	
	
	//Get Page for fund transfer to other account
	@RequestMapping("/FundTransferToOtherAccount.mvc")
	public String getFundTransferToOtherAccountPage(){
		return "FundTransferToOther";
	}
	
	
	//Send account Id and new bean attribute to create Registration form to add a new payee 
	@RequestMapping("/AddNewPayee.mvc")
	public String getAddNewPayee(@RequestParam("sessionId") long accountSession,Model model){
		try {
			PayeeBean newPayee=new PayeeBean();
			newPayee.setAccId(accountSession);					//Session Id
			model.addAttribute("newPayee",newPayee);
			return "FundTransferToOther";
		} catch (Exception e) {
			model.addAttribute("errMsg","Contact the admin. "+e.getMessage());
			return "ErrorPage";
		}
	}
	
	
	//Process Registration form to add a new payee
	@RequestMapping(value="/ProcessAddNewPayee.mvc",method=RequestMethod.POST)
	public String processAddNewPayee(
			@ModelAttribute("newPayee") PayeeBean newPayee,
			BindingResult bindingResult,
			Model model){
		try {
			//Validate the entered URN by user which was sent to the user via sms
			boolean status=userService.validatePayeeReg(newPayee.getUrn());
			if(status==false){
				model.addAttribute("addPayeeMessage","Invalid URN!");
				return "FundTransferToOther";
			}
			//Register New Payee
			userService.regPayee(newPayee);
			model.addAttribute("payeeSuccessMsg","Payee added successfully");
			return "FundTransferToOther";
		} catch (OnlineBankingException e) {
			model.addAttribute("errMsg",e.getMessage());
			return "ErrorPage";
		}
	}
	
	//Get Payee List and send to jsp page to create a form to make a Fund Transfer
	@RequestMapping(value="/MakeFundTransfer.mvc",method=RequestMethod.GET)
	public String getMakeFundTransfer(@RequestParam("sessionId") long accountSession,Model model){
		try {
			//Get all Payee List to show in dropdown on view
			List<PayeeBean> payeeList=userService.getAllPayee(accountSession);
			if(payeeList==null){
				model.addAttribute("fundMessageToOther","You have not added any payee!");
				return "FundTransferToOther";
			}
			
			//Send Payee List and current session account to client view
			model.addAttribute("payeeList", payeeList);
			MakeFundBean newFundToOther=new MakeFundBean();
			newFundToOther.setFrom(accountSession);								//Session Id
			model.addAttribute("newFundToOther",newFundToOther);
			return "FundTransferToOther";
		} catch (Exception e) {
			model.addAttribute("errMsg",e.getMessage());
			return "ErrorPage";
		}
	}
	
	//Process the Fund transfer to other form 
	@RequestMapping(value="/ProcessFundTransferToOther.mvc",method=RequestMethod.POST)
	public String processFundTransferToOther(
			@ModelAttribute("newFundToOther") MakeFundBean newFundToOther,
			@RequestParam("sessionId") long accountSession,
			BindingResult bindingResult,
			Model model){
		try {
			if(bindingResult.hasErrors())
				return "FundTransferToOther";

			//Validate the Transaction Password
			boolean verificationStatus=userService.validateUserTransaction(accountSession, newFundToOther.getPass());					//sesssion Id
			if(verificationStatus==false){
				model.addAttribute("fundMessageToOther","Wrong Transaction Password!");
				return "FundTransferToOther";
			}

			//Set a bean to send to persist in DB
			FundBean fund=new FundBean();
			fund.setAccID(accountSession);															//Session Id
			fund.setPayeeAccId(newFundToOther.getPayee());
			fund.setTransferAmount(newFundToOther.getAmount());
			fund.setDateOfTransfer(new Date());

			//Get Transaction Id after inserting fund bean data into db table
			long transactionId=userService.fundTransfer(fund);

			//Return Transaction Id to the page
			model.addAttribute("transactionIdtoOther",transactionId);
			return "FundTransferToOther";
			
		} catch (OnlineBankingException e) {
			model.addAttribute("errMsg","Contact the admin. "+e.getMessage());
			return "ErrorPage";
		}
	}
	
	/***********************************************************************************************************************************
	 *                                           /Author:	Gaurav Sahu
	 ************************************************************************************************************************************/
	

	
	/*==================================================================================================================================
	 * =================================================================================================================================
	 *                                          Author:	Thejeswini Mayakuntala
	 * =================================================================================================================================
	 * =================================================================================================================================*/
	
	@RequestMapping("/UpdateCustomerProfile.mvc")
	public String updateCustomerPage(@RequestParam("sessionId") long acc_id,Model model)
	{
		try
		{
			CustomerBean customer = userService.getUserInfo(acc_id);
			
			model.addAttribute("customer", customer);
			
			return "UpdateProfile";
		}
		catch(OnlineBankingException e)
		{
			model.addAttribute("errMsg","Something went wrong while trying to update customer details .Reason:"+e.getMessage());

			return "ErrorPage";
		}
		catch(Exception e)
		{
			model.addAttribute("errMsg", "Something went wrong with the application");
			
			return "ErrorPage";
		}
	}
	
	@RequestMapping(value="/ProcessUpdateCustomerDetails.mvc", method=RequestMethod.POST)
	public String processUpdateCustomerDetailsForm(
			@ModelAttribute("customer") @Valid CustomerBean customer,
			BindingResult bindingResult,
			Model model
			)
	{	
		if(bindingResult.hasErrors()){
			return "UpdateProfile";
		}
		
		try
		{
		
			userService.updateCustomerProfile(customer);
			
			model.addAttribute("message", "Profile Updated Successfully");
			
			return "UpdateProfile";
		}
		catch(OnlineBankingException e)
		{
			model.addAttribute("errMsg","Something went wrong while trying to update customer details .Reason:"+e.getMessage());

			return "ErrorPage";
		}
		catch(Exception e)
		{
			model.addAttribute("errMsg", "Something went wrong with the application"+e.getMessage());
			
			return "ErrorPage";
		}
	}
	
	@RequestMapping("/UpdatePassword.mvc")
	public String getUpdatePasswordPage(Model model)
	{
		 UserBean userBean = new UserBean();
		
		 model.addAttribute("userBean", userBean);

		return "UpdatePassword";
	}
	
	@RequestMapping(value="/ProcessChangePassword.mvc",method=RequestMethod.POST)
	public String processChangeUpdatePassword(Model model,
			@RequestParam("sessionId") long accID,
			@RequestParam("password") String oldPassword,
			@RequestParam("newPassword") String newPassword)
	{
		
		try
		{
			userService.updatePassword(accID, oldPassword, newPassword);
			
			model.addAttribute("accID", accID);
			model.addAttribute("password", oldPassword);
			model.addAttribute("newPassword", newPassword);	
			
			model.addAttribute("message", "Password Updated Successfully");
			return "UpdatePassword";
		}
		catch(OnlineBankingException e)
		{
			model.addAttribute("errMsg",e.getMessage());

			return "UpdatePassword";
		}
		catch(Exception e)
		{
			model.addAttribute("errMsg", "Something went wrong with the application"+e.getMessage());
			
			return "ErrorPage";
		}
	}
	
	/*==================================================================================================================================
	 *                                           /Author:	Thejeswini Mayakuntala
	 * =================================================================================================================================*/
	

	/***********************************************************************************************************************************
	 ***********************************************************************************************************************************
	 *                                          Author:	Harika Devu
	 ***********************************************************************************************************************************
	 ************************************************************************************************************************************/
	
	
	@RequestMapping("/RequestChequeBook.mvc")
	public String requestChequeBookPage(@RequestParam("sessionId") long accID,Model model)
	{
		ServiceTrackerBean newService= new ServiceTrackerBean();
		newService.setAccID(accID);
		model.addAttribute("newService",newService);
		return "ChequebookRequest";
	}
	

	@RequestMapping("/ProcessRequestChequeBook.mvc")
	public String processRequestChequeBook(
			@ModelAttribute("newService") ServiceTrackerBean newService,
			Model model){
		try
		{	

			
			newService.setServDate(new Date());
			newService.setServStatus("Pending");
			int requestId = userService.requestChequeBook(newService);
			model.addAttribute("message", "Cheque Book Requested with Service Id "+requestId);
			return "ChequebookRequest";
		}
		catch(OnlineBankingException e)
		{
			model.addAttribute("errMsg","Something went wrong while trying to update customer details .Reason:"+e.getMessage());

			return "ErrorPage";
		}
		catch(Exception e)
		{
			model.addAttribute("errMsg", "Something went wrong with the application"+e.getMessage());

			return "ErrorPage";
		}

	}

	
	/***********************************************************************************************************************************
	 *                                           /Author:	Harika Devu
	 ************************************************************************************************************************************/
	

	
	/*==================================================================================================================================
	 * =================================================================================================================================
	 *                                          Author:	Sayali Banjari
	 * =================================================================================================================================
	 * =================================================================================================================================*/
	
	@RequestMapping("/TrackServiceRequest.mvc")
	public String trackServiceRequest(@RequestParam("sessionId") long accountId,Model model)
	{	
		try {
			
			List<ServiceTrackerBean> listRequestId = userService.getAllServiceRequestsId(accountId);
					
			model.addAttribute("listRequestId",listRequestId);
			
			return "TrackServiceRequest";
		}
		catch(OnlineBankingException e)
		{
			model.addAttribute("errMsg","Something went wrong while trying to retrive service Request Id .Reason:"+e.getMessage());

			return "ErrorPage";
		}
		catch(Exception e)
		{
			model.addAttribute("errMsg", "Something went wrong with the application"+e.getMessage());
			
			return "ErrorPage";
		}
	}
	
	@RequestMapping(value="ProcessTrackServiceRequest.mvc", method=RequestMethod.POST)
	public String processTrackServiceRequestForm(Model model, @RequestParam("Id") int servID)
	{
		try
		{
			ServiceTrackerBean serviceTrackerBean = userService.trackServiceRequest(servID);
			model.addAttribute("serviceTrackerBean", serviceTrackerBean);
			
		}
		catch(Exception e)
		{
			model.addAttribute("errMsg", "Something went wrong. Contact Administrator"+e.getMessage());
			return "ErrorPage";
		}
		return "TrackServiceRequest";
			
	}
	
	@RequestMapping("/GetAllServiceRequests.mvc")
	public String getAllServiceRequest(@RequestParam("sessionId") long accID,Model model)
	{
		try
		{	
			List<ServiceTrackerBean> serviceRequests = userService.getAllServiceRequests(accID);
			model.addAttribute("serviceRequests", serviceRequests);

			return "GetAllServiceRequests";
		}
		catch(Exception e)
		{
			model.addAttribute("errMsg", "Something went wrong. Contact Administrator"+e.getMessage());
			return "ErrorPage";
		}
	}
	

	/*==================================================================================================================================
	 *                                           /Author:	Sayali Banjari
	 * =================================================================================================================================*/
}
