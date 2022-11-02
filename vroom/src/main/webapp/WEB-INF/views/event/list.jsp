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

.container {
	min-height: 700px;
}

.imagebox {
	position: relative;
}

.btn:active, .btn:focus, .btn:hover {
	background-color: #0E6EFD;
	color: #eee;
}

.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: not-allowed;
	filter: alpha(opacity = 65);
	-webkit-box-shadow: none;
	box-shadow: none;
	opacity: .65;
}

tr.hover:hover {
	cursor: pointer;
	background: #0E6EFD;
}

a {
	text-decoration-line: none;
	text-decoration: none;
}

.container {
	box-shadow: 4px 4px 4px rgb(72, 92, 161, 0.2);
	border: none;
	border-radius: 30px;
}

.image {
	display: block;
	width: 100%;
	height: auto;
}

.textbox {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	height: 100%;
	width: 100%;
	opacity: 0;
	transition: .5s ease;
	background-color: #0E6EFD;
}

.text {
	color: #eee;
	font-size: 30px;
	font-family: verdana, sans-serif;
	position: absolute;
	top: 50%;
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
	text-align: center;
}

.body-container {
	max-width: 1200px;
	margin: auto;
}

.imagebox:hover .textbox {
	opacity: 0.7;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">

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
		<div class="container ">
			<div class="body-container">
				<div class="body-title">
					<h2>이벤트</h2>
				</div>
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">진행중인 이벤트</a></li>
					<li class="nav-item"><a class="nav-link"
						href="list2.do?page=1">종료된 이벤트</a></li>
				</ul>

				<div class="body-main">
					<div class="row board-list-header">
						<div class="col-auto me-auto">
							<div>
								<p class="form-control-plaintext">${dataCount}개(${page}/${total_page}페이지)</p>
							</div>
						</div>
					</div>

					<div class="row ">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<c:if test="${dto.event == 0}">
								<div class="col-md-4 col-lg-3 p-1 item imagebox">
									<img class="img-fluid img-thumbnail w-100 h-100 image"
										src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}">

									<div class="textbox">
										<div >
											<a href="${articleUrl}&eveNum=${dto.eveNum}"
												title="${dto.eveTitle}" class="text"> ${dto.eveTitle}</a>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>

				<div class="row board-list-footer">
					<div class="col"></div>
					<div class="col"></div>
					<div class="col-6 text-center">
						<form name="searchForm" class="row"
							action="${pageContext.request.contextPath}/event/list.do"
							method="post">
							<div class="col-auto p-1">
								<select name="condition" class="form-select">
									<option value="all"
										${condition=="all"?"selected='selected='selected'":""}>제목+내용</option>
									<option value="reg_date"
										${condition=="reg_date"?"selected='selected'":""}>등록일</option>
									<option value="subject"
										${condition=="subject"?"selected='selected'":""}>제목</option>
									<option value="content"
										${condition=="content"?"selected='selected'":""}>내용</option>
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
						<c:if test="${sessionScope.member.userId=='admin'}">
							<button type="button" class="btn btn-light"
								onclick="location.href='${pageContext.request.contextPath}/event/write.do';">이벤트
								등록</button>
						</c:if>
					</div>
				</div>
				<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</div>
			</div>
		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>