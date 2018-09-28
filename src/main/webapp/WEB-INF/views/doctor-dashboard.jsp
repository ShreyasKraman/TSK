<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>TSK | Welcome</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
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
					href="${contextPath}/doctor/register_patient.htm">Register
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
						aria-expanded="false"> Hi ${userName}! </a>
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
			<h2 class="text-center">List of patient appointment schedule</h2>

			<c:choose>
				<c:when test="${appointmentMessage!= null}">
					<div class="alert alert-info" role="alert">
						<h6 class="text-center">${appointmentMessage}.Makesureyou
							have registered some patients</h6>
					</div>
				</c:when>
				<c:when test="${errorMessage != null}">
					<div class="alert alert-danger" role="alert">
						<h6 class="text-center">${errorMessage}</h6>
					</div>
				</c:when>
				<c:otherwise>
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">Reg. No</th>
								<th scope="col">Name</th>
								<th scope="col">Address</th>
								<th scope="col">Mobile</th>
								<th scope="col">Allergy</th>
								<th scope="col">Disease</th>
								<th scope="col">Severity</th>
								<th scope="col">Course Duration</th>
								<th scope="col">Appointment Date time</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${appointmentList}" var="patient">

								<c:forEach items="${patient.reports}" var="reports">
									<c:forEach items="${reports.patientAppointments}"
										var="appointment">
										<tr>
											<th scope="row">${appointment.id}</th>
											<td>${patient.firstName}${patient.lastName}</td>
											<td>${patient.address}</td>
											<td>${patient.mobileNumber}</td>
											<td>${reports.allergy}</td>
											<td>${reports.tb_type}Tuberculosis</td>
											<td>${reports.tb_activity}</td>
											<td>${patient.course_length}days</td>
											<td><c:out value="${appointment.date}" /> at
												${appointment.time}</td>
											<td>
											<a href="${contextPath}/doctor/send_email.htm?
												email=${patient.email}&date=${appointment.date}
												&time=${appointment.time}&reportId=${reports.reportId}"
												class="btn btn-outline-primary">
												Send Email</a></td>
										</tr>
									</c:forEach>
								</c:forEach>


							</c:forEach>
							<!-- <tr>
							<th scope="row">MASGEN20168</th>
							<td>Shreyas</td>
							<td>78/2 St Germain</td>
							<td>9876543210</td>
							<td>N/A</td>
							<td>Pulmonary Tuberculosis</td>
							<td>Latent</td>
							<td>9 months</td>
							<td>29/05/2018 17:00:00</td>
							<td><a
								href="${pageContext}/doctor/full_appointment.htm?reg_no=MASGEN20168"
								class="btn btn-primary">Full Appointment list</a></td>
						</tr> -->
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>
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