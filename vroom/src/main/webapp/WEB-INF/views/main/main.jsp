<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉</title>
<jsp:include page="/WEB-INF/views/layout/static_mainHeader.jsp"/>

<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.8.8/i18n/jquery.ui.datepicker-ko.js"></script>
<style type="text/css">
main { 
	position: relative; top: -300px; background: white;
}

.fake-box2 {
	background: white; width: 100%; height: 50px; 
	border-radius: 100px 100px 0 0;
	margin-top: 450px; position: relative;
}

.body-container { min-height: 600px; margin-top: 100px; }
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
#bushalf, #busfull { padding: auto; }
.select-departure { margin-top: 10px; display: flex; width: 100%; }
.select-destination { margin-top: 10px; display: flex; width: 100%; }
.select-date { margin-top: 10px; display: flex; width: 45%; }
.select-date2 { margin-top: 10px; display: flex; width: 52.5%;}
.select-date3 { margin-top: 10px; display: flex; width: 52.5%;}
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
#buschangeButton { background: #0E6EFD; color: white; position: absolute; }
#changeButton:hover { background: #0D5ED7; cursor: pointer; }
#buschangeButton:hover { background: #0D5ED7; cursor: pointer; }

.container {
	min-width: 900px;
	width: 80%;
	margin: 0 auto;
	margin-top: 80px;
}

.carousel-control-prev{
    color: #0E6EFD;
}
.blue-box2 {
	top: 0; left: 0; z-index: -1; background-size: cover;
	width: 100%; height: 600px; position: absolute; background-image: url("${pageContext.request.contextPath}/resources/images/vroom_back.png")
}
.sort {
	font-size: 10px;
	border: 0;
	width: 70px;
	height: 27px;
	border-radius: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	
}
</style>
<script type="text/javascript">

function selectDep(){
	let radioText = $("input[name=radio2]:checked").next("label").text();
	let stationCode = $("input[name=radio2]:checked").val();
	
	$("#departure").text(radioText);
	$("#departure").attr("data-departure", stationCode);
	if(!radioText) {
		$("#departure").text("선택");
		$("#departure").val("선택");
	} 
	$("#myDialogModal1").modal("hide");
	
	let departure = $("#departure").text();
	let destination = $("#destination").text();
	if(departure === destination){
		$("#destination").text("선택");
		$("#destination").val("선택");
		$("#destination").attr("data-destination", "");
	}
}

function busselectDep(){
	let radioText = $("input[name=radio3]:checked").next("label").text();
	let stationCode = $("input[name=radio3]:checked").val();
	
	$("#busdeparture").text(radioText);
	$("#busdeparture").attr("data-busdeparture", stationCode);
	if(!radioText) {
		$("#busdeparture").text("선택");
		$("#busdeparture").val("선택");
	} 
	$("#myDialogModal11").modal("hide");
	
	let busdeparture = $("#busdeparture").text();
	let busdestination = $("#busdestination").text();
	if(busdeparture === busdestination){
		$("#busdestination").text("선택");
		$("#busdestination").val("선택");
		$("#busdestination").attr("data-busdestination", "");
	}
}
	
function selectDes(){
	let radioText = $("input[name=radio4]:checked").next("label").text();
	let stationCode = $("input[name=radio4]:checked").val();
	$("#destination").text(radioText);
	$("#destination").attr("data-destination", stationCode);
	$("#myDialogModal2").modal("hide");
}

function busselectDes(){
	let radioText = $("input[name=radio5]:checked").next("label").text();
	let stationCode = $("input[name=radio5]:checked").val();
	$("#busdestination").text(radioText);
	$("#busdestination").attr("data-busdestination", stationCode);
	$("#myDialogModal22").modal("hide");
}

$(function(){
	$(".select-date3").hide();
	$("#full").click(function(){
		$(".select-date3").show();
	});
	$("#half").click(function(){
		$(".select-date3").hide();
	});
});
$(function(){
	$(".select-date2").hide();
	$("#busfull").click(function(){
		$(".select-date2").show();
	});
	$("#bushalf").click(function(){
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
		let deptStationCode = $("#departure").attr("data-departure"); 
		let destStationCode = $("#destination").attr("data-destination");
		$("#departure").text(des);
		$("#destination").text(dep);
		$("#departure").attr("data-departure", deptStationCode);
		$("#destination").attr("data-destination", deptStationCode);
	});
});
//버스
$(function(){
	$("#buschangeButton").click(function(){
		let dep = $("#busdeparture").text();
		let des = $("#busdestination").text();
		let depbStationCode = $("#busdeparture").attr("data-busdeparture"); 
		let desbStationCode = $("#busdestination").attr("data-busdestination");
		$("#busdeparture").text(des);
		$("#busdestination").text(dep);
		$("#busdeparture").attr("data-busdeparture", depbStationCode);
		$("#busdestination").attr("data-busdestination", depbStationCode);
	});
});

// 기차 - 출발지 선택리스트
$(function(){
	$(".select-departure").click(function(){
		let url = "${pageContext.request.contextPath}/reservetrain/traininsertDepList.do";
		
		$.ajax({
			type:"post",
			url:url,
			data:null,
			dataType:"json",
			success:function(data){
				
				let out = "";
				let i = 0;
				$(data.list).each(function(index, item){
					let stationCode = item.stationCode;
					let stationName = item.stationName;
					out += '<input type="radio" name="radio2" id="'+"trainDep"+(++i)+'" value="'+stationCode+'"><label class="four col" for="'+"trainDep"+(i)+'">'+stationName+'</label>';
				});
				$(".trainDepList").html(out);		
			},
			error:function(e) {
				console.log(e.responseText);
			}
		});
	});
});

//버스 - 출발지 선택리스트
$(function(){
	$(".select-busdeparture").click(function(){
		let url = "${pageContext.request.contextPath}/busreserve/businsertlist.do";
		
		$.ajax({
			type:"post",
			url:url,
			data:null,
			dataType:"json",
			success:function(data){
				
				let out = "";
				let i = 0;
				$(data.list).each(function(index, item){
					let stationCode = item.stationCode;
					let stationName = item.stationName;
					out += '<input type="radio" name="radio3" id="'+"busDep"+(++i)+'" value="'+stationCode+'"><label class="col" for="'+"busDep"+(i)+'">'+stationName+'</label>';
				});
				
				$(".busDepList").html(out);		
			},
			error:function(e) {
				console.log(e.responseText);
			}
		});
	});
});

// 기차 - 출발지 선택 후 도착지 선택 리스트
$(function(){
	$(".select-destination").click(function(){
		if(!$("#departure").attr("data-departure")){
			$(".trainDesList").text("출발지를 선택해주세요.");
			return false;
		}
		let url = "${pageContext.request.contextPath}/reservetrain/traininsertDesList.do";
		let deptStationCode = $("#departure").attr("data-departure"); 
		let query = "deptStationCode="+deptStationCode;
		
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success:function(data){
				
				let out = "";
				let i = 0;
				$(data.list).each(function(index, item){
					let stationCode = item.stationCode;
					let stationName = item.stationName;
					out += '<input type="radio" name="radio4" id="'+"trainDes"+(++i)+'" value="'+stationCode+'"><label class="four col" for="'+"trainDes"+(i)+'">'+stationName+'</label>';
				});
				$(".trainDesList").html(out);		
			},
			error:function(e) {
				console.log(e.responseText);
			}
		});
	});
});

//버스 - 출발지 선택 후 도착지 선택 리스트
$(function(){
	$(".select-busdestination").click(function(){
		if(!$("#busdeparture").attr("data-busdeparture")){
			$(".busDesList").text("출발지를 선택해주세요.");
			return false;
		}
		let url = "${pageContext.request.contextPath}/busreserve/businsertlist.do";
		let depbStationCode = $("#busdeparture").attr("data-busdeparture"); 
		let query = "depbStationCode="+depbStationCode;
		
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success:function(data){
				
				let out = "";
				let i = 0;
				$(data.list).each(function(index, item){
					let stationCode = item.stationCode;
					let stationName = item.stationName;
					out += '<input type="radio" name="radio5" id="'+"busDes"+(++i)+'" value="'+stationCode+'"><label class="four col" for="'+"busDes"+(i)+'">'+stationName+'</label>';
				});
				$(".busDesList").html(out);		
			},
			error:function(e) {
				console.log(e.responseText);
			}
		});
	});
});

// 기차 - 다 선택 후에 조회 눌렀을 때 가져갈 데이터
$(function(){
	$(".trainSend").click(function(){
		// 비어있는 칸 있는지 확인
		if(!compareDate()){
			alert("가는날은 오늘날보다 이전이어야 합니다.");
		}
		if(!$("#countCus-right").text()){
			alert("인원수를 입력해주세요.");
			return false;
		}
		if(!$("#departure").attr("data-departure")){
			alert("출발지 및 도착지를 선택해주세요.");
			return false;
		}
		if($("#destination").text()==="선택"){
			alert("도착지를 선택해주세요.");
			return false;
		}		
		let cycle = $("input[name=btnradio]:checked").val();
		let childCount = $("#childCountResult").text();
		let adultCount = $("#adultCountResult").text();
		if(!$("#adultCountResult").text()){
			adultCount = 0;
		}
		if(!$("#childCountResult").text()){
			childCount = 0;
		}
		let deptStationCode = $("#departure").attr("data-departure");
		let destStationCode = $("#destination").attr("data-destination");
		let deptStationName = $("#departure").text();
		let destStationName = $("#destination").text();
		
		let y1 = $("#staDate").attr("data-year");
		let m1 = $("#staDate").attr("data-month");
		let d1 = $("#staDate").attr("data-date");
		let tBoardDate1 = encodeURIComponent(y1+"-"+m1+"-"+d1);
		
		let tBoardDate2 = "";
		if(cycle == "full"){
			let y2 = $("#endDate").attr("data-year");
			let m2 = $("#endDate").attr("data-month");
			let d2 = $("#endDate").attr("data-date");
			tBoardDate2 = encodeURIComponent(y2+"-"+m2+"-"+d2);
		}
		let staDate = $("#staDate").text();
		let endDate = $("#endDate").text();
		let grade = $("input[name=radio1]:checked").val();
		
		let out = "${pageContext.request.contextPath}/reservetrain/trainsteptwo_ok.do?"
		if(cycle == "full"){
			out += "cycle="+cycle+"&adultCount="+adultCount+"&childCount="+childCount;
			out += "&deptStationCode="+deptStationCode+"&destStationCode="+destStationCode;
			out += "&deptStationName="+deptStationName+"&destStationName="+destStationName;
			out += "&staDate="+staDate+"&endDate="+endDate;
			out += "&tBoardDate1="+tBoardDate1+"&tBoardDate2="+tBoardDate2+"&grade="+grade;
		} else {
			out += "cycle="+cycle+"&adultCount="+adultCount+"&childCount="+childCount;
			out += "&deptStationName="+deptStationName+"&destStationName="+destStationName;
			out += "&staDate="+staDate+"&endDate="+endDate;
			out += "&deptStationCode="+deptStationCode+"&destStationCode="+destStationCode;
			out += "&tBoardDate1="+tBoardDate1+"&grade="+grade;
		}
		location.href = out;
	});
	
	function compareDate(){
		let sy = $("#staDate").attr("data-year");
		let sm = $("#staDate").attr("data-month");
		let sd = $("#staDate").attr("data-date");
		
		let ey = $("#endDate").attr("data-year");
		let em = $("#endDate").attr("data-month");
		let ed = $("#endDate").attr("data-date");
		
		if(ey>=sy&&em>=sy&&ed>=sd) {
			return false;
		}
		return true;
	}
});
//버스데이터
// 기차 - 다 선택 후에 조회 눌렀을 때 가져갈 데이터
$(function(){
	$(".busSend").click(function(){
		// 비어있는 칸 있는지 확인
		if(!compareDate()){
			alert("가는날은 오늘날보다 이전이어야 합니다.");
		}
		if(!$("#busdeparture").attr("data-busdeparture")){
			alert("출발지 및 도착지를 선택해주세요.");
			return false;
		}
		if($("#busdestination").text()==="선택"){
			alert("도착지를 선택해주세요.");
			return false;
		}		
		let bcycle = $("input[name=busbtnradio]:checked").val();
		let childCount = $("#childCountResult").text();
		let adultCount = $("#adultCountResult").text();
		if(!$("#adultCountResult").text()){
			adultCount = 0;
		}
		if(!$("#childCountResult").text()){
			childCount = 0;
		}
		let depbStationCode = $("#busdeparture").attr("data-busdeparture");
		let desbStationCode = $("#busdestination").attr("data-busdestination");
		let depbStationName = $("#busdeparture").text();
		let desbStationName = $("#busdestination").text();
		
		let y1 = $("#busstaDate").attr("data-year");
		let m1 = $("#busstaDate").attr("data-month");
		let d1 = $("#busstaDate").attr("data-date");
		let bBoardDate1 = encodeURIComponent(y1+"-"+m1+"-"+d1);
		
		let bBoardDate2 = "";
		//왕복, 편도
		if(bcycle == "busfull"){
			let y2 = $("#busendDate").attr("data-year");
			let m2 = $("#busendDate").attr("data-month");
			let d2 = $("#busendDate").attr("data-date");
			bBoardDate2 = encodeURIComponent(y2+"-"+m2+"-"+d2);
		}
		let busstaDate = $("#busstaDate").text();
		let busendDate = $("#busendDate").text();
		let bgrade = $("input[name=busradio1]:checked").val();
		
		let out = "${pageContext.request.contextPath}/busreserve/buslistbefore.do?"
		if(bcycle == "busfull"){
			out += "bcycle="+bcycle;
			out += "&depbStationCode="+depbStationCode+"&desbStationCode="+desbStationCode;
			out += "&depbStationName="+depbStationName+"&desbStationName="+desbStationName;
			out += "&busstaDate="+busstaDate+"&busendDate="+busendDate;
			out += "&bBoardDate1="+bBoardDate1+"&bBoardDate2="+bBoardDate2+"&bgrade="+bgrade;
		} else {
			out += "bcycle="+bcycle;
			out += "&depbStationCode="+depbStationCode+"&desbStationCode="+desbStationCode;
			out += "&depbStationName="+depbStationName+"&desbStationName="+desbStationName;
			out += "&busstaDate="+busstaDate+"&busendDate="+busendDate;
			out += "&bBoardDate1="+bBoardDate1+"&bgrade="+bgrade;
		}
		location.href = out;
	});
	
	function compareDate(){
		let sy = $("#busstaDate").attr("data-year");
		let sm = $("#busstaDate").attr("data-month");
		let sd = $("#busstaDate").attr("data-date");
		
		let ey = $("#busendDate").attr("data-year");
		let em = $("#busendDate").attr("data-month");
		let ed = $("#busendDate").attr("data-date");
		
		if(ey>=sy&&em>=sy&&ed>=sd) {
			return false;
		}
		return true;
	}
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
	<div class="fake-box2"></div>
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
			<!--  버스 -->
			<div class="tab-pane fade train-container justify-content-center active show" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
			<form name="busReserveForm" method="post">
				<span id="buschangeButton" style="width: 30px; height: 30px; border-radius: 30px; left: 170px; top: 70px; padding: auto; padding-left: 7px; padding-top: 3px; z-index: 300;"><i class="bi bi-arrow-left-right"></i></span>
				<div class="btn-goup row row-cols-3 text-dark text-center" style="margin: 0px;" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="busbtnradio" id="busbtnradio1" autocomplete="off" checked value="half">
  					<label class="col-6 btn btn-outline-primary" id="bushalf" for="busbtnradio1" style="margin: 2px; width: 49%; border: none; font-weight: 600;"><span>편 도</span></label>
					
					<input type="radio" class="btn-check" name="busbtnradio" id="busbtnradio2" autocomplete="off" value="full">
  					<label class="col-6 btn btn-outline-primary" id="busfull" for="busbtnradio2" style="margin: 2px; width: 49%; border: none; font-weight: 600;"><span>왕 복</span></label>
				</div>
				<div class="row row-cols-3 text-dark second-row">
					<div class="col-3" style="margin: 2px; width: 24%">
					  	<button type="button" class="btn select-busdeparture position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal11" style="height: 80px; overflow: hidden">
					  		<div class="small-text">출발지</div>
					  		<div class="middle-hilight-text" id="busdeparture" data-busdeparture="" style="line-height: 20px;">선택</div>
					  	</button>
					</div>
					<div class="col-3" style="margin: 2px; width: 24%">
					  	<button type="button" class="btn select-busdestination position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal22" style="height: 80px; overflow: hidden">
						  	<div class="small-text">도착지</div>
						  	<div class="middle-hilight-text" id="busdestination" data-busdestination="" style="line-height: 20px;">선택</div>
					  	</button>
					</div>
					<div class="col-6" style="margin: 2px; width: 49%; height: 84px;">
						<button type="button" class="btn select-date position-relative btn-busstaDate">
						  	<div class="small-text">가는날</div>
						  	<div class="middle-hilight-text" id="busstaDate"></div>
					 	 </button>
						<button type="button" class="btn select-date2 position-relative btn-busendDate">
						  	<div class="small-text" style="text-align: right;">오는날</div>
						  	<div class="middle-hilight-text" style="text-align: right;" id="busendDate"></div>
					 	 </button>
					</div>
				</div>
				<div class="row row-cols-3 text-dark text-center third-row level-container">
					<div class="col-6 level-container" style="margin: 2px; width: 48.75%; padding: 16px 12px; margin-top: 1px;">
						<div class="small-text">등급</div>
					 	<section class="plan cf">
							<input type="radio" name="busradio1" id="busall" value="all" checked><label class="free-label four col" for="busall">전체</label>
							<input type="radio" name="busradio1" id="busbasic" value="basic"><label class="basic-label four col" for="busbasic">일반</label>
							<input type="radio" name="busradio1" id="bussuperior" value="superior"><label class="superior-label four col" for="bussuperior">우등</label>
							<input type="radio" name="busradio1" id="buspremium" value="premium"><label class="premium-label four col" for="buspremium">프리미엄</label>
							
						</section>
					</div>
					<div class="col-6" style="margin: 2px; width: 318.5px;">
						<button type="button" class="btn btn-primary final-button busSend" style="font-size: 18px; font-weight: 600">조&nbsp;&nbsp;회</button>
					</div>
				</div>
			</form>
			</div>
			<!-- 기차 -->
			<div class="tab-pane fade train-container justify-content-center" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
			<form name="trainReserveForm" method="post">
				<span id="changeButton" style="width: 30px; height: 30px; border-radius: 30px; left: 170px; top: 70px; padding: auto; padding-left: 7px; padding-top: 3px; z-index: 300;"><i class="bi bi-arrow-left-right"></i></span>
				<div class="btn-goup row row-cols-3 text-dark text-center" style="margin: 0px;" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" value="half" checked>
  					<label class="col-3 btn btn-outline-primary" id="half" for="btnradio1" style="margin: 2px; width: 24%; border: none; font-weight: 600;"><span>편 도</span></label>
					
					<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" value="full">
  					<label class="col-3 btn btn-outline-primary" id="full" for="btnradio2" style="margin: 2px; width: 24%; border: none; font-weight: 600;"><span>왕 복</span></label>

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
					  		<div class="middle-hilight-text" id="departure" data-departure="">선택</div>
					  	</button>
					</div>
					<div class="col-3" style="margin: 2px; width: 24%">
					  	<button type="button" class="btn select-destination position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal2">
						  	<div class="small-text">도착지</div>
						  	<div class="middle-hilight-text" id="destination" data-destination="">선택</div>
					  	</button>
					</div>
					<div class="col-6" style="margin: 2px; width: 49%">
						<button type="button" class="btn select-date position-relative btn-staDate">
						  	<div class="small-text">가는날</div>
						  	<div class="middle-hilight-text" id="staDate"></div>
					 	 </button>
						<button type="button" class="btn select-date3 position-relative btn2-endDate">
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
							<input type="radio" name="radio1" id="premium" value="premium"><label class="premium-label four col" for="premium">특실</label>
							<input type="radio" name="radio1" id="basic" value="basic"><label class="basic-label four col" for="basic">일반</label>
						</section>
					</div>
					<div class="col-6" style="margin: 2px; width: 318.5px;">
						<button type="button" class="btn btn-primary final-button trainSend" style="font-size: 18px; font-weight: 600">조&nbsp;&nbsp;회</button>
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
					<button type='button' class="pm-button" onclick='countAdult("minus")' value='-' style="background: white"><i class="bi bi-dash-circle"></i></button>
					<div id='aCountResult'>0</div>
	        		<button type='button' class="pm-button" onclick='countAdult("plus")' value='+' style="background: white"><i class="bi bi-plus-circle"></i></button>
				</div>
				<div class="child-count" style="display: flex; align-items: flex-end;">
					<span>아동</span>
					<button type='button' class="pm-button" onclick='countChild("minus")' value='-' style="background: white"><i class="bi bi-dash-circle"></i></button>
					<div id='cCountResult'>0</div>
	        		<button type='button' class="pm-button" onclick='countChild("plus")' value='+' style="background: white"><i class="bi bi-plus-circle"></i></button>
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
		        	<section class="plan cf trainDepList">
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
		        	<section class="plan2 cf trainDesList">
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
		aria-labelledby="myDialogModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel2">출발지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="departureForm">
				<div class="modal-body"  style="min-height: 500px;">	
		        	<section class="plan cf busDepList">
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
		aria-labelledby="myDialogModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel2">도착지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<form name="destinationForm">
				<div class="modal-body" style="min-height: 500px;">
		        	<section class="plan2 cf busDesList">
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
		aria-labelledby="myDialogModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel2">가는날</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<div id="bus-depDate">
        			
        		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal44" tabindex="-1" 
		aria-labelledby="myDialogModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel2">오는날</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<div id="bus-desDate">
        			
        		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
	<main>
		<!-- 캐러셀 -->
		
		
		<div class="container">
			<div class="body-container">
				<div class="row">
					<div id="carouselImageCaptions" class="carousel slide" data-bs-ride="carousel">
				<div class="fs-4 fw-bolder" style="margin-left: 10px">이벤트</div>
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselImageCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="첫번째 이미지"></button>
					<button type="button" data-bs-target="#carouselImageCaptions" data-bs-slide-to="1" aria-current="true" aria-label="두번째 이미지"></button>
					<button type="button" data-bs-target="#carouselImageCaptions" data-bs-slide-to="2" aria-current="true" aria-label="세번째 이미지"></button>
				</div>
				
				<div class="carousel-inner">
					<c:forEach var="dto" items="${eventList}" varStatus="status">
						
						<c:if test="${status.index % 3 == 0}">
							<c:set var="active" value="${status.index==0 ?'active':''}"/>
							<c:out value="<div class='carousel-item  ${active}'>" escapeXml="false"/>
								<c:out value="<div class='row '>" escapeXml="false"/>
						</c:if>
						
							<div class="col-4 p-4">
							<a href="${articleUrl2}&eveNum=${dto.eveNum}"
									title="${dto.eveTitle}" class="text"><img class="img-fluid img-thumbnail w-100 h-100 image"
									src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}" style="padding: 0; border: 0px;"></a>
							</div>
						<c:if test="${status.count % 3 == 0 || status.last }">
								<c:out value="</div>" escapeXml="false"/>
							<c:out value="</div>" escapeXml="false"/>
						</c:if>
						
					</c:forEach>

			</div>
			
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselImageCaptions" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselImageCaptions" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		
		</div>	
				</div>
				<br> <br>
				<div style="">
					<div style="padding-left: 10px;">
						<div class="fs-4 fw-bolder" style="margin-bottom: 5px;">공지사항</div>
					</div>
					<div class="body-main row">
						<form name="listForm" method="post">
							<c:forEach var="dto" items="${list}" varStatus="status">

								<c:if test="${status.index % 6 == 0}">
									<c:set var="active" value="${status.index==0 ?'active':''}" />
									<c:out value="<div class='carousel-item  ${active}'>"
										escapeXml="false" />
									<c:out value="<div class='row '>" escapeXml="false" />
								</c:if>

								<c:choose>
									<c:when test="${dto.category == '보도기사'}">
										<div class="col-3" style="float: left; margin: 19px; width: 30%; box-shadow: none;">
											<div class="sort" style=" font-size: 12px; background-color: #43FFE4; margin-bottom: 10px;">${dto.category}</div>
											<div style="font-weight: 600;margin-bottom: 10px; font-size: 20px;">
												<a href="${articleUrl}&boardNum=${dto.boardNum}"
													class="text-reset text-decoration-none">${dto.boSubject}</a>
											</div>
											<div class="date-div" style="color: gray; margin-bottom: 5px;">${dto.boDate}</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="col-3" style="float: left; margin: 19px; width: 30%; box-shadow: none;">
											<div class="sort" style=" font-size: 15px; background-color: #FFFF88;margin-bottom: 10px;">${dto.category}</div>
											<div style="font-weight: 600;margin-bottom: 10px; font-size: 20px;">
												<a href="${articleUrl}&boardNum=${dto.boardNum}"
													class="text-reset text-decoration-none">${dto.boSubject}</a>
											</div>
											<div class="date-div" style="color: gray; margin-bottom: 5px;">${dto.boDate}</div>
										</div>
									</c:otherwise>
								</c:choose>
								<c:if test="${status.count % 6 == 0 || status.last }">
									<c:out value="</div>" escapeXml="false" />
									<c:out value="</div>" escapeXml="false" />
								</c:if>

								

							</c:forEach>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
<div class="blue-box2"></div>
<script type="text/javascript">

		$(function() {
			let now = new Date();
			let y = now.getFullYear();
			let m = now.getMonth() + 1;
			let d = now.getDate();

			$("#busstaDate").attr("data-year", y);
			$("#busstaDate").attr("data-month", m);
			$("#busstaDate").attr("data-date", d);

			$("#busendDate").attr("data-year", y);
			$("#busendDate").attr("data-month", m);
			$("#busendDate").attr("data-date", d);

			let w = now.getDay(); // 요일 (0~6, 일~토)
			let week = [ '일', '월', '화', '수', '목', '금', '토' ]; // 자바스크립트에서 배열의 초기값을 줄 때

			let today = y + "." + m + "." + d + " " + week[w];

			$("#busstaDate").text(today);
			$("#busendDate").text(today);

		});

		$(function() {
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
			let week = [ '일', '월', '화', '수', '목', '금', '토' ]; // 자바스크립트에서 배열의 초기값을 줄 때

			let today = y + "." + m + "." + d + " " + week[w];

			$("#staDate").text(today);
			$("#endDate").text(today);
		});

		$(function() {
			$(".btn-busstaDate").click(function() {
				let now = new Date();
				let y5 = now.getFullYear();
				let m5 = now.getMonth() + 1;
				let d5 = now.getDate();
				
				let max = new Date(y5, m5-1, d5+10);
				
				let staDate = $("#busstaDate").text();
				let staDate2 = staDate.substring(0, staDate.length-2);
				let staArr = staDate2.split(".");
				
				let y = $("#busstaDate").attr("data-year");
				let m = $("#busstaDate").attr("data-month");
				let d = $("#busstaDate").attr("data-date");

				calendar3(y, m);
				
				$("td").each(function(index, item){
					let selDate = $(this).children().text();
					let selArr = selDate.split(".");
					let sel = new Date(selArr[0], selArr[1]-1, Number(selArr[2])+1);
					if(sel < now || sel >= max) {
						$(this).css({"background":"#e2e2e2", "color":"#ccc", "cursor": "default"});
						$(this).addClass("cntClick");
					}
				});
				
				$("#myDialogModal33").modal("show");

				$("#calendarLayout3 td").click(function() {
					if($(this).hasClass('cntClick')){
						alert("해당 날짜는 선택하실 수 없습니다.");
					} else {
						let selectTr = $(this).parent().find("td").index(this);
						let week = [ '일', '월', '화', '수', '목', '금', '토' ];
						let selectDate = $(this).children().text();
						selectDate = selectDate + " " + week[selectTr];
	
						$("#busstaDate").text(selectDate);
						let select2 = selectDate.substring(0, selectDate.length - 2);
						let select = select2.split(".");
						$("#busstaDate").attr("data-year",select[0]);
						$("#busstaDate").attr("data-month",select[1]);
						$("#busstaDate").attr("data-date",select[2]);
						
						if (!compareDate()) {
							$("#busendDate").text(selectDate);
							$("#busendDate").attr("data-year",select[0]);
							$("#busendDate").attr("data-month",select[1]);
							$("#busendDate").attr("data-date",select[2]);
						}
						$("#myDialogModal33").modal("hide");
					}
				});
					
				function compareDate() {
					let sy = $("#busstaDate").attr("data-year");
					let sm = $("#busstaDate").attr("data-month");
					let sd = $("#busstaDate").attr("data-date");
					
					let selDate = new Date(sy, sm-1, sd);
	
					let ey = $("#busendDate").attr("data-year");
					let em = $("#busendDate").attr("data-month");
					let ed = $("#busendDate").attr("data-date");
					
					let endDate = new Date(ey, em-1, ed);
	
					if (selDate < endDate) {
						return true;
					} else {
						return false;
					}
				}
			});
			$(".btn-busendDate").click(function() {
				let now = new Date();
				let y5 = now.getFullYear();
				let m5 = now.getMonth() + 1;
				let d5 = now.getDate();
					
				let max = new Date(y5, m5-1, d5+10);
					
				let endDate = $("#busendDate").text();
				let endDate2 = endDate.substring(0, endDate.length-2);
				let endArr = endDate2.split(".");
				
				let y = $("#busendDate").attr("data-year");
				let m = $("#busendDate").attr("data-month");
				let d = $("#busendDate").attr("data-date");

				calendar4(y, m);
				
				$("td").each(function(index, item){
					let selDate = $(this).children().text();
					let selArr = selDate.split(".");
					let sel = new Date(selArr[0], selArr[1]-1, Number(selArr[2])+1);
					if(sel < now || sel >= max) {
						$(this).css({"background":"#e2e2e2", "color":"#ccc", "cursor": "default"});
						$(this).addClass("cntClick");
					}
				});

				$("#myDialogModal44").modal("show");

				$("#calendarLayout4 td").click(function() {
					if($(this).hasClass('cntClick')){
						alert("해당 날짜는 선택하실 수 없습니다.");
					} else {
						let selectTr = $(this).parent().find("td").index(this);
						let week = [ '일', '월', '화', '수', '목', '금', '토' ];
						let selectDate = $(this).children().text();
						selectDate = selectDate + " " + week[selectTr];
	
						$("#busendDate").text(selectDate);
						let select2 = selectDate.substring(0, selectDate.length - 2);
						let select = select2.split(".");
						$("#busendDate").attr("data-year", select[0]);
						$("#busendDate").attr("data-month", select[1]);
						$("#busendDate").attr("data-date", select[2]);
						$("#myDialogModal44").modal("hide");
						
						if (!compareDate()) {
							$("#busstaDate").text(selectDate);
							$("#busstaDate").attr("data-year",select[0]);
							$("#busstaDate").attr("data-month",select[1]);
							$("#busstaDate").attr("data-date",select[2]);
						}
						$("#myDialogModal33").modal("hide");
					}
				});
				function compareDate() {
					let ey = $("#busendDate").attr("data-year");
					let em = $("#busendDate").attr("data-month");
					let ed = $("#busendDate").attr("data-date");
					
					let endDate = new Date(ey, em-1, ed);
	
					let sy = $("#busstaDate").attr("data-year");
					let sm = $("#busstaDate").attr("data-month");
					let sd = $("#busstaDate").attr("data-date");
					
					let staDate = new Date(sy, sm-1, sd);
	
					if (staDate < endDate) {
						return true;
					} else {
						return false;
					}
				}
			});
			
		});

		$(function() {
			$(".btn-staDate").click(function() {
				let now = new Date();
				let y5 = now.getFullYear();
				let m5 = now.getMonth() + 1;
				let d5 = now.getDate();
				
				let max = new Date(y5, m5-1, d5+10);
				
				let staDate = $("#staDate").text();
				let staDate2 = staDate.substring(0, staDate.length-2);
				let staArr = staDate2.split(".");
				
					
				let y = $("#staDate").attr("data-year");
				let m = $("#staDate").attr("data-month");
				let d = $("#staDate").attr("data-date");

				calendar1(y, m);
				
				$("td").each(function(index, item){
					let selDate = $(this).children().text();
					let selArr = selDate.split(".");
					let sel = new Date(selArr[0], selArr[1]-1, Number(selArr[2])+1);
					if(sel < now || sel >= max) {
						$(this).css({"background":"#e2e2e2", "color":"#ccc", "cursor": "default"});
						$(this).addClass("cntClick");
					}
				});
				$("#myDialogModal3").modal("show");

				$("#calendarLayout1 td").click(function() {
					if($(this).hasClass('cntClick')){
						alert("해당 날짜는 선택하실 수 없습니다.");
					} else {
						let selectTr = $(this).parent().find("td").index(this);
						let week = [ '일', '월', '화', '수', '목', '금', '토' ];
						let selectDate = $(this).children().text();
						selectDate = selectDate + " " + week[selectTr];
		
						$("#staDate").text(selectDate);
						let select2 = selectDate.substring(0, selectDate.length - 2);
						let select = select2.split(".");
						$("#staDate").attr("data-year",select[0]);
						$("#staDate").attr("data-month",select[1]);
						$("#staDate").attr("data-date",select[2]);
	
						if (!compareDate()) {
							$("#endDate").text(selectDate);
							$("#endDate").attr("data-year",select[0]);
							$("#endDate").attr("data-month",select[1]);
							$("#endDate").attr("data-date",select[2]);
						}
						$("#myDialogModal3").modal("hide");
					}				
				});
						
				function compareDate() {
					let sy = $("#staDate").attr("data-year");
					let sm = $("#staDate").attr("data-month");
					let sd = $("#staDate").attr("data-date");

					let ey = $("#endDate").attr("data-year");
					let em = $("#endDate").attr("data-month");
					let ed = $("#endDate").attr("data-date");

					if (ey >= sy && em >= sy && ed >= sd) {
						return true;
					}
					return false;
				}
			});
			$(".btn2-endDate").click( function() {
				let now = new Date();
				let y5 = now.getFullYear();
				let m5 = now.getMonth() + 1;
				let d5 = now.getDate();
					
				let max = new Date(y5, m5-1, d5+10);
					
				let endDate = $("#endDate").text();
				let endDate2 = endDate.substring(0, endDate.length-2);
				let endArr = endDate2.split(".");
					
				let y = $("#endDate").attr("data-year");
				let m = $("#endDate").attr("data-month");
				let d = $("#endDate").attr("data-date");

				calendar2(y, m);
					
				$("td").each(function(index, item){
					let selDate = $(this).children().text();
					let selArr = selDate.split(".");
					let sel = new Date(selArr[0], selArr[1]-1, Number(selArr[2])+1);
					if(sel < now || sel >= max) {
						$(this).css({"background":"#e2e2e2", "color":"#ccc", "cursor": "default"});
						$(this).addClass("cntClick");
					}
				});

				$("#myDialogModal4").modal("show");

				$("#calendarLayout2 td").click( function() {
					if($(this).hasClass('cntClick')){
						alert("해당 날짜는 선택하실 수 없습니다.");
					} else {
						let selectTr = $(this).parent().find("td").index(this);
						let week = [ '일', '월', '화', '수', '목', '금', '토' ];
						let selectDate = $(this).children().text();
						selectDate = selectDate + " " + week[selectTr];
						
						$("#endDate").text(selectDate);
						let select2 = selectDate.substring(0, selectDate.length - 2);
						let select = select2.split(".");
						$("#endDate").attr("data-year", select[0]);
						$("#endDate").attr("data-month", select[1]);
						$("#endDate").attr("data-date", select[2]);
						$("#myDialogModal4").modal("hide");
						
						if (!compareDate()) {
							$("#staDate").text(selectDate);
							$("#staDate").attr("data-year",select[0]);
							$("#staDate").attr("data-month",select[1]);
							$("#staDate").attr("data-date",select[2]);
						}
						$("#myDialogModal4").modal("hide");

					}
				});
				function compareDate() {
					let ey = $("#endDate").attr("data-year");
					let em = $("#endDate").attr("data-month");
					let ed = $("#endDate").attr("data-date");
					
					let endDate = new Date(ey, em-1, ed);
	
					let sy = $("#staDate").attr("data-year");
					let sm = $("#staDate").attr("data-month");
					let sd = $("#staDate").attr("data-date");
					
					let staDate = new Date(sy, sm-1, sd);
	
					if (staDate < endDate) {
						return true;
					} else {
						return false;
					}
				}

			});
		});


// ================캘린더

function calendar1(y, m) {
	let date = new Date(y, m - 1, 1); // y년 m월 1일의 Date 객체 생성
	y = date.getFullYear();
	m = date.getMonth() + 1;

	let w = date.getDay(); // 요일 (0~6, 일~토)
	let week = [ '일', '월', '화', '수', '목', '금', '토' ]; // 자바스크립트에서 배열의 초기값을 줄 때

	// 시스템 오늘 날짜
	let now = new Date();
	let ny = now.getFullYear();
	let nm = now.getMonth() + 1;
	let nd = now.getDate();

	let out = '<div id="calendarLayout1">';
	out += '<div class="subject">';
	out += '<span class="lr" onclick="calendar1(' + y + ',' + (m - 1) + ')">&lt;</span>&nbsp;&nbsp;';
	out += '<label>' + y + '년 ' + m + '월</label>&nbsp;&nbsp;';
	out += '<span onclick="calendar1(' + y + ',' + (m + 1) +')">&gt;</span>';
	out += '</div>';

	out += '<table class="table td-border">';
	out += '<tr>';
	for (let i = 0; i < week.length; i++) {
		out += '<td style="background: #0E6EFD; color: white; border: 1px solid #0E6EFD">'
				+ week[i] + '</td>';
	}
	out += '</tr>';

	// 무조건 6주로 만들기
	let row = 1; // 주 수

	// 1일 앞부분 : 이전달
	let preDate = new Date(y, m - 1, 0); // 이전달의 마지막 날짜로 Date 객체 생성
	let pLastDay = preDate.getDate(); // 이전달의 마지막 날짜
	let pDay = pLastDay - w;

	out += '<tr>';
	for (let i = 0; i < w; i++) {
		let y2 = y;
		let m2 = m - 1;
		if (nm === 1) {
			y2 = y - 1;
			m2 = 12;
		}
		let date = new Date(y2, m2, pDay - 1);
		let w = date.getDay();
		let week = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++pDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y2 + '.' + m2 + '.' + pDay + '</span>' + '</td>';
	}

	let cls;
	let lastDay = (new Date(y, m, 0)).getDate();
	for (let i = 1; i <= lastDay; i++) {

		cls = y === ny && m === nm && i === nd ? ' today ' : '';

		let date = new Date(y, m, i);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];

		out += '<td class="'+cls+' clsClass">'
				+ i
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y + '.' + m + '.' + i + '</span>' + '</td>';
		if (i !== lastDay && ++w % 7 === 0) {
			row++;
			out += '</tr><tr>';
		}
	}
	// 마지막 날짜 뒷부분
	let nDay = 0;
	for (let i = w % 7; i < 6; i++) {
		let y3 = ny;
		let m3 = nm + 1;
		if (nm === 12) {
			y3 = ny + 1;
			m3 = 1;
		}
		let date = new Date(y3, m3, nDay + 1);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++nDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
	}
	out += '</tr>';
	// 한달은 최대 6주
	for (let i = row; i < 6; i++) {
		out += '<tr>';
		for (let j = 0; j < 7; j++) {
			let y3 = ny;
			let m3 = nm + 1;
			if (nm === 12) {
				y3 = ny + 1;
				m3 = 1;
			}
			let date = new Date(y3, m3, nDay + 1);
			let w2 = date.getDay();
			let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
			out += '<td class="gray">'
					+ (++nDay)
					+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
					+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
		}
		out += '</tr>';
	}
	
	out += '</table></div>';

	let selector = "#depDate";
	document.querySelector(selector).innerHTML = out;
}

function calendar2(y, m) {
	let date = new Date(y, m - 1, 1); // y년 m월 1일의 Date 객체 생성
	y = date.getFullYear();
	m = date.getMonth() + 1;

	let w = date.getDay(); // 요일 (0~6, 일~토)
	let week = [ '일', '월', '화', '수', '목', '금', '토' ]; // 자바스크립트에서 배열의 초기값을 줄 때

	// 시스템 오늘 날짜
	let now = new Date();
	let ny = now.getFullYear();
	let nm = now.getMonth() + 1;
	let nd = now.getDate();

	let out = '<div id="calendarLayout2">';
	out += '<div class="subject">';
	out += '<span class="lr" onclick="calendar2(' + y + ',' + (m - 1) + ')">&lt;</span>&nbsp;&nbsp;';
	out += '<label>' + y + '년 ' + m + '월</label>&nbsp;&nbsp;';
	out += '<span onclick="calendar2(' + y + ',' + (m + 1) +')">&gt;</span>';
	out += '</div>';

	out += '<table class="table td-border">';
	out += '<tr>';
	for (let i = 0; i < week.length; i++) {
		out += '<td style="background: #0E6EFD; color: white; border: 1px solid #0E6EFD">'
				+ week[i] + '</td>';
	}
	out += '</tr>';

	// 무조건 6주로 만들기
	let row = 1; // 주 수

	// 1일 앞부분 : 이전달
	let preDate = new Date(y, m - 1, 0); // 이전달의 마지막 날짜로 Date 객체 생성
	let pLastDay = preDate.getDate(); // 이전달의 마지막 날짜
	let pDay = pLastDay - w;

	out += '<tr>';
	for (let i = 0; i < w; i++) {
		let y2 = y;
		let m2 = m - 1;
		if (nm === 1) {
			y2 = y - 1;
			m2 = 12;
		}
		let date = new Date(y2, m2, pDay - 1);
		let w = date.getDay();
		let week = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++pDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y2 + '.' + m2 + '.' + pDay + '</span>' + '</td>';
	}

	let cls;
	let lastDay = (new Date(y, m, 0)).getDate();
	for (let i = 1; i <= lastDay; i++) {

		cls = y === ny && m === nm && i === nd ? ' today ' : '';

		let date = new Date(y, m, i);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];

		out += '<td class="'+cls+' clsClass">'
				+ i
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y + '.' + m + '.' + i + '</span>' + '</td>';
		if (i !== lastDay && ++w % 7 === 0) {
			row++;
			out += '</tr><tr>';
		}
	}
	// 마지막 날짜 뒷부분
	let nDay = 0;
	for (let i = w % 7; i < 6; i++) {
		let y3 = ny;
		let m3 = nm + 1;
		if (nm === 12) {
			y3 = ny + 1;
			m3 = 1;
		}
		let date = new Date(y3, m3, nDay + 1);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++nDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
	}
	out += '</tr>';
	// 한달은 최대 6주
	for (let i = row; i < 6; i++) {
		out += '<tr>';
		for (let j = 0; j < 7; j++) {
			let y3 = ny;
			let m3 = nm + 1;
			if (nm === 12) {
				y3 = ny + 1;
				m3 = 1;
			}
			let date = new Date(y3, m3, nDay + 1);
			let w2 = date.getDay();
			let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
			out += '<td class="gray">'
					+ (++nDay)
					+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
					+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
		}
		out += '</tr>';
	}

	out += '</table></div>';

	let selector = "#desDate";
	document.querySelector(selector).innerHTML = out;
}

function calendar3(y, m, mode) {
	let date = new Date(y, m - 1, 1); // y년 m월 1일의 Date 객체 생성
	y = date.getFullYear();
	m = date.getMonth() + 1;

	let w = date.getDay(); // 요일 (0~6, 일~토)
	let week = [ '일', '월', '화', '수', '목', '금', '토' ]; // 자바스크립트에서 배열의 초기값을 줄 때

	// 시스템 오늘 날짜
	let now = new Date();
	let ny = now.getFullYear();
	let nm = now.getMonth() + 1;
	let nd = now.getDate();

	let out = '<div id="calendarLayout3">';
	out += '<div class="subject">';
	out += '<span class="lr" onclick="calendar3(' + y + ',' + (m - 1) + ')">&lt;</span>&nbsp;&nbsp;';
	out += '<label>' + y + '년 ' + m + '월</label>&nbsp;&nbsp;';
	out += '<span onclick="calendar3(' + y + ',' + (m + 1) +')">&gt;</span>';
	out += '</div>';

	out += '<table class="table td-border">';
	out += '<tr>';
	for (let i = 0; i < week.length; i++) {
		out += '<td style="background: #0E6EFD; color: white; border: 1px solid #0E6EFD">'
				+ week[i] + '</td>';
	}
	out += '</tr>';

	// 무조건 6주로 만들기
	let row = 1; // 주 수

	// 1일 앞부분 : 이전달
	let preDate = new Date(y, m - 1, 0); // 이전달의 마지막 날짜로 Date 객체 생성
	let pLastDay = preDate.getDate(); // 이전달의 마지막 날짜
	let pDay = pLastDay - w;

	out += '<tr>';
	for (let i = 0; i < w; i++) {
		let y2 = y;
		let m2 = m - 1;
		if (nm === 1) {
			y2 = y - 1;
			m2 = 12;
		}
		let date = new Date(y2, m2, pDay - 1);
		let w = date.getDay();
		let week = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++pDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y2 + '.' + m2 + '.' + pDay + '</span>' + '</td>';
	}

	let cls;
	let lastDay = (new Date(y, m, 0)).getDate();
	for (let i = 1; i <= lastDay; i++) {

		cls = y === ny && m === nm && i === nd ? ' today ' : '';

		let date = new Date(y, m, i);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];

		out += '<td class="'+cls+' clsClass">'
				+ i
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y + '.' + m + '.' + i + '</span>' + '</td>';
		if (i !== lastDay && ++w % 7 === 0) {
			row++;
			out += '</tr><tr>';
		}
	}
	// 마지막 날짜 뒷부분
	let nDay = 0;
	for (let i = w % 7; i < 6; i++) {
		let y3 = ny;
		let m3 = nm + 1;
		if (nm === 12) {
			y3 = ny + 1;
			m3 = 1;
		}
		let date = new Date(y3, m3, nDay + 1);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++nDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
	}
	out += '</tr>';
	// 한달은 최대 6주
	for (let i = row; i < 6; i++) {
		out += '<tr>';
		for (let j = 0; j < 7; j++) {
			let y3 = ny;
			let m3 = nm + 1;
			if (nm === 12) {
				y3 = ny + 1;
				m3 = 1;
			}
			let date = new Date(y3, m3, nDay + 1);
			let w2 = date.getDay();
			let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
			out += '<td class="gray">'
					+ (++nDay)
					+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
					+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
		}
		out += '</tr>';
	}

	out += '</table></div>';

	let selector = "#bus-depDate";
	document.querySelector(selector).innerHTML = out;
}

function calendar4(y, m) {
	let date = new Date(y, m - 1, 1); // y년 m월 1일의 Date 객체 생성
	y = date.getFullYear();
	m = date.getMonth() + 1;

	let w = date.getDay(); // 요일 (0~6, 일~토)
	let week = [ '일', '월', '화', '수', '목', '금', '토' ]; // 자바스크립트에서 배열의 초기값을 줄 때

	// 시스템 오늘 날짜
	let now = new Date();
	let ny = now.getFullYear();
	let nm = now.getMonth() + 1;
	let nd = now.getDate();

	let out = '<div id="calendarLayout4">';
	out += '<div class="subject">';
	out += '<span class="lr" onclick="calendar4(' + y + ',' + (m - 1) + ')">&lt;</span>&nbsp;&nbsp;';
	out += '<label>' + y + '년 ' + m + '월</label>&nbsp;&nbsp;';
	out += '<span onclick="calendar4(' + y + ',' + (m + 1) +')">&gt;</span>';
	out += '</div>';

	out += '<table class="table td-border">';
	out += '<tr>';
	for (let i = 0; i < week.length; i++) {
		out += '<td style="background: #0E6EFD; color: white; border: 1px solid #0E6EFD">'
				+ week[i] + '</td>';
	}
	out += '</tr>';

	// 무조건 6주로 만들기
	let row = 1; // 주 수

	// 1일 앞부분 : 이전달
	let preDate = new Date(y, m - 1, 0); // 이전달의 마지막 날짜로 Date 객체 생성
	let pLastDay = preDate.getDate(); // 이전달의 마지막 날짜
	let pDay = pLastDay - w;

	out += '<tr>';
	for (let i = 0; i < w; i++) {
		let y2 = y;
		let m2 = m - 1;
		if (nm === 1) {
			y2 = y - 1;
			m2 = 12;
		}
		let date = new Date(y2, m2, pDay - 1);
		let w = date.getDay();
		let week = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++pDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y2 + '.' + m2 + '.' + pDay + '</span>' + '</td>';
	}

	let cls;
	let lastDay = (new Date(y, m, 0)).getDate();
	for (let i = 1; i <= lastDay; i++) {

		cls = y === ny && m === nm && i === nd ? ' today ' : '';

		let date = new Date(y, m, i);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];

		out += '<td class="'+cls+' clsClass">'
				+ i
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y + '.' + m + '.' + i + '</span>' + '</td>';
		if (i !== lastDay && ++w % 7 === 0) {
			row++;
			out += '</tr><tr>';
		}
	}
	// 마지막 날짜 뒷부분
	let nDay = 0;
	for (let i = w % 7; i < 6; i++) {
		let y3 = ny;
		let m3 = nm + 1;
		if (nm === 12) {
			y3 = ny + 1;
			m3 = 1;
		}
		let date = new Date(y3, m3, nDay + 1);
		let w2 = date.getDay();
		let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
		out += '<td class="gray">'
				+ (++nDay)
				+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
				+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
	}
	out += '</tr>';
	// 한달은 최대 6주
	for (let i = row; i < 6; i++) {
		out += '<tr>';
		for (let j = 0; j < 7; j++) {
			let y3 = ny;
			let m3 = nm + 1;
			if (nm === 12) {
				y3 = ny + 1;
				m3 = 1;
			}
			let date = new Date(y3, m3, nDay + 1);
			let w2 = date.getDay();
			let week2 = [ ' 일', ' 월', ' 화', ' 수', ' 목', ' 금', ' 토' ];
			out += '<td class="gray">'
					+ (++nDay)
					+ '<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'
					+ y3 + '.' + m3 + '.' + nDay + '</span>' + '</td>';
		}
		out += '</tr>';
	}

	out += '</table></div>';

	let selector = "#bus-desDate";
	document.querySelector(selector).innerHTML = out;
}
</script>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>