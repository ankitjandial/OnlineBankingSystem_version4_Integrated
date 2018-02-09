<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- 

File					: FundTransferToOther.jsp
Author Name				: Gaurav Sahu
Description				: View for Login and signup to users
Version					: 5
Last Modified Date		: 01/01/2018
Change Description		: Provided View Design to Functionalities (Look and Feel)

-->



<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Digital Banking | OBS </title>

<c:url value="/externalFiles/css/bootstrap.min.css" var="bootstrap"></c:url>
<c:url value="/externalFiles/css/css.css" var="style"></c:url>

<link rel="stylesheet" type="text/css" href="${bootstrap}" />
<link rel="stylesheet" type="text/css" href="${style}" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	
	<!-- Header -->
	<div class="navbar navbar-default navbar-fixed-top increase-hieght" role="navigation" id="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" id="sitename" data-toggle="tooltip" data-placement="bottom" title="Digital Banking | OBS"><h2>Online Banking System</h2></a>
			</div>
			<div class="nav navbar-nav navbar-right">

				<!-- 	Session Management -->
				<c:choose>
					<c:when test="${empty sessionUser}">
						<c:redirect url="Login.mvc"></c:redirect>
					</c:when>
					<c:otherwise>
						<h3 class="navbar-text text-success user-name">${sessionUser.name }</h3>
					</c:otherwise>
				</c:choose>

				<a href="Logout.mvc" class="btn btn-default logout-button navbar-btn" data-toggle="tooltip" data-placement="left" title="Hit this to logout">Logout <span class="glyphicon glyphicon-log-out"></span></a>
			</div>
		</div>
	</div>
	
	<!-- 	Body -->

	<div class="container-fluid body-container">
		<div class="row">
			<!-- 		Back navigation to home  -->
			<h3 class="navigation-back">
				<a href="goback.mvc?id=${accId}&name=${name}"><span class="glyphicon glyphicon-arrow-left"></span> Home</a>
			</h3>
			<div class="well well-sm"><h4 class="text-center">Fund Transfer</h4></div>
			<div class="row">
				<div class="option col-sm-offset-4 col-sm-4">
					<a href="AddNewPayee.mvc?sessionId=${sessionUser.acc_id}"><div class="well statement">Add Payee</div></a>
				</div>
			</div>
			<c:if test="${newPayee.accId!=null}">
				<form:form action="ProcessAddNewPayee.mvc" method="post" modelAttribute="newPayee">
					<div class="panel panel-default col-sm-offset-4 col-sm-4 remove-padding">
						<div class="panel-body">
							<form:hidden path="accId"/>
							<div class="form-group row">
								<label for="account_id" class="col-sm-4">Account Number</label>
								<div class="col-sm-8">
									<form:input path="payeeAccId" class="form-control" name="account_id" placeholder="Account Number" required="required" />
								</div>
							</div>
							<div class="form-group row">
								<label for="nickName" class="col-sm-4">Nick Name</label>
								<div class="col-sm-8">
									<form:input path="nickName" class="form-control" name="nickName" placeholder="Nick Name" required="required" />
								</div>
							</div>
							<div class="form-group row">
								<label for="urn" class="col-sm-4">URN</label>
								<div class="col-sm-8">
									<form:input path="urn" class="form-control" name="urn" placeholder="URN" required="required"/>
								</div>
							</div>
							<div class="row">
								<small class="form-text text-danger col-sm-offset-4 col-sm-8">
									<c:if test="${addPayeeMessage!=null}">${addPayeeMessage}</c:if>
								</small>
							</div>
						</div>
						<div class="panel-footer">
							<small class="form-text text-success col-sm-8"> <c:if
									test="${payeeSuccessMsg!=null}">${payeeSuccessMsg}</c:if>
							</small> 
							<input type="submit" class="btn btn-default col-sm-3" value="Add" />
						</div>
					</div>
				</form:form>
			</c:if>
			
			
			<div class="row">
				<div class="option col-sm-offset-4 col-sm-4">
					<a href="MakeFundTransfer.mvc?sessionId=${sessionUser.acc_id}"><div class="well statement">Make Fund Transfer</div></a>
				</div>
			</div>
			<c:if test="${fundMessageToOther!=null}">
				<div class="well well-sm"><p class="text-center">${fundMessageToOther}</p></div>
			</c:if>
			<c:if test="${payeeList!=null}">
				<form:form action="ProcessFundTransferToOther.mvc?sessionId=${sessionUser.acc_id}" method="post" modelAttribute="newFundToOther">
					<div class="panel panel-default col-sm-offset-4 col-sm-4 remove-padding">
						<div class="panel-body">
							<form:hidden path="from" />
							<div class="form-group row">
								<label for="payee" class="col-sm-4">Payee</label>
								<div class="col-sm-8">
									<form:select path="payee"  class="form-control" name="payee" required="required">
										<form:option value="0">Select Payee</form:option>
										<c:forEach items="${payeeList}" var="payee">
											<form:option value="${payee.payeeAccId}">${payee.nickName} ${payee.payeeAccId}</form:option>
										</c:forEach>
									</form:select>
								</div>
							</div>
							<div class="form-group row">
								<label for="amount" class="col-sm-4">Amount</label>
								<div class="col-sm-8">
									<form:input path="amount" class="form-control" name="amount" placeholder="Amount" required="required" />
								</div>
							</div>
							<div class="form-group row">
								<label for="transPass" class="col-sm-4">Transaction Password</label>
								<div class="col-sm-8">
									<form:input path="pass" type="password" class="form-control" name="transPass" placeholder="Transaction Password" required="required"/>
								</div>
							</div>
						</div>
						<div class="panel-footer">
							<input type="submit" class="btn btn-default col-sm-offset-8 col-sm-3" value="Proceed" />
						</div>
					</div>
				</form:form>
			</c:if>
			<c:if test="${transactionIdtoOther!=null}">
				<div class="well well-sm col-sm-offset-4 col-sm-4"><p class="text-center text-justify">Fund Transfer Successfully completed with Transaction Id ${transactionIdtoOther}</p></div>
			</c:if>
						
		</div>
	</div>

	<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS || @Capgemini, India</strong>
	</div>
</body>
</html>