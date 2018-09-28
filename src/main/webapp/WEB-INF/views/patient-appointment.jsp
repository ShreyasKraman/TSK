<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
	<!-------------------------------------- Body ------------------------------------------->
	<div class="container">
		<div class="container-fluid m-sm-4">
			<h2 class="text-center">Your Appointments list</h2>
			<c:set var="response" value="${responseText}" />
			<c:choose>
				<c:when test="${response != null}">
					<div class="alert alert-warning" role="alert">${response}</div>
				</c:when>
				<c:when test="${appointmentList != null}">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">Sr No</th>
								<th scope="col">Date</th>
								<th scope="col">Day</th>
								<th scope="col">Time</th>
								<th scope="col">Doctor Name</th>
								<th scope="col">Clinic Address</th>
								<th scope="col">Clinic Name</th>
								<th scope="col">Status</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${appointmentList}" var="appointment">
								<tr>
									<th class="row" scope="row">${appointment.id}</th>
									<td><input class="form-control" type="date"
										value="${appointment.date}" class="date" readonly></td>
									<td><input class="form-control" type="text"
										value="${appointment.day}" class="day" readonly></td>
									<td><input class="form-control" type="text"
										value="${appointment.time}" readonly></td>
									<td><input class="form-control" type="text"
										value="${appointment.doc_name}" readonly></td>
									<td><input class="form-control" type="text"
										value="${appointment.clinic_name}" readonly></td>
									<td><input class="form-control" type="text"
										value="${appointment.clinic_address}" readonly></td>
									<c:choose>
										<c:when test="${appointment.appointment_status != null}">
											<td>${appointment.appointment_status}</td>
										</c:when>
										<c:otherwise>
											<td>Confirmed</td>
										</c:otherwise>
									</c:choose>
									
									<td><button class="btn btn-primary editBtn">Reschedule</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:when>
				<c:otherwise>
					<div class="alert alert-warning" role="alert">No appointments
						scheduled till date</div>
				</c:otherwise>
			</c:choose>
			<a class="btn btn-outline-primary"
				href="${contextPath}/user/dashboard.htm">Go to dashBoard</a>
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
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
	<script type="text/javascript">

		$('.date').change(function(){
			
			var d = new Date($(this).val());

			var weekday = new Array(7);
			weekday[0] =  "Sunday";
			weekday[1] = "Monday";
			weekday[2] = "Tuesday";
			weekday[3] = "Wednesday";
			weekday[4] = "Thursday";
			weekday[5] = "Friday";
			weekday[6] = "Saturday";
			$(this).parents('tr').find('td').find('.day').val(weekday[d.getDay() + 1]);
		});
			
	
		$('.editBtn').click(
				function() {
					var currentId = $(this).parents('tr').find('td');

					if ($(this).html() == 'Reschedule') {
						$.each(currentId,function(){
							$(this).find('input').prop('readonly',false);
						});
						$(this).html($(this).html() == 'Reschedule' ? 'Save': 'Reschedule');
						
					} else {

						var id = $(this).parents('tr').find('th').html();
						var date = currentId.find('input').val();
						
						$.each(currentId, function() {
							
							$(this).find("input").prop('readonly', true);
						});

						var date = new Date(date);
						var weekday = new Array(7);
						weekday[0] =  "Sunday";
						weekday[1] = "Monday";
						weekday[2] = "Tuesday";
						weekday[3] = "Wednesday";
						weekday[4] = "Thursday";
						weekday[5] = "Friday";
						weekday[6] = "Saturday";
						var day = weekday[date.getDay() + 1];
						
						var jsonData = "{ id:" + id + ", date:" + date + ", day:"+day+", time:null, doc_name=null, clinic_name:null,clinic_address:null,appointment_status:'on hold'}";
						alert(jsonData);
						$.ajax({
						type:"POST",
						contentType:'application/json; charset=utf-8',
						dataType:'json',
						url:"${contextPath}/user/editAppointment.htm",
						data: JSON.stringify(jsonData),
						async: false,    
					    cache: false,              
					    processData:false, 
						success:function(response) {
							alert("success",response);
						},
						error:function(status){
							
							alert(status.responseText);
							alert(status.statusCode);
							
						}
					});
						
						$(this).html($(this).html() == 'Save' ? 'Reschedule': 'Save');
				}
			});
	</script>

</body>
</html>