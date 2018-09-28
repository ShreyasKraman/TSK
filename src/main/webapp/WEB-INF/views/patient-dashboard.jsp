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
	<c:import url="header.jsp"></c:import>
	<!-------------------------------------------- Body -------------------------------------------------------->
	<div class="container-fluid">
		<div class="container">
			<h2 class="text-center">Your DashBoard</h2>
			<div class="row">
				<div class="col-sm-6">
					<div class="card m-sm-2">
						<div class="card-header bg-info text-white text-center">
							<h3 class="card-title">Your Bio Data</h3>
						</div>
						<c:set var="patientBio" value="${patientdata}" />
						<div class="card-body">
							<div class="row">
								<div class="col-sm-8">
									<table class="table">
										<tbody>
											<tr>
												<td>First & Last Name</td>
												<td>${patientBio.patient.firstName}
													${patientBio.patient.lastName}
											</tr>
											<tr>
												<td>Age</td>
												<td>${patientBio.patient.age}</td>
											</tr>
											<tr>
												<td>Sex</td>
												<td>${patientBio.patient.gender}</td>
											</tr>
											<c:if test="${null != patientBio.recentReport}">
												<tr>
													<td>Blood Pressure</td>
													<td>${patientBio.recentReport.systolicPressure}/${patientBio.recentReport.diastolicPressure}</td>
												</tr>

												<tr>
													<td>Recent Heart Rate (bpm)</td>

													<td>${patientBio.recentReport.heart_rate}
												</tr>
											</c:if>
										</tbody>
									</table>
								</div>
								<div class="col-sm-4">
									<c:url value="" var="image" />
									<img src="${image}" class="img-fluid img-thumbnail"
										style="width: 140px; height: 140px">
									<!--<img src="${patientBio.image}"
										style="width: 40px; height: 40px" />-->
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="card m-sm-2">
						<c:choose>
							<c:when test="${null != patientBio.recentReport}">
								<c:if test="${patientBio.recentReport.dis_stat}">
									<c:choose>
										<c:when
											test="${patientBio.recentReport.tb_activity=='Latent'}">
											<div class="card-header bg-warning text-white">
												<h3 class="card-title text-center">Tuberculosis status
													: Latent</h3>
											</div>
										</c:when>
										<c:otherwise>
											<div class="card-header bg-danger text-white">
												<h3 class="card-title text-center">Tuberculosis status
													: Active</h3>
											</div>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:when>
							<c:otherwise>
								<div class="card-header bg-info text-white">
									<h3 class="card-title text-center">Tuberculosis status :
										N/A</h3>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="card-body">
							<table class="table">
								<tbody>
									<tr>
										<td>Course Duration</td>
										<td>${patientBio.patient.course_length}</td>
									</tr>
									<tr>
										<c:choose>
											<c:when test="${patientBio.patient.course_length != 0}">
												<td><a
													href="${contextPath}/user/appointmentList.htm?patient_id=${patientBio.patient.patientId}"
													class="btn btn-outline-primary">See total Appointment
														List</a></td>
											</c:when>
											<c:otherwise>
												<td><a href="${pageContext}/user/appointmentList.htm"
													class="btn btn-outline-primary" disabled>See total
														Appointment List</a></td>
											</c:otherwise>
										</c:choose>

									</tr>
								</tbody>
							</table>
							<div class="card">
								<div id="chartContainer" style="height: 300px; width: 100%;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="card m-sm-4">
					<div class="card-header">
						<h3 class="card-title text-center">Medical Reports</h3>
					</div>
					<div class="card-body m-sm-4>">
						<c:set var="user_reports" value="${patientBio.reports}" />
						<c:choose>
							<c:when test="${user_reports != null}">
								<table class="table">
									<thead>
										<tr>
											<th scope="col">Report Id</th>
											<th scope="col">Date</th>
											<th scope="col">Hospital Name</th>
											<th scope="col">Blood Pressure</th>
											<th scope="col">Heart Rate</th>
											<th scope="col">Disease</th>
											<th scope="col">Disease Type</th>
											<th scope="col">Disease status</th>
											<th scope="col">Remarks</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${user_reports}" var="report">
											<tr>
												<th scope="row">${report.reportId}</th>
												<td>${report.date}</td>
												<td>${report.hospital_name}</td>
												<td>${report.systolicPressure}/${report.diastolicPressure}</td>
												<td>${report.heart_rate}</td>
												<c:choose>
													<c:when test="${report.dis_stat}">
														<td>Tuberculosis</td>
													</c:when>
													<c:otherwise>
														<td>No Disease</td>
													</c:otherwise>
												</c:choose>
												<td>${report.tb_type}</td>
												<td>${report.tb_activity}</td>
												<td>${report.remarks}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

								<div class="card m-sm-4 p-sm-4">
									<div class="card-header text-center">Upload Medical
										Report</div>
									<div class="card-body">
										<form action="${contextPath}/user/uploadReports.htm"
											method="post" enctype="multipart/form-data">
											<div class="row">
												<div class="col-sm-6">
													<div class="form-group">
														<div class="custom-file">
															<input type="file" class="custom-file-input" id="report"
																name="medicalReport" required> <label
																class="custom-file-label" for="report">Choose
																latest report</label>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6">
													<div class="form-group">
														<label for="date">Choose the date you want to
															start your course</label> <input id="date" class="form-control"
															type="date" name="courseDate" required />
													</div>
												</div>
												<div class="col-sm-6">
													<input type="submit"
														class="btn btn-outline-primary btn-block"
														value="Upload Medical Report">
												</div>
											</div>

										</form>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<h6>
									No File found. Please upload at least one medical report given
									to you by your <span class="text-info">registered clinic</span>
								</h6>
								<form action="${contextPath}/user/uploadReports.htm"
									method="post" enctype="multipart/form-data">
									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<div class="custom-file">
													<label for="report">Upload Medical Report</label> <input
														type="file" class="custom-file-input" id="report"
														name="medicalReport"> <label
														class="custom-file-label" for="report">Choose
														latest report</label>
												</div>
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<label for="date">Choose the date you want to start
													your course</label> <input id="date" class="form-control"
													type="date" name="courseDate" required />
											</div>
										</div>
									</div>
									<input type="submit" class="btn btn-primary"
										value="Upload Medical Report">
								</form>
							</c:otherwise>
						</c:choose>
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
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js" /></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" /></script>
	<script type="text/javascript"
		src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/canvasjs.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/jquery.canvasjs.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/jquery.canvasjs.min.js"></script>

	<script type="text/javascript">
		var chart = new CanvasJS.Chart("chartContainer", {
			animationEnabled : true,
			theme : "light2", // "light1", "light2", "dark1", "dark2"
			title : {
				text : "Tuberculosis stats Age Wise in your area"
			},
			axisY : {
				title : "Affected people",
				suffix : "%",
				includeZero : false
			},
			axisX : {
				title : "Age Groups"
			},
			data : [ {
				type : "column",
				yValueFormatString : "#,##0.0#\"%\"",
				dataPoints : [ {
					label : "0-20",
					y : 2.1
				}, {
					label : "20-40",
					y : 5.70
				}, {
					label : "40-60",
					y : 5.00
				}, {
					label : "60-80",
					y : 7.50
				}, {
					label : "80-100",
					y : 1.30
				} ]
			} ]
		});

		chart.render();
	</script>
</body>
</html>
