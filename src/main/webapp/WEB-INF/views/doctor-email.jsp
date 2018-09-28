<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

	<c:set var="patient" value="${mailPackage}" />
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<div class="card m-sm-4">
						<div class="card-header">
							<div class="card-title text-center card-header">
								<h6>
									Send Mail to <b>${patient.patient.firstName}
										${patient.patient.lastName}</b> with Registration No: <b>${patient.patient.patientId}</b>
								</h6>
							</div>
							<div class="card-body">
								<div class="form-group">
									<label for="sendTo">To</label> <input type="email" id="sendTo"
										class="form-control" placeholder="Email address of receiver"
										value="${patient.patient.email }">
								</div>

								<div class="form-group">
									<label for="sendfrom">From</label> <input type="email"
										id="sendfrom" class="form-control"
										placeholder="Email address of sender"
										value="callthebadri@gmail.com">
								</div>

								<div class="form-group">
									<label for="subject">Subject</label> <input type="text"
										id="subject" class="form-control" placeholder="Subject"
										value="${patient.clinicName} : Update regarding your appointment on ${patient.date} at ${patient.time}">
								</div>

								<div class="form-group">
									<label for="body">Message</label>
									<textarea id="mailBody" class="form-control" rows="3">
									</textarea>
								</div>

								<button class="btn btn-primary sendMail">Send Mail</button>
							</div>
						</div>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".sendMail").click(function() {

				var sendTo = $("#sendTo").val();
				var from = $("#sendfrom").val();
				var subject = $("#subject").val();
				var body = $("#mailBody").val();

				var data = "{ id:1, receiver:" + sendTo + ", sender:" + from+ ", subject:" + subject + ", message:" + body+"}";
						

				alert(data);
	
				swal({
					title : "Confim send",
					text : "Do you want to send this email",
					type : "info",
					showCancelButton : true,
					closeOnConfirm : false,
					showLoaderOnConfirm : true
				}, function() {
					$.post("localhost:8080/tsk/doctor/sendmail.htm", {
						data : JSON.stringify(data)
					}, function(data, status, xhr) {
						alert(status);
					}).done(function() {
						setTimeout(function() {
							swal("Email sent successfully");
						}, 2000);
					}).fail(function(jqxhr, settings, ex) {
						alert("Email sending failed"+"jxhr"+jqxhr.responseText+jqxhr.status+" settings:"+settings+" ex"+ex);
					});

				});
			});
		});
	</script>

</body>
</html>
</body>
</html>