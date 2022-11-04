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
	let cycle = $("input[name=bcycle]").val();
	if(cycle==='half'){
		$(".ticket-2").hide();
		$(".ticket-4").hide();
	} else if(cycle==='full') {
		$(".ticket-2").show();
		$(".ticket-4").show();
	}
});

$(function(){
	$("#next-btn").click(function(){
		let url = "${pageContext.request.contextPath}/busreserve/buspassengerinfo.do?";
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
		<div id="check-title">승차권 정보 확인</div>
		<div id="ticket-info">
			<div class="ticket-1">
				<span class="date">${busstaDate}</span>
				<span class="ticket-count"></span>
				<div class="info1">${bName}&nbsp;&nbsp;</div>
				<div class="info2">출발지 : ${depbStationName}&nbsp;${bFirstStaTime} &nbsp;<br>도착지 : ${desbStationName}&nbsp; ${bEndStaTime}</div>
				<div class="info3"><span id="grade-1"></span>${bType}&nbsp;&nbsp; 
				<c:forEach items="${reSeatArr}" varStatus="status">
				${status.current}번, 
				</c:forEach>
				&nbsp;<span class="direction"></span></div>
			</div>
			<div class="ticket-3">
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">일반&nbsp;&nbsp;${bNor}명</div>
					<div class="left-side">${bNorFee}원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">중고등&nbsp;&nbsp;${bOld}명</div>
					<div class="left-side">${bOldFee}원</div>
				</div>
				<div class="info5 d-flex justify-content-between">
					<div class="left-side">초등&nbsp;&nbsp;${bEle}명</div>
					<div class="left-side">${bEleFee}원</div>
				</div> 
				<div id="grade-3" class="left-side"></div>
				<div class="left-side">총금액</div>
				<div class="info6  d-flex justify-content-end"><span class="cost">${totFee}원</span></div>
			</div>
			
			<div class="d-flex justify-content-center">
				<button class="btn btn-primary btn-pay" id="next-btn">다음단계</button>
			</div>
		</div>
	</div>
</main>

<form name="hiddenForm" method="post">
<!-- "&bNumId="+bNumId+"&bOperCode="+bOperCode+"&busBoardDate="+busBoardDate;
    	out += "&reSeatArr="+reSeatArr; -->
	<!-- 
	bcycle(편도,왕복인데 편도만 완성해서 bcycle필요없어요)
	bDisCern(상행,하행 버스에서는 없어서 안넣었어요), 
	bNumId 빠진거 같아요 ㅇㅈ ? 확신은 없음... 확신하셔도됩니다
	 bNumId,bOperCode,busBoardDateyyyy-MM-dd 추가완료 -->
	<input type="hidden" name="bcycle" value="${bcycle}">
	<!-- 밑에 5개 추가함 -->
	<input type="hidden" name="bNumId" value="${bNumId}">
	<input type="hidden" name="bOperCode" value="${bOperCode}">
	<input type="hidden" name="busBoardDate" value="${busBoardDate}">
	<input type="hidden" name="seatTotNum" value="${seatTotNum}">
	<input type="hidden" name="reSeatArr" value="${reSeatArr}">
	
	<input type="hidden" name="bNor" value="${bNor}">
	<input type="hidden" name="bOld" value="${bOld}">
	<input type="hidden" name="bEle" value="${bEle}">
	
	<input type="hidden" name="busstaDate" value="${busstaDate}">
	<input type="hidden" name="busendDate" value="${busendDate}">
	
	<input type="hidden" name="bFirstStaTime" value="${bFirstStaTime}">
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	<input type="hidden" name="bFirstStaTime" value="${bFirstStaTime}">
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	
	<input type="hidden" name="bSeatNum" value="${bSeatNum}">
	<input type="hidden" name="bSeatNum" value="${bSeatNum}">
	
	<input type="hidden" name="bName" value="${bName}">
	<input type="hidden" name="bType" value="${bType}">
	
	<input type="hidden" name="bNorFee" value="${bNorFee}">
	<input type="hidden" name="bOldFee" value="${bOldFee}">
	<input type="hidden" name="bEleFee" value="${bEleFee}">
	<input type="hidden" name="bNorFee" value="${bNorFee}">
	<input type="hidden" name="bOldFee" value="${bOldFee}">
	<input type="hidden" name="bEleFee" value="${bEleFee}">
	
	<input type="hidden" name="totFee" value="${totFee}">
	
	<input type="hidden" name="bRouteCode" value="${bRouteCode}">
	<input type="hidden" name="bRouteCode" value="${bRouteCode}">
	
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
</form>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>