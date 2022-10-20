<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/jquery/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap5/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap5/icon/bootstrap-icons.css" type="text/css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.2.0/css/all.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/util-jquery.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/core.js"></script>

<style type="text/css">
* { margin: 0; padding: 0; }
*, *::after, *::before { box-sizing: border-box; }

body { font-size: 14px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif; }

a { color: #000; text-decoration: none; cursor: pointer; }
a:active, a:hover { text-decoration: underline; color: #F28011; }

.btn {
	padding: 5px 10px;
	font-size: 14px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	color: #333; font-weight: 500;
	border: 1px solid #999; border-radius: 4px;
	background-color: #fff;
	cursor:pointer;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	color:#333;
	background-color: #f8f9fa;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
}

.form-control {
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	vertical-align: baseline;
}
.form-select[readonly] { background-color:#f8f9fa; }

textarea:focus, input:focus { outline: none; }
input[type=checkbox], input[type=radio] { vertical-align: middle; }

/* table */
.table { width: 100%; border-spacing: 0; border-collapse: collapse; }
.table th, .table td { padding-top: 10px; padding-bottom: 10px; }

.table-border thead > tr { border-top: 2px solid #212529; border-bottom: 1px solid #ced4da; }
.table-border tbody > tr { border-bottom: 1px solid #ced4da; }
.table-border tfoot > tr { border-bottom: 1px solid #ced4da; }
.td-border td { border: 1px solid #ced4da; }

/* layout */
#calendarLayout {
	width: 280px;
	margin: 30px auto;
}
#calendarLayout .subject{
	height: 37px;
	line-height: 37px;
	text-align: center;
	font-weight: 600;
}

#calendarLayout table td { text-align: center; }
#calendarLayout table td:nth-child(7n+1) { color: orange; }
#calendarLayout table td:nth-child(7n) { color: #0E6EFD; }
#calendarLayout table td.gray { color: #ccc; }
#calendarLayout table td.today { font-weight:700; background: #E6FFFF; }

#calendarLayout .footer { height: 25px; line-height: 25px;
	text-align: right; font-size: 12px; }

.subject>span, .footer>span { cursor: pointer; }
.subject>span:hover, .footer>span:hover { color: tomato; }
td:hover { background: #eee; }
.hidden-cal { font-size: 0px; }
</style>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css" type="text/css"/>
<script type="text/javascript">
function calendar(y, m) {
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
	
	let out = '<div class="subject">';
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
		out += '<td class="gray">'+(++pDay)+'<span class="hidden-cal" style="visibility: hidden">'+y2+'.'+m2+'.'+pDay+week[w]+'</span>'+'</td>';
	}
	
	let cls;
	let lastDay = (new Date(y, m, 0)).getDate();
	for(let i=1; i<=lastDay; i++){
		
		cls = y===ny && m===nm && i===nd ? ' today ' : '';
		
		let date = new Date(y, m, i);
		let w2 = date.getDay();
		let week2 = [' 일',' 월',' 화',' 수',' 목',' 금',' 토'];
		
		out += '<td class="'+cls+'">'+ i +'<span class="hidden-cal" style="visibility: hidden">'+y+'.'+m+'.'+i+week2[w2]+'</span>'+'</td>';
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
		out += '<td class="gray">'+(++nDay)+'<span class="hidden-cal" style="visibility: hidden">'+y3+'.'+m3+'.'+nDay+week2[w2]+'</span>'+'</td>';
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
			out += '<td class="gray">'+(++nDay)+'<span class="hidden-cal" style="visibility: hidden">'+y3+'.'+m3+'.'+nDay+week2[w2]+'</span>'+'</td>';
		}
		out += '</tr>';
	}
	
	out += '</table>';
	
	out += '<div class="footer"><span onclick="calendar('+ny+','+nm+')">오늘날짜로</span></div>';
	
	document.querySelector("#calendarLayout").innerHTML = out;
}

window.onload = () => { // onload : 메모리에 있으면 실행
	let now = new Date();
	let y = now.getFullYear();
	let m = now.getMonth() + 1;
	
	calendar(y, m);
};

$(function(){
	$("body").on("click", "tr",
		function(){
			$("td").click(function(){
				console.log($(this).children().text());
			});
		}
	);
});

</script>

</head>
<body>

<div id="calendarLayout"></div>

</body>
</html>