<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 템플릿</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<style type="text/css">
main {
	position: relative;
	top: -55px;
	background: white;
}

.container {
	padding: 30px;
}

.fblock1 {
	min-width: 300px;
	min-height: 700px;
	background-color: #0d6efd;
}

.fblock1_1 {
	display: flex;
	justify-content: flex-start;
	align-items: baseline;
	min-height: 60px;
	padding: 10px 0px;
}

.fblock1_2 {
	display: flex;
	justify-content: space-between;
	min-height: 60px;
}

.fblock1_3 {
	display: flex;
	justify-content: flex-end;
	min-height: 60px;
}

.fblock1_icon {
	display: flex;
	width: 50px;
	height: 50px;
	border-radius: 25px;
	justify-content: center;
	align-items: center;
}

#calendarLayout {
	font-size: 25px;
	font-weight: bolder;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	min-height: 50px;
	z-index: 1000;
}

#calendarLayout:hover {
	border-color: #0d6efd;
}

#buslistgroup {
	height: 700px;
}

.buslist_title {
	min-height: 30px;
	min-width: 110px;
	padding: 0px 3px;
}

#list-group {
	width:900px;
	height: 600px;
	overflow-y: auto;
	overflow-x: hidden;
}

/* 아래의 모든 코드는 영역::코드로 사용 */
#list-group::-webkit-scrollbar {
	width: 23px; /* 스크롤바의 너비 */
}

#list-group::-webkit-scrollbar-thumb {
	height: 30%; /* 스크롤바의 길이 */
	background: #0d6efd; /* 스크롤바의 색상 */
	border-radius: 10px;
}

#list-group::-webkit-scrollbar-track {
	border-radius: 10px;
	background:  #0d6efd; /*스크롤바 뒷 배경 색상*/
}

.row {
	margin-left: 0px;
	margin-right: 0px;
}

.buslist {
	min-height: 30px;
	min-width: 100px;
}

#buslist {
	display: flex;
	width: 860px;
	justify-content: space-between;
	align-items: center;
	min-height: 60px;
}

#buslist:hover {
	border-color:  #0d6efd;
}

.fblock2 {
	margin-left: 10px;
	width: 900px;
	height: 720px;
	padding: 20px;
	background:white;
	border-radius: 30px;
	box-shadow: 4px 4px 4px rgb(0 0 0/ 12%);
}

#fblock2_title {
	padding: 10px 16px;
	width: 860px;
	position: relative;
	z-index: 1;
}

#fblock2_title:before {
	content: "";
	position: absolute;
	left: 0;
	bottom: 0;
	height: 1px;
	width: 100%; /* or 100px */
	border-top: 1px solid gray;
}


button {
	background-color:  #0d6efd;
	border-radius: 10%;
	border-color:  #0d6efd;
	color: white;
	opacity: .4;
	line-height: 20px;
}

div.subject {
	caret-color: transparent;
}

.subject span {
	cursor: pointer;
}
///////////////////////////////////
////////////////////////////////////////
#refresh {
	width: 101px;
	height: 42px;
	position: relative;
	border-radius: 8px;
	font-weight: Bold;
	font-size: 16px;
}
#seatCount{
	width:250px;
	height: 35px;
	position:relative;
	right:40px;
	font-weight:  Bold;
	font-size: 20px;
	text-align: center;
}
#fblock2-1{
	display:flex;
	flex-direction:column;
	min-width: 108px;
	min-height:519px;
	color: rgba(163, 166, 173, 1);
	font-weight: Semi Bold;
	font-size: 15px;
	text-align: center;
	margin: 50px;
	justify-content: space-around;
	align-content: space-around; 
}
#fblock2-1-1, #fblock2-1-3, #fblock2-1-5{
	width:60px;
	height: 100px;
	font-weight: Bold;
	align-items: space-around;
	justify-content: space-around;
}
#fblock2-1-1-1, #fblock2-1-3-1, #fblock2-1-5-1,{
	width:60px;
	height: 40px;
	font-weight: Bold;

}
#fblock2-1-1-3, #fblock2-1-3-3, #fblock2-1-5-3{
	width:40px;
	height: 40px;
	font-weight: Bold;
	align-content:flex-end;
	text-align: center;
	position:relative;
	left:7px;
	display:flex;
    align-items: center;
    justify-content: center;
}
#fblock2-1-2, #fblock2-1-4, #fblock2-1-6{
	width:60px;
	height: 100px;
	align-items: space-around;
	justify-content: space-around;
}
#fblock2-1-1-2{
	width:40px;
	height: 40px;
	font-weight: Bold;
	text-align: center;
}
#fblock2-1-1-4{
	width:40px;
	height: 40px;
	font-weight: Bold;
	text-align: center;
}
#fblock2-2{
	min-width: 262px;
    min-height: 614px;
    background: gray;
    border-radius: 30px;
    padding: 20px;
    opacity: 0.4;
}
#fblock2-2-1{
display: flex;
justify-content: center;
align-content: space-around;
margin: 5px;
}

#driveSeat{
	display:flex;
	justify-content:center;
	align-items:center;
	position:relative;
	right:7px;
	width: 95px;
	height: 57px;
	background-color:black;
	border-radius:10px;
	opacity: 0.7;
	color: white;
	font-size: 18px;
}
#enter{
	display:flex; 
	justify-content:center;
	align-items:center;
	position:relative;
	left:10px;
	width: 102px;
	height: 57px;
	color: white;
	font-size: 18px;
}
#seats{
	color:white;
	min-width: 220px;
    min-height: 470px;
    
}
.seatBtn{
	color:white;
	background-color: white;
	margin:5px;
	width: 40px;
	height: 40px;
	font-weight: bold;
}

#fblock2-3{
	width: 222px;
    height: 614px;
    margin: 20px;
    display: flex;
    flex-direction: column;
}
#fblock2-3-1{
	display: flex;
	flex-direction: column;
}
#fblock2-3-1-title{
	font-size: 16px;
	font-weight: bold;
	margin: 15px 15px 15px 0px;
}
#fblock2-3-1-1{
	font-size:24px;
	margin: 15px 15px 15px 0px;
}
#fblock2-line{
	background-color:gray;
	opacity:0.5;
}
#fblock2-3-2-title{
	font-size: 16px;
	font-weight: bold;
	margin: 15px 15px 15px 0px;
}
#fblock2-3-2-1, #fblock2-3-2-2, #fblock2-3-2-3{
	display:flex;
    justify-content: space-between;
	height:30px;
	font-size: 16px;
	font-weight: bold;
}
#fblock2-3-2-1-1,#fblock2-3-2-2-1, #fblock2-3-2-3-1{
color:  #0d6efd;
}
#fblock2-3-2-1-2,#fblock2-3-2-2-2, #fblock2-3-2-3-2{
color: gray;
}
#fblock2-3-3{
display: flex;
flex-direction: column;
}
#fblock2-3-3-title{
color: gray;
font-size:22px;
}
#fblock2-3-3-1{
font-size:35px;
font-weight:bold;
color:  #0d6efd;
}
.btnsize{
	display: flex;
    align-content: center;
    justify-content: center;
    align-items: center;
	width:40px;
	height: 40px;
	font-weight: Bold;
	font-size: 25px;
	text-align: center;
}

</style>
<script type="text/javascript">
	let bFee= "${bFee}";
	let seatNum = "${seatNum}";
	let seatTotNum=0;
	let seatNor=0;
	let seatNorPrice=0;
	let seatEle=0;
	let seatElePrice=0;
	let seatOld=0;
	let seatOldPrice=0;
	let SeatTotCount=0;
	let seatTotPrice;
	let bgrade = "${bType}";
	
	$("#fblock2-3-3-1").text(seatTotNum);
	
function fseatTotCount(seatNor,seatEle,seatOld){
		seatTotCount=seatNor+ seatEle+ seatOld;
		return seatTotCount;
}
function fseatTotPrice(seatNorPrice,seatElePrice, seatOldPrice){
	seatTotPrice= seatNorPrice+ seatElePrice+seatOldPrice;
	return seatTotPrice;
}

	if (bgrade=="일반") {//우등
		$("#fblock2-2").css({
			width:"260px",
			height:"322px"
		});
		
	} else if ((bgrade=="우등")||(bgrade=="프리미엄")) {//우등
		$("#fblock2-2").css({
			width:"220px",
			height:"262px"
		});
	} 
	
function countNor(type){
	let f2 = document.getElementById("fblock2-3-2-1-1");
	seatNor = $("#fblock2-1-1-3").text();
	if(type ==='+'){
		seatNor = parseInt(seatNor)+1; 
	} else if( type === '-'){
		if(parseInt(seatNor)>=1){
			seatNor = parseInt(seatNor)-1;
		}
		if(parseInt(seatNor)<=0){
			seatNor =0;
		}
	}
	$("#fblock2-1-1-3").text(seatNor);
	seatNorPrice=Math.round(seatNor*bFee / 10) * 10;
	fseatTotCount(seatNor,seatEle,seatOld);
	fseatTotPrice(seatNorPrice,seatElePrice, seatOldPrice);
	$("#fblock2-3-3-1").text(seatTotPrice);
	$("#fblock2-3-2-1-2").text(Math.round(seatNor*bFee / 10) * 10 +"원");
	f2.innerText = "일반"+ seatNor + "명";
}

function countEle(type){
	let f2 = document.getElementById("fblock2-3-2-2-1");
	let seatEle = $("#fblock2-1-3-3").text();
	if(type ==='+'){
		seatEle = parseInt(seatEle)+1; 
	} else if( type === '-'){
		if(parseInt(seatEle)>=1){
			seatEle = parseInt(seatEle)-1;
		}
		if(parseInt(seatEle)<=0){
			seatEle =0;
		}
	}
	$("#fblock2-1-3-3").text(seatEle);
	seatElePrice=Math.round(seatEle*bFee*0.5 / 10) * 10;
	fseatTotCount(seatNor,seatEle,seatOld);
	fseatTotPrice(seatNorPrice,seatElePrice, seatOldPrice);
	$("#fblock2-3-3-1").text(seatTotPrice);
	$("#fblock2-3-2-2-2").text(Math.round(seatEle*bFee*0.5 / 10) * 10 +"원");
	f2.innerText = "초등생"+ seatEle + "명";
}
function countMid(type){
	let f2 = document.getElementById("fblock2-3-2-3-1");
	let seatOld = $("#fblock2-1-5-3").text();
	if(type ==='+'){
		seatOld = parseInt(seatOld)+1; 
	} else if( type === '-'){
		if(parseInt(seatOld)>=1){
			seatOld = parseInt(seatOld)-1;
		}
		if(parseInt(seatOld)<=0){
			seatOld =0;
		}
	}
	$("#fblock2-1-5-3").text(seatOld);
	seatOldPrice = Math.round(seatOld*bFee*0.7 / 10) * 10;
	fseatTotCount(seatNor,seatEle,seatOld);
	fseatTotPrice(seatNorPrice,seatElePrice, seatOldPrice);
	$("#fblock2-3-3-1").text(seatTotPrice);
	$("#fblock2-3-2-3-2").text(Math.round(seatOld*bFee*0.7 / 10) * 10 +"원");
	f2.innerText = "중고등생"+ seatOld + "명";
}	
$(function(){
	//$(document).ready(function()와 동일
	let f = document.getElementById("fblock2-3-1-1");
	
	let seatArr = [];

	$(".btn-init").click(function(){
		seatArr = [];
		resetBtn();                                                                                                                                                                                                                                                                                                                                          
	});
	
	$("form[name=seatForm] input:checkbox").on('click', function() {
		let chk_id = $(this).attr("id");
		let num = parseInt($(this).attr("data-num"));
		
	    if ( $(this).prop('checked') ) {
	    	seatArr.push(num);
	    } else {
	    	let idx = seatArr.indexOf(num);
	    	if(idx > -1) seatArr.splice(idx, 1);
	    }
	    
	    seatArr.sort(function(a, b){
	    	return a-b;
	    });
	    
	    let s = "";
	    for(let item of seatArr) {
	    	s += item + "번 ";
	    }
	    
	    f.innerText = s;
	});
	
});
$(function() {
    $('.fblock2 input[type="button"]').click(function() {
    	let bFirstStaTime=$(this).parent().siblings('#bFirstStaTime').text();
    	let bEndStaTime=$(this).parent().siblings('#bEndStaTime').text();
    	let bName= $(this).parent().siblings('#bName').text();
    	let bType=$(this).parent().siblings('#bType').text();
    	let bFee=$(this).parent().siblings('#bFee').text();
    	let  seatNum=$(this).parent().siblings('#seatNum').attr("data-seatNum");
		
    	let bcycle = $("form[name=hiddenForm] input[name=bcycle]").attr("data-bcycle");
    	let busstaDate= $("form[name=hiddenForm] input[name=busstaDate]").attr("data-busstaDate");
    	let busendDate= $("form[name=hiddenForm] input[name=busendDate]").attr("data-busendDate");
    	let depbStationName= $("form[name=hiddenForm] input[name=depbStationName]").attr("data-depbStationName");
    	let desbStationName= $("form[name=hiddenForm] input[name=desbStationName]").attr("data-desbStationName");
    	let btakeTime= $("form[name=hiddenForm] input[name=btakeTime]").attr("data-btakeTime");
    	let bTotalTimeString= $("form[name=hiddenForm] input[name=bTotalTimeString]").attr("data-bTotalTimeString");
    	let bRouteDetailCode= $("form[name=hiddenForm] input[name=bRouteDetailCode]").attr("data-bRouteDetailCode");
    	let bRouteCode= $("form[name=hiddenForm] input[name=bRouteCode]").attr("data-bRouteCode");
    	
    	let out = "${pageContext.request.contextPath}/busreserve/busreserveseat.do?";
    	out += "bFirstStaTime="+bFirstStaTime+"&bEndStaTime="+bEndStaTime+"&bName="+bName+"&bType="+bType+"&bFee="+bFee+"&seatNum="+seatNum;
    	out += "&bcycle="+bcycle+"&busstaDate="+busstaDate+"&busendDate="+busendDate+"&depbStationName="+depbStationName;
    	out += "&desbStationName="+desbStationName+"&btakeTime="+btakeTime+"&bTotalTimeString="+bTotalTimeString;
    	out += "&bRouteDetailCode="+bRouteDetailCode+"&bRouteCode="+bRouteCode;
    	
    	location.href = out;
    });
    
});
function resetBtn(){
	let f2 = document.getElementById("fblock2-1-1-3");
	let f3 = document.getElementById("fblock2-1-3-3");
	let f4 = document.getElementById("fblock2-1-5-3");
	let f5 = document.getElementById("fblock2-3-1-1");
	let f6 = document.getElementById("fblock2-3-2-1-1");
	let f7 = document.getElementById("fblock2-3-2-1-2");
	let f8 = document.getElementById("fblock2-3-2-2-1");
	let f9 = document.getElementById("fblock2-3-2-2-2");
	let f10 = document.getElementById("fblock2-3-2-3-1");
	let f11 = document.getElementById("fblock2-3-2-3-2");
	let f12 = document.getElementById("fblock2-3-3-1");

		
	f2.innerText=0;
	f3.innerText=0;
	f4.innerText=0;
	f5.innerText="";
	f6.innerText="일반0명";
	f7.innerText="0원";
	f8.innerText="초등생0명";
	f9.innerText="0원";
	f10.innerText="중고등생0명";
	f11.innerText="0원";
	f12.innerText="0원";
}


</script>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main >
	<div class="container gx-10 d-flex justify-content-center ">
	    <div class="d-flex justify-content-center">
		    <div class="fblock1  text-light " style="border-radius: 30px; padding:20px;">
		    	<div class="h-20 p-3 text-center fs-5 fw-bold">${busendDate}</div>
		    	<div class="h-15 text-center fblock1_1">
	    			<div class="fblock1_icon bg-light text-primary p-10 m-2 text-center fw-bold">출발</div>
	    			<div class="text-center fs-4 fw-bold">${depbStationName}</div>
		    	</div>
		    	<div class="h-15 fblock1_1 p-10">
		    		<span class="fblock1_icon bg-light text-primary p-10 m-2 text-center fw-bold">도착</span>
		    		<span class="text-center fs-4 fw-bold">${desbStationName}</span>
		    	</div>
		    	<div class="row h-10 p-10 m-2 fblock1_1 fw-bold">${bTotalTimeString}</div>
		    	<div class="row h-10 p-10 m-2 fblock1_1  text-start fs-5 fw-bold">요금정보</div>
		    	<c:forEach var="dto" items="${bRouteInfoList}" varStatus="status">
			    	<c:if test="${dto.bType eq '일반'}">
				    	<div class="row h-10 p-10 m-2 fblock1_2 text-center"><div class="col fblock1_2 fw-bold" >일반</div><div class="col fblock1_3 fw-bold" id="bType" data-bFee="${dto.bFee}">${dto.bFee}원</div></div>
				    </c:if>
				    <c:if test="${dto.bType eq '우등'}">
				    	<div class="row h-10 p-10 m-2 fblock1_2 text-center" style=""><div class="col fblock1_2 fw-bold">우등</div><div class="col fblock1_3 fw-bold" id="bType" data-bFee="${dto.bFee}">${dto.bFee}원</div></div>
				    </c:if>
				    <c:if test="${dto.bType eq '프리미엄'}">
				    	<div class="row h-10 p-10 m-2 fblock1_2 text-center"><div class="col fblock1_2 fw-bold">프리미엄</div><div class="col fblock1_3 fw-bold" id="bType" data-bFee="${dto.bFee}">${dto.bFee}원</div></div>
			    	</c:if>
		    	</c:forEach>
		    </div>
	    </div>
			<form name="seatForm">
				<div class="fblock2">
					<div>
						<div class="d-flex  justify-content-evenly align-items-center">
							<button type="reset" class="d-flex btn btn-secondary btn-init" style="position:relative; right:35px;" >새로고침</button>
	     					<div class="d-flex align-items-center" id="seatCount">잔여 25석/전체 28석</div>				
							<div class="d-flex">&nbsp;</div>
						</div>
					</div>
					<div class="d-flex justify-content-evenly align-items-center">
						<div class="" id="fblock2-1">
							<div class="d-flex justify-content-around">
								<div class="d-flex flex-column " id="fblock2-1-1">
									<div id="fblock2-1-1-1">일반</div>
									<div id="fblock2-1-1-3">0</div>
								</div>
								<div class="d-flex flex-column" id="fblock2-1-2">
								<button type="button" id="fblock2-1-2-2" class="btn btn-secondary btnsize"  onclick="countNor('+')">+</button>
								<button type="button" id="fblock2-1-2-4" class="btn btn-secondary btnsize" onclick="countNor('-')">-</button>
								</div>
							</div>
							<div class="d-flex justify-content-around">
								<div class="d-flex flex-column " id="fblock2-1-3">
									<div id="fblock2-1-3-1">초등</div>
									<div id="fblock2-1-3-3">0</div>
								</div>
								<div class="d-flex flex-column" id="fblock2-1-4">
								<button type="button" id="fblock2-1-4-2" class="btn btn-secondary btnsize" onclick="countEle('+')">+</button>
								<button type="button" id="fblock2-1-4-4" class="btn btn-secondary btnsize" onclick="countEle('-')">-</button>
								</div>
							</div>
							<div class="d-flex justify-content-around">
								<div class="d-flex flex-column " id="fblock2-1-5">
									<div id="fblock2-1-5-1">중고등</div>
									<div id="fblock2-1-5-3">0</div>
								</div>
								<div class="d-flex flex-column" id="fblock2-1-6">
								<button type="button" id="fblock2-1-6-2" class="btn btn-secondary btnsize" onclick="countMid('+')">+</button>
								<button type="button" id="fblock2-1-6-4" class="btn btn-secondary btnsize" onclick="countMid('-')">-</button>
								</div>
							</div>
						</div>
						<!--버스 좌석정보(bgrade에 따라 + 예약된 좌석테이블관련 sql작성후 arr로 추가-->
						<%
						String bgrade = (String) request.getAttribute("bType");
						
						int rows=0, cols=0, notSeat=0;
						
						if (bgrade.equals("우등")) {//우등
							cols = 4;
							rows = 9;
							notSeat = 3;
						} else if(bgrade.equals("일반")){//일반
							cols = 5;
							rows = 11;
							notSeat = 3;
						} else if(bgrade.equals("프리미엄")){//프리미엄
							cols = 4;
							rows = 7;
							notSeat = 3;
						}
						
						%>
						<div id="fblock2-2">
							<div id="fblock2-2-1">
							<div id="driveSeat">운전석</div>
							<div id="enter">출입구</div>
							</div>
							<c:forEach var="dto" items="${bRouteInfoList}">
							<c:if test="${dto.bType eq '일반'}">
								
							</c:if>
							</c:forEach>
							<div id="seats">
								<%int count =0; %>
								<% for(int i=1; i<= rows-1; i++) {%>
								<div id="seats-row">
									<% for(int j=1; j<=cols; j++) {%>
										<%if(j == notSeat) {%>
										<%count++;%>
										<input type="checkbox" id="notSeat" class="btn-check" style="visibility: hidden;" >
										<label class="btn btn-outline-primary seatBtn" for="notSeat" style="border:none; visibility: hidden;"></label>
										<%} else {%>
										<input type="checkbox" id="seat-<%=(i-1)*(cols)+j-count%>" class="btn-check" data-num="<%=(i-1)*(cols)+j-count%>">
										<label class="btn btn-outline-primary seatBtn" for="seat-<%=(i-1)*(cols)+j-count%>" style="border:none;"><%=(i-1)*(cols)+j-count%></label>
										<%} %>
									<%} %>
								</div>
								<% }%>
								<div id="seats-row-last">
								<% for(int j=1; j<=cols; j++) {%>
									<input type="checkbox" id="seat-<%=(rows-1)*(cols)+j-count%>" class="btn-check" data-num="<%=(rows-1)*(cols)+j-count%>">
									<label class="btn btn-outline-primary seatBtn" for="seat-<%=(rows-1)*(cols)+j-count%>" style="border:none;"><%=(rows-1)*(cols)+j-count%></i></label>
								<%} %>
								</div>
							</div>
							<div></div>
						</div>
						<div id="fblock2-3">
							    <div id="fblock2-3-1">
								      <span id="fblock2-3-1-title">선택좌석</span>
								      <span id="fblock2-3-1-1" class="bseatNum"></span>
								</div>
								<hr id="fblock2-line">
								<div id="fblock2-3-2">
									<div id="fblock2-3-2-title">탑승인원 및 요금</div>
									<div id="fblock2-3-2-1">
										<span id="fblock2-3-2-1-1" class="bNor">일반0명</span>
										<span id="fblock2-3-2-1-2" class="bNorFee">0원</span>
									</div>
									<div id="fblock2-3-2-2">
										<span id="fblock2-3-2-2-1" class="bEle">초등생0명</span>
										<span id="fblock2-3-2-2-2" class="bEleFee">0원</span>
									</div>
									<div id="fblock2-3-2-3">
										<span id="fblock2-3-2-3-1" class="bOld">중고등생0명</span>
										<span id="fblock2-3-2-3-2" class="bOldFee">0명</span>
									</div>
								</div>
							<hr id=" fblock2-line">
							<div id="fblock2-3-3">
								<div id="fblock2-3-3-title">총결제금액</div>
								<div id="fblock2-3-3-1" class="totFee">원</div>
							</div>
						</div>
						
					</div>
				</div>
			</form>
		</div>
	</main>

	<form name="hiddenForm">
	<!-- 좌석번호 bSeatNum, 총좌석수 seatNum, 잔여석 reserveSeatNum -->
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">	
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	<input type="hidden" name="bName" value="${bName}">
	<input type="hidden" name="bType" value="${bType}">
	<input type="hidden" name="bFee" value="${bFee}">
	<input type="hidden" name="seatNum" value="${seatNum}">
	<input type="hidden" name="busstaDate" value="${busstaDate}">
	<input type="hidden" name="busendDate" value="${busendDate}">
	<input type="hidden" name="depbStationName" value="${depbStationName}">
	<input type="hidden" name="desbStationName" value="${desbStationName}">
	<input type="hidden" name="btakeTime" value="${btakeTime}">
	<input type="hidden" name="bTotalTimeString" value="${bTotalTimeString}">
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	<input type="hidden" name="bRouteCode" value="${bRouteCode}">
	<input type="hidden" name="bcycle" value="${bcycle}">
	<input type="hidden" name="bRouteInfoList" value="${bRouteInfoList}">
	</form>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>