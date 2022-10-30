<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 결제창</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container { min-height: 480px; }
.ticket { 
	width: 500px; box-shadow: 0px 0px 8px rgb(72, 92, 161, 0.3); min-height: 50px; 
	border-radius: 10px; margin: 0 auto; margin-top: 20px; padding: 20px 30px 20px 30px;
}
/* #check-title { 
	background: #0E6EFD; width: 250px; height: 40px; font-size: 17px;
	text-align: center; color: white; line-height: 40px; vertical-align: 40px;
	border-radius: 40px;
} */
#check-title { 
	font-size: 25px; font-weight: 600; width: 500px; margin: 0 auto;
}
#ticket-info { margin: 0 auto; width: 500px; }
.date { color: #0E6EFD; }
.info1 { color: gray; }
.info2 { font-weight: 600; font-size: 20px; }
.ticket-count { float: right; }
.direction { color: #0E6EFD; }
.btn-pay { margin-top: 20px; width: 500px; height: 60px; font-size: 20px; border-radius: 10px; }
</style>

<script type="text/javascript">

</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
		<div id="check-title">승차권 정보 확인</div>
		<div id="ticket-info">
			<div class="ticket">
				<span class="date">2022.10.31 월</span>
				<span class="ticket-count">어른&nbsp; 3매</span>
				<div class="info1">KTX&nbsp;&nbsp; 003</div>
				<div class="info2">서울&nbsp; 05:30 &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; 대전&nbsp; 06:32</div>
				<div class="info3">일반&nbsp;&nbsp; 1호차&nbsp;&nbsp; A-3, A-4, B-1&nbsp; <span class="direction">(역방향)</span></div>
			</div>
			<div class="ticket">
				<span class="date">2022.11.1 화</span>
				<span class="ticket-count">어른&nbsp; 3매</span>
				<div class="info1">KTX&nbsp;&nbsp; 005</div>
				<div class="info2">대전&nbsp; 05:30 &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; 서울&nbsp; 06:32</div>
				<div class="info3">일반&nbsp;&nbsp; 2호차&nbsp;&nbsp; A-3, A-4, B-1&nbsp; <span class="direction">(상행)</span></div>
			</div>
			<div class="d-flex justify-content-center">
				<button class="btn btn-primary btn-pay">결제하기</button>
			</div>
		</div>
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>