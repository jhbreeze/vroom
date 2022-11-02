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

<script type="text/javascript">
	function searchList() {
		const f = document.searchForm;
		f.submit();
	}

	<c:if test="${sessionScope.member.userId=='admin'}">
	function deleteBoard() {
		let query = "faqNum=${dto.faqNum}&${query}";
		let url = "${pageContext.request.contextPath}/faq/delete.do?" + query;
		location.href = url;
	}
	</c:if>
</script>

<script type="text/javascript">
	function check() {
		const f = document.boardForm;
		let str;

		str = f.faqSubject.value.trim();
		if (!str) {
			alert("제목을 입력하세요. ");
			f.faqSubject.focus();
			return false;
		}

		str = f.faqContent.value.trim();
		if (!str || str === "<p><br></p>") {
			alert("내용을 입력하세요. ");
			f.faqContent.focus();
			return false;
		}

		f.action = "${pageContext.request.contextPath}/faq/write_ok.do";
		f.submit();
	}

	<c:if test="${sessionScope.member.userId=='admin'}">
	$(function() {
		$("#chkAll").click(function() {
			if ($(this).is(":checked")) {
				$("input[name=faqNums]").prop("checked", true);
			} else {
				$("input[name=faqNums]").prop("checked", false);
			}
		});

		$("#btnDeleteList").click(function() {
			let cnt = $("input[name=faqNums]:checked").length;
			if (cnt === 0) {
				alert("삭제할 게시물을 먼저 선택하세요.");
				return false;
			}

			const f = document.listForm;
			f.action = "${pageContext.request.contextPath}/faq/deleteList.do";
			f.submit();
		});
	});
	</c:if>
</script>
<style type="text/css">
main {
	position: relative;
	top: -55px;
	background: white;
}

#accordion:hover {
	background: #fff;
	box-shadow: 0px 0px 4px rgb(72, 92, 161, 0.4);
}

.container {
	min-height: 700px;
}

.body-container {
	max-width: 1200px;
	margin: auto;
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

.col-3, .container {
	box-shadow: 4px 4px 4px rgb(72, 92, 161, 0.2);
	border: none;
	border-radius: 30px;
}
.backColor{
background-color : #99ccff;
color: black;
font-size: 20px;
font-weight: 600;
}
#header2{
background: #0E6EFD;
color: white;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">



</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container ">
			<div class="body-container">
				<div class="body-title">
					<h2>자주하는 질문</h2>
				</div>

				<div class="reply">
					<c:if test="${sessionScope.member.userId=='admin'}">
						<form name="boardForm" method="post">
							<div class='form-header'>
								<span class="bold">질문/답변
									<button type="button" class='btn btn-light btnSendReply'
										onclick="check();">등록하기&nbsp;</button>
								</span>
							</div>

							<table class="table write-form  mt-5">
								<tr>
									<td class="col-sm-2" scope="row" id='header'>제
										목</td>
									<td><input type="text" name="faqSubject"
										class="form-control" value="${dto.faqSubject}"></td>
								</tr>
								<tr>
									<td class="col-sm-2" scope="row" id='header2'>내
										용</td>
									<td><textarea class='form-control' name="faqContent">${dto.faqContent}</textarea>
									</td>
								</tr>
							</table>
						</form>
					</c:if>

					<div id="listReply"></div>
				</div>

				<div class="body-main">
					<div>
						<div>${dataCount}개(${page}/${total_page}페이지)</div>
						<div>&nbsp;</div>
					</div>
				</div>

				<div class="accordion accordion-flush" id="accordionFlush">
					<form name="listForm" method="post">
						<c:if test="${sessionScope.member.userId=='admin'}">
							<input type="checkbox" class="form-check-input" name="chkAll"
								id="chkAll">
							<button type="button" class="btn btn-light"
								data-bs-toggle="modal" data-bs-target="#exampleModal" title="삭제">
								<i class="bi bi-trash"></i>
							</button>
						</c:if>
						<c:forEach var="dto" items="${list}" varStatus="status">

							<div class="accordion-item" id="accordion">
								<c:if test="${sessionScope.member.userId=='admin'}">
									<input type="checkbox" class="form-check-input" name="faqNums"
										value="${dto.faqNum}">
								</c:if>
								<h2 class="accordion-header" id="flush-heading-${status.index}">
									<button class="accordion-button collapsed  backColor"
										type="button" data-bs-toggle="collapse"
										data-bs-target="#flush-collapse-${status.index}"
										aria-expanded="false"
										aria-controls="flush-collapse-${status.index}">
										${dto.faqSubject}</button>

								</h2>
								<div id="flush-collapse-${status.index}"
									class="accordion-collapse collapse"
									aria-labelledby="flush-heading-${status.index}"
									data-bs-parent="#accordionFlush">
									<div class="accordion-body">${dto.faqContent }</div>
								</div>
							</div>
						</c:forEach>
					</form>
				</div>


				<div class="modal fade" id="exampleModal" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">자주하는 질문</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">게시글을 삭제하시겠습니까?</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">아니요</button>
								<button type="button" class="btn btn-primary" id="btnDeleteList">예</button>
							</div>
						</div>
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