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
					<i class="fa-regular fa-square"></i> 이벤트
				</h2>
			</div>

			<div class="body-main">
				<div>
					<div>${dataCount}개(${page}/${total_page}페이지)</div>
					<div>&nbsp;</div>
				</div>
			</div>

			<table class="table table-hover board-list">
				<thead>
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
							<td><a href="${articleUrl}&eveNum=${dto.eveNum}">${dto.eveTitle}</a>
							</td>
							<td>${dto.eveRegDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div>${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</div>

			<div>
				<div>
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/event/list.do';">새로고침</button>
				</div>
				<div>
					<form name="searchForm"
						action="${pageContext.request.contextPath}/event/list.do"
						method="post">
						<div>
							<select>
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
					</form>
				</div>
				<div>
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/event/write.do';">글올리기</button>
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