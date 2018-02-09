<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>       


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
			
			<div class="well well-sm">
				<h2 class="text-center">Track Services</h2>
			</div>
			
			<c:if test="${serviceRequests!=null}">
				<div class="panel panel-default remove-padding col-sm-offset-4 col-sm-4">
					<div class="panel-heading">
						<div class="row">
							<h4 class="header col-sm-2">Service Id</h4>
							<h4 class="header col-sm-4">Service Date</h4>
							<h4 class="header col-sm-2">Service Status</h4>
							<h4 class="header col-sm-4">Service Description</h4>
						</div>
					</div>
					<div class="panel-body">
						<c:forEach items="${serviceRequests}" var="serviceRequest">
							<div class="row">
								<strong class="col-sm-2 text-center">${serviceRequest.servID}</strong>
								<strong class="col-sm-4 text-center">${serviceRequest.servDate}</strong>
								<strong class="col-sm-2 text-center">${serviceRequest.servStatus}</strong>
								<strong class="col-sm-4 text-center">${serviceRequest.servDesc}</strong>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
		</div>
	</div>

	<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS </strong>
	</div>
</body>
</html>