<%@page import="com.reserve.ReserveDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<style type="text/css">
.container {
	min-height: 700px;
}

main {
	position: relative;
	top: -55px;
	background: white;
}

.body-container {
	max-width: 1050px;
	margin: auto;
	height: 400px;
}

.ticket1 {
	height: 500px;
}

.ticketBoxBack {
	margin-right: 0px;
	position: relative;
	width: 200px;
	height: 150px;
	border-bottom-left-radius: 2em;
	border-top-left-radius: 2em;
	background-color: #0E6EFD;
}

.ticketBoxFirst {
	position: absolute;
	left: 16px;
	width: 400px;
	height: 150px;
	border-bottom-left-radius: 0.5em;
	border-top-left-radius: 0.5em;
	border-right-style: dotted;
	border-width: 9px;
	border-right-color: white;
	background-color: #F1F5FC;
}

.ticketBoxSecond {
	width: 500px;
	margin-left: 300px;
	height: 150px;
	border-bottom-right-radius: 2em;
	border-top-right-radius: 2.5em;
	border-left-style: dotted;
	border-width: 9px;
	border-left-color: white;
	background-color: #F1F5FC;
}

.ticketBoxThird {
	top: 50px;
	position: absolute;
	width: 100px;
	margin-left: 550px;
	height: 50px;
}

.ticketBoxFourth {
	top: 40px;
	position: absolute;
	width: 100px;
	margin-left: 780px;
	height: 100px;
}

.titleName {
	font-weight: bold;
	width: 300px;
}

.titleDateSearch {
	float: left;
}

.inputDateSearch {
	display: inline-block;
	margin-left: 10px;
}

h6 {
	font-weight: bold;
	font-size: 19px;
}

h2 {
	font-size: 34px;
	font-weight: bold;
}

.searchDate2 {
	font-weight: bold;
	font-size: 19px;
}

.testStation {
	margin-left: 20px;
	margin-top: 20px;
}

.infoLeft {
	margin-left: 30px;
	margin-top: 15px;
	height: 120px;
}

.textStaition {
	font-weight: bold;
	color: #0E6EFD;
	font-size: 24px;
}

.textTrasnport {
	margin-top: -15px;
	color: #848484;
	font-size: 15px;
}

.textDate {
	margin-top: 33px;
	font-size: 14px;
	font-weight: bold;
}

.textDateBUS {
	font-size: 14px;
	font-weight: bold;
	margin: 0px;
	position: relative;
	top: 15px;
}

.textStaitionBUS {
	font-weight: bold;
	color: #0E6EFD;
	font-size: 17px;
	text-align: left;
	width: 330px;
}

.infoRightMemberTitle {
	margin-bottom: 5px;
	margin-left: 140px;
	top: 20px;
	width: 40px;
	height: 20px;
	display: inline-block;
	margin-top: 35px;
	color: #0E6EFD;
	font-weight: bold;
}

.infoRightMemberInput {
	margin-bottom: 5px;
	display: inline-block;
	margin-left: 230px;
	color: #0E6EFD;
	font-weight: bold;
}

.infoRightMemberShow {
	margin-bottom: 5px;
	display: inline-block;
	font-weight: bold;
	color: #6E6E6E;
}

.infoRightHochaTitle {
	margin-bottom: 5px;
	display: inline-block;
	margin-left: 140px;
	color: #0E6EFD;
	font-weight: bold;
}

.infoRightHochaGrade {
	margin-bottom: 5px;
	display: inline-block;
	margin-left: 150px;
	font-weight: bold;
	color: #6E6E6E;
}

.infoRightHochaInput {
	margin-bottom: 5px;
	display: inline-block;
	color: #0E6EFD;
	font-weight: bold;
}

.infoRightHochaShow {
	margin-bottom: 5px;
	display: inline-block;
	font-weight: bold;
	color: #6E6E6E;
}

.infoRightHochaGradeBUS {
	margin-bottom: 5px;
	float: right;
	display: inline-block;
	font-weight: bold;
	color: #6E6E6E;
}

.infoRightSeatTitle {
	margin-bottom: 5px;
	display: inline-block;
	margin-left: 140px;
	color: #0E6EFD;
	font-weight: bold;
}

.infoRightSeatShow {
	margin-bottom: 5px;
	display: inline-block;
	font-weight: bold;
	color: #6E6E6E;
	float: right;
}

.infoRightSeatShowBus {
	margin: 0px;
	text-align: right;
	float: right;
	font-weight: bold;
	color: #6E6E6E;
}

.infoRight3 {
	width: 445px;
	margin: 0px;
}

.infoRight22 {
	width: 445px;
}

.infoRightSeatTitle-1 {
	display: inline-block;
	float: right;
}

.ticketBoxFourthCircle {
	color: white;
	font-size: 40px;
}

.ticketBoxThirdB {
	top: 50px;
	position: absolute;
	width: 100px;
	margin-left: 860px;
	height: 50px;
}
</style>
<script type="text/javascript">

$(function() {
	console.log(${reserveBusList2})
})

$(function(){
	console.log(${reserveTrainList2})
})


$(function() {
	$(".cancel-btn").click(function() {
		if(! confirm("해당 예매내역을 취소하시겠습니까?")) {
			return false;
		}
		
		let tTkNum = $(this).attr("data-tTkNum");
	 	
		let url = "${pageContext.request.contextPath}/reserve/traincancel.do";
		let query = "tTkNum="+tTkNum ;
		
		$.ajax({
			type : "POST",
			url : url,
			data : query,
			dataType : "json",
			success : function(data) {
				alert("예매 취소가 완료되었습니다.");
			},
			beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error : function(jqXHR) {
				if (jqXHR.status === 403) {
					login();
					return false;
				} else if (jqXHR.status === 400) {
					alert("요청 처리가 실패했습니다.");
					return false;
				}

				console.log(jqXHR.responseText);
			}
		})
	
	});
	
	$(".cancel-btn2").click(function() {
		if(! confirm("해당 예매내역을 취소하시겠습니까?")) {
			return false;
		}
		
	 	let bTkNum = $(this).attr("data-bTkNum");
	 	
		let url = "${pageContext.request.contextPath}/reserve/buscancel.do";
		let query = "bTkNum="+bTkNum ;
		
		$.ajax({
			type : "POST",
			url : url,
			data : query,
			dataType : "json",
			success : function(data) {
				alert("예매 취소가 완료되었습니다.");
			},
			beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error : function(jqXHR) {
				if (jqXHR.status === 403) {
					login();
					return false;
				} else if (jqXHR.status === 400) {
					alert("요청 처리가 실패했습니다.");
					return false;
				}

				console.log(jqXHR.responseText);
			}
		})
		
	});
	
});

</script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>
	<main>
		<div class="container body-container">
			<div class="fs-4 fw-bolder">예매내역 조회</div>
			<br>
			<div class="ticket1" style="overflow-y: scroll;">
				<c:forEach var="dto" items="${reserveTrainList}" varStatus="status">
					<div class="ticketBoxBack">
						<div class="ticketBoxFirst">
							<div class="infoLeft">
								<p class="textStaition">${dto.tStationNameSta}→
									${dto.tStationNameEnd}</p>
								<p class="textTrasnport">KTX&nbsp;${dto.tNumId}</p>
								<p class="textDate">${dto.tBoardDate}| ${dto.tStaTime} →
									${dto.countTime}</p>
							</div>
						</div>
						<div class="ticketBoxSecond">
							<div class="infoRight">
								<div class="infoRight1">
									<p class="infoRightMemberTitle">인원&nbsp;</p>
									<p class="infoRightMemberInput">${dto.tTotNum}</p>
									<p class="infoRightMemberShow">명</p>
								</div>
								<div class="infoRight2">
									<p class="infoRightHochaTitle">호차</p>
									<p class="infoRightHochaGrade">${dto.tSeat}</p>
									<p class="infoRightHochaInput">${dto.tHoNum }</p>
									<p class="infoRightHochaShow">호차</p>
								</div>
								<div class="infoRight3">
									<p class="infoRightSeatTitle">좌석</p>
									<p class="infoRightSeatShow">${dto.tSeatNum}</p>
								</div>
							</div>
							<div class="ticketBoxThird">
								<button type="button" class="btn btn-primary cancel-btn"
									style="height: 50px; width: 140px;" data-tTkNum="${dto.tTkNum}">예매
									취소</button>

							</div>
						</div>

						<div class="ticketBoxFourth">
							<p class="ticketBoxFourthCircle">●</p>
						</div>
					</div>
					<br>
				</c:forEach>

				<c:forEach var="dto" items="${reserveBusList}" varStatus="status">
					<div class="ticketBoxBack">
						<div class="ticketBoxFirst">
							<div class="infoLeft">
								<p class="textStaitionBUS">${dto.bStationNameSta}→
									${dto.bStationNameEnd}</p>
								<p class="textTrasnport">${dto.bName}&nbsp;${dto.bTotNum}</p>
								<p class="textDateBUS">${dto.bBoardDate}|
									${dto.bFirstStaTime} → ${dto.bEndStaTime}</p>
							</div>
						</div>
						<div class="ticketBoxSecond">
							<div class="infoRight">
								<div class="infoRight1">
									<p class="infoRightMemberTitle">인원&nbsp;</p>
									<p class="infoRightMemberInput">${dto.bTotNum}</p>
									<p class="infoRightMemberShow">명</p>
								</div>
								<div class="infoRight22">
									<p class="infoRightHochaTitle">구분</p>
									<p class="infoRightHochaGradeBUS">${dto.bType}</p>
								</div>
								<div class="infoRight3">
									<p class="infoRightSeatTitle">좌석</p>
									<p class="infoRightSeatShowBus">${dto.bSeatNum}</p>
								</div>
							</div>
							<div class="ticketBoxThird">
								<button type="button" class="btn btn-primary cancel-btn2"
									data-bTkNum="${dto.bTkNum}" style="height: 50px; width: 140px;">예매
									취소</button>
							</div>
						</div>
						<div class="ticketBoxFourth">
							<p class="ticketBoxFourthCircle">●</p>
						</div>
					</div>
					<br>
				</c:forEach>

				<c:if test="${not empty  message}">
					<div class="row justify-content-md-center mt-5">
						<div class="col-md-8">
							<div class="border bg-light mt-5 p-4">
								<div class="d-grid p-3">
									<p class="text-center">${message}</p>
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>