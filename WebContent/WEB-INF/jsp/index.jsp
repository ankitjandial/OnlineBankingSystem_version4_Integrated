<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!-- 

File					: index.jsp
Author Name				: Gaurav Sahu
Description				: View for Login and signup to users
Version					: 5
Last Modified Date		: 01/01/2018
Change Description		: Provided View Design to Functionalities (Look and Feel)

-->




<!DOCTYPE>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Digital Banking | OBS </title>

<c:url value="/externalFiles/css/bootstrap.min.css" var="bootstrap"></c:url>
<c:url value="/externalFiles/css/css.css" var="style"></c:url>

<link rel="stylesheet" type="text/css" href="${bootstrap}" />
<link rel="stylesheet" type="text/css" href="${style}" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>

	<!-- Header -->
	<div class="navbar navbar-default navbar-fixed-top" role="navigation" id="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" id="sitename" data-toggle="tooltip" data-placement="bottom" title="Digital Banking | OBS"><h2>Online Banking System</h2></a>
			</div>
			<div class="nav navbar-nav navbar-right">
				<form action="ProcessLogin.mvc" class="navbar-form" method="post">
					<input type="text" class="form-control" name="userId" placeholder="User ID" title="User ID" required />
					<input type="password" class="form-control" name="password" placeholder="Password" title="Password" required/>
					<button type="submit" class="btn btn-default login-button"><span class="glyphicon glyphicon-log-in"></span> Login</button>
				</form>
				<c:if test="${loginerrMsg!=null}">
					<p class="navbar-text">${loginerrMsg }</p>
				</c:if>
				<p class="navbar-text"><a href="gotoForget.mvc">Forgot Password? Click Here</a></p>
			</div>
		</div>
	</div>
	
	<div class="container-fluid body-container">
		<div class="row">
			<div class="col-sm-8">
			
			</div>
			<div class="col-sm-4 pull-right">
			
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="header">Register</h3>
						<c:if test="${userId!=null}">
							<div style="color: green;" align="center">You have
								successfully registered. Please note down your Id:${userId}</div>
						</c:if>
						<c:if test="${errMsg!=null}">${errMsg}</c:if>
					</div>
					
				<!-- 	Registraion Form -->
					<form:form action="ProcessRegisterForm.mvc" method="post" modelAttribute="userbean" class="form-horizontal">
						<div class="panel-body">
							<div class="form-group row">
								<label for="account_id" class="col-sm-4">Account Number</label>
								<div class="col-sm-8">
									<form:input path="accID" class="form-control" name="account_id" placeholder="Account Number" />
								</div>
							</div>
							<div class="row">
								<small class="form-text text-danger col-sm-offset-4 col-sm-8">
									<form:errors path="accID" />
								</small>
							</div>
							<div class="form-group row">
								<label for="account_id" class="col-sm-4">Password</label>
								<div class="col-sm-8">
									<form:input path="password" type="password" class="form-control" name="account_id" placeholder="Create your Password" />
								</div>
							</div>
							<div class="row">
								<small class="form-text text-danger col-sm-offset-4 col-sm-8">
									<form:errors path="password" />
								</small>
							</div>
							<div class="form-group row">
								<label for="account_id" class="col-sm-4">Security Question</label>
								<div class="col-sm-8">
									<form:input path="question" class="form-control" name="account_id" placeholder="Security Question" />
								</div>
							</div>
							<div class="row">
								<small class="form-text text-danger col-sm-offset-4 col-sm-8">
									<form:errors path="question" />
								</small>
							</div>
							<div class="form-group row">
								<label for="account_id" class="col-sm-4">Transaction Password</label>
								<div class="col-sm-8">
									<form:input path="transactionPassword" type="password" class="form-control" name="account_id" placeholder="Transaction Password" />
								</div>
							</div>
							<div class="row">
								<small class="form-text text-danger col-sm-offset-4 col-sm-8">
									<form:errors path="transactionPassword" />
								</small>
							</div>
						</div>
						<div class="panel-footer register">
							<input type="submit" class="btn btn-default col-sm-offset-8 col-sm-3" value="Register" />
						</div>
					
					</form:form>
				</div>
				
			</div>
		</div>
	</div>
	
	<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS || @Capgemini, India</strong>
	</div>
</body>
</html>