<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.captcha.botdetect.web.servlet.Captcha"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>TSK | Register</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">

</head>
<body>
	<c:import url="header.jsp"></c:import>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="container-fluid">
		<div class="container m-sm-5">
			<c:choose>
				<c:when test="${errorValue!=null}">
					<div class="alert alert-danger fade show alert-dismissable"
						role="alert">
						${errorValue}
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:when>
				<c:when test="${re_register != null}">
					<div class="alert alert-success fade show alert-dismissable"
						role="alert">
						Data fetched successfully. Please feel free to edit the changes
						and set your password
						<button type="button" class="close" data-dismiss="alert"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<c:set var="patient" value="${re_register}" />
				</c:when>
				<c:when test="${re_register_error != null}">
					<div class="alert alert-danger fade show alert-dismissable"
						role="alert">
						${re_register_error}
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
					<div class="card p-sm-5">
						<h3 class="card-title text-center">Register</h3>
						<form action="${contextPath}/register.htm" method="post"
							enctype="multipart/form-data">
							<c:choose>
								<c:when test="${patient != null}">

									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="firstName">First Name</label> <input type="text"
													class="form-control" id="firstName"
													placeholder="Enter First Name" name="firstName"
													value="${patient.firstName}" required="required">
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<label for="lastName">Last Name</label> <input type="text"
													class="form-control" id="lastName"
													value="${patient.lastName}" placeholder="Enter Last Name"
													name="lastName" required="required">
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="mobileNumber">Mobile Number</label> <input
													type="text" class="form-control" id="mobileNumber"
													value="${patient.mobileNumber}"
													placeholder="Enter a valid 10 digit Mobile Number"
													name="mobileNumber" required="required" maxlength="10">
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<div class="custom-file">
													<label for="profilePic">Upload your profile picture</label><input
														type="file" class="form-control" id="profilePic"
														placeholder="Upload your picture" name="profilePicture">
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-sm-8">
											<div class="form-group">
												<label for="address">Address</label> <input type="text"
													class="form-control" id="address"
													value="${patient.address}"
													placeholder="Ex: 360, Huntington Ave, Boston, MA"
													name="address" required="required">
											</div>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<label for="pincode">Pincode</label> <input type="text"
													value="${patient.pincode}" class="form-control"
													id="pincode" placeholder="Ex: 02115" maxlength="6"
													name="pincode" required="required">
											</div>
										</div>
									</div>

									<div class="form-group">
										<label for="emailAddress">Email</label> <input type="email"
											class="form-control" id="emailAddress"
											value="${patient.email}" placeholder="Enter a Email ID"
											name="emailAddress" required="required" readonly="readonly">
									</div>
									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="password">Password</label> <input
													type="password" class="form-control" id="password"
													placeholder="Password" name="password" required="required">
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<label for="confirmPassword">Confirm Password</label> <input
													type="password" class="form-control" id="confirmPassword"
													placeholder="Confirm Password" name="confirmPassword"
													required="required">
											</div>

										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="firstName">First Name</label> <input type="text"
													class="form-control" id="firstName"
													placeholder="Enter First Name" name="firstName"
													required="required">
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<label for="lastName">Last Name</label> <input type="text"
													class="form-control" id="lastName"
													placeholder="Enter Last Name" name="lastName"
													required="required">
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="mobileNumber">Mobile Number</label> <input
													type="text" class="form-control" id="mobileNumber"
													placeholder="Enter a valid 10 digit Mobile Number"
													name="mobileNumber" required="required" maxlength="10">
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<div class="custom-file">
													<label for="profilePic">Upload your profile picture</label><input
														type="file" class="form-control" id="profilePic"
														placeholder="Upload your picture" name="profilePicture">
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-sm-8">
											<div class="form-group">
												<label for="address">Address</label> <input type="text"
													class="form-control" id="address"
													placeholder="Ex: 360, Huntington Ave, Boston, MA"
													name="address" required="required">
											</div>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<label for="pincode">Pincode</label> <input type="text"
													class="form-control" id="pincode" placeholder="Ex: 02115"
													maxlength="6" name="pincode" required="required">
											</div>
										</div>
									</div>

									<div class="form-group">
										<label for="emailAddress">Email</label> <input type="email"
											class="form-control" id="emailAddress"
											placeholder="Enter a Email ID" name="emailAddress"
											required="required">
									</div>
									<div class="row">
										<div class="col-sm-6">
											<div class="form-group">
												<label for="password">Password</label> <input
													type="password" class="form-control" id="password"
													placeholder="Password" name="password" required="required">
											</div>
										</div>
										<div class="col-sm-6">
											<div class="form-group">
												<label for="confirmPassword">Confirm Password</label> <input
													type="password" class="form-control" id="confirmPassword"
													placeholder="Confirm Password" name="confirmPassword"
													required="required">
											</div>

										</div>
									</div>
								</c:otherwise>
							</c:choose>
							<div class="form-group">
								<label for="captcha">Retype the characters from the
									picture</label>
								<%
									// Adding BotDetect Captcha to the page
									Captcha captcha = Captcha.load(request, "CaptchaObject");
									captcha.setUserInputID("captchaCode");

									String captchaHtml = captcha.getHtml();
									out.write(captchaHtml);
								%>
								<div class="row">
									<div class="col-sm-6">
										<input id="captcha" type="text" name="captchaCode"
											required="required" class="form-control mt-sm-4"
											placeholder="Enter Captcha" />
									</div>
								</div>

							</div>

							<input type="submit" class="btn btn-outline-primary btn-block"
								value="Register">
						</form>
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