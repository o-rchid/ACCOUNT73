<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<%
	if (application.getAttribute("Counter") != null) {
		String strCounter = String.valueOf(application.getAttribute("Counter"));
		int counter = Integer.parseInt(strCounter) + 1;
		application.setAttribute("Counter", counter);
	} else {
		application.setAttribute("Counter", 1);
	}
%>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>메인</title>
	<style>
		.bg {
			background-image:
					url("${pageContext.request.contextPath}/assets/img/desk.jpg");
			background-size: cover;
		}

		.text-rainbow {
			background-image: linear-gradient(45deg, lightcyan, powderblue, royalblue);
			-webkit-background-clip: text;
			color: transparent;
			font-weight: bold;
			font-size: large;
		}

		.rowMar {
			margin-top: 50px;
		}

		.text {
			background-image: linear-gradient(dodgerblue, 30%, lavender);
			-webkit-background-clip: text;
			color: transparent;
			font-weight: bold;
			font-size: x-large;
		}

		.text2 {
			background-image: linear-gradient(blue, 50%, pink);
			-webkit-background-clip: text;
			color: transparent;
			font-weight: bold;
			font-size: large;
		}
	</style>
	<script>
		const lat = 35.2120;
		const lon = 128.1610;
		const API_KEY = "f9e6915c53fa1640c06498c947545acb";
		const apiURI = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat
				+ "&lon=" + lon + "&appid=" + API_KEY + "&units=metric";

		const data = function() {
			$.ajax({
				url : apiURI,
				dataType : "json",
				type : "GET",
				async : "false",

				success : function(resp) {
					console.log(resp);
					console.log(new Date());
					console.log("현재 위치 : " + resp.name);
					console.log("현재 날씨 : " + resp.weather[0].main);
					console.log("현재 온도 : " + resp.main.temp + "°C"); //add

					const now = new Date();
					const year = now.getFullYear();
					const month = now.getMonth() + 1;
					const day = now.getDate();
					const hours = now.toLocaleString('en-US', {
						hour : 'numeric',
						minute : 'numeric',
						hour12 : true
					});
					const icon = (resp.weather[0].icon);
					var imgURL = 'http://openweathermap.org/img/wn/' + icon
							+ '@2x.png'
					$("#icon").attr('src', imgURL);
					$("#date").html(
							year + "년" + month + "월" + day + "일" + "<small>"
							+ hours + "</small>");

					$("#result").html(

							'<div class="text2">' + "Location :" + "<strong>"
							+ resp.name + "</strong>" + "<br/>"
							+ "Weather :" + "<strong>"
							+ resp.weather[0].main + "</strong>" + "<br/>"
							+ "Temp :" + "<strong>"
							+ Math.floor(resp.main.temp) + "°C"
							+ "</strong>" + '<div/>');

				}
			})
		}
		data();
		setInterval(function() {
			data();
		}, 60000); //1분 단위로 ajax 갱신
	</script>
</head>
<body class="bg-gradient-primary">
<div class="container ">

	<!-- Outer Row -->
	<div class="row justify-content-center rowMar">


		<div class="col-lg-12 col-md-9">

			<div class="card o-hidden border-0 shadow-lg my-5">

				<div class="card-body p-0">

					<!-- Nested Row within Card Body -->
					<div class="row">
						<div class="col-lg-6 d-none d-lg-block bg"></div>
						<div class="col-lg-6">


							<!-- Card Header -->
							<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between"
									style="margin-left: -12px;">
								<h6 class="text2">72th ACOUNTING PORTAL</h6>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="text">
									<strong>현재 날씨</strong>
									<img src="" id="icon" style="width:55px; height:55px;" ></img> <br/>
									<span class="text2" id="date"></span>
								</div>
								<div id="result"></div>
								<hr>
								<div>
									<span class="text-rainbow">오시는 길</span>
								</div>
								<iframe
										src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3261.87432179727!2d128.10405001509625!3d35.159754980319164!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x356efb6cd0196e31%3A0x5aa98d85d3eaaea8!2z7ISc7Jq4SVTqtZDsnKHshLzthLDtlZnsm5A!5e0!3m2!1sko!2skr!4v1652246318792!5m2!1sko!2skr"
										width="360" height="200" style="border: 0;"> </iframe>
								<div>
										<span class="text-rainbow">현재 페이지에 <span
												class="text-rainbow"><%=application.getAttribute("Counter")%></span>번째
											접속하셨습니다.
										</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
		<div style="float: center; width: 100%; padding: 10px;"></div>

		<div id="openGrid" class="ag-theme-balham"
			 style="height: 150px; width: auto;"></div>
	</div>
</div>
</body>

</html>

