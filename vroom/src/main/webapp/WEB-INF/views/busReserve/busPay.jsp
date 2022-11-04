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
	position: relative; top: -35px; background: white;
}
.container { min-height: 600px; }
.ticket-1, .ticket-2, .ticket-3, .ticket-4 { 
	width: 500px; box-shadow: 0px 0px 8px rgb(72, 92, 161, 0.3); min-height: 50px; 
	border-radius: 10px; margin: 0 auto; margin-top: 20px; padding: 20px 30px 20px 30px;
}
#check-title { 
	font-size: 25px; font-weight: 700; width: 500px; margin: 0 auto;
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
	let cycle = $("input[name=bcycle]").val();
	if(cycle==='half'){
		$(".ticket-2").hide();
		$(".ticket-4").hide();
		/* 버스는 총 요금 넘어오니까 필요없음? 
		let grade = $("input[name=staGrade]").val();
		if(grade==='premium'){
			$("#grade-1").text('특실');
			$("#grade-3").text('특실요금 적용');
		} else {
			$("#grade-1").text('일반');
			$("#grade-3").text('일반요금 적용');
		}
		*/
		
	} else if(cycle==='full') {
		$(".ticket-2").show();
		$(".ticket-4").show();
		/*
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
		*/
	}
/*	let adult = $("input[name=adultCount]").val();
	let child = $("input[name=childCount]").val();
	
	if(adult > 0 && child === 0){
		$(".ticket-count").text('어른  '+adult+'매');
	} else if(adult===0 && child > 0) {
		$(".ticket-count").text('아이  '+child+'매');
	} else if(adult > 0 && child > 0) {
		$(".ticket-count").text('어른  '+adult+'매, '+'  아이  '+child+'매');
	} */
	
});

$(function(){
	$("#next-btn").click(function(){
		let url = "${pageContext.request.contextPath}/busReserve/beforePayment.do?";
		let query = $("form[name=hiddenForm]").serialize();
		alert(query);
		
		location.href= url + query;
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
		<div id="check-title">🚌승차권 정보 확인</div>
		<div id="ticket-info">
			<div class="ticket-1">
				<span class="date">${busstaDate}</span>
				<span class="ticket-count"></span>
				<div class="info1">${bName}&nbsp;&nbsp; ${bNumId}</div>
				<div class="info2">${depbStationName}&nbsp; ${bFirstStaTime 출발시간} &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; ${desbStationName}&nbsp; ${bEndStaTime}</div>
				<div class="info3"><span id="grade-1"></span>&nbsp;&nbsp; ${bType}&nbsp;&nbsp; ${seatNum}&nbsp;<span class="direction">(${bDiscern})</span></div>
			</div>
			<div class="ticket-2">
				<span class="date">${busendDate}</span>
				<span class="ticket-count"></span>
				<div class="info1">${bName}&nbsp;&nbsp; ${bNumId}</div>
				<div class="info2">${depbStationName}&nbsp; ${bFirstStaTime 출발시간} &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; ${desbStationName}&nbsp; ${bEndStaTime}</div>
				<div class="info3"><span id="grade-2"></span>&nbsp;&nbsp; ${bType}&nbsp;&nbsp; ${seatNum}&nbsp;<span class="direction">(${bDiscern})</span></div>
			</div>
			<div class="ticket-3">
				<!--  <div class="info5 d-flex justify-content-between">
					<div class="left-side">일반&nbsp;&nbsp;${#}명</div>
					<div class="left-side">${bFee}&nbsp;원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">중고등&nbsp;&nbsp;${#}명</div>
					<div class="left-side">${중고등}&nbsp;원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">초등&nbsp;&nbsp;${#}명</div>
					<div class="left-side">${초등}&nbsp;원</div>
				</div> -->
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">총 결제금액&nbsp;&nbsp;</div>
					<div class="left-side">${bFee}&nbsp;원</div>
				</div>
				<div id="grade-3" class="left-side"></div>
				<div class="info6  d-flex justify-content-end"><span class="cost">${bFee}</span><span class="won">&nbsp;원</span></div>
			</div>
			<div class="ticket-4">
				<!--  <div class="info5 d-flex justify-content-between">
					<div class="left-side">일반&nbsp;&nbsp;${#}명</div>
					<div class="left-side">${bFee}&nbsp;원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">중고등&nbsp;&nbsp;${#}명</div>
					<div class="left-side">${중고등}&nbsp;원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">초등&nbsp;&nbsp;${#}명</div>
					<div class="left-side">${초등}&nbsp;원</div>
				</div> -->
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">총 결제금액&nbsp;&nbsp;</div>
					<div class="left-side">${bFee}&nbsp;원</div>
				</div>
				<div id="grade-4" class="left-side"></div>
				<div class="info6  d-flex justify-content-end"><span class="cost">${bFee}</span><span class="won">&nbsp;원</span></div>
			</div>
			<div class="d-flex justify-content-center">
				<button class="btn btn-primary btn-pay" id="next-btn">다음단계</button>
			</div>
		</div>
	</div>
</main>

<form name="hiddenForm" method="post">
 <!-- 뭐 빼고 뭐 넣어야할지 재확인 필요!  -->	
	<input type="hidden" name="bDiscern" value="${bDiscern}">
	
	<input type="hidden" name="bcycle" value="${bcycle}">
	
	<input type="hidden" name="bFee" value="${bFee}">
	
	<input type="hidden" name="busstaDate" value="${busstaDate}">
	<input type="hidden" name="busendDate" value="${busendDate}">
	
	<input type="hidden" name="bFirstStaTime" value="${bFirstStaTime}">
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	
	<!-- 버스 운행코드? 뭐 넘겨야 할지 모르겟음 -->
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	 
	<input type="hidden" name="seatNum" value="${seatNum}">
	
	<input type="hidden" name="bType" value="${bType}">
	<input type="hidden" name="bNumId" value="${bNumId}">
	<input type="hidden" name="bName" value="${bName}">
	
	
</form>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>