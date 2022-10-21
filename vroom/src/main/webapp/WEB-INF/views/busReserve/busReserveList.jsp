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

.fblock1{
min-width: 300px;
min-height: 700px;
}
.fblock1_1{
display: flex;
justify-content:flex-start;
align-items: baseline;
min-height: 60px;
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
}
#buslistgroup{
 height:600px;
 overflow-y: auto;
}
.buslist_title{
min-height: 30px;
min-width: 120px;
}
#buslist{
 height: 60px;
}
#buslist:hover {
	border-color: rgba(gray,0.9);
}
#fblock2_title{
	border-top:1px solid gray;
}
</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container row gx-10 ">
	    <div class="col-3">
		    <div class="fblock1 container  bg-primary text-light rounded" >
		    	<div class="h-20 p-3 text-center fs-5">2022.10.26 수</div>
		    	<div class="h-15 text-center fblock1_1">
	    			<div class="fblock1_icon bg-light text-primary p-10 m-2 text-center fw-bold">출발</div>
	    			<div class="text-center fs-4 fw-bold">출발지</div>
		    	</div>
		    	<div class="h-15 fblock1_1 p-10">
		    		<span class="fblock1_icon bg-light text-primary p-10 m-2 text-center fw-bold">도착</span>
		    		<span class="text-center fs-4 fw-bold">도착지</span>
		    	</div>
		    	<div class="row h-10 p-10 m-2 fblock1_1 fw-bold">1시간 30분 소요</div>
		    	<div class="row h-10 p-10 m-2 fblock1_1  text-start fs-5 fw-bold">요금정보</div>
		    	<div class="row h-10 p-10 m-2 fblock1_2 text-center"><div class="col fblock1_2" >일반</div><div class="col fblock1_3">일반요금</div></div>
		    	<div class="row h-10 p-10 m-2 fblock1_2 text-center" style=""><div class="col fblock1_2">우등</div><div class="col fblock1_3">우등요금</div></div>
		    	<div class="row h-10 p-10 m-2 fblock1_2 text-center"><div class="col fblock1_2">프리미엄</div><div class="col fblock1_3">프리미엄요금</div></div>
		    </div>
	    </div>
	    <div class="body-main col-8" >
		  	<div id="fblock2_title" class="row" >
				<div class="buslist_title col m-2  fw-bold fs-5 text-center">출발</div>
				<div class="buslist_title col m-2  fw-bold fs-5 text-center ">고속사</div>
				<div class="buslist_title col m-2  fw-bold fs-5 text-center">등급</div>
				<div class="buslist_title col m-2  fw-bold fs-5 text-center ">가격</div>
				<div class="buslist_title col m-2  fw-bold fs-5 text-center ">잔여석</div>
				<div class="buslist_title col m-2  fw-bold fs-5 text-center ">예매가능</div>
			</div>
			<div class="list-group list-group-flush border-bottom buslistgroup" id="list-group" style="height:600px; overflow: auto">
		
				<a  class=" list-group-item " id="buslist" >Item 1</a>
			    <a class=" list-group-item " id="buslist">Item 2</a>
			    <a class=" list-group-item " id="buslist">Item 3</a>
			    <a class=" list-group-item " id="buslist">Item 4</a>
			    <a class=" list-group-item " id="buslist">Item 4</a>
			    <a class=" list-group-item " id="buslist">Item 4</a>
			    <a class=" list-group-item " id="buslist">Item 4</a>
			    <a class=" list-group-item " id="buslist">Item 4</a>
			    <a class=" list-group-item " id="buslist">Item 4</a>
			    <a class=" list-group-item " id="buslist">Item 4</a> 
			    <a class=" list-group-item " id="buslist">Item 4</a>
			    <a class=" list-group-item " id="buslist">Item 4</a>
		    </div>
			<div></div>
		  	<div class="middle-hilight-text">2022.10.13 목</div>
		 	 
		</div>

	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>