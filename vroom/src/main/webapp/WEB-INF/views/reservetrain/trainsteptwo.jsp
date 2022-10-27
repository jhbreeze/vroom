<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 기차예매</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container { min-height: 900px; }
tr { font-size: 15px; }

tr:hover { background: #fff; box-shadow: 0px 0px 4px rgb(72, 92, 161, 0.4); }

.trainNum { font-size: 15px;}
.date-th { width: 100px; }
.date-div { font-size: 12px; line-height: 20.5px; }
.takeTime, arrow { width: 100%; color: #727272; margin: auto; }
.right{ text-align: left; }
.arrow { color: #727272; }
.ktx-td { width: 13% }
.train-td{ width: 8% }
.reserve-table { width: 100%; height: 500px; margin: 30px auto; overflow: scroll; }
.table { width: 78%; margin: 5px auto; }
.trainNum { margin-left: 5%; }
.destinationTime, .destination { text-align: right }
.top-section { width: 70%; margin: 50px auto 0; }
.small-arrow { color: #0E6EFD; } 
.small-arrow:hover { color: #0D5ED7; } 
.next-btn:disabled { background: #9B9B9B; border-color: #9B9B9B; }
</style>

<script type="text/javascript">
/* //오늘 날짜이면 왼쪽 화살표를 막음
$(function(){
	let now = new Date();
	let a = $("#selected-date").text();
	let b = a.trim().slice(0,-1);
	let sdArr = b.split(".");
	let sy = sdArr[0];
	let sm = sdArr[1];
	let sd = sdArr[2];
	
	let date = new Date(sy, sm-1, sd-1);
	console.log(date);
	if(date < now){
		$("#left-arrow").hide();
	} else {
		$("#left-arrow").show();
	}
});

// 오늘 날짜포함 +10일 경우 오른쪽 화살표를 막음
$(function(){
	let now = new Date();
	let y = now.getFullYear();
	let m = now.getMonth() + 1;
	let d = now.getDate();
	let max = new Date(y, m-1, Number(d)+9);
	
	let a = $("#selected-date").text();
	let b = a.trim().slice(0,-1);
	let sdArr = b.split(".");
	let sy = sdArr[0];
	let sm = sdArr[1];
	let sd = sdArr[2];
	
	let date = new Date(sy, sm-1, sd);
	if(date >= max){
		$("#right-arrow").hide();
	} else {
		$("#right-arrow").show();
	}
}); */
// 왼쪽 버튼을 누를 경우
$(function(){
	$("#left-arrow").click(function(){
		// 날짜 바꿈	
		let selectDate = $("#selected-date").text();
		let sDate = selectDate.trim().slice(0,-1);
		let sdArr = sDate.split(".");
		let sy = sdArr[0];
		let sm = sdArr[1];
		let sd = sdArr[2];
		let date = new Date(sy, sm-1, sd-1);
		sy = date.getFullYear();
		sm = date.getMonth()+1;
		sd = date.getDate();
		sDay = date.getDay();
		let week = ['일','월','화','수','목','금','토'];
		
		let selectedDate = sy+"."+sm+"."+sd+" "+week[sDay];
		$("#selected-date").text(selectedDate);
		
		// 왼쪽 버튼을 누를 경우 서버 갔다와서 다시 뿌림
		url = "${pageContext.request.contextPath}/reservetrain/reloadsteptwolist.do";
		let selector = "#trainst2List";
		let query = "";
		const fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	});
});

// 오른쪽 버튼을 누를 경우
$(function(){
	$("#right-arrow").click(function(){
		// 날짜 바꿈
		let selectDate = $("#selected-date").text();
		let sDate = selectDate.trim().slice(0,-1);
		let sdArr = sDate.split(".");
		let sy = sdArr[0];
		let sm = sdArr[1];
		let sd = sdArr[2];
		let date = new Date(sy, sm-1, Number(sd)+1);
		sy = date.getFullYear();
		sm = date.getMonth()+1;
		sd = date.getDate();
		sDay = date.getDay();
		let week = ['일','월','화','수','목','금','토'];
		
		let selectedDate = sy+"."+sm+"."+sd+" "+week[sDay];
		$("#selected-date").text(selectedDate);
		
		// 오른쪽 버튼을 누를 경우 서버 갔다와서 다시 뿌림
		listPage();
	});
});

// 처음에 페이지가 시작하는 곳
$(function(){
	listPage();
});

function listPage(){
	url = "${pageContext.request.contextPath}/reservetrain/reloadsteptwolist.do";
	let selector = "#trainst2List";
	let query = "";
	const fn = function(data){
		$(selector).html(data);
		
		let selectDate = $("#selected-date").text();
		let sDate = selectDate.trim().slice(0,-1);
		let sdArr = sDate.split(".");
		let sy = sdArr[0];
		let sm = sdArr[1];
		let sd = sdArr[2];
		
		let date = new Date();
		let ny = date.getFullYear();
		let nm = date.getMonth()+1;
		let nd = date.getDate();
		
		let nh = date.getHours();
		let nM = date.getMinutes();
		
		// 날짜가 같으면 시간비교를 해서 disalbed하기
		if(sy==ny&&sm==nm&&sd==nd){ 
			$("#trainst2List .times").each(function(index, item){
				let t = $(item).attr("data-tStaTime");
				let nTime = nh*100+nM;
				
				let tArr = t.split(":");
				let th = Number(tArr[0]);
				let tm = Number(tArr[1])+30;
				if(tm > 60){
					th = th + 1;
					tm = tm - 60;
				}
				let tTime = th*100+tm;
				if(nTime > tTime){
					$(item).find(".next-btn").prop("disabled", true);
				}
			});
		}
	};
	ajaxFun(url, "get", query, "html", fn);
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403){
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}
// 가는날, 오는날 판별 / selected-date에 (staDate / endDate) 판별

</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="reserveTrain-top">
	    	<div class="top-section d-flex justify-content-between">
		    	<p class="fw-bold fs-4" id="title-when">가는날</p>
		    	<div class="reserveTrain-date">
		    		<a class="small-arrow" id="left-arrow"><i class="bi bi-caret-left-fill" style="width: 20px;"></i></a>
		    		<span class="fw-bold fs-5" id="selected-date">${staDate}</span>
		    		<a class="small-arrow" id="right-arrow"><i class="bi bi-caret-right-fill" style="width: 20px;"></i></a>
		    	</div>
	    	</div>
		    <div class="reserve-table" id="trainst2List">
		    
		    
		    
			</div>
	    	
	    </div>
	</div>
</main>
<form name="">
	<input type="hidden" name="staDateTime">
	<input type="hidden" name="endDateTIme">
</form>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>