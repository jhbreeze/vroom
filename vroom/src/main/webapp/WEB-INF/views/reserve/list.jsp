<%@page import="com.reserve.ReserveDTO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 템플릿</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container { min-height: 1100px; margin-left: 300px; margin-top: 40px;}

.ticketBoxBack { margin-right:0px; position:relative; width: 200px; height: 150px; border-bottom-left-radius: 2em; border-top-left-radius: 2em; background-color: #0E6EFD; }
.ticketBoxFirst {position:absolute; left:16px;  width: 400px; height: 150px; border-bottom-left-radius: 0.5em; border-top-left-radius: 0.5em; border-right-style:dotted; border-width:9px; border-right-color:white;  background-color: #F1F5FC;}
.ticketBoxSecond { width: 500px; margin-left: 300px; height: 150px; border-bottom-right-radius: 2em; border-top-right-radius: 2.5em; border-left-style:dotted; border-width:9px; border-left-color:white;  background-color: #F1F5FC; }
.ticketBoxThird { top:50px; position:absolute; width: 100px; margin-left: 870px; height: 50px;}
.ticketBoxFourth { top:40px; position:absolute; width: 100px; margin-left: 780px; height: 100px; }


.ticket1 { width: 1100px; height: 600px;}

.titleName { font-weight: bold; }

.titleDateSearch { float: left; }
.inputDateSearch { display: inline-block; margin-left: 10px; }

h6 {font-weight: bold; font-size: 19px;}
h2 { font-size: 30px;}
.searchDate2 {font-weight: bold; font-size: 19px;}


.testStation { margin-left: 20px; margin-top: 20px;}


.infoLeft { margin-left: 30px; margin-top: 15px;}
.textStaition {font-weight: bold; color: #0E6EFD; font-size: 24px; }
.textTrasnport { margin-top: -15px; color: #848484; font-size: 15px; }
.textDate { margin-top: 33px; font-size: 14px; font-weight:bold; }
.textDateBUS { margin-top: 45px; font-size: 14px; font-weight:bold; } 

.textStaitionBUS {font-weight: bold; color: #0E6EFD; font-size: 17px; }


.infoRightMemberTitle  { margin-bottom:5px; margin-left: 140px; top: 20px; width: 40px; height: 20px; display: inline-block; margin-top: 35px; color: #0E6EFD; font-weight: bold;}
.infoRightMemberInput { margin-bottom:5px; display: inline-block; margin-left: 230px; color: #0E6EFD; font-weight: bold;}
.infoRightMemberShow { margin-bottom:5px; display: inline-block; font-weight: bold; color: #6E6E6E;}

.infoRightHochaTitle {  margin-bottom:5px; display: inline-block; margin-left: 140px; color: #0E6EFD; font-weight: bold;}
.infoRightHochaGrade { margin-bottom:5px; display: inline-block; margin-left: 150px; font-weight: bold;color: #6E6E6E; }
.infoRightHochaInput { margin-bottom:5px; display: inline-block; color: #0E6EFD; font-weight: bold; }
.infoRightHochaShow { margin-bottom:5px; display: inline-block; font-weight: bold; color: #6E6E6E;}
.infoRightHochaGradeBUS { margin-bottom:5px; float:right; display: inline-block; font-weight: bold;color: #6E6E6E; }


.infoRightSeatTitle { margin-bottom:5px; display: inline-block; margin-left: 140px; color: #0E6EFD; font-weight: bold; }
.infoRightSeatShow { margin-bottom:5px; display: inline-block;  font-weight: bold; color: #6E6E6E; float: right; }

.infoRightSeatShowB { margin-bottom:5px; display: inline-block;  font-weight: bold; color: #6E6E6E; float: right; }

.infoRight22 { height: 28px; width: 445px; }
.infoRight3 { width: 445px; }



.ticketBoxFourthCircle { color: white; font-size: 40px; }


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
			<h2 class="titleName">예매내역 조회</h2>
			<br>
			<div class="searchDate">
				<div class="titleDateSearch">
					<label class="searchDate2">&nbsp;승차일자 검색 :&nbsp;</label>
				</div>
				<div class="inputDateSearch">
					<form name="dateSearchForm" action="${pageContext.request.contextPath}/reserve/list.do" method="POST">
						<input type="date" name="date" value=""></input>
						<button type="button" class="btn btn-primary" style="height: 35px; width: 100px; margin-left: 10px;" onclick="searchDate();">조회하기</button>
					</form>
				</div>
			</div>
			<br>
			<div class="ticket1" style="overflow-y: scroll;">
				<c:forEach var="dto" items="${reserveTrainList}" varStatus="status">
						<div class="ticketBoxBack">
							<div class="ticketBoxFirst">
								<div class="infoLeft">
									<p class="textStaition">${dto.tStationNameSta} →  ${dto.tStationNameEnd}</p>
									<p class="textTrasnport">KTX&nbsp;${dto.tNumId}</p>
									<p class="textDate">${dto.tBoardDate} | ${dto.tStaTime} → ${dto.countTime}</p>
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
							</div>
							<div class="ticketBoxThird">
									<button type="button" class="btn btn-primary cancel-btn"
										style="height: 50px; width: 140px;" data-tTkNum="${dto.tTkNum}">예매 취소</button>

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
									<p class="textStaitionBUS">${dto.bStationNameSta} → ${dto.bStationNameEnd}</p>
									<p class="textTrasnport">${dto.bName}&nbsp;${dto.bTotNum}</p>
									<p class="textDateBUS">${dto.bBoardDate} | ${dto.bFirstStaTime} → ${dto.bEndStaTime}</p>
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
										<p class="infoRightSeatShow">${dto.bSeatNum}</p>
									</div>
								</div>
							</div>
							<div class="ticketBoxThird">
								<button type="button" class="btn btn-primary cancel-btn2" 
									style="height: 50px; width: 140px;" data-bTkNum="${dto.bTkNum}" >예매 취소</button> 
							</div>
							<div class="ticketBoxFourth">
								<p class="ticketBoxFourthCircle">●</p>
							</div>
						</div>
						<br>
				</c:forEach>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>