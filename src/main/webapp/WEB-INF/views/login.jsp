<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Tsk | Login</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
</head>
<body>
	<c:import url="header.jsp"></c:import>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="container-fluid">
		<div class="container m-sm-5">
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<c:choose>
						<c:when test="${verification}">
							<div class="alert alert-success alert-dismissible fade show"
								role="alert">
								Verification link sent successfully. Please verify your account
								from registered email address.
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
						</c:when>
						<c:when test="${errorVerify != null}">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert">
								${errorVerify}
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
						</c:when>
						<c:when test="${errorMessage != null}">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert">
								${errorMessage}
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
						</c:when>
						<c:when test="${successVerify != null}">
							<div class="alert alert-success alert-dismissible fade show"
								role="alert">
								${successVerify}
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
						</c:when>
						<c:when test="${expired != null}">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert">
								${expired} <a href="${contextPath}/user/resendemail.htm">Resend
									Verification Link</a>
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
						</c:when>
						<c:when test="${registerExpired != null }">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert">
								${expired} <a href="${contextPath}/user/resendRegisterEmail.htm">Resend
									Verification Link</a>
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
						</c:when>
					</c:choose>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-4">
					<div class="card">
						<div class="card-body">
							<h6 class="text-center card-subtitle mb-2 text-muted">Dont
								have an account?</h6>
							<h3 class="text-center card-title">Create an Account</h3>

							<p class="card-text lead">By creating an account you can</p>
							<ul>
								<li>Digitize your TB Medical Report</li>
								<li>Know your progress on fight over TB</li>
								<li>Book an appointment with doctor</li>
								<li>Keep track of your future appointments</li>
								<li>Keep tabs on the cost spent for the treatment</li>
							</ul>
							<a href="${contextPath}/register.htm"
								class="btn btn-outline-primary btn-block">Register</a>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="card">
						<div class="card-body">
							<h3 class="text-center card-title">Log in</h3>
							<form action="${contextPath}/login.htm" method="Post">
								<div class="form-group">
									<label for="inputEmail">Email address</label> <input
										type="email" class="form-control" id="inputEmail"
										name="username" placeholder="Enter email" />
								</div>

								<div class="form-group">
									<label for="inputPassword">Password</label> <input
										type="password" class="form-control" id="inputPassword"
										name="password" placeholder="Password" />
								</div>
								<button type="submit" class="btn btn-outline-primary btn-block">Log
									in</button>
							</form>
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
</body>
</html>