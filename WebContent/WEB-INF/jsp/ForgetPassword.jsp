<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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
				<h4 class="navbar-text link-button"><a href="Login.mvc"><span class="glyphicon glyphicon-arrow-left"></span> Login</a></h4>
			</div>
		</div>
	</div>
	
<!-- 	Body -->
	 <div class="container body-container">
		<div class="row">
			<div class="panel panel-default remove-padding col-sm-offset-3 col-sm-6">
				<div class="panel-heading">
					<h3 class="header">Reset Password</h3>
				</div>
	
				<!-- 	Registraion Form -->
				<form action="processForgetPassword.mvc" method="post">
					<div class="panel-body">
						<div class="form-group row">
							<label for="userId" class="col-sm-4">User Id</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="userId" placeholder="User Id" required="required" />
							</div>
						</div>
						<div class="form-group row">
							<label for="oldPass" class="col-sm-4">Current Password</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" name="oldPass" placeholder="Current Password" required="required" />
							</div>
						</div>
						<div class="form-group row">
							<label for="newPass" class="col-sm-4">New Password</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" name="newPass" placeholder="New Password" required="required" />
							</div>
						</div>
					</div>
					<div class="panel-footer">
						<div class="col-sm-8">
							<c:if test="${msgSuccess!=null}">
								<p class="text-justify text-success text-center">${msgSuccess}</p>
							</c:if>

							<c:if test="${msg!=null}">
								<p class="text-justify text-danger text-center">${msg}</p>
							</c:if>
						</div>
						<input type="submit" class="btn btn-default col-sm-3" value="Create" />
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