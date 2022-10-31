<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 결제창</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container { min-height: 480px; }
.ticket-1, .ticket-2, .ticket-3, .ticket-4 { 
	width: 500px; box-shadow: 0px 0px 8px rgb(72, 92, 161, 0.3); min-height: 50px; 
	border-radius: 10px; margin: 0 auto; margin-top: 20px; padding: 20px 30px 20px 30px;
}
#check-title { 
	font-size: 25px; font-weight: 600; width: 500px; margin: 0 auto;
}
#ticket-info { margin: 0 auto; width: 500px; }
.date { color: #0E6EFD; }
.info1 { color: gray; }
.info2 { font-weight: 600; font-size: 20px; }
.ticket-count { float: right; }
.direction { color: #0E6EFD; }
.btn-pay { margin-top: 20px; width: 500px; height: 60px; font-size: 20px; border-radius: 8px; }
.cost { font-size: 24px; font-weight: 600; }
.won { height: 100%; line-height: 2.5; }
.left-side { color: gray; }
</style>

<script type="text/javascript">

$(function(){
	// 편도일 경우, 두 번째는 안 보이도록 함
	let cycle = $("input[name=cycle]").val();
	if(cycle==='half'){
		$(".ticket-2").hide();
		$(".ticket-4").hide();
		let grade = $("input[name=selGrade]").val();
		if(grade==='premium'){
			$("#grade-1").text('특실');
			$("#grade-3").text('특실요금 적용');
		} else {
			$("#grade-1").text('일반');
			$("#grade-3").text('일반요금 적용');
		}
	} else if(cycle==='full') {
		$(".ticket-2").show();
		$(".ticket-4").show();
		
		let staGrade = $("input[name=staGrade]").val();
		let endGrade = $("input[name=endGrade]").val();
		if(staGrade==='premium'){
			$("#grade-1").text('특실');
			$("#grade-3").text('특실요금 적용');
		} else {
			$("#grade-1").text('일반');
			$("#grade-3").text('일반요금 적용');
		}
		if(endGrade==='premium'){
			$("#grade-2").text('특실');
			$("#grade-4").text('특실요금 적용');
		} else {
			$("#grade-2").text('일반');
			$("#grade-4").text('일반요금 적용');
		}
	}
	let adult = $("input[name=adultCount]").val();
	let child = $("input[name=childCount]").val();
	
	if(adult > 0 && child === 0){
		$(".ticket-count").text('어른  '+adult+'매');
	} else if(adult===0 && child > 0) {
		$(".ticket-count").text('아이  '+child+'매');
	} else if(adult > 0 && child > 0) {
		$(".ticket-count").text('어른  '+adult+'매, '+'  아이  '+child+'매');
	}
	
});

</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
		<div id="check-title">승차권 정보 확인</div>
		<div id="ticket-info">
			<div class="ticket-1">
				<span class="date">${staDate}</span>
				<span class="ticket-count"></span>
				<div class="info1">KTX&nbsp;&nbsp; ${staTNumId}</div>
				<div class="info2">${statStaionName}&nbsp; ${deptStaDateTime} &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; ${endtStaionName}&nbsp; ${deptEndDateTime}</div>
				<div class="info3"><span id="grade-1"></span>&nbsp;&nbsp; ${staTNum}호차&nbsp;&nbsp; ${staSeats}&nbsp;<span class="direction">(${statDiscern})</span></div>
			</div>
			<div class="ticket-2">
				<span class="date">${endDate}</span>
				<span class="ticket-count"></span>
				<div class="info1">KTX&nbsp;&nbsp; ${endTNumId}</div>
				<div class="info2">${endtStaionName}&nbsp; ${destStaDateTime} &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; ${statStaionName}&nbsp; ${destEndDateTime}</div>
				<div class="info3"><span id="grade-2"></span>&nbsp;&nbsp; ${endTNum}호차&nbsp;&nbsp; ${endSeats}&nbsp;<span class="direction">(${endtDiscern})</span></div>
			</div>
			<div class="ticket-3">
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">어른&nbsp;&nbsp;${adultCount}명</div>
					<div class="left-side">${staadultCost}&nbsp;원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">아이&nbsp;&nbsp;${childCount}명</div>
					<div class="left-side">${stachildCost}&nbsp;원</div>
				</div>
				<div id="grade-3" class="left-side"></div>
				<div class="info6  d-flex justify-content-end"><span class="cost">${statotalCost}</span><span class="won">&nbsp;원</span></div>
			</div>
			<div class="ticket-4">
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">어른&nbsp;&nbsp;${adultCount}명</div>
					<div class="left-side">${endadultCost}&nbsp;원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">아이&nbsp;&nbsp;${childCount}명</div>
					<div class="left-side">${endchildCost}&nbsp;원</div>
				</div>
				<div id="grade-4" class="left-side"></div>
				<div class="info6  d-flex justify-content-end"><span class="cost">${endtotalCost}</span><span class="won">&nbsp;원</span></div>
			</div>
			<div class="d-flex justify-content-center">
				<button class="btn btn-primary btn-pay">결제하기</button>
			</div>
		</div>
	</div>
</main>


<form name="hiddenForm">
	<input type="hidden" name="tDiscern" value="${tDiscern}">
	<input type="hidden" name="statDiscern" value="${statDiscern}">
	<input type="hidden" name="endtDiscern" value="${endtDiscern}">
	<input type="hidden" name="cycle" value="${cycle}">
	<input type="hidden" name="adultCount" value="${adultCount}">
	<input type="hidden" name="childCount" value="${childCount}">
	<input type="hidden" name="staDate" value="${staDate}">
	<input type="hidden" name="endDate" value="${endDate}">
	<input type="hidden" name="tStaTime" value="${tStaTime}">
	<input type="hidden" name="tEndTime" value="${tEndTime}">
	<input type="hidden" name="deptStaDateTime" value="${deptStaDateTime}">
	<input type="hidden" name="deptEndDateTime" value="${deptEndDateTime}">
	<input type="hidden" name="destStaDateTime" value="${destStaDateTime}">
	<input type="hidden" name="destEndDateTime" value="${destEndDateTime}">
	<input type="hidden" name="tOperCode" value="${tOperCode}">
	<input type="hidden" name="deptOperCode" value="${deptOperCode}">
	<input type="hidden" name="destOperCode" value="${destOperCode}">
	<input type="hidden" name="statDetailCode" value="${statDetailCode}">
	<input type="hidden" name="endtDetailCode" value="${endtDetailCode}">
	<input type="hidden" name="depstatDetailCode" value="${depstatDetailCode}">
	<input type="hidden" name="desstatDetailCode" value="${desstatDetailCode}">
	<input type="hidden" name="dependtDetailCode" value="${dependtDetailCode}">
	<input type="hidden" name="desendtDetailCode" value="${desendtDetailCode}">
	<input type="hidden" name="selSeats" value="${selSeats}">
	<input type="hidden" name="staSeats" value="${staSeats}">
	<input type="hidden" name="endSeats" value="${endSeats}">
	
	<input type="hidden" name="selTHoNum" value="${selTHoNum}">
	<input type="hidden" name="staTHoNum" value="${staTHoNum}">
	<input type="hidden" name="endTHoNum" value="${endTHoNum}">
	
	<input type="hidden" name="selGrade" value="${selGrade}">
	<input type="hidden" name="staGrade" value="${staGrade}">
	<input type="hidden" name="endGrade" value="${endGrade}">
</form>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>