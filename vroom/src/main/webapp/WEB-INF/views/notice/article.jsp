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
<script type="text/javascript">
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deleteBoard() {
			let query = "boardNum=${dto.boardNum}&${query}";
			let url = "${pageContext.request.contextPath}/notice/delete.do?"
					+ query;
			location.href = url;
	}
	</c:if>
</script>

<script type="text/javascript">
	function login() {
		location.href = "${pageContext.request.contextPath}/member/login.do";
	}
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">
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

thead tr {
	font-size: 45px;
}

.col-3, .container {
	box-shadow: 4px 4px 4px rgb(72, 92, 161, 0.2);
	border: none;
	border-radius: 30px;
}

.body-container {
	max-width: 1200px;
	margin: auto;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #0E6EFD;
	color: #eee;
}
a {
	text-decoration-line: none;
}
</style>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h2>공지사항</h2>
				</div>

				<div class="body-main mx-auto">
					<table class="table">
						<thead>
							<tr>
								<td colspan="2" align="center">${dto.boSubject}</td>
							</tr>
						</thead>

						<tbody>
							<tr>
								<td width="50%">이름 : ${dto.name}</td>
								<td align="right">${dto.boDate}</td>
							</tr>
							<tr>
								<td colspan="2" valign="top" height="200">${dto.boCont}</td>
							</tr>
							<tr>
								<td colspan="2">이전글 : <c:if test="${not empty preReadDto}">
										<a
											href="${pageContext.request.contextPath}/notice/article.do?${query}&boardNum=${preReadDto.boardNum}">${preReadDto.boSubject}</a>
									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2">다음글 : <c:if test="${not empty nextReadDto}">
										<a
											href="${pageContext.request.contextPath}/notice/article.do?${query}&boardNum=${nextReadDto.boardNum}">${nextReadDto.boSubject}</a>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>

					<table class="table table-borderless">
						<tr>
							<td width="50%"><c:choose>
									<c:when test="${sessionScope.member.userId=='admin'}">
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/notice/update.do?boardNum=${dto.boardNum}&page=${page}&size=${size}';">수정</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">수정</button>
									</c:otherwise>
								</c:choose> <c:choose>
									<c:when test="${sessionScope.member.userId=='admin'}">
										<button type="button" class="btn btn-light"
											data-bs-toggle="modal" data-bs-target="#exampleModal">
											삭제</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">삭제</button>
									</c:otherwise>
								</c:choose></td>
							<td class="text-end">
								<button type="button" class="btn btn-light"
									onclick="location.href='${pageContext.request.contextPath}/notice/list.do?${query}';">리스트</button>
							</td>
						</tr>
					</table>
					<div class="modal fade" id="exampleModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">공지사항</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">게시글을 삭제하시겠습니까?</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">아니요</button>
									<button type="button" class="btn btn-primary"
										onclick="deleteBoard();">예</button>
								</div>
							</div>
						</div>
					</div>
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