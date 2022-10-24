<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 템플릿</title>
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
	min-height: 900px;
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
		<div class="container body-container">
			<div class="body-title">
				<h2>
					이벤트
				</h2>
			</div>

			<div class="body-main">
				<div>
					<div>${dataCount}개(${page}/${total_page}페이지)</div>
					<div>&nbsp;</div>
				</div>
			</div>

			<table class="table table-hover board-list">
				<thead class="table-light">
					<tr>
						<th class="num">번호</th>
						<th class="subject">제목</th>
						<th class="date">작성일</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<td>${dataCount - (page-1) * size - status.index}</td>
							<td class="left"><a
								href="${articleUrl}&eveNum=${dto.eveNum}" class="text-reset">${dto.eveTitle}</a>
							</td>
							<td>${dto.eveRegDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</div>

			<div class="row board-list-footer">
				<div class="col">
				</div>
				<div class="col">
				</div>
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
							onclick="location.href='${pageContext.request.contextPath}/event/write.do';">글올리기</button>
					</c:if>
				</div>
			</div>
		</div>
		
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>