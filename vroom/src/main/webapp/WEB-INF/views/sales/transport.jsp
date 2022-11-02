<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 매출내역</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<script src="https://code.highcharts.com/highcharts.js"></script>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container { min-height: 900px; width: 600px; }
.chart-container {
	padding: 5px;
}
.chart-header {
	text-align: center;
	padding: 10px;
	font-size: 15px;
}
.chart-header .disp-date {
	font-weight: 600;
}
.chart-area {
	display: inline-block;
	width: 405px; height: 405px;
	border: 1px solid gray;
	margin: 5px;
}
#countData { color: #0E6EFD; text-align: center; } 
select {margin-right: 5px;}
</style>

<script type="text/javascript">

$(document).ready(function () {
    setDateBox();
});

function setDateBox() {
	let now = new Date();
	let year = "";
	let com_year = now.getFullYear();

    $("#year").append("<option>년도</option>");

    for (let y = 2020; y < (com_year + 1); y++) {
		$("#year").append("<option value='" + y + "' >" + y + " 년" + "</option>");
    }

    $("#month").append("<option>월</option>");
    for (let i = 1; i <= 12; i++) {
		$("#month").append("<option value='" + i + "'>" + i + " 월" + "</option>");
    }

    $("#date").append("<option>일</option>");
    for (let i = 1; i <= 31; i++) {
		$("#date").append("<option value='" + i + "'>" + i + " 일" + "</option>");
    }
    
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

$(function(){
	searchList();
	// getData();
})
	
function searchList(){
	let mode = $("select[name=mode]").val();
	let tORb = $("select[name=tORb]").val();
	let year = $("select[name=year]").val();
	let month = $("select[name=month]").val();
	let date = $("select[name=date]").val();
	
	let url = "${pageContext.request.contextPath}/sales/transport_ok.do?"
	let query = "mode="+mode+"&tORb="+tORb+"&year="+year+"&month="+month+"&date="+date;
	const fn = function(data){
		$("#table-insert").html(data);
		let count = $("input[name=count]").val();
		if(count > 0){
			let statement = count + "개의 검색 결과";
			$("#countData").text(statement);
		} else {
			let statement = "검색된 결과가 없습니다."
			$("#countData").text(statement);
		}
		
	}
	ajaxFun(url, "get", query, "html", fn);
}
/* function getData(){
	let mode = $("select[name=mode]").val();
	let tORb = $("select[name=tORb]").val();
	let year = $("select[name=year]").val();
	let month = $("select[name=month]").val();
	let date = $("select[name=date]").val();
	
	let url = "${pageContext.request.contextPath}/sales/transdata.do";
	let query = "mode="+mode+"&tORb="+tORb+"&year="+year+"&month="+month+"&date="+date;
	
	const fn = function(data){
		printJSON(data);
	}
	ajaxFun(url, "get", query, "json", fn);
}
function printJSON(data){
	let row;
	let value;
	row = data.dateArr.join();
	value = data.priceArr.join();
	chartsBar(row, value);
}
function chartsBar(row, value) {
	Highcharts.chart('chart-bar', {
	
	    title: {
	        text: '매출 및 환불'
	    },
	
	    subtitle: {
	        text: 'Source: <a href="https://irecusa.org/programs/solar-jobs-census/" target="_blank">IREC</a>'
	    },
	
	    yAxis: {
	        title: {
	            text: 'Number of Employees'
	        }
	    },
	
	    xAxis: {
	        accessibility: {
	            rangeDescription: 'Range: 2010 to 2020'
	        }
	    },
	
	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'middle'
	    },
	
	    plotOptions: {
	        series: {
	            label: {
	                connectorAllowed: false
	            },
	            pointStart: 2010
	        }
	    },
	
	    series: [{
	        name: 'Installation & Developers',
	        data: [43934, 48656, 65165, 81827, 112143, 142383,
	            171533, 165174, 155157, 161454, 154610]
	    }, {
	        name: 'Manufacturing',
	        data: [24916, 37941, 29742, 29851, 32490, 30282,
	            38121, 36885, 33726, 34243, 31050]
	    }, {
	        name: 'Sales & Distribution',
	        data: [11744, 30000, 16005, 19771, 20185, 24377,
	            32147, 30912, 29243, 29213, 25663]
	    }, {
	        name: 'Operations & Maintenance',
	        data: [null, null, null, null, null, null, null,
	            null, 11164, 11218, 10077]
	    }, {
	        name: 'Other',
	        data: [21908, 5548, 8105, 11248, 8989, 11816, 18274,
	            17300, 13053, 11906, 10073]
	    }],
	
	    responsive: {
	        rules: [{
	            condition: {
	                maxWidth: 500
	            },
	            chartOptions: {
	                legend: {
	                    layout: 'horizontal',
	                    align: 'center',
	                    verticalAlign: 'bottom'
	                }
	            }
	        }]
	    }
	
	});
} */
</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container" >
		<div class="body-title mb-4">
			<div class="fs-4 fw-bolder">매출정보</div>
		</div>

		<div class="mb-3">
			<form class="d-flex justify-content-start" name="searchForm" action="${pageContext.request.contextPath}/sales/transport.do"
				method="post">
				<div class="col-auto p-1 d-flex justify-content-start">
					<select name="mode" class="form-select form-select-sm" id="mode" style="width: 100px">
						<option value="구매내역">구매내역</option>
						<option value="환불내역">환불내역</option>
					</select>
					<select name="tORb" class="form-select form-select-sm" id="tORb" style="width: 80px">
						<option value="기차">기차</option>
						<option value="버스">버스</option>
					</select>
					<select name="year" class="form-select form-select-sm" id="year" style="width: 100px">
						
					</select>
					<select name="month" class="form-select form-select-sm" id="month" style="width: 80px">
						
					</select>
					<select name="date" class="form-select form-select-sm" id="date" style="width: 80px">
					</select>
				</div>
				<div class="col-auto p-1">
					<button type="button" class="btn btn-primary btn-sm" onclick="searchList()">검색</button>
					<button type="button" class="btn btn-primary btn-sm"
						onclick="location.href='${pageContext.request.contextPath}/sales/transport.do'">새로고침</button>
				</div>
			</form>
		</div>
		<div style="width: 600px; max-height: 500px; overflow: scroll;">
			<table class="table">
				<thead class="table-primary text-center">
					<tr>
						<th style="width: 300px;">매출일자</th>
						<th style="width: 300px;">금액</th>
					</tr>
				</thead>
				<tbody class="text-center" id="table-insert">
					
				</tbody>
			</table>
		</div>
		<div id="countData">
			
		</div>
		<!-- <div class="chart-body">
			<div id="chart-bar" class="chart-area"></div>
		</div> -->
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>