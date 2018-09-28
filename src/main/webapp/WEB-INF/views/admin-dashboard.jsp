<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TSK | Admin</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
</head>
<body>
	<c:import url="header.jsp"></c:import>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	<div class="container-fluid">
		<div class="container m-sm-5">
			<div class="row">
				<div class="col-sm-12">
					<div class="card">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>Clinic Id</th>
										<th>Clinic Name</th>
										<th>Clinic Address</th>
										<th>Clinic Pincode</th>
										<th>Name of doctor (owner)</th>
										<th>Name of visiting doctors</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${clinicList}" var="clinic">
										<tr>
											<td>${clinic.clinic_id}</td>
											<td>${clinic.clinic_name }</td>
											<td>${clinic.address}</td>
											<td>${clinic.pincode}</td>
											<td>${clinic.main_doc.firstName}
												${clinic.main_doc.lastName}
												(${${clinic.main_doc.qualification} })</td>
											<c:if test="${clinic.visitingDoctors != null}"}>
												<td><c:forEach items="${clinic.visitingDoctors}"
														var="visiting">
													${visiting.firstName} ${visiting.lastName} (${visiting.qualification}),
												</c:forEach></td>
											</c:if>
											<c:if test="${clinic.visitingDoctors != null}">
												<td>-</td>
											</c:if>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<a href="${contextPath}/admin/add-clinic.htm" class="btn btn-primary-outline">Add a Clinic</a>
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