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

	function insertBoard() {
		const f = document.pwdForm;
		let str;

		str = f.qnaPwd.value.trim();
		if (!str) {
			alert("비밀번호를 입력하세요. ");
			f.qnaPwd.focus();
			return false;
		}

		f.action = "${pageContext.request.contextPath}/qna/article1.do";
		f.submit();
	}

	$(function() {
		$(".btnpwd").click(function() {
			let qnaNum = $(this).attr("data-qnaNum");
			$("form[name=pwdForm] input[name=qnaNum]").val(qnaNum);
			$("#exampleModal").modal("show");
		});
	});
</script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title">
					<h2>1:1 문의</h2>
				</div>

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
							<th class="num text-center" width="10%">번호</th>
							<th class="subject" width="45%">제목</th>
							<th class="name text-center" width="15%">작성자</th>
							<th class="date" width="15%">작성일</th>
							<th class="hit text-center" width="15%">답변여부</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td scope="row" class="text-center" width="10%">${dataCount - (page-1) * size - status.index}</td>
								<td class="left" width="45%"><c:choose>
										<c:when
											test="${not empty sessionScope.member && sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
											<a href="${articleUrl}&qnaNum=${dto.qnaNum}"
												class="text-reset" id="href"
												class="text-reset text-decoration-none">${dto.qnaSubject}<i
												class="bi bi-unlock"></i></a>
										</c:when>
										<c:when
											test="${empty sessionScope.member && empty dto.userId}">
											<button type="button" class="btn btn-light btnpwd" id="button"
												data-qnaNum="${dto.qnaNum}">
												${dto.qnaSubject}<i class="bi bi-lock-fill"></i>
											</button>
										</c:when>
										<c:otherwise>
											${dto.qnaSubject}
									</c:otherwise>
									</c:choose></td>
								<td width="15%"><c:choose>
										<c:when test="${dto.name == '*'}"> <div class="text-center">${dto.qnaName}</div> </c:when>
										<c:otherwise><div class="text-center">${dto.name}</div></c:otherwise>
									</c:choose></td>
								<td class="text-left" width="15%"><div class="date-div">${dto.qnaRegDate}</div></td>
								<td class="text-center"  width="15%">${dto.replyCount == 0 ? "미답변" : "답변완료"}</td>
							</tr>

						</c:forEach>
					</tbody>
				</table>
				<form name="pwdForm" method="post">
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
									<input type="hidden" name="qnaNum"> <input
										type="hidden" name="page" value="${page}"> <input
										type="text" name="qnaPwd" value="${dto.qnaPwd}">
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
				</form>

				<div class="row board-list-footer">
					<div class="col"></div>
					<div class="col"></div>
					<div class="col-6 text-center">
						<form class="row" name="searchForm"
							action="${pageContext.request.contextPath}/qna/list.do"
							method="post">
							<div class="col-auto p-1">
								<select name="condition" class="form-select">
									<option value="all"
										${condition=="all"?"selected='selected'":""}>제목+내용</option>
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
									onclick="location.href='${pageContext.request.contextPath}/qna/write2.do';">글올리기</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-light"
									onclick="location.href='${pageContext.request.contextPath}/qna/write.do';">글올리기</button>
							</c:otherwise>
						</c:choose>
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