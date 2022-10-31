<%@page import="java.util.List"%>
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
main { position: relative; top: -55px; background: white; }
.container { min-height: 900px; }
#ho-select { width: 300px; text-align: center; border-radius: 40px; }
.top-section { margin: 40px 0 0 0; width: 80px; }
.top-section-btn{margin: 40px 0 0 0}
#ho-select:hover { cursor: pointer; }
.form_check_btn {
	width: 80px; height: 80px;
	border-radius: 10px; background: white; margin: 3px;
}
.form_check_btn input[type=checkbox] { display: none; }
.form_check_btn label {
	display: block; border-radius: 10px; margin: 0 auto; text-align: center; color: #9B9B9B;
	
	/* height: -webkit-fill-available; line-height: 60px; */ }
.form_check_btn input[type=checkbox]:checked+label { background: #0E6EFD; color: white; }
#choice-seats2 .form_check_btn input[type=checkbox]:checked+label { background: #0E6EFD; color: white; }
.form_check_btn label:hover { color: #666; cursor: pointer; }
.form_check-btn input[type=checkbox]+label { background: white; color: #DEDEDE; }
.aisle { width: 80px; height: 60px; background: #D6D9DE; }
#choice-seats1, #choice-seats2 { background: #D6D9DE; width: 80%; height: 500px; 
	border-radius: 20px; margin: 30px auto; overflow: scroll;  }
.form_toggle { margin: 0 auto; }
.direction { position: relative; top: 8px; font-size: 14px; }
.inner-text { position: relative; top: 15px; font-size: 20px; }
.aisle { padding-top: 30px }
.form_check_btn input[type=checkbox]:disabled+label { background: #A2A6AD; color: white; }
#div-seats-count { margin: 0 auto; color: #0E6EFD; text-align: center; }
</style>
<script type="text/javascript">
$(function(){
	let grade = $("input[name=grade]").val();
	
	// 사전에 선택한 인원수보다 더 많이 골랐을 경우 alert창을 띄움
	let count = $("input[name=count]").val();
	
	$("#seatForm-div").on("click", "#choice-seats2 input[name=seats]", function(){
		let check = $("#choice-seats2 input[name=seats]:checked").length; // 체크된 좌석 개수
		$("#selected-count").text(check);	
		
		// 사전에 선택한 인원수보다 더 많이 골랐을 경우 alert창을 띄움
		if(count < check) {
			alert("이미 모두 선택하셨습니다.");
			$(this).prop("checked", false);
			$("#selected-count").text(check-1);
		}
	});
	$("#seatForm-div").on("click", "#choice-seats1 input[name=seats]", function(){
		let check = $("#choice-seats1 input[name=seats]:checked").length; // 체크된 좌석 개수
		$("#selected-count").text(check);	
		
		// 사전에 선택한 인원수보다 더 많이 골랐을 경우 alert창을 띄움
		if(count < check) {
			alert("이미 모두 선택하셨습니다.");
			$(this).prop("checked", false);
			$("#selected-count").text(check-1);
		}
	});
});

function direction(){
	let cycle = $("input[name=cycle]").val();
	let statDiscern = $("input[name=statDiscern]").val();
	let endtDiscern = $("input[name=endtDiscern]").val();
	let hORf = $("input[name=hORf]").val();
	let tDiscern = $("input[name=tDiscern]").val();
	
	if(cycle==="half"){
		if(tDiscern==="하행") {
			let arrow = "<i class='bi bi-caret-down-fill' style='color: white;'></i>";
			$(".aisle").html(arrow);
			$(".direction1").text("역방향");
			$(".direction2").text("순방향");
		} else if(tDiscern==="상행") {
			let arrow = "<i class='bi bi-caret-up-fill' style='color: white;'></i>";
			$(".aisle").html(arrow);
			$(".direction1").text("순방향");
			$(".direction2").text("역방향");
		}
	} else if(cycle==="full"){
		if(hORf==="1"&&statDiscern==="하행"){
			$("#sORn").text("가는날 ");
			let arrow = "<i class='bi bi-caret-down-fill' style='color: white;'></i>";
			$(".aisle").html(arrow);
			$(".direction1").text("역방향");
			$(".direction2").text("순방향");
		} else if(hORf==="1"&&statDiscern==="상행"){
			$("#sORn").text("가는날 ");
			let arrow = "<i class='bi bi-caret-up-fill' style='color: white;'></i>";
			$(".aisle").html(arrow);
			$(".direction1").text("순방향");
			$(".direction2").text("역방향");
		} else if(hORf==="2"&&endtDiscern==="하행"){
			$("#sORn").text("오는날 ");
			let arrow = "<i class='bi bi-caret-down-fill' style='color: white;'></i>";
			$(".aisle").html(arrow);
			$(".direction1").text("역방향");
			$(".direction2").text("순방향");
		} else if(hORf==="2"&&endtDiscern==="상행"){
			$("#sORn").text("오는날 ");
			let arrow = "<i class='bi bi-caret-up-fill' style='color: white;'></i>";
			$(".aisle").html(arrow);
			$(".direction1").text("순방향");
			$(".direction2").text("역방향");
		}
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

// 호차를 눌렀을 때 다시 서버 갔다오도록 함
$(function(){
	listSeats(null);
	
	// 선택 완료 눌렀을 떼
	$("body").on("click", "#select-complete", function(){
		let hORf = $("input[name=hORf]").val();
		let count = $("input[name=count]").val();
		let cycle = $("input[name=cycle]").val();
		let grade = $("option:checked").attr("data-hoDiv");
		
		let selectedArr = [];
		$("input[name=seats]:checked").each(function(){
			let selected = $(this).next("label").find(".inner-text").text();
			selectedArr.push(selected);
		});
		$("input[name=selSeats]").attr("data-selSeats", selectedArr.join());
		
		if(selectedArr.length < count) {
			alert("선택하신 좌석 수가 모자랍니다.");
			return false;
		};
		
		let url = "${pageContext.request.contextPath}/reservetrain/beforePay.do?";
		let query = "";
		
		if(cycle==='half') {
			$("input[name=selSeats]").attr("data-selSeats", selectedArr.join());
			let selGrade = $("input[name=gradetHoNum]").val();
			let selTHoNum = $("option:selected").val();
			
			let tDiscern = $("input[name=tDiscern]").val();
			let staDate = $("input[name=staDate]").val();
			let tStaTime = $("input[name=tStaTime]").val();
			let tEndTime = $("input[name=tEndTime]").val();
			let tOperCode = $("input[name=tOperCode]").val();
			let statDetailCode = $("input[name=statDetailCode]").val();
			let endtDetailCode = $("input[name=endtDetailCode]").val();
			let selSeats = $("input[name=selSeats]").attr("data-selSeats");
			
			query = "tDiscern="+tDiscern+"&staDate="+staDate+"&tStaTime="+tStaTime+"&tEndTime="+tEndTime
				+"&tOperCode="+tOperCode+"&statDetailCode="+statDetailCode
				+"&endtDetailCode="+endtDetailCode+"&selSeats="+selSeats
				+"&selTHoNum="+selTHoNum+"&selGrade="+selGrade;
			
		} else if (cycle==="full" && hORf==="1"){
			$("input[name=staSeats]").attr("data-staSeats", selectedArr.join());
			let staGrade = $("input[name=gradetHoNum]").val();
			let staTHoNum = $("option:selected").val();
			$("input[name=staGrade]").attr("data-staGrade", staGrade);
			$("input[name=staTHoNum]").attr("data-staTHoNum", staTHoNum);
			
			let gra = staGrade === 'premium'? '특실' : '일반';
			let statement = "< 가는날 >\n등급 : "+gra+"\n호실번호 : "+staTHoNum+"\n좌석번호 : "+selectedArr.join()+"\n\n오는날 좌석을 선택하시겠습니까?";
			if(confirm(statement)){
				$("input[name=hORf]").val("2");
				listSeats(null);
			}
			return false;
		} else if (cycle==="full" && hORf==="2"){
			let staSeats = $("input[name=staSeats]").attr("data-endSeats");
			$("input[name=endSeats]").attr("data-endSeats", selectedArr.join());
			let endGrade = $("input[name=gradetHoNum]").val();
			let endTHoNum = $("option:selected").val();
			$("input[name=staGrade]").attr("data-endGrade", endGrade);
			$("input[name=staTHoNum]").attr("data-endtHoNum", endTHoNum);
			
			let gra = endGrade === 'premium'? '특실' : '일반';
			let statement = "< 오는날 >\n등급 : "+gra+"\n호실번호 : "+endTHoNum+"\n좌석번호 : "+selectedArr.join()+"\n\n결제창으로 넘어가시겠습니까?";
			if(confirm(statement)){
				let staSeats = $("input[name=staSeats]").attr("data-staSeats");
				let endSeats = $("input[name=endSeats]").attr("data-endSeats");
				let staTHoNum = $("input[name=staTHoNum]").attr("data-staTHoNum");
				let staGrade = $("input[name=staGrade]").attr("data-staGrade");
				let statDiscern = $("input[name=statDiscern]").val();
				let endtDiscern = $("input[name=endtDiscern]").val();
				let staDate = $("input[name=staDate]").val();
				let endDate = $("input[name=endDate]").val();
				let deptStaDateTime = $("input[name=deptStaDateTime]").val();
				let deptEndDateTime = $("input[name=deptEndDateTime]").val();
				let destStaDateTime = $("input[name=destStaDateTime]").val();
				let destEndDateTime = $("input[name=destEndDateTime]").val();
				let deptOperCode = $("input[name=deptOperCode]").val();
				let destOperCode = $("input[name=destOperCode]").val();
				let depstatDetailCode = $("input[name=depstatDetailCode]").val();
				let desstatDetailCode = $("input[name=desstatDetailCode]").val();
				let dependtDetailCode = $("input[name=dependtDetailCode]").val();
				let desendtDetailCode = $("input[name=desendtDetailCode]").val();
				
				query = "statDiscern="+statDiscern+"&endtDiscern="+endtDiscern+"&staDate="+staDate
					+"&endDate="+endDate+"&deptStaDateTime="+deptStaDateTime+"&deptEndDateTime="+deptEndDateTime
					+"&destStaDateTime="+destStaDateTime+"&destEndDateTime="+destEndDateTime
					+"&deptOperCode="+deptOperCode+"&destOperCode="+destOperCode+"&depstatDetailCode="+depstatDetailCode
					+"&desstatDetailCode="+desstatDetailCode+"&dependtDetailCode="+dependtDetailCode
					+"&dependtDetailCode="+dependtDetailCode+"&staSeats="+staSeats+"&endSeats="+endSeats
					+"&staTHoNum="+staTHoNum+"&endTHoNum="+endTHoNum+"&staGrade="+staGrade+"&endGrade="+endGrade;
			} else {
				return false;
			}
		}
		location.href= url + query ;
	});
	
	
	//버튼 이벤트는 여기서 만들기
	$("#reset-btn").click(function(){
		listSeats(null);
	})
	
	function listSeats(tHoNum){
		let cycle = $("input[name=cycle]").val();
		let statDiscern = $("input[name=statDiscern]").val();
		let endtDiscern = $("input[name=endtDiscern]").val();
		let hORf = $("input[name=hORf]").val();
		
		$("input[name=selTHoNum]").attr("data-selTHoNum",tHoNum);
		
		url = "${pageContext.request.contextPath}/reservetrain/choiceSeatsList.do?";
		let query = "";
		let grade = $("input[name=grade]").val();
		let count = $("input[name=count]").val();
		let staDate = $("input[name=staDate]").val();
		let endDate = $("input[name=endDate]").val();
		let deptOperCode = $("input[name=deptOperCode]").val();
		let destOperCode = $("input[name=destOperCode]").val();
		let statDetailCode = $("input[name=statDetailCode]").val();
		let endtDetailCode = $("input[name=endtDetailCode]").val();
		let depstatDetailCode = $("input[name=depstatDetailCode]").val();
		let desstatDetailCode = $("input[name=desstatDetailCode]").val();
		let dependtDetailCode = $("input[name=dependtDetailCode]").val();
		let desendtDetailCode = $("input[name=desendtDetailCode]").val();
		let tOperCode = $("input[name=tOperCode]").val();
		if(cycle==="half"){
			query = "grade="+grade+"&cycle="+cycle+"&staDate="+staDate+"&count="+count
				+"&statDetailCode="+statDetailCode+"&endtDetailCode="+endtDetailCode
				+"&tOperCode="+tOperCode;
		} else if(hORf==="1"&&cycle==="full"){
			query = "grade="+grade+"&cycle="+cycle+"&staDate="+staDate+"&count="+count
				+"&depstatDetailCode="+depstatDetailCode+"&desstatDetailCode="+desstatDetailCode
				+"&deptOperCode="+deptOperCode+"&hORf="+hORf;
		} else if(hORf==="2"&&cycle==="full"){
			query = "grade="+grade+"&cycle="+cycle+"&endDate="+endDate+"&count="+count+"&staDate="+staDate
				+"&dependtDetailCode="+dependtDetailCode+"&desendtDetailCode="+desendtDetailCode
				+"&destOperCode="+destOperCode+"&hORf="+hORf;
		}
		if(tHoNum!=null) query+="&tHoNum="+tHoNum;
		
		const fn = function(data){
			let gradetHoNum = data.gradetHoNum;
			
			$("input[name=gradetHoNum]").val(gradetHoNum);
			
			let selector = "";
			if(gradetHoNum === 'premium'){
				$("#choice-seats1").hide();
				$("#choice-seats2").show();
				selector = "#choice-seats2";
			} else {
				$("#choice-seats2").hide();
				$("#choice-seats1").show();
				selector = "#choice-seats1";
			}
			direction();
			
			let out = "";
			let i = 0;
			$(data.list).each(function(index, item){
				let tHoNum = item.tHoNum;
				let hoNum = item.hoNum;
				let num = item.num;
				let leftSeats = item.leftSeats;
				out += '<option class="hocha-list" value="'+tHoNum+'">'+num+' 호차 잔여 '
					+leftSeats+'석 / '+hoNum+'석</option>';
			});
			$("#ho-select").html(out);
			
			if(tHoNum != null) $("#ho-select").val(tHoNum);
			
			$("input[name=seats]").each(function(){
				$(this).prop("disabled", false);
			});
			
			$(selector+" input[name=seats]").each(function(){
				$(this).prop("checked", false);
			});
			
			// 0으로 고치기
			$("#selected-count").text(0);
			
			$(data.reservedSeatsArr).each(function(index, item){
				$(selector+" input[name=seats]").each(function(){

					if($(this).val()===item){
						$(this).prop("disabled", true);
					}
				});
			});
			
		}
		
		ajaxFun(url, "get", query, "json", fn);
	}
	
	$("body").on("change", "#ho-select", function(){
		let tHoNum = $(this).val();
		listSeats(tHoNum);
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
		<div id="seatForm-div">
			
			<form name="seatForm">
				<input type="hidden" name="gradetHoNum" value="">
				<div class="hocha-button d-flex justify-content-between"
					style="width: 80%; margin: 0 auto">
					<div class="top-section">
						<select class="form-select fw-bolder" id="ho-select"
							aria-label=".form-select-lg example" style="color: #9B9B9B">
							
						</select>
					</div>
					<div class="top-section-btn">
						<button class="btn btn-primary" type="reset" id="reset-btn">새로고침</button>
						<button class="btn btn-primary" type="button" id="select-complete">선택완료</button>
					</div>
				</div>
			
				<div class="mb-3" id="choice-seats1">
					<% for (int i = 0; i < 15; i++) { %>
					<div class="form_toggle d-flex flex-row justify-content-center">
						<% for (int j = 1; j <= 4; j++) { %>
						<% if (j == 3) { %>
						<div class="aisle" style="text-align: center;">
							<i class="bi bi-caret-down-fill" style="color: white;"></i>
						</div>
						<% } %>
						<% if (j == 5) { %>
						<br>
						<% } %>
						<% if (j != 5) { %>
						<div class="form_check_btn">
							<input id="<%=(char) (65+i) + "-" + j%>" type="checkbox" name="seats" value="<%=(char) (65+i) + "-" + j%>">
							<% if (i > 15 / 2) { %>
							<label for="<%=(char) (65+i) + "-" + j%>" style="height: 100%;">
								<span class="inner-text"><%=(char) (65+i) + "-" + j%></span>
								<br>
								<span class="direction direction1"></span>
							</label>
							<% } else { %>
							<label for="<%=(char) (65+i) + "-" + j%>" style="height: 100%;">
								<span class="inner-text"><%=(char) (65+i) + "-" + j%></span>
								<br>
								<span class="direction direction2"></span>
							</label>
							<% } %>
						</div>
						<% } %>
						<% } %>
					</div>
					<% } %>
				</div>
			
			
			
				<div class="mb-3" id="choice-seats2">
					<% for (int i = 0; i < 11; i++) { %>
					<div class="form_toggle d-flex flex-row justify-content-center">
						<% for (int j = 1; j <= 3; j++) { %>
						<% if (j == 2) { %>
						<div class="aisle" style="text-align: center;">
							<i class="bi bi-caret-down-fill" style="color: white;"></i>
						</div>
						<% } %>
						<% if (j == 4) { %>
						<br>
						<% } %>
						<% if (j != 4) { %>
						<div class="form_check_btn">
							<input id="1<%=(char) (65+i) + "-" + j%>" type="checkbox" name="seats" value="<%=(char) (65+i) + "-" + j%>">
							<% if (i > 15 / 2) { %>
							<label for="1<%=(char) (65+i) + "-" + j%>" style="height: 100%;">
								<span class="inner-text"><%=(char) (65+i) + "-" + j%></span>
								<br>
								<span class="direction direction1"></span>
							</label>
							<% } else { %>
							<label for="1<%=(char) (65+i) + "-" + j%>" style="height: 100%;">
								<span class="inner-text"><%=(char) (65+i) + "-" + j%></span>
								<br>
								<span class="direction direction2"></span>
							</label>
							<% } %>
						</div>
						<% } %>
						<% } %>
					</div>
					<% } %>
				</div>
				
				
			</form>
			
			
			
		</div>
		<div id="div-seats-count"><span id="sORn"></span>선택된 좌석 : <span id="selected-count">0</span> / ${count} 개</div>
	</div>
</main>
<form name="hiddenForm">
	<input type="hidden" name="tDiscern" value="${tDiscern}">
	<input type="hidden" name="statDiscern" value="${statDiscern}">
	<input type="hidden" name="endtDiscern" value="${endtDiscern}">
	<input type="hidden" name="hORf" value="1">
	<input type="hidden" name="cycle" value="${cycle}">
	<input type="hidden" name="grade" value="${grade}">
	<input type="hidden" name="count" value="${count}">
	<input type="hidden" name="staDate" value="${staDate}">
	<input type="hidden" name="endDate" value="${endDate}">
	<input type="hidden" name="tStaTime" value="${tStaTime}">
	<input type="hidden" name="tEndTime" value="${tEndTime}">
	<input type="hidden" name="deptStaDateTime" value="${deptStaDateTime}">
	<input type="hidden" name="deptEndDateTime" value="${deptEndDateTime}">
	<input type="hidden" name="destStaDateTime" value="${destStaDateTime}">
	<input type="hidden" name="destEndDateTime" value="${destEndDateTime}">
	<input type="hidden" name="tOperCode" value="${tOperCode}">
	<input type="hidden" name="deptOperCode" value="${deptOperCode}">
	<input type="hidden" name="destOperCode" value="${destOperCode}">
	<input type="hidden" name="statDetailCode" value="${statDetailCode}">
	<input type="hidden" name="endtDetailCode" value="${endtDetailCode}">
	<input type="hidden" name="depstatDetailCode" value="${depstatDetailCode}">
	<input type="hidden" name="desstatDetailCode" value="${desstatDetailCode}">
	<input type="hidden" name="dependtDetailCode" value="${dependtDetailCode}">
	<input type="hidden" name="desendtDetailCode" value="${desendtDetailCode}">
	<input type="hidden" name="selSeats" data-selSeats=""> <!-- 편도 : 선택한 좌석 번호 -->
	<input type="hidden" name="staSeats" data-staSeats=""> <!-- 왕복 가는날 : 선택한 좌석 번호 -->
	<input type="hidden" name="endSeats" data-endSeats=""> <!-- 왕복 오는날 : 선택한 좌석 번호 -->
	
	<input type="hidden" name="staTHoNum" data-staTHoNum=""> <!-- 왕복 가는날 : 선택한 호차번호 -->
	<input type="hidden" name="endTHoNum" data-endTHoNum=""> <!-- 왕복 오는날 : 선택한 호차번호 -->
	
	<input type="hidden" name="staGrade" data-staGrade=""> <!-- 왕복 가는날 : 좌석등급 -->
	<input type="hidden" name="endGrade" data-endGrade=""> <!-- 왕복 오는날 : 좌석등급 -->
</form>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>