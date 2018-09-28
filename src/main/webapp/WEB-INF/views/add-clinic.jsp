<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TSK | Add Clinic</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
</head>
<body>
	<c:import url="header.jsp"></c:import>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	<div class="container-fluid m-sm-2">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<div class="card">
					<h3 class="card-title text-center m-sm-4">Register Clinic</h3>
					<form:form commandName="clinic" action="${contextPath}/admin/add-clinic.htm" method="post">
						<div class="form-group">
							<label for="clinicId">Clinic Registeration number</label>
							<form:input path="registerationID" id="clinicId" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for="clinicName">Clinic Name</label>
							<form:input path="clinic_name" id="clinicName" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for="address">CLinic Address</label>
							<form:input path="address" id="address" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for="stateName">State</label>
							<form:input path="state" id="stateName" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for="countryName">Country</label>
							<form:input path="country" id="countryName" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for="pincode">Pincode</label>
							<form:input path="pincode" id="pincode" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for=telephone>Telephone</label>
							<form:input path="telephone_number" id="telephone" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for=mainDocfName>Doctor First Name(Owner)</label>
							<form:input path="main_doc[0].firstName" id="mainDocName" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for=mainDoclName>Doctor Last Name(Owner)</label>
							<form:input path="main_doc[0].lastName" id="mainDoclName" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for=docRegNo>Doctor Registrnation Number(Owner)</label>
							<form:input path="main_doc[0].registered_id" id="docRegNo" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for="docTele">Doctor Telephone Number(Owner)</label>
							<form:input path="main_doc[0].mobileNo" id="docTele" cssClass="form-control"/>
						</div>
						<div class="form-group">
							<label for="quali">Doctor Telephone Number(Owner)</label>
							<form:input path="main_doc[0].qualification" id="quali" cssClass="form-control"/>
						</div>	
						
						<input type="submit" class="btn btn-outline-primary btn-block"/>					
					</form:form> 	
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