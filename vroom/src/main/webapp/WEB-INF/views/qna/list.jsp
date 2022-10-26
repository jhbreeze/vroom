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
</style>
<script type="text/javascript">
	function searchList() {
		const f = document.searchForm;
		f.submit();
	}
	function insertBoard() {
		let query = "qnaNum=${dto.qnaNum}&${query}";
		alert(query);
		// let url = "${pageContext.request.contextPath}/qna/article.do?" + query;
		// location.href = url;
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
					<i class="bi bi-patch-question"></i> 1:1 문의
				</h2>
			</div>

			<div class="body-main">
				<div class="row board-list-header">
					<div class="col-auto me-auto">${dataCount}개(${page}/${total_page}
						페이지)</div>
					<div class="col-auto">&nbsp;</div>
				</div>
			</div>

			<table>
				<thead>
					<tr>
						<th class="qnaNum">번호</th>
						<th class="qnaSubject">제목</th>
						<th class="userName">작성자</th>
						<th class="qnaRegDate">작성일</th>
						<th>답변여부</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<td>${dataCount - (page-1) * size - status.index}</td>
							<td class="left"><c:choose>
									<c:when
										test="${sessionScope.member.userId == dto.userId || sessionScope.member.userId=='admin'}">
										<a href="${articleUrl}&qnaNum=${dto.qnaNum}"
											class="text-reset">${dto.qnaSubject}</a>
									</c:when>
									<c:when test="${sessionScope.member.userId == null}">
										<button type="button" class="btn btn-light"
											data-bs-toggle="modal" data-bs-target="#exampleModal">
											${dto.qnaSubject}</button>
									</c:when>
									<c:otherwise>
									${dto.qnaSubject}
									</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${dto.name == null }">${dto.qnaName}</c:when>
									<c:otherwise>${dto.name}</c:otherwise>
								</c:choose></td>
							<td>${dto.qnaRegDate}</td>
							<td>${reCount == 0 ? "미답변" : "답변완료"}</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">패스워드를 입력하세요</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="text" name="qnaSubject" value="${dto.qnaPwd}">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary"
								onclick="insertBoard();">입력</button>
						</div>
					</div>
				</div>
			</div>

			<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>

			<div class="row board-list-footer">
				<div class="col"></div>
				<div class="col"></div>
				<div class="col-6 text-center">
					<form class="row" name="searchForm"
						action="${pageContext.request.contextPath}/qna/list.do"
						method="post">
						<div class="col-auto p-1">
							<select name="condition" class="form-select">
								<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
								<option value="name"
									${condition=="name"?"selected='selected'":""}>작성자</option>
								<option value="qnaRegDate"
									${condition=="qnaRegDate"?"selected='selected'":""}>등록일</option>
								<option value="qnaSubject"
									${condition=="qnaSubject"?"selected='selected'":""}>제목</option>
								<option value="qnaContent"
									${condition=="qnaContent"?"selected='selected'":""}>내용</option>
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
					<c:choose>
						<c:when test="${sessionScope.member.userId == dto.userId}">
							<button type="button" class="btn btn-light"
								onclick="location.href='${pageContext.request.contextPath}/qna/write2.do';">글올리기2</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-light"
								onclick="location.href='${pageContext.request.contextPath}/qna/write.do';">글올리기</button>
						</c:otherwise>
					</c:choose>

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