<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>


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
	<div class="navbar navbar-default navbar-fixed-top increase-hieght" id="navigation">
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
		
			<div class="panel panel-default remove-padding col-sm-offset-4 col-sm-4">
				<div class="panel-heading">
					<h3 class="header">Password Update</h3>
				</div>
	
				<!-- 	Registraion Form -->
				<form action="ProcessChangePassword.mvc?sessionId=${sessionUser.acc_id}" method="post">
					<div class="panel-body">
						<div class="form-group row">
							<label for="password" class="col-sm-4">Current Password</label>
							<div class="col-sm-8">
								<input type="password" name="password" class="form-control" placeholder="Current Password" required="required" />
							</div>
						</div>
						<div class="form-group row">
							<label for="newPassword" class="col-sm-4">New Password</label>
							<div class="col-sm-8">
								<input type="password" name="newPassword" class="form-control" placeholder="New Password" required="required" />
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="col-sm-8">
							<c:if test="${message!=null}">
								<p class="text-justify text-success text-center">${message}</p>
							</c:if>

							<c:if test="${errMsg!=null}">
								<p class="text-justify text-danger text-center">${errMsg}</p>
							</c:if>
						</div>
						<input type="submit" class="btn btn-default col-sm-3" value="Update" />
					</div>
	
				</form>
			</div>
			
		</div>
	</div>

	<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS </strong>
	</div>
</body>
</html>