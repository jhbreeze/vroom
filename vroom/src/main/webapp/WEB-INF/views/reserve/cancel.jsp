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
.container { min-height: 900px; margin-left: 500px; margin-top: 70px;}

.box-container { border: 1px solid gray; width: 300px; height:200px;  }

.h3 { margin-left: 300px;}

.textReserve  { width: 650px; height: 40px;}

.textPassword { width: 650px; height: 40px;}
.cancelReserve { margin-left: 10px; }

h2 { font-weight: bold; }
.titleReserve { font-weight: bold;}


</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>

	<main>
		<div class="container body-container">
			<h2>예매취소</h2>

			<br> <br>
			<div class="cancelReserve">
				<div class="reserveNumber">
					<label class="titleReserve">예매번호</label>
					<br>
					<input type="text" class="textReserve">
				</div>
				<br>
				<div class="password">
					<label class="titleReserve">전화번호</label>
					<br>
					<input class="textPassword" type="text">
				</div>
				<div>
					<br> <br>
						<form action="">
							<div class="d-grid gap-4 col-6">
								<button class="btn btn-primary btn-lg" type="button" style="height: 70px;">취소하기</button>
							</div>
						</form>
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