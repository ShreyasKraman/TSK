<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<title>TSK | Welcome</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
</head>
<body>
	<!-------------------------------------- Menu ------------------------------------------------->
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<c:url var="logo" value="/resources/images/Logo.png" />
		<a class="navbar-brand" href="${contextPath}"><image src="${logo}"
				style="width:200px;height:60px;" /></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="${contextPath}/doctor/dashboard.htm">Home <span
						class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}/doctor/register-patient.htm">Register
						Patient</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}/doctor/schedule-appointment.htm">Schedule
						Appointment</a></li>
			</ul>

			<c:set var="userName" value="${sessionScope.username}" />
			<c:choose>
				<c:when test="${userName != null}">
					<span class="navbar-text dropdown"> <a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> Hi Admin! </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="${contextPath}/user/logout.htm">Logout</a>
						</div>
					</span>
				</c:when>
			</c:choose>
		</div>
	</nav>
	<!-------------------------------------------- Body -------------------------------------------------------->
	<div class="container-fluid">
		<div class="container">
			<h2 class="text-center">Register a patient</h2>
			<c:choose>
				<c:when test="${null != success}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<strong>Patient Registered Successfully. Verification
							link sent to patient
							<button type="button" class="close" data-dismiss="alert"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
					</div>
				</c:when>
				<c:when test="${null!=error}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<strong>Patient registeration failed. Please try after
							sometime
							<button type="button" class="close" data-dismiss="alert"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
					</div>
				</c:when>
			</c:choose>
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<div class="card p-sm-4">
						<form:form method="post" commandName="patientRegister"
							action="${contextPath}/doctor/register_patient.htm"
							enctype="multipart/form-data">
							<div class="form-group">
								<label for="email">Patient Email Id</label>
								<form:input id="email" cssClass="form-control" path="email"
									required="true" />
							</div>
							<div class="row">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="patientName">Patient First Name</label>
										<form:input id="patientName" cssClass="form-control"
											path="firstName" required="true" />
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<label for="patientName">Patient Last Name</label>
										<form:input id="patientName" cssClass="form-control"
											path="lastName" required="true" />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="patientAge">Age</label>
										<form:input id="patientAge" cssClass="form-control" path="age"
											required="true" />
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<label for="patientSex">Gender</label>
										<form:input id="patientSex" cssClass="form-control"
											path="gender" required="true" />
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="patientAddress">Address</label>
								<form:input id="patientAddress" cssClass="form-control"
									path="address" required="true" />
							</div>
							<div class="form-group">
								<label for="patientContact">Contact</label>
								<form:input id="patientContact" cssClass="form-control"
									path="mobileNumber" required="true" />
							</div>

							<div class="row">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="length">Length of course</label>
										<form:input id="length" cssClass="form-control"
											path="course_length" required="true" />
									</div>
								</div>
								<div class="col-sm-6">	
									<div class="form-group">
										<label for="date">Start date of course</label>
										<input id="date" class="form-control"
											type = "date" name="courseDate" required="true" />
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="report"
											name="medicalReport" required> <label
											class="custom-file-label" for="report">Upload Medical
											Report</label>
									</div>
								</div>
							</div>
							<input type="submit" class="btn btn-outline-primary btn-block"
								value="Register">
						</form:form>
						<a class="btn btn-outline-primary" href="${pageContext}/doctor/">DashBoard</a>
					</div>
				</div>
			</div>

		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
	<script defer
		src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"
		integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
		integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
		integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
		crossorigin="anonymous"></script>
</body>
</html>