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
					href="${contextPath}/doctor/dashboard.htm">Home <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}/doctor/register_patient.htm">Register Patient</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}/doctor/schedule-appointment.htm">Schedule Appointment</a></li>
			</ul>

			<c:set var="userName" value="${sessionScope.username}" />
			<c:choose>
				<c:when test="${userName != null}">
					<span class="navbar-text dropdown"> <a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> Hi $(requestScope.session.username)! </a>
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
			<div class="card">
				<div class="card-header">
					<h2 class="text-center">Patient Bio Data</h2>
					<h4 class="text-center card-subtitle mb-2 text-muted">Registeration
						Number:RN2351</h4>
				</div>
				<div class="card-body m-sm-4">
					<div class="row">
						<div class="col-sm-4">
							<table>
								<tbody>
									<tr>
										<td>Name</td>
										<td>Shreyas</td>
									</tr>
									<tr>
										<td>Address</td>
										<td>71/9 St Germain, Boston</td>
									</tr>
									<tr>
										<td>Age</td>
										<td>24</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-sm-4">
							<table>
								<tbody>
									<tr>
										<td>Sex</td>
										<td>Male</td>
									</tr>
									<tr>
										<td>Average BP</td>
										<td>115/90</td>
									</tr>
									<tr>
										<td>Average heart rate</td>
										<td>70bpm</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-sm-4">
							<table>
								<tbody>
									<tr>
										<td>Disease</td>
										<td>Tuberculosis</td>
									</tr>
									<tr>
										<td>Severity</td>
										<td>Latent</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<h2 class="text-center">List of patient appointment schedule</h2>

			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">Sr No</th>
						<th scope="col">Date</th>
						<th scope="col">Day</th>
						<th scope="col">Time</th>
						<th scope="col">Status</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${appointmentList}" var="appointment">
						<tr> 
							<th scope="row">${appointment.srno}</th>
							<td><input class="form-control" type="date"
								value="${appointment.date}" readonly></td>
							<td><input class="form-control" type="text"
								value="${appointment.day}" readonly>"</td>
							<td><input class="form-control" type="text"
								value="${appointment.time}" readonly></td>
							<td>${appointment.status}</td>
							<td><a
								href="${pageContext}/doctor/email_patient.htm/regno=RN2351&appointment_no=2"
								class="btn btn-primary">Send Mail</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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