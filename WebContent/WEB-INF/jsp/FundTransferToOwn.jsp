<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<c:if test="${accountList==null || fundMessage!=null}">
	<div class="well well-sm"><p>${fundMessage}</p></div>
</c:if>

	<div class="container-fluid body-container">
		<div class="row">
			<!-- 		Back navigation to home  -->
			<h3 class="navigation-back">
				<a href="goback.mvc?id=${accId}&name=${name}"><span class="glyphicon glyphicon-arrow-left"></span> Home</a>
			</h3>
			<div class="well well-sm"><h4 class="text-center">Fund Transfer To Own Account</h4></div>
			
			<c:if test="${accountList!=null}">
				<form:form action="ProcessFundTransfer.mvc?sessionId=${sessionUser.acc_id}" method="post" modelAttribute="newFund">
					<div class="panel panel-default col-sm-offset-4 col-sm-4 remove-padding">
						<div class="panel-body">
							<div class="form-group row">
								<label for="from" class="col-sm-4">From</label>
								<div class="col-sm-8">
									<form:select path="from"  class="form-control" name="from" required="required">
										<form:option value="0">Select Payer</form:option>
										<form:options items="${accountList}" />
									</form:select>
								</div>
							</div>
							<div class="form-group row">
								<label for="payee" class="col-sm-4">To</label>
								<div class="col-sm-8">
									<form:select path="payee"  class="form-control" name="payee" required="required">
										<form:option value="0">Select Payee</form:option>
										<form:options items="${accountList}" />
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
		</div>
	</div>

<c:if test="${transactionId!=null}">
	<div class="well well-sm"><p class="text-center text-danger">Fund Transfer Successfully completed with Transaction Id ${transactionId}</p></div>
</c:if>
<c:if test="${fundMessage!=null}">
	<div class="well well-sm"><p class="text-center text-danger">${fundMessage}</p></div>
</c:if>
<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS </strong>
	</div>
</body>
</html>