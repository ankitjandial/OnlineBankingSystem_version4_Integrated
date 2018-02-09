<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- 

File					: MiniStatement.jsp
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
<!-- 	Body -->

	<div class="container-fluid body-container">
		<div class="row">
			<!-- 		Back navigation to home  -->
			<h3 class="navigation-back">
				<a href="goback.mvc?id=${accId}&name=${name}"><span class="glyphicon glyphicon-arrow-left"></span> Home</a>
			</h3>
			<div class="table">
				<div class="well well-sm col-sm-offset-3 col-sm-6"><h4>Mini Statement</h4></div>
				<c:choose>
					<c:when test="${transactionList==null}">
						<p>Oops! No transaction is made by you yet.</p>
					</c:when>
					<c:otherwise>
						<div class="panel col-sm-offset-3 col-sm-6">
							<div class="panel-heading row column-head">
								<div class="col-sm-2 header">TransactionId</div>
								<div class="col-sm-3 header">Transaction Description</div>
								<div class="col-sm-3 header">Date Of Transaction</div>
								<div class="col-sm-2 header">Transaction Type</div>
								<div class="col-sm-2 header">Transaction Amount</div>
							</div>
							<hr />
							<div class="panel-body">
								<c:forEach items="${transactionList}" var="transaction">
									<div class="row column-content">
										<div class="col-sm-2">${transaction.tranId}</div>
										<div class="col-sm-3">${transaction.transDescription}</div>
										<div class="col-sm-3">${transaction.transDate}</div>
										<div class="col-sm-2">${transaction.transType}</div>
										<div class="col-sm-2">${transaction.transAmount}</div>
									</div><hr />
								</c:forEach>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	
<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS || @Capgemini, India</strong>
	</div>
</body>
</html>