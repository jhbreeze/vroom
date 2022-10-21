<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		out += '<td class="gray">'+(++pDay)+'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y2+'.'+m2+'.'+pDay+week[w]+'</span>'+'</td>';
	}
	
	let cls;
	let lastDay = (new Date(y, m, 0)).getDate();
	for(let i=1; i<=lastDay; i++){
		
		cls = y===ny && m===nm && i===nd ? ' today ' : '';
		
		let date = new Date(y, m, i);
		let w2 = date.getDay();
		let week2 = [' 일',' 월',' 화',' 수',' 목',' 금',' 토'];
		
		out += '<td class="'+cls+' clsClass">'+ i +'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y+'.'+m+'.'+i+week2[w2]+'</span>'+'</td>';
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
		out += '<td class="gray">'+(++nDay)+'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y3+'.'+m3+'.'+nDay+week2[w2]+'</span>'+'</td>';
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
			out += '<td class="gray">'+(++nDay)+'<span class="hidden-cal" style="visibility: hidden; font-size: 0px;">'+y3+'.'+m3+'.'+nDay+week2[w2]+'</span>'+'</td>';
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
			});
			$("td").prop("disabled", true);
		}
	);
});

</script>

</head>
<body>

<div id="calendarLayout"></div>

</body>
</html>