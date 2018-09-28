<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
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
					href="${contextPath}">Home <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}#how-it-works">How it Works</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}#about-us">About Us</a></li>
			</ul>

			<c:set var="userName" value="${sessionScope.username}" />
			<c:choose>
				<c:when test="${userName != null}">
					<span class="navbar-text dropdown"> <a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> Hi ${userName} </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">Profile</a> <a
								class="dropdown-item" href="#">Account Settings</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="${contextPath}/user/logout.htm">Logout</a>
						</div>
					</span>
					<span class="navbar-text"><a class="nav-link" href="${contextPath}/user/dashboard.htm">Dashboard</a></span>
				</c:when>
				<c:otherwise>
					<span class="navbar-text"> <a class="nav-link"
						href="${contextPath}/register.htm">Register</a></span>
					<span class="navbar-text"> <a class="nav-link"
						href="${contextPath}/login.htm">Log in</a>
					</span>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
</body>
</html>