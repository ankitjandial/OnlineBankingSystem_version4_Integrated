<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>


<!-- 	 	Header -->
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
						<h3 class="navbar-text text-success user-name"> ${sessionUser.name }</h3>
					</c:otherwise>
				</c:choose>
			<!-- 	Logout -->
				<h4 class="navbar-text link-button"><a href="Logout.mvc"><span class="glyphicon glyphicon-log-out"></span> Logout</a></h4>
			</div>
		</div>
	</div>
	
	
	<!-- 	Body -->
	 <div class="container body-container">
		<div class="row">
		<!-- 		Back navigation to home  -->
			<h3 class="navigation-back">
				<a href="goback.mvc?id=${accId}&name=${name}"><span class="glyphicon glyphicon-arrow-left"></span> Home</a>
			</h3>
			<div class="panel panel-default remove-padding col-sm-offset-3 col-sm-6">
				<div class="panel-heading">
					<h3 class="header">Profile Update</h3>
				</div>
	
				<!-- 	Registraion Form -->
				<form:form action="ProcessUpdateCustomerDetails.mvc" method="post" modelAttribute="customer">
					<div class="panel-body">
						<div class="form-group row">
							<label for="customerName" class="col-sm-4">Name</label>
							<div class="col-sm-8">
								<form:hidden path="name" name="customerName" />${customer.name}
							</div>
						</div>
						<div class="form-group row">
							<label for="accountId" class="col-sm-4">Account Number</label>
							<div class="col-sm-8">
								<form:hidden path="acc_id" name="accountId" />${customer.acc_id}
							</div>
						</div>
						<div class="form-group row">
							<label for="phone" class="col-sm-4">Contact Number</label>
							<div class="col-sm-8">
								<form:input path="phone" name="phone" required="required" Pattern="[6-9][0-9]{9}" />
							</div>
						</div>
						<div class="form-group row">
							<label for="address" class="col-sm-4">Address</label>
							<div class="col-sm-8">
								<form:input path="address" name="address" required="required" />
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="col-sm-8">
							<c:if test="${message!=null}">
								<p class="text-justify text-success text-center">${message}</p>
							</c:if>
						</div>
						<input type="submit" class="btn btn-default col-sm-3" value="Update" />
					</div>
	
				</form:form>
			</div>
		</div>
	</div>
	
<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<small>Copyright &copy; OBS </small>
	</div>
</body>
</html>