<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 메인</title>
<jsp:include page="/WEB-INF/views/layout/static_mainHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.body-container { min-height: 900px; margin-top: 100px; }
.reserve-container { 
	background: #fff; width: 700px; height: 280px;
	position: relative; top: -400px; z-index: 100;  
	margin: 0px auto; border-radius: 20px;
}
.reserve-container div { border-radius: 5px; margin: 0; padding: 0; }
.tab-button {
	position: relative; top: -42px; background-color: rgba(0, 0, 0, 0.5); width: 250px;
	margin: 0px auto; border-radius: 30px; -webkit-backdrop-filter: blur(7px);backdrop-filter: blur(7px);
}
.nav-item {
	margin: 5px 10px;
}
.second-row, .third-row {
	height: 84px;
}
.reserve-tab { position: relative; top: -24px; }
.reserve-tab > div { width: 650px; margin: 0px auto; }
.countCus-btn { width: 100%; }
#countCus-left { color: #0E6EFD; font-weight: 600; float: left; } 
#countCus-right { text-align: right; float: right; font-weight: 600; color: #767676 }
#half, #full { padding: auto; }
.select-departure { margin-top: 10px; display: flex; width: 100%; }
.select-destination { margin-top: 10px; display: flex; width: 100%; }
.select-date { margin-top: 10px; display: flex; width: 45%; }
.select-date2 { margin-top: 10px; display: flex; width: 52.5%;}
.small-text { font-size: 14px; text-align: left; }
.middle-hilight-text { font-weight: 600; color: #4971FF; font-size: 18px; text-align: left; }
.btn { color: #767676; border: none; }
.btn:checked { color: #0E6EFD; }  
.plan input, .plan2 input{ display: none; }
.plan label, .plan2 label{
	position: relative; color: #767676; font-size: 18px;
	cursor: pointer; float: left; text-align: left; margin-right: 10px;
}
.plan input:checked + label, .plan2 input:checked + label{ color: #0E6EFD; font-weight: 600 }
.plan input:checked + label:after, .plan2 input:checked + label:after{
	height: 40px; line-height: 40px;
	border-radius: 100%; z-index: 999;
	position: absolute; top: -10px; right: -10px;
}
.level-container { padding: 6px 12px; }
.final-button { width: 100%; height: 100%; }
.col-3, .col-6 { box-shadow: 4px 4px 4px rgb(72, 92, 161, 0.2); border: none; }
#tab-1, #tab-2 { color: white; border-radius: 20px; }
#tab-1:checked, #tab-2:checked { background: white; color: #0E6EFD; }
.pm-button { border: none; }
.adult-count > button, .adult-count > div  { margin: 0 0 0 10px; }
.child-count > button, .child-count > div { margin: 0 0 0 10px; }
.adult-count { margin-bottom: 10px; }
.adult-count :nth-child(2), .child-count :nth-child(2) { margin-left: 165px; }
#changeButton { background: #0E6EFD; color: white; position: absolute; }
#changeButton:hover { background: #0D5ED7; cursor: pointer; }

</style>
<script type="text/javascript">

// 기차
function selectDep(){
	let radioText = $("input[name=radio2]:checked").next("label").text();
	let radioValue = $("input[name=radio2]:checked").val();
	$("#departure").text(radioText);
	$("#departure").val(radioValue);
	$("#myDialogModal1").modal("hide");
};
function selectDes(){
	let radioText = $("input[name=radio3]:checked").next("label").text();
	let radioValue = $("input[name=radio3]:checked").val();
	$("#destination").text(radioText);
	$("#destination").val(radioValue);
	$("#myDialogModal2").modal("hide");
};
$(function(){
	$(".select-date2").hide();
	$("#full").click(function(){
		$(".select-date2").show();
	});
	$("#half").click(function(){
		$(".select-date2").hide();
	});
});
function countAdult(type)  {
  const resultElement = document.getElementById('aCountResult');
  let number = resultElement.innerText;
  if(type === 'plus') {
    number = parseInt(number) + 1;
  }else if(type === 'minus')  {
	if(parseInt(number)===0){
		alert("0 이상만 가능합니다.");
	}
    number = parseInt(number) - 1;
  }
  resultElement.innerText = number;
}
function countChild(type) {
	  const resultElement = document.getElementById('cCountResult');
	  let number = resultElement.innerText;
	  if(type === 'plus') {
	  	number = parseInt(number) + 1;
	  }else if(type === 'minus')  {
		if(parseInt(number)===0){
			alert("0 이상만 가능합니다.");
			return;
		}
	    number = parseInt(number) - 1;
	  }
	  resultElement.innerText = number;
}
function resultCount(){
	let resultCount = "";
	let adultCountResult = $("#aCountResult").text();
	let childCountResult = $("#cCountResult").text();
	if(adultCountResult > 0) {
		resultCount = "<span id='countCus-right' value='어른'>성인 "+"<span id='adultCountResult'>"+adultCountResult+"</span>"+" 명</span>";
	}
	if(childCountResult > 0 ) {
		resultCount = "<span id='countCus-right' value='아동'>&nbsp;&nbsp;아동 "+"<span id='childCountResult'>"+childCountResult+"</span>"+" 명</span>";
	}
	if(adultCountResult > 0 && childCountResult > 0) {
		resultCount = "<span id='countCus-right' value='어른'>&nbsp;&nbsp;&nbsp;&nbsp;아동 "+"<span id='childCountResult'>"+childCountResult+"</span>"+" 명</span>" + 
						"<span id='countCus-right' value='아동'>성인 "+"<span id='adultCountResult'>"+adultCountResult+"</span>"+" 명</span>"
	}
	$("#countCus-right").html(resultCount);
	$("#myDialogModal").modal("hide");
}

$(function(){
	$("#changeButton").click(function(){
		let dep = $("#departure").text();
		let des = $("#destination").text();
		$("#departure").text(des);
		$("#destination").text(dep);
	});
});

</script>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap5/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap5/icon/bootstrap-icons.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap5/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	<div class="mb-2 pt-3 reserve-container">
		<ul class="nav nav-pills justify-content-center tab-button" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true" style="font-weight: 600">버 스</button>
			</li>
			<li class="nav-item" role="presentation" >
				<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true" style="font-weight: 600">기 차</button>
			</li>
		</ul>

		<div class="tab-content reserve-tab" id="nav-tabContent" role="group" aria-label="Basic radio toggle button group">
			
			
			<!-- 기차 -->
			<div class="tab-pane fade train-container justify-content-center" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
			<form name="trainReserveForm" method="post">
				<span id="changeButton" style="width: 30px; height: 30px; border-radius: 30px; left: 170px; top: 70px; padding: auto; padding-left: 7px; padding-top: 3px; z-index: 300;"><i class="bi bi-arrow-left-right"></i></span>
				<div class="btn-goup row row-cols-3 text-dark text-center" style="margin: 0px;" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
  					<label class="col-3 btn btn-outline-primary" id="bushalf" for="btnradio1" style="margin: 2px; width: 24%; border: none; font-weight: 600;"><span>편 도</span></label>
					
					<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
  					<label class="col-3 btn btn-outline-primary" id="busfull" for="btnradio2" style="margin: 2px; width: 24%; border: none; font-weight: 600;"><span>왕 복</span></label>

					<div class="col-6" style="margin: 2px; width: 49%">
					  <button type="button" class="btn countCus-btn position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal">
					  	<span id="countCus-left">인원</span>
					  	<span id="countCus-right"></span>
					  </button>
					</div>
				</div>
				<div class="row row-cols-3 text-dark second-row">
					<div class="col-3" style="margin: 2px; width: 24%">
					  	<button type="button" class="btn select-departure position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal1">
					  		<div class="small-text">출발지</div>
					  		<div class="middle-hilight-text" id="departure">선택</div>
					  	</button>
					</div>
					<div class="col-3" style="margin: 2px; width: 24%">
					  	<button type="button" class="btn select-destination position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal2">
						  	<div class="small-text">도착지</div>
						  	<div class="middle-hilight-text" id="destination">선택</div>
					  	</button>
					</div>
					<div class="col-6" style="margin: 2px; width: 49%">
						<button type="button" class="btn select-date position-relative btn-staDate">
						  	<div class="small-text">가는날</div>
						  	<div class="middle-hilight-text" id="staDate"></div>
					 	 </button>
						<button type="button" class="btn select-date2 position-relative btn-endDate">
						  	<div class="small-text" style="text-align: right;">오는날</div>
						  	<div class="middle-hilight-text" style="text-align: right;" id="endDate"></div>
					 	 </button>
					</div>
				</div>
				<div class="row row-cols-3 text-dark text-center third-row level-container">
					<div class="col-6 level-container" style="margin: 2px; width: 48.75%; padding: 16px 12px;">
						<div class="small-text">등급</div>
					 	<section class="plan cf">
							<input type="radio" name="radio1" id="all" value="all" checked><label class="free-label four col" for="all">전체</label>
							<input type="radio" name="radio1" id="premium" value="premium"><label class="basic-label four col" for="premium">특실</label>
							<input type="radio" name="radio1" id="basic" value="basic"><label class="premium-label four col" for="basic">일반</label>
						</section>
					</div>
					<div class="col-6" style="margin: 2px; width: 48.75%">
						<button type="button" class="btn btn-primary final-button" style="font-size: 18px; font-weight: 600">조&nbsp;&nbsp;회</button>
					</div>
				</div>
			</form>
			</div>
		</div>
	</div>

<!-- 기차 모달창 -->
<div class="modal fade" id="myDialogModal" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">인원</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="adult-count" style="display: flex; align-items: flex-end;">
					<span>성인</span>
					<button type='button' class="pm-button" onclick='countAdult("minus")' value='-'><i class="bi bi-dash-circle"></i></button>
					<div id='aCountResult'>0</div>
	        		<button type='button' class="pm-button" onclick='countAdult("plus")' value='+'><i class="bi bi-plus-circle"></i></button>
				</div>
				<div class="child-count" style="display: flex; align-items: flex-end;">
					<span>아동</span>
					<button type='button' class="pm-button" onclick='countChild("minus")' value='-'><i class="bi bi-dash-circle"></i></button>
					<div id='cCountResult'>0</div>
	        		<button type='button' class="pm-button" onclick='countChild("plus")' value='+'><i class="bi bi-plus-circle"></i></button>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="resultCount();">등록하기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal1" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">출발지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="departureForm">
				<div class="modal-body"  style="min-height: 200px;">	
		        	<section class="plan cf">
						<input type="radio" name="radio2" id="su" value="서울" checked><label class="four col" for="su">서울</label>
						<input type="radio" name="radio2" id="ydp" value="영등포"><label class="four col" for="ydp">영등포</label>
						<input type="radio" name="radio2" id="sw" value="수원"><label class="four col" for="sw">수원</label>
					</section>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="selectDep();">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal2" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">도착지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="destinationForm">
				<div class="modal-body" style="min-height: 200px;">
		        	<section class="plan2 cf">
						<input type="radio" name="radio3" id="su2" value="서울" checked><label for="su2">서울</label>
						<input type="radio" name="radio3" id="ydp2" value="영등포"><label for="ydp2">영등포</label>
						<input type="radio" name="radio3" id="sw2" value="수원"><label for="sw2">수원</label>
					</section>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="selectDes();">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal3" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">가는날</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<div id="depDate">
        			
        		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal4" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">오는날</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<div id="desDate">
        			
        		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 버스 부분 -->
<div class="modal fade" id="myDialogModal11" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">출발지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="departureForm">
				<div class="modal-body"  style="min-height: 200px;">	
		        	<section class="plan cf">
						<input type="radio" name="radio4" id="su" value="서울" checked><label class="four col" for="su">서울</label>
						<input type="radio" name="radio4" id="ydp" value="영등포"><label class="four col" for="ydp">영등포</label>
						<input type="radio" name="radio4" id="sw" value="수원"><label class="four col" for="sw">수원</label>
					</section>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="busselectDep();">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal22" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">도착지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="destinationForm">
				<div class="modal-body" style="min-height: 200px;">
		        	<section class="plan2 cf">
						<input type="radio" name="radio5" id="su2" value="서울" checked><label for="su2">서울</label>
						<input type="radio" name="radio5" id="ydp2" value="영등포"><label for="ydp2">영등포</label>
						<input type="radio" name="radio5" id="sw2" value="수원"><label for="sw2">수원</label>
					</section>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="busselectDes();">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal33" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">가는날</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<div id="depDate">
        			
        		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal44" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">오는날</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<div id="desDate">
        			
        		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<main>
	<div class="container body-container">
	</div>
</main>

<script type="text/javascript">
function calendar(y, m, mode) {
	let date = new Date(y, m-1, 1); // y년 m월 1일의 Date 객체 생성
	y = date.getFullYear();
	m = date.getMonth() + 1;
	
	let w = date.getDay(); // 요일 (0~6, 일~토)
	let week = ['일','월','화','수','목','금','토']; // 자바스크립트에서 배열의 초기값을 줄 때
	
	// 시스템 오늘 날짜
	let now = new Date();
	let ny = now.getFullYear();
	let nm = now.getMonth()+1;
	let nd = now.getDate();
	
	let out = '<div id="calendarLayout">';
	out += '<div class="subject">';
	out += '<span class="lr" onclick="calendar('+y+','+(m-1)+')">&lt;</span>&nbsp;&nbsp;'; // onclick : 버튼을 클릭했을 때 발생하는 것을 지정
	out += '<label>' + y + '년 ' + m + '월</label>&nbsp;&nbsp;';
	out += '<span onclick="calendar('+y+','+(m+1)+')">&gt;</span>';
	out += '</div>';
	
	out += '<table class="table td-border">';
	out += '<tr>';
	for(let i=0; i<week.length; i++){
		out += '<td style="background: #0E6EFD; color: white; border: 1px solid #0E6EFD">' + week[i] + '</td>';
	}
	out += '</tr>';
	
	// 무조건 6주로 만들기
	let row = 1; // 주 수
	
	// 1일 앞부분 : 이전달
	let preDate = new Date(y, m-1, 0); // 이전달의 마지막 날짜로 Date 객체 생성
	let pLastDay = preDate.getDate(); // 이전달의 마지막 날짜
	let pDay = pLastDay - w;
	
	
	out += '<tr>';
	for(let i=0; i<w; i++){
		let y2 = y;
		let m2 = m-1;
		if(nm===1){
			y2 = y - 1;
			m2 = 12;
		}
		let date = new Date(y2, m2, pDay-1);
		let w = date.getDay();
		let week = [' 일',' 월',' 화',' 수',' 목',' 금',' 토'];
		out += '<td class="gray">'+(++pDay)+'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y2+'.'+m2+'.'+'</span>'+'</td>';
	}
	
	let cls;
	let lastDay = (new Date(y, m, 0)).getDate();
	for(let i=1; i<=lastDay; i++){
		
		cls = y===ny && m===nm && i===nd ? ' today ' : '';
		
		let date = new Date(y, m, i);
		let w2 = date.getDay();
		let week2 = [' 일',' 월',' 화',' 수',' 목',' 금',' 토'];
		
		out += '<td class="'+cls+' clsClass">'+ i +'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y+'.'+m+'.'+i+'</span>'+'</td>';
		if(i !== lastDay && ++w % 7 ===0) {
			row++;
			out += '</tr><tr>';
		}
	}
	// 마지막 날짜 뒷부분
	let nDay = 0;
	for(let i=w%7; i<6; i++){
		let y3 = ny;
		let m3 = nm+1;
		if(nm===12){
			y3 = ny + 1;
			m3 = 1;
		}
		let date = new Date(y3, m3, nDay+1);
		let w2 = date.getDay();
		let week2 = [' 일',' 월',' 화',' 수',' 목',' 금',' 토'];
		out += '<td class="gray">'+(++nDay)+'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y3+'.'+m3+'.'+'</span>'+'</td>';
	}
	out += '</tr>';
	// 한달은 최대 6주
	for(let i=row; i<6; i++){
		out += '<tr>';
		for(let j=0; j<7; j++){
			let y3 = ny;
			let m3 = nm+1;
			if(nm===12){
				y3 = ny + 1;
				m3 = 1;
			}
			let date = new Date(y3, m3, nDay+1);
			let w2 = date.getDay();
			let week2 = [' 일',' 월',' 화',' 수',' 목',' 금',' 토'];
			out += '<td class="gray">'+(++nDay)+'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y3+'.'+m3+'.'+'</span>'+'</td>';
		}
		out += '</tr>';
	}
	
	out += '</table></div>';
	
	
	let selector = "#depDate";
	if(mode === "des") {
		selector = "#desDate";
	}
	document.querySelector(selector).innerHTML = out;
}

$(function(){
	let now = new Date();
	let y = now.getFullYear();
	let m = now.getMonth() + 1;
	let d = now.getDate();
	
	$("#staDate").attr("data-year", y);
	$("#staDate").attr("data-month", m);
	$("#staDate").attr("data-date", d);
	
	$("#endDate").attr("data-year", y);
	$("#endDate").attr("data-month", m);
	$("#endDate").attr("data-date", d);
	
	let w = now.getDay(); // 요일 (0~6, 일~토)
	let week = ['일','월','화','수','목','금','토']; // 자바스크립트에서 배열의 초기값을 줄 때
	
	let today = y+"."+m+"."+d+" "+week[w];
	
	$("#staDate").text(today);
	$("#endDate").text(today);
	
});

$(function(){
	$(".btn-staDate").click(function(){
		let y = $("#staDate").attr("data-year");
		let m = $("#staDate").attr("data-month");
		let d = $("#staDate").attr("data-date");
		
		calendar(y, m, "dep");
		
		$("#myDialogModal3").modal("show");
		
		$("#calendarLayout td").click(function(){
			let selectTr = $(this).parent().find("td").index(this);
			let week = ['일','월','화','수','목','금','토'];
			let selectDate = $(this).children().text();
			selectDate = selectDate + " " + week[selectTr];
			
			$("#staDate").text(selectDate);
			$("#myDialogModal3").modal("hide");
		});
	});
	$(".btn-endDate").click(function(){
		let y = $("#endDate").attr("data-year");
		let m = $("#endDate").attr("data-month");
		let d = $("#endDate").attr("data-date");
		
		calendar(y, m, "des");
		
		$("#myDialogModal4").modal("show");
		
		$("#calendarLayout td").click(function(){
			let selectTr = $(this).parent().find("td").index(this);
			let week = ['일','월','화','수','목','금','토'];
			let selectDate = $(this).children().text();
			selectDate = selectDate + " " + week[selectTr];
			
			$("#endDate").text(selectDate);
			$("#myDialogModal4").modal("hide");
		});
	});
});

</script>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>