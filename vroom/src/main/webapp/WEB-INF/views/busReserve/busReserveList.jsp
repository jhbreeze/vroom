<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 템플릿</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container{
 padding: 30px;
}
.fblock1{
min-width: 300px;
min-height: 700px;
background-color: #0d6efd;
}
.fblock1_1{
display: flex;
justify-content:flex-start;
align-items: baseline;
min-height: 60px;
padding: 10px 0px;
}
.fblock1_2{
display: flex;
justify-content:space-between;
min-height: 60px;
}
.fblock1_3{
display: flex;
justify-content:flex-end;
min-height: 60px;
}
.fblock1_icon{
	display:flex;
	width: 50px;
	height: 50px;
	border-radius: 25px;
	justify-content: center;
    align-items: center;
}
#calendarLayout{
	font-size: 25px;
	font-weight: bolder;
	display:flex;
	align-items:center;
	justify-content:center;
	cursor: pointer;
	min-height: 50px;
	z-index: 1000;
}
#calendarLayout:hover {
	border-color:#0d6efd; 
}

#buslistgroup{
 height:700px;
}

.buslist_title{
min-height: 30px;
min-width: 130px;
padding: 0px 3px;
}
#list-group{
height:600px; 
overflow-y: auto;
overflow-x:hidden;
}


/* 아래의 모든 코드는 영역::코드로 사용 */

#list-group::-webkit-scrollbar {
    width: 23px;  /* 스크롤바의 너비 */
}

#list-group::-webkit-scrollbar-thumb {
    height: 30%; /* 스크롤바의 길이 */
    background:  #0d6efd; /* 스크롤바의 색상 */
    opacity:0.8;
    border-radius: 10px;
}

#list-group::-webkit-scrollbar-track {
	border-radius: 10px;
    background:  rgba(0, 123, 255,0.1);  /*스크롤바 뒷 배경 색상*/

}
.row{
margin-left:0px;
margin-right:0px;
}
.buslist{
min-height: 30px;
min-width: 100px;
}
#buslist{
display: flex;
width:860px;
justify-content:space-between;
align-items:center;
min-height: 60px;
}
#buslist:hover {
	border-top:1px solid #0d6efd;
	border-bottom:1px solid #0d6efd;
}
.fblock2{
	margin-left:10px;
    width: 900px;
    height: 720px;
	padding: 20px;
    background: white;
    border-radius: 30px;
    box-shadow: 4px 4px 4px rgb(0 0 0 / 12%);

}
#fblock2_title{
	padding: 10px 16px;
	width: 860px;
	position: relative;
	z-index: 1;
}
#fblock2_title:before{
	content : "";
  position: absolute;
  left    : 0;
  bottom  : 0;
  height  : 1px;
  width   : 100%;  /* or 100px */
  border-top:1px solid gray;
}
#reserveBtn{
width:100px;
height: 35px;
background-color: #0d6efd;
border-radius: 5px;
border-color: #0d6efd;
color: white;
}
div.subject{
caret-color: transparent;
}
.subject span {
	cursor: pointer;
}
</style>
<script type="text/javascript">
function calendar(y, m, d){
	let date = new Date(y, m-1, d); //y년 m월 1일의 Date객체생성
	y = date.getFullYear();
	m = date.getMonth()+1;
	d = date.getDate();
	
	let w  = date.getDay(); 
	let week = ['일', '월', '화', '수', '목', '금', '토'];

	//시스템 오늘날짜
	let now = new Date();
	let ny = now.getFullYear();
	let nm = now.getMonth() +1;
	let nd = now.getDate();

	let out = '<div class= "subject">';
		out += '<span onclick="calendar('+y+','+(m)+','+(d-1)+')">&lt;</span>&nbsp;&nbsp;';
		out += '<label>' + y + '.' + (m)+ '.'+d+' '+week[w]+' </label>&nbsp;&nbsp;';
		out += '<span onclick = "calendar(' + y+','+(m)+','+(d+1)+')">&gt;</span>';
		out += '</dlv>';

		document.querySelector("#calendarLayout").innerHTML = out;
}

$(function(){
	let now = new Date();
	let y = now.getFullYear();
	let m = now.getMonth()+1;
	let d = now.getDate();
	calendar(y, m, d);
});

//편도 왕복 구분 방식?

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
				    	<div class="row h-10 p-10 m-2 fblock1_2 text-center"><div class="col fblock1_2 fw-bold" >일반</div><div class="col fblock1_3 fw-bold" data-bFee="${dto.bFee}">${dto.bFee}원</div></div>
				    </c:if>
				    <c:if test="${dto.bType eq '우등'}">
				    	<div class="row h-10 p-10 m-2 fblock1_2 text-center" style=""><div class="col fblock1_2 fw-bold">우등</div><div class="col fblock1_3 fw-bold" data-bFee="${dto.bFee}">${dto.bFee}원</div></div>
				    </c:if>
				    <c:if test="${dto.bType eq '프리미엄'}">
				    	<div class="row h-10 p-10 m-2 fblock1_2 text-center"><div class="col fblock1_2 fw-bold">프리미엄</div><div class="col fblock1_3 fw-bold" data-bFee="${dto.bFee}">${dto.bFee}원</div></div>
			    	</c:if>
		    	</c:forEach>
		    </div>
	    </div>
	    
	    <div class="fblock2">
	    	<div class="Bcycle" style="display: none;">${bcycle}배차조회</div>
		    <div id="calendarLayout" style="z-index: 1000;" >
		    </div>
		    <div class="fblock2-1" >
			  	<div id="fblock2_title" class="row" >
					<div class="buslist_title col-2  fw-bold fs-5 text-center">출발</div>
					<div class="buslist_title col-2  fw-bold fs-5 text-center ">고속사</div>
					<div class="buslist_title col-2 fw-bold fs-5 text-center">등급</div>
					<div class="buslist_title col-2 fw-bold fs-5 text-center ">가격</div>
					<div class="buslist_title col-2 fw-bold fs-5 text-center ">잔여석</div>
					<div class="buslist_title col-2 fw-bold fs-5 text-center "></div>
				</div>
				<div class="list-group list-group-flush border-bottom buslistgroup" id="list-group" >
				<c:forEach var="dto" items="${bRouteInfoList}" varStatus="status">
					<a class=" list-group-item row" id="buslist" >
						<div class="buslist col-2 fw-bold fs-6  text-center" id="bFirstStaTime" >${dto.bFirstStaTime}</div>
						<div style="display: none;" id="bEndStaTime" >${dto.bEndStaTime}</div>
						<div style="display: none;" id="bRouteDetailCode" >${dto.bRouteDetailCode}</div>
						<div style="display: none;" id="bRouteCode" >${dto.bRouteCode}</div>
						<div  class="buslist col-2 fw-bold fs-6  text-center" id="bName"  >${dto.bName}</div>
						<div  class="buslist col-2 fw-bold fs-6  text-center" id="bType" >${dto.bType}</div>
						<div  class="buslist col-2 fw-bold fs-6  text-center " id="bFee" >${dto.bFee}</div>
						<div class="buslist col-2 fw-bold fs-6  text-center "style="min-width: 130px;" id="seatNum" data-seatNum="${dto.seatNum}">?석/전체${dto.seatNum}석</div>
						<div class="buslist col-2 fw-bold fs-6  text-center "><input type="button" id="reserveBtn" value="예매하기"></div>
					</a>
			    </c:forEach>
			    </div>
			</div>
	    </div>
	</div>
</main>
<form name="hiddenForm">
	<input type="hidden" name="bcycle" data-bcycle="${bcycle}">
	<input type="hidden" name="busstaDate" data-busstaDate="${busstaDate}">
	<input type="hidden" name="busendDate" data-busendDate="${busendDate}">
	<input type="hidden" name="depbStationName" data-depbStationName="${depbStationName}">
	<input type="hidden" name="desbStationName" data-desbStationName="${desbStationName}">
	<input type="hidden" name="btakeTime" data-btakeTime="${btakeTime}">
	<input type="hidden" name="bTotalTimeString" data-bTotalTimeString="${bTotalTimeString}">
	<input type="hidden" name="bRouteDetailCode" data-bRouteDetailCode="${bRouteDetailCode}">
	<input type="hidden" name="bRouteCode" data-bRouteCode="${bRouteCode}">
</form>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>