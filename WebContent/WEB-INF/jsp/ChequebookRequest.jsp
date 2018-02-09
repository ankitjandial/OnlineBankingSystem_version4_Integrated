<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!-- 

File					: CheckBookRequest.jsp
Author Name				: Harika Devu
Description				: View for Login and signup to users
Version					: 5
Last Modified Date		: 02/01/2018
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
	
	<div class="container-fluid body-container">
		<div class="row">
		
		<!-- 		Back navigation to home  -->
			<h3 class="navigation-back">
				<a href="goback.mvc?id=${accId}&name=${name}"><span class="glyphicon glyphicon-arrow-left"></span> Home</a>
			</h3>
		
			<div class="panel panel-default remove-padding col-sm-offset-4 col-sm-4">
				<div class="panel-heading">
					<h3 class="header">Request for Cheque Book</h3>
				</div>
	
				<!-- 	Registraion Form -->
				<form:form action="ProcessRequestChequeBook.mvc" method="post" modelAttribute="newService">
					<form:hidden path="accID" />
					<div class="panel-body">
						<div class="form-group row">
							<label for="servDesc" class="col-sm-4">Description</label>
							<div class="col-sm-8">
								<form:textarea rows="3" cols="30" path="servDesc" name="servDesc" class="form-control control-textarea" placeholder="Why are you applying for cheque book?" required="required"></form:textarea>
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="col-sm-8">
							<c:if test="${message!=null}">
								<p class="text-justify text-success text-center">${message}</p>
							</c:if>
						</div>
						<input type="submit" class="btn btn-default col-sm-3" value="Request" />
					</div>
	
				</form:form>
			</div>
		</div>
	</div>
	
<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS || @Capgemini, India</strong>
	</div>

</body>
</html>