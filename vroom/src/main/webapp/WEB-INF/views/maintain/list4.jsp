<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap5/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap5/icon/bootstrap-icons.css"
	type="text/css">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap5/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
main {
	position: relative;
	top: -55px;
	background: white;
}

tr:hover {
	background: #fff;
	box-shadow: 0px 0px 4px rgb(72, 92, 161, 0.4);
}

.container {
	min-height: 700px;
}

.sort {
	font-size: 10px;
	border: 1px solid #e2e2e2;
	width: 50px;
	height: 20px;
	border-radius: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#button {
	all: unset;
}

#button:hover {
	cursor: pointer;
	color: #0E6EFD;
}

#href {
	text-decoration-line: none;
}

#href:hover {
	color: #0E6EFD;
}

.col-3, .col-9 {
	box-shadow: 4px 4px 4px rgb(72, 92, 161, 0.2);
	border: none;
}

.body-container {
	max-width: 1200px;
	margin: auto;
}

.col-3, .container {
	box-shadow: 4px 4px 4px rgb(72, 92, 161, 0.2);
	border: none;
	border-radius: 30px;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #0E6EFD;
	color: #eee;
}
</style>
<script type="text/javascript">
	function searchList() {
		const f = document.searchForm;
		f.submit();
	}

</script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title mb-4">
					<div class="fs-4 fw-bolder">예매 내역 조회</div>
				</div>
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="reserve.do">기차 예매 조회</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="reserve2.do">기차 환불 조회</a></li>
					<li class="nav-item"><a class="nav-link " href="reserve3.do">버스
							예매 조회</a></li>
					<li class="nav-item"><a class="nav-link active" aria-current="page"
						href="#">버스 환불 조회</a></li>
				</ul>

				<div class="body-main">
					<div class="row board-list-header">
						<div class="col-auto me-auto">${dataCount}개(${page}/${total_page}
							페이지)</div>
						<div class="col-auto">&nbsp;</div>
						<br>
						<br>
					</div>
				</div>

				<table class="table board-list">
					<thead>
						<tr>
							<th>구분</th>
						    <th>고객번호</th>
							<th>이름</th>
							<th>출발역</th>
							<th>도착역</th>
							<th>버스예매번호</th>
							<th>총예매수</th>
							<th>날짜</th>
							<th>출발시간</th>
							<th>도착시간</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td>${dto.userId.length() > 0 ? "회원" : "비회원"}</td>
							    <td>${dto.cusNum}</td>
								<td>${dto.name}</td>
								<td>${dto.bStationNameEnd}</td>
								<td>${dto.bStationNameSta}</td>
								<td>${dto.bTkNum}</td>
								<td>${dto.bTotNum}</td>
								<td>${dto.bBoardDate}</td>
								<td>${dto.bFirstStaTime}</td>
								<td>${dto.bEndStaTime}</td>
							</tr>

						</c:forEach>
					</tbody>
				</table>

				<div class="row board-list-footer">
					<div class="col"></div>
					<div class="col"></div>
					<div class="col-6 text-center">
						<form class="row" name="searchForm"
							action="${pageContext.request.contextPath}/maintain/reserve4.do"
							method="post">
							<div class="col-auto p-1">
								<select name="condition" class="form-select">
									<option value="name"
										${condition=="name"?"selected='selected'":""}>이름</option>
									<option value="bBoardDate"
										${condition=="bBoardDate"?"selected='selected'":""}>탑승날짜</option>
									<option value="cusNum"
										${condition=="cusNum"?"selected='selected'":""}>고객번호</option>
									<option value="bStationName"
										${condition=="bStationName"?"selected='selected'":""}>탑승역</option>
								</select>
							</div>
							<div class="col-auto p-1">
								<input type="text" name="keyword" value="${keyword}"
									class="form-control">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light"
									onclick="searchList()">검색</button>
							</div>
						</form>
					</div>
					<div class="col text-end">
					</div>
				</div>

				<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>

<script type="text/javascript">
	
</script>
</html>