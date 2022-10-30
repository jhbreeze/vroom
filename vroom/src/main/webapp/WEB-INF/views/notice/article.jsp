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
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deleteBoard() {
		if (confirm("게시글을 삭제 하시 겠습니까 ? ")) {
			let query = "boardNum=${dto.boardNum}&${query}";
			let url = "${pageContext.request.contextPath}/notice/delete.do?"
					+ query;
			location.href = url;
		}
	}
	</c:if>
</script>

<script type="text/javascript">
	function login() {
		location.href = "${pageContext.request.contextPath}/member/login.do";
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
					공지사항
				</h2>
			</div>

			<div class="body-main mx-auto">
				<table>
					<thead>
						<tr>
							<td>${dto.boSubject}</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>이름 : ${dto.name}</td>
							<td>${dto.boDate}</td>
						</tr>
						<tr>
							<td colspan="2" valign="top" height="200">${dto.boCont}</td>
						</tr>
						<tr>
							<td colspan="2">
								이전글 :
								<c:if test="${not empty preReadDto}">
									<a href="${pageContext.request.contextPath}/notice/article.do?${query}&boardNum=${preReadDto.boardNum}">${preReadDto.boSubject}</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								다음글 :
								<c:if test="${not empty nextReadDto}">
									<a href="${pageContext.request.contextPath}/notice/article.do?${query}&boardNum=${nextReadDto.boardNum}">${nextReadDto.boSubject}</a>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>

				<table class="table table-borderless">
					<tr>
						<td width="50%">
						<c:choose>
								<c:when test="${sessionScope.member.userId==dto.userId}">
									<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/notice/update.do?boardNum=${dto.boardNum}&page=${page}&size=${size}';">수정</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled="disabled">수정</button>
								</c:otherwise>
							</c:choose>
						<c:choose>
								<c:when
									test="${sessionScope.member.userId=='admin'}">
									<button type="button" class="btn btn-light"
										onclick="deleteBoard();">삭제</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
								</c:otherwise>
							</c:choose></td>
						<td class="text-end">
							<button type="button" class="btn btn-light"
								onclick="location.href='${pageContext.request.contextPath}/notice/list.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>