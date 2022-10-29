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
.form_check_btn label:hover { color: #666; cursor: pointer; }
.form_check-btn input[type=checkbox]+label { background: white; color: #DEDEDE; }
.aisle { width: 80px; height: 60px; background: #D6D9DE; }
#choice-seats { background: #D6D9DE; width: 80%; height: 500px; 
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
	
	$("#seatForm-div").on("click", "input[name=seats]", function(){
		let check = $("input[name=seats]:checked").length; // 체크된 좌석 개수
		$("#selected-count").text(check);	
		
		// 사전에 선택한 인원수보다 더 많이 골랐을 경우 alert창을 띄움
		if(count < check) {
			alert("이미 모두 선택하셨습니다.");
			$(this).prop("checked", false);
			$("#selected-count").text(check-1);
		}
	});
});
// 선택 완료버튼을 누르면, 선택한 좌석들의 이름이 confirm창으로 뜨고, 결제하시겠냐고 물어봄

// 왕복일 경우, 선택 완료를 누르면, 왕복좌석 선택을 하기위해 한 번 더 실행함

function listSeats(){
	// 상행일때, 하행일때 화살표 방향 다름 + 화살표 방향에 맞게 순방향/역방향 다르게
	let cycle = $("input[name=cycle]").val();
	let statDiscern = $("input[name=statDiscern]").val();
	let endtDiscern = $("input[name=endtDiscern]").val();
	let hORf = $("input[name=hORf]").val();
	let selector = "#seatForm-div";
	
	if(cycle==="half"){
		let tDiscern = $("input[name=tDiscern]").val();
		let statDiscern = $("input[name=statDiscern]").val();
		let endtDiscern = $("input[name=endtDiscern]").val();
			
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
	} else if(hORf==="2"&&endtDiscern==="full"){
		query = "grade="+grade+"&cycle="+cycle+"&endDate="+endDate+"&count="+count
			+"&dependtDetailCode="+dependtDetailCode+"&desendtDetailCode="+desendtDetailCode
			+"&destOperCode="+destOperCode+"&hORf="+hORf;
	}
	
	const fn = function(data){
		$(selector).html(data);
		/* let cc = data.reservedSeatsArr;
		for(let i of cc) {
			$("input[value="+i+"]").prop("disabled", true);
		} */
	}
	
	ajaxFun(url, "get", query, "html", fn);
}

$(function(){
	listSeats();
});

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

// 체크된 항목들 저장
$(function(){
	let cycle = $("input[name=cycle]").val();
	let hORf = $("input[name=hORf]").val();
	let count = $("input[name=count]").val();
	
	$("body").on("click", "#select-complete", function(){
		let selectedArr = [];
		$("input[name=seats]:checked").each(function(){
			let selected = $(this).next("label").find(".inner-text").text();
			selectedArr.push(selected);
		});
		if(cycle==='half') {
			$("input[name=selSeats]").attr("data-selSeats", selectedArr.join());
		} else if (cycle==="full" && hORf==="1"){
			$("input[name=staSelSeats]").attr("data-staSelSeats", selectedArr.join());
		} else if (cycle==="full" && hORf==="1"){
			$("input[name=endSelSeats]").attr("data-endSelSeats", selectedArr.join());
		}
		if(selectedArr.length < count) {
			alert("선택하신 좌석 수가 모자랍니다.");
			return false;
		};
	});
});

// 호차를 눌렀을 때 다시 서버 갔다오도록 함
$(function(){
	$("body").on("change", "#ho-select", function(){
		let tHoNum = $(this).val();
		let cycle = $("input[name=cycle]").val();
		let statDiscern = $("input[name=statDiscern]").val();
		let endtDiscern = $("input[name=endtDiscern]").val();
		let hORf = $("input[name=hORf]").val();
		let selector = "#seatForm-div";
		
		$("input[name=selTHoNum]").attr("data-selTHoNum",tHoNum);
		console.log($("input[name=selTHoNum]").attr("data-selTHoNum"));
		if(cycle==="half"){
			let tDiscern = $("input[name=tDiscern]").val();
			let statDiscern = $("input[name=statDiscern]").val();
			let endtDiscern = $("input[name=endtDiscern]").val();
				
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
				+"&tOperCode="+tOperCode+"&tHoNum="+tHoNum;
		} else if(hORf==="1"&&cycle==="full"){
			query = "grade="+grade+"&cycle="+cycle+"&staDate="+staDate+"&count="+count
				+"&depstatDetailCode="+depstatDetailCode+"&desstatDetailCode="+desstatDetailCode
				+"&deptOperCode="+deptOperCode+"&hORf="+hORf+"&tHoNum="+tHoNum;
		} else if(hORf==="2"&&endtDiscern==="full"){
			query = "grade="+grade+"&cycle="+cycle+"&endDate="+endDate+"&count="+count
				+"&dependtDetailCode="+dependtDetailCode+"&desendtDetailCode="+desendtDetailCode
				+"&destOperCode="+destOperCode+"&hORf="+hORf+"&tHoNum="+tHoNum;
		}
		
		const fn = function(data){
			$(selector).html(data);
			let tHoNum = $("input[name=selTHoNum]").attr("data-selTHoNum");
			$(".hocha-list").each(function(index, item){
				if($(item).val=tHoNum){
					$(item).prop("checked", true);
				}
			})
		}
		
		ajaxFun(url, "get", query, "html", fn);
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
			
			
		</div>
		<div id="div-seats-count"><span id="sORn"></span>선택하신 좌석 : <span id="selected-count">0</span> / ${count} 개</div>
	</div>
</main>
<form name="hiddenForm">
	<input type="hidden" name="tDiscern" class="tDiscern" value="${tDiscern}">
	<input type="hidden" name="statDiscern" class="statDiscern" value="${statDiscern}">
	<input type="hidden" name="endtDiscern" class="endtDiscern" value="${endtDiscern}">
	<input type="hidden" name="hORf" value="1">
	<input type="hidden" name="cycle" value="${cycle}">
	<input type="hidden" name="grade" value="${grade}">
	<input type="hidden" name="count" value="${count}">
	<input type="hidden" name="staDate" value="${staDate}">
	<input type="hidden" name="endDate" value="${endDate}">
	<input type="hidden" name="deptOperCode" value="${deptOperCode}">
	<input type="hidden" name="destOperCode" value="${destOperCode}">
	<input type="hidden" name="tOperCode" value="${tOperCode}">
	<input type="hidden" name="statSeatNum" value="${statSeatNum}">
	<input type="hidden" name="statHoNum" value="${statHoNum}">
	<input type="hidden" name="statNumId" value="${statNumId}">
	<input type="hidden" name="endtSeatNum" value="${endtSeatNum}">
	<input type="hidden" name="endtHoNum" value="${endtHoNum}">
	<input type="hidden" name="endtNumId" value="${endtNumId}">
	<input type="hidden" name="statDetailCode" value="${statDetailCode}">
	<input type="hidden" name="endtDetailCode" value="${endtDetailCode}">
	<input type="hidden" name="depstatDetailCode" value="${depstatDetailCode}">
	<input type="hidden" name="desstatDetailCode" value="${desstatDetailCode}">
	<input type="hidden" name="dependtDetailCode" value="${dependtDetailCode}">
	<input type="hidden" name="desendtDetailCode" value="${desendtDetailCode}">
	<input type="hidden" name="selSeats" data-selSeats="">
	<input type="hidden" name="staSelSeats" data-staSelSeats="">
	<input type="hidden" name="endSelSeats" data-endSelSeats="">
	<input type="hidden" name="selTHoNum" data-selTHoNum="">
</form>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>