<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<!-- 

File					: home.jsp
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
						<h3 class="navbar-text text-success user-name">Welcome ${sessionUser.name }</h3>
					</c:otherwise>
				</c:choose>

				<a href="Logout.mvc" class="btn btn-default logout-button navbar-btn" data-toggle="tooltip" data-placement="left" title="Hit this to logout">Logout <span class="glyphicon glyphicon-log-out"></span></a>
			</div>
		</div>
	</div>
	

	
<!-- 	Menu -->
	<div class="container body-container">
		<div class="row">
			<div class="option">
				<a href="ViewStatement.mvc?name=${sessionUser.name}&id=${sessionUser.acc_id}"><div class="well">View Statement</div></a>
			</div>
			<div class="option">
				<a href="#update" data-toggle="collapse"><div class="well">Update Account Information<span class="glyphicon glyphicon-tasks pull-right"></span></div></a>
			</div>
			<div id="update" class="collapse option">
				<a href="UpdateCustomerProfile.mvc?sessionId=${sessionUser.acc_id}"><div class="well well-sm col-sm-offset-1">Change Account Information</div></a>
				<a href="UpdatePassword.mvc"><div class="well well-sm col-sm-offset-1">Change Password</div></a>
			</div>
			<div class="option">
				<a href="#services" data-toggle="collapse"><div class="well">Services<span class="glyphicon glyphicon-tasks pull-right"></span></div></a>
			</div>
			<div id="services" class="collapse option">
				<a href="RequestChequeBook.mvc?sessionId=${sessionUser.acc_id}"><div class="well well-sm col-sm-offset-1">Request For Chequebook</div></a>
				<a href="TrackServiceRequest.mvc?sessionId=${sessionUser.acc_id}"><div class="well well-sm col-sm-offset-1">Track a Service Request</div></a>
				<a href="GetAllServiceRequests.mvc?sessionId=${sessionUser.acc_id}"><div class="well well-sm col-sm-offset-1">Get All Service Requests</div></a>
			</div>
			<div class="option">
				<a href="FundHomePage.mvc"><div class="well control-anchor">Fund Transfer</div></a>
			</div>
			
		</div>
	</div>
	
	<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS || @Capgemini, India</strong>
	</div>
</body>
</html>