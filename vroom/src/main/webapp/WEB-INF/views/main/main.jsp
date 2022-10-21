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
function selectDep(){
	var radioText = $("input[name=radio2]:checked").next("label").text();
	var radioValue = $("input[name=radio2]:checked").val();
	$("#departure").text(radioText);
	$("#departure").val(radioValue);
	$("#myDialogModal1").modal("hide");
};
function selectDes(){
	var radioText = $("input[name=radio3]:checked").next("label").text();
	var radioValue = $("input[name=radio3]:checked").val();
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
	var resultCount = "";
	var adultCountResult = $("#aCountResult").text();
	var childCountResult = $("#cCountResult").text();
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

$(function(){
	let today = $("#depDate .today").children().text();
	$("#staDate").text(today);
	$("#endDate").text(today);
	$("#depDate td").click(function(){
		let depDate = $(this).children().text();
		$("#staDate").text(depDate);
		$("#myDialogModal3").modal("hide");
	});
});
/* $(function(){
	// $("#date1").datepicker();
	$("#staDate").datepicker({
		showMonthAfterYear:true
	});
});

$(function(){
	$("#endDate").datepicker({
		showMonthAfterYear:true
		,defaultDate:"2021-05-03"
		//,minDate:0, maxDate:"+5D" // 기준 날짜에서 -5, +5만 선택 가능
		//,minDate:-5, maxDate:"+1M +5D"
		,minDate:"2021-05-01", maxDate:"2021-05-10"
	});
}); */
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
<form name="reserveForm" method="post">
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
		
		
			<div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
				버스 부분
			</div>
			
			
			<div class="tab-pane fade train-container justify-content-center" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
				<span id="changeButton" style="width: 30px; height: 30px; border-radius: 30px; left: 170px; top: 70px; padding: auto; padding-left: 7px; padding-top: 3px; z-index: 300;"><i class="bi bi-arrow-left-right"></i></span>
				<div class="btn-goup row row-cols-3 text-dark text-center" style="margin: 0px;" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
  					<label class="col-3 btn btn-outline-primary" id="half" for="btnradio1" style="margin: 2px; width: 24%; border: none; font-weight: 600;"><span>편 도</span></label>
					
					<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
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
						<button type="button" class="btn select-date position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal3">
						  	<div class="small-text">가는날</div>
						  	<div class="middle-hilight-text" id="staDate"></div>
					 	 </button>
						<button type="button" class="btn select-date2 position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal4">
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
			</div>
		</div>

	</div>
</form>


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
        			<jsp:include page="/WEB-INF/views/util/calendar.jsp"></jsp:include>
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
        			<jsp:include page="/WEB-INF/views/util/calendar.jsp"></jsp:include>
        		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>

<main>
	<div class="container body-container">
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>