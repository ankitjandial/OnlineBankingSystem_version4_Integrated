<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>      

<!-- 

File					: TrackServiceRequest.jsp
Author Name				: Sayali Banjari
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
				<a href="goback.mvc?id=${accId}&name=${name}"><span
					class="glyphicon glyphicon-arrow-left"></span> Home</a>
			</h3>

			<div class="well well-sm">
				<h2 class="text-center">Track Services</h2>
			</div>

			<div class="row">
				<c:if test="${listRequestId!=null}">
					<div class="col-sm-offset-3 col-sm-3">
						<div class="well well-sm">
							<h3 class="text-center">Requested Services</h3>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="row">
									<h4 class="header col-sm-offset-2 col-sm-4">Sr.</h4>
									<h4 class="header col-sm-4">Service Id</h4>
								</div>
							</div>
							<div class="panel-body">
								<%
									int count = 0;
								%>
								<c:forEach items="${listRequestId}" var="service">
									<strong class="col-sm-offset-2 col-sm-4 text-center"><%=count%></strong>
									<strong class="col-sm-4 text-center">${service.servID}</strong>
									<%
										count++;
									%>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="panel panel-success">
							<form:form action="ProcessTrackServiceRequest.mvc" method="post">
								<div class="panel-body">
									<div class="form-group row">
										<label for="Id" class="col-sm-5">Service Request Id</label>
										<div class="col-sm-7">
											<input type="text" name="Id" class="form-control"
												placeholder="Service Request Id" required="required" />
										</div>
									</div>
								</div>
								<div class="panel-footer">
									<input type="submit"
										class="btn btn-default col-sm-offset-8 col-sm-3"
										value="Get Details" />
								</div>
							</form:form>
						</div>
					</div>
				</c:if>
			</div>

			<div class="row">
				<c:if test="${serviceTrackerBean!=null}">
					<div class="panel panel-default col-sm-offset-4 col-sm-4">
						<div class="panel-heading">
							<div class="row">
								<h4 class="header col-sm-3">Service Id</h4>
								<h4 class="header col-sm-3">Service Date</h4>
								<h4 class="header col-sm-3">Service Status</h4>
								<h4 class="header col-sm-3">Service Description</h4>
							</div>
						</div>
						<div class="panel-body row">
							<strong class="col-sm-3 text-center">${serviceTrackerBean.servID}</strong> <strong
								class="col-sm-3 text-center">${serviceTrackerBean.servDate}</strong> <strong
								class="col-sm-3 text-center">${serviceTrackerBean.servStatus}</strong> <strong
								class="col-sm-3 text-center">${serviceTrackerBean.servDesc}</strong>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS || @Capgemini, India</strong>
	</div>
</body>
</html>