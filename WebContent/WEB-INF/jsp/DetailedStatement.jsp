<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- 

File					: DetailedStatement.jsp
Author Name				: Gaurav Sahu
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

<script>


	$(function() {
		$('#datepicker1').datepicker({
			dateFormat : 'dd-mm-yy'
		}).val();
	});
	
	$(function() {
		$('#datepicker2').datepicker({
			dateFormat : 'dd-mm-yy'
		}).val();
	});
	
</script>

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
				<a href="goback.mvc?id=${accId}&name=${name}"><span class="glyphicon glyphicon-arrow-left"></span> Home</a>
			</h3>
			<div class="form-block row">
				<div class="panel panel-default remove-padding col-sm-offset-4 col-sm-4">
					<div class="panel-heading">
						<h3 class="header">Detailed Statement</h3>
					</div>
	
					<form:form action="ProcessSearchforDetailedStatement.mvc?id=${accId}" method="post" modelAttribute="transactionDetailed">
						
						<div class="panel-body">
							<div class="form-group">
								<label for="startDate" class="col-sm-offset-1 col-sm-3 control-label">From:</label>
								<div class="col-sm-7">
									<form:input path="frmDate" name="startDate" id="datepicker1" class="form-control line-height" placeholder="dd/mm/yyyy" data-toggle="tooltip" data-placement="top" readonly="readonly" title="Start Date" required="required" />
								</div>
							</div>
							<div class="form-group">
								<label for="endDate" class="col-sm-offset-1 col-sm-3 control-label">To:</label>
								<div class="col-sm-7">
									<form:input path="toDate" name="endDate" id="datepicker2" class="form-control line-height" placeholder="dd/mm/yyyy" data-toggle="tooltip" data-placement="top" title="Last Date" readonly="readonly" required="required" />
								</div>
							</div>
						</div>
						<div class="panel-footer">
							<div class="form-group">
								<div class="pull-right">
									<button type="submit" class="btn btn-default button-custom" data-toggle="tooltip" data-placement="top" title="Hit it to get statements">
										Get Statements <span class="glyphicon glyphicon-search"></span>
									</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
	
	
	
			<c:if test="${statementNotMessage!=null}">
				<div class="alert alert-warning row message">
					<p class="col-sm-offset-4 col-sm-4"><strong>Error!</strong> ${statementNotMessage}</p>
				</div>
			</c:if>
	
			<c:if test="${transactionList!=null}">
				<div class="row">
					<div class="panel panel-success remove-padding col-sm-offset-2 col-sm-8">
						<div class="panel-heading">
							<div class="row column-head">
								<div class="col-sm-2 header">Transaction Id</div>
								<div class="col-sm-3 header">Transaction Description</div>
								<div class="col-sm-3 header">Date Of Transaction</div>
								<div class="col-sm-2 header">Transaction Type</div>
								<div class="col-sm-2 header">Transaction Amount</div>
							</div>
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
				</div>
			</c:if>
		</div>
	</div>

	
<!-- 	Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom footer">
		<strong>Copyright &copy; OBS || @Capgemini, India</strong>
	</div>

</body>
</html>