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
				<li class="nav-item active"><a class="nav-link" href="#">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#how-it-works">How
						it Works</a></li>
				<li class="nav-item"><a class="nav-link" href="#about-us">About
						Us</a></li>
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
	<!-------------------------------------- Body ------------------------------------------------->
	<div class="container-fluid  mt-sm-5 mb-sm-5">
		<div class="container">
			<div class="card p-sm-4">
				<div id="carouselExampleIndicators" class="carousel slide"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0"
							class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<c:url var="worldtb" value="/resources/images/World-TB.jpg" />
						<div class="carousel-item active">
							<img class="d-block w-100" src="${worldtb}" alt="First slide"
								style="width: 800px; height: 500px;">
						</div>
						<c:url var="tbgoals" value="/resources/images/TB-Goals.jpg" />
						<div class="carousel-item">
							<img class="d-block w-100" src="${tbgoals}" alt="Second slide"
								style="width: 800px; height: 500px;">
						</div>
						<c:url var="tbcurable" value="/resources/images/TB-Curable.png" />
						<div class="carousel-item">
							<img class="d-block w-100" src="${tbcurable}" alt="Third slide"
								style="width: 800px; height: 500px;">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
		<div class="container m-sm-5" id="how-it-works">
			<div class="card p-sm-5">
				<h2 class="text-center mb-sm-5">How it Works</h2>
				<div class="row">
					<div class="col-sm-3">
						<div class="card">
							<div class="card-body">
								<i class="fas fa-user-circle fa-4x"></i>
								<p class="card-text">Register & upload Report</p>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="card">
							<div class="card-body">
								<i class="fas fa-calendar-check fa-4x"></i>
								<p class="card-text">Schedule appointments</p>
							</div>
						</div>

					</div>
					<div class="col-sm-3">
						<div class="card">
							<div class="card-body">
								<i class="fas fa-mobile-alt fa-4x"></i>
								<p class="card-text">Receive reminders</p>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="card">
							<div class="card-body">
								<i class="fas fa-heart fa-4x"></i>
								<p class="card-text">Get Rid of TB</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container" id="about-us">
			<div class="card p-sm-5">
				<h2 class="text-center m-sm-3">About Us</h2>

				<p class="text-justify m-sm-3 lead">
					In the annual TB INDIA 2017 report published by Government of
					India, Director of General Health Services <b>Dr. B.D. Athani</b>
					quoted that
				</p>
				<blockquote class="blockquote m-sm-3"
					cite="https://tbcindia.gov.in/WriteReadData/TB%20India%202017.pdf">
					<p class="mb-0">
						Though Tuberculosis(TB) is completly curable, its late diagnosis,
						non-adherance or non-completion of treatment, co-morbidities are
						some of the major challenges in fighting Tuberculosis mortality.
						Currently TB incidence is declining by about 1-2% per year and to
						achieve the TB elimination goal by <b>2025</b>, we need to have a
						decline in TB incidence by about 15-20% annually.
					</p>
				</blockquote>

				<p class="text-justify m-sm-3 lead">With the help of this
					system, we are trying to join hands with Government of India to get
					rid of these challenges. We are a group of motivated college
					graduate individuals who aim to bring difference in the healthcare
					industry. With this aim we have built this comprehensive system.</p>
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
