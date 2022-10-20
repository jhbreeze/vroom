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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">
<script type="text/javascript">
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deleteBoard() {
		if (confirm("게시글을 삭제 하시 겠습니까 ? ")) {
			let query = "num=${dto.eveNum}&${query}";
			let url = "${pageContext.request.contextPath}/event/delete.do?"
					+ query;
			location.href = url;
		}
	}
	</c:if>
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
					<i class="fa-regular fa-square"></i> 이벤트
				</h2>
			</div>

			<div class="body-main mx-auto">
				<table>
					<thead>
						<tr>
							<td colspan="2" align="center">${dto.eveTitle}</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td width="50%">이름 : ${dto.userId}</td>
							<td align="right">${dto.eveRegDate}</td>
						</tr>
						<tr>
							<td colspan="2" valign="top" height="200">${dto.eveCont}</td>
						</tr>
					</tbody>
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