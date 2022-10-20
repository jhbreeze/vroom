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
	function check() {
		const f = document.boardForm;
		let str;

		str = f.eveTitle.value.trim();
		if (!str) {
			alert("제목을 입력하세요. ");
			f.eveTitle.focus();
			return false;
		}

		str = f.content.value.trim();
		if (!str || str === "<p><br></p>") {
			alert("내용을 입력하세요. ");
			f.content.focus();
			return false;
		}

		f.action = "${pageContext.request.contextPath}/event/write_ok.do";
	}

	<c:if test="${mode=='update'}">
	function deleteFile(num) {
		if (!confirm("파일을 삭제하시겠습니까 ?")) {
			return;
		}
		let url = "${pageContext.request.contextPath}/event/deleteFile.do?num="
				+ num + "&page=${page}";
		location.href = url;
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

			<div class="body-main">
				<form name="boardForm" method="post" enctype="multipart/form-data"
					onsubmit="return submitContents(this);">
					<table class="table write-form mt-5">
						<tr>
							<td scope="row">제 목</td>
							<td><input type="text" name="eveTitle"
								value="${dto.eveTitle}"></td>
						</tr>

						<tr>
							<td scope="row">작성자명</td>
							<td>
								<p>${sessionScope.member.userName}</p>
							</td>
						</tr>

						<tr>
							<td scope="row">내 용</td>
							<td><textarea name="content" id="ir1"
									style="width 1000px; height: 270px;">${dto.eveCont}</textarea></td>
						</tr>
					</table>

					<table class="table table-borderless">
						<tr>
							<td class="text-center">
								<button type="submit" class="btn btn-dark">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i
										class="bi bi-check2"></i>
								</button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light"
									onclick="location.href='${pageContext.request.contextPath}/event/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i
										class="bi bi-x"></i>
								</button> <c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.eveNum}">
									<input type="hidden" name="page" value="${page}">
								</c:if>
							</td>
						</tr>
					</table>
				</form>
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
				// elClickedObj.form.submit();
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