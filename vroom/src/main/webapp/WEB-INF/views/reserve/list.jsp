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


.ticket1 { width: 1100px; height: 500px;}

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

.infoRightMemberTitle  { margin-bottom:5px; margin-left: 140px; top: 20px; width: 40px; height: 20px; display: inline-block; margin-top: 35px; color: #0E6EFD; font-weight: bold;}
.infoRightMemberInput { margin-bottom:5px; display: inline-block; margin-left: 230px; color: #0E6EFD; font-weight: bold;}
.infoRightMemberShow { margin-bottom:5px; display: inline-block; font-weight: bold; color: #6E6E6E;}

.infoRightHochaTitle {  margin-bottom:5px; display: inline-block; margin-left: 140px; color: #0E6EFD; font-weight: bold;}
.infoRightHochaGrade { margin-bottom:5px; display: inline-block; margin-left: 185px; font-weight: bold;color: #6E6E6E; }
.infoRightHochaInput { margin-bottom:5px; display: inline-block; color: #0E6EFD; font-weight: bold; }
.infoRightHochaShow { margin-bottom:5px; display: inline-block; font-weight: bold; color: #6E6E6E;}

.infoRightSeatTitle { margin-bottom:5px; display: inline-block; margin-left: 140px; color: #0E6EFD; font-weight: bold; }
.infoRightSeatShow { margin-bottom:5px; display: inline-block;  margin-left: 238px; font-weight: bold; color: #6E6E6E; }

.ticketBoxFourthCircle { color: white; font-size: 40px; }


</style>
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
					<form action="">
						<input type="date"></input>
						<button type="button" class="btn btn-primary"
							style="height: 35px; width: 100px; margin-left: 10px;">조회하기</button>
					</form>
				</div>
			</div>
			<br>
			<div class="ticket1" style="overflow-y: scroll;">

				<div class="ticketBoxBack">
					<div class="ticketBoxFirst">
						<div class="infoLeft">
							<p class="textStaition">${dto.tDetailCodeSta} → ${dto.tDetailCodeEnd}</p>
							<p class="textTrasnport">KTX&nbsp;${dto.tHoNum }</p>
							<p class="textDate">${dto.tBoardDate} | ${dto.tStaTime} → ${dto.tEndStaTime}</p>
						</div>
					</div>
					<div class="ticketBoxSecond">
						<div class="infoRight">
							<div class="infoRight1">
								<p class="infoRightMemberTitle">인원&nbsp;</p>
								<p class="infoRightMemberInput">?</p>
								<p class="infoRightMemberShow">명</p>
							</div>
							<div class="infoRight2">
								<p class="infoRightHochaTitle">호차</p>
								<p class="infoRightHochaGrade">등급</p>
								<p class="infoRightHochaInput">?</p>
								<p class="infoRightHochaShow">호차</p>
							</div>
							<div class="infoRight3">
								<p class="infoRightSeatTitle">좌석</p>
								<p class="infoRightSeatShow">10A</p>
							</div>
						</div>
					</div>
					<div class="ticketBoxThird">
						<form action="">
							<button type="button" class="btn btn-primary"
								style="height: 50px; width: 140px;">예매 취소</button>
						</form>
					</div>
					<div class="ticketBoxFourth">
						<p class="ticketBoxFourthCircle">●</p>
					</div>
				</div>
				<br>
				
				<div class="ticketBoxBack">
					<div class="ticketBoxFirst">
						<div class="infoLeft">
							<p class="textStaition">출발지 → 도착지</p>
							<p class="textTrasnport">운송수단&nbsp;호차번호</p>
							<p class="textDate">날짜.요일 | 출발시간 → 도착시간</p>
						</div>
					</div>
					<div class="ticketBoxSecond">
						<div class="infoRight">
							<div class="infoRight1">
								<p class="infoRightMemberTitle">인원&nbsp;</p>
								<p class="infoRightMemberInput">?</p>
								<p class="infoRightMemberShow">명</p>
							</div>
							<div class="infoRight2">
								<p class="infoRightHochaTitle">호차</p>
								<p class="infoRightHochaGrade">등급</p>
								<p class="infoRightHochaInput">?</p>
								<p class="infoRightHochaShow">호차</p>
							</div>
							<div class="infoRight3">
								<p class="infoRightSeatTitle">좌석</p>
								<p class="infoRightSeatShow">10A</p>
							</div>
						</div>
					</div>
					<div class="ticketBoxThird">
						<form action="">
							<button type="button" class="btn btn-primary"
								style="height: 50px; width: 140px;">예매 취소</button>
						</form>
					</div>
					<div class="ticketBoxFourth">
						<p class="ticketBoxFourthCircle">●</p>
					</div>
				</div>
				<br>
				
				<div class="ticketBoxBack">
					<div class="ticketBoxFirst">
						<div class="infoLeft">
							<p class="textStaition">출발지 → 도착지</p>
							<p class="textTrasnport">운송수단&nbsp;호차번호</p>
							<p class="textDate">날짜.요일 | 출발시간 → 도착시간</p>
						</div>
					</div>
					<div class="ticketBoxSecond">
						<div class="infoRight">
							<div class="infoRight1">
								<p class="infoRightMemberTitle">인원&nbsp;</p>
								<p class="infoRightMemberInput">?</p>
								<p class="infoRightMemberShow">명</p>
							</div>
							<div class="infoRight2">
								<p class="infoRightHochaTitle">호차</p>
								<p class="infoRightHochaGrade">등급</p>
								<p class="infoRightHochaInput">?</p>
								<p class="infoRightHochaShow">호차</p>
							</div>
							<div class="infoRight3">
								<p class="infoRightSeatTitle">좌석</p>
								<p class="infoRightSeatShow">10A</p>
							</div>
						</div>
					</div>
					<div class="ticketBoxThird">
						<form action="">
							<button type="button" class="btn btn-primary"
								style="height: 50px; width: 140px;">예매 취소</button>
						</form>
					</div>
					<div class="ticketBoxFourth">
						<p class="ticketBoxFourthCircle">●</p>
					</div>
				</div>
				<br>
				
				<div class="ticketBoxBack">
					<div class="ticketBoxFirst">
						<div class="infoLeft">
							<p class="textStaition">출발지 → 도착지</p>
							<p class="textTrasnport">운송수단&nbsp;호차번호</p>
							<p class="textDate">날짜.요일 | 출발시간 → 도착시간</p>
						</div>
					</div>
					<div class="ticketBoxSecond">
						<div class="infoRight">
							<div class="infoRight1">
								<p class="infoRightMemberTitle">인원&nbsp;</p>
								<p class="infoRightMemberInput">?</p>
								<p class="infoRightMemberShow">명</p>
							</div>
							<div class="infoRight2">
								<p class="infoRightHochaTitle">호차</p>
								<p class="infoRightHochaGrade">등급</p>
								<p class="infoRightHochaInput">?</p>
								<p class="infoRightHochaShow">호차</p>
							</div>
							<div class="infoRight3">
								<p class="infoRightSeatTitle">좌석</p>
								<p class="infoRightSeatShow">10A</p>
							</div>
						</div>
					</div>
					<div class="ticketBoxThird">
						<form action="">
							<button type="button" class="btn btn-primary"
								style="height: 50px; width: 140px;">예매 취소</button>
						</form>
					</div>
					<div class="ticketBoxFourth">
						<p class="ticketBoxFourthCircle">●</p>
					</div>
				</div>
				<br>
				
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>