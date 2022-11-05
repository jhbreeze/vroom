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

<style type="text/css">
main {
	position: relative;
	top: -55px;
	background: white;
}

.container {
	min-height: 700px;
}

.container {
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
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">
<script type="text/javascript">
	function check() {
		const f = document.boardForm;
		let str;

		str = f.qnaSubject.value.trim();
		if (!str) {
			alert("제목을 입력하세요. ");
			f.qnaSubject.focus();
			return false;
		}

		str = f.qnaContent.value.trim();
		if (!str || str === "<p><br></p>") {
			alert("내용을 입력하세요. ");
			f.qnaContent.focus();
			return false;
		}

		f.action = "${pageContext.request.contextPath}/qna/write_ok.do";
	}
</script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title mb-4">
					<div class="fs-4 fw-bolder">1:1 문의</div>
				</div>

				<div class="body-main mx-auto">
					<form name="boardForm" method="post" enctype="multipart/form-data"
						onsubmit="return submitContents(this);">
						<table class="table write-form mt-5">
							<tr>
								<td scope="row">제목</td>
								<td><input type="text" name="qnaSubject"
									value="${dto.qnaSubject}"></td>
							</tr>
							<tr>
								<td class=" col-sm-2" scope="row">작성자명</td>
								<td>
									<p class="form-control-plaintext">${sessionScope.member.userName}</p>
								</td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea name="qnaContent" id="ir1">${dto.qnaContent}</textarea>
								</td>
							</tr>
						</table>
						<table class="table table-borderless">
							<tr>
								<td class="text-center">
									<button type="submit" class="btn btn-dark">
										등록하기<i class="bi bi-check2"></i>
									</button>
									<button type="reset" class="btn btn-light">다시입력</button>
									<button type="button" class="btn btn-light"
										onclick="location.href='${pageContext.request.contextPath}/qna/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i
											class="bi bi-x"></i>
									</button> <c:if test="${mode=='update'}">
										<input type="hidden" name="qnaNum" value="${dto.qnaNum}">
										<input type="hidden" name="page" value="${page}">
									</c:if>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</main>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
		charset="utf-8"></script>
	<script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator
				.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "ir1",
					sSkinURI : "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
					fCreator : "createSEditor2"
				});

		function submitContents(elClickedObj) {
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
			try {
				return check();
			} catch (e) {
			}
		}

		function setDefaultFont() {
			var sDefaultFont = '돋움';
			var nFontSize = 12;
			oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
		}
	</script>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>