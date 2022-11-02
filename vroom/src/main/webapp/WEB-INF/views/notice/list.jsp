<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 공지사항</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.container {
	min-height: 700px;
}

main {
	position: relative;
	top: -55px;
	background: white;
}

.body-container {
	max-width: 1200px;
	margin: auto;
}

tr {
	font-size: 15px;
}

tr:hover {
	background: #fff;
	box-shadow: 0px 0px 4px rgb(72, 92, 161, 0.4);
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

.sort-td {
	width: 80px;
}

.date-th {
	width: 100px;
}

.date-div {
	text-align: center;
}

.container {
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
	<c:if test="${sessionScope.member.userId=='admin'}">
	$(function() {
		$("#chkAll").click(function() {
			if ($(this).is(":checked")) {
				$("input[name=nums]").prop("checked", true);
			} else {
				$("input[name=nums]").prop("checked", false);
			}
		});

		$("#btnDeleteList")
				.click(
						function() {
							let cnt = $("input[name=nums]:checked").length;
							if (cnt === 0) {
								alert("삭제할 게시물을 먼저 선택하세요.");
								return false;
							}

							if (confirm("선택한 게시물을 삭제 하시겠습니까 ?")) {
								const f = document.listForm;
								f.action = "${pageContext.request.contextPath}/notice/deleteList.do";
								f.submit();
							}
						});
	});
	</c:if>
</script>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h2>공지사항</h2>
				</div>

				<div class="body-main">
					<form name="listForm" method="post">
						<div class="row board-list-header">
							<div class="col-auto me-auto">${dataCount}개(${page}/${total_page}
								페이지)</div>
							<div class="col-auto">&nbsp;</div>
							<br> <br>
						</div>


						<table class="table">
							<tbody>
								<c:forEach var="dto" items="${listNotice}">
									<tr>
										<td><span class="badge bg-primary text-center">공지</span></td>
										<td scope="row" class="text-center sort-td"><div
												class="sort">${dto.category}</div></td>
										<td class="left"><a
											href="${articleUrl}&boardNum=${dto.boardNum}"
											class="text-reset text-decoration-none">${dto.boSubject}</a></td>
										<td class="text-center date-th"><div class="date-div">${dto.boDate }</div></td>
									</tr>
								</c:forEach>
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr>
										<td scope="row" class="text-center">${dataCount - (page-1) * size - status.index}</td>
										<td scope="row" class="text-center sort-td"><div
												class="sort">${dto.category}</div></td>
										<td class="left"><a
											href="${articleUrl}&boardNum=${dto.boardNum}"
											class="text-reset text-decoration-none">${dto.boSubject}</a>
											<c:if test="${dto.gap<1}">
												<img
													src="${pageContext.request.contextPath}/resources/images/train.gif"
													width="5%">
											</c:if></td>
										<td class="text-center date-th"><div class="date-div">${dto.boDate }</div></td>
									</tr>
								</c:forEach>


							</tbody>
						</table>
					</form>

					<div class="row board-list-footer">
						<div class="col"></div>
						<div class="col"></div>
						<div class="col-6 text-center">
							<form class="row" name="searchForm" action="" method="post">
								<div class="col-auto p-1">
									<select name="condition" class="form-select form-select-sm">
										<option value="all">제목+내용</option>
										<option value="userName">작성자</option>
										<option value="reg_date">등록일</option>
										<option value="subject">제목</option>
										<option value="content">내용</option>
									</select>
								</div>
								<div class="col-auto p-1">
									<input type="text" name="keyword" value=""
										class="form-control form-control-sm">
								</div>
								<div class="col-auto p-1">
									<button type="button" class="btn btn-light btn-sm"
										onclick="searchList()">검색</button>
								</div>
							</form>
						</div>
						<div class="col text-end">
							<c:if test="${sessionScope.member.userId=='admin'}">
								<button type="button" class="btn btn-light btn-sm"
									onclick="location.href='${pageContext.request.contextPath}/notice/write.do?size=${size}';">글올리기</button>
							</c:if>
						</div>
					</div>

					<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
					</div>

				</div>
			</div>
		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>