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
	function sendOk() {
		const f = document.noticeForm;
		let str;

		str = f.boSubject.value.trim();
		if (!str) {
			alert("제목을 입력하세요. ");
			f.boSubject.focus();
			return false;
		}

		str = f.boCont.value.trim();
		if (!str || str === "<p><br></p>") {
			alert("내용을 입력하세요. ");
			f.boCont.focus();
			return false;
		}
		str = f.categoryNum.value;
		str = f.notice.value;

		f.action = "${pageContext.request.contextPath}/notice/${mode}_ok.do";
		f.submit();
	}
</script>
<style type="text/css">
main {
	position: relative;
	top: -55px;
	background: white;
}

.container {
	min-height: 700px;
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

.body-container {
	max-width: 800px;
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
#backColor{
background: #0E6EFD;
color: white;
}
</style>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container ">
			<div class="body-container">
				<div class="body-title">
					<h2>공지사항</h2>
				</div>

				<div class="body-main mx-auto">
					<form name="noticeForm" method="post" enctype="multipart/form-data"
						onsubmit="return submitContents(this);">
						<table class="table write-form mt-5">
							<tr>
								<td scope="row">제 목</td>
								<td><input type="text" name="boSubject"
									value="${dto.boSubject}"></td>
							</tr>
							<tr>
								<td id="backColor" scope="row">항 목</td>
								<td><select name="categoryNum" class="form-select" >
										<option value="1"
											${dto.categoryNum == 1 ? "selected='selected' ":"" }>알림</option>
										<option value="2"
											${dto.categoryNum == 2 ? "selected='selected' ":"" }>보도기사</option>
								</select></td>
							</tr>
							<tr>
								<td class="col-sm-2" scope="row">공지여부</td>
								<td><input type="checkbox" class="form-check-input"
									name="notice" id="notice" value="1"
									${dto.notice==1 ? "checked='checked' ":"" }> <label
									class="form-check-label" for="notice"> 공지</label></td>
							</tr>
							<tr>
								<td class="col-sm-2" scope="row" id="backColor">작성자명</td>
								<td>
									<p class="form-control-plaintext">${sessionScope.member.userId}</p>
								</td>
							</tr>
							<tr>
								<td scope="row">내용</td>
								<td><textarea name="boCont" id="ir1">${dto.boCont}</textarea>
								</td>
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
										onclick="location.href='${pageContext.request.contextPath}/notice/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i
											class="bi bi-x"></i>
									</button> <input type="hidden" name="size" value="${size}"> <c:if
										test="${mode=='update'}">
										<input type="hidden" name="boardNum" value="${dto.boardNum}">
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
				// elClickedObj.form.submit();
				return sendOk();
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