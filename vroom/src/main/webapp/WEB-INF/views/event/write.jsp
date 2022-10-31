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

.write-form .img-viewer {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	border-radius: 45px;
	background-image:
		url("${pageContext.request.contextPath}/resources/images/add_photo.png");
	position: relative;
	z-index: 9999;
	background-repeat: no-repeat;
	background-size: cover;
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">

<script type="text/javascript">
	function sendOk() {
		const f = document.eventForm;
		let str;

		str = f.eveTitle.value.trim();
		if (!str) {
			alert("제목을 입력하세요. ");
			f.eveTitle.focus();
			return false;
		}

		str = f.eveCont.value.trim();
		if (!str || str === "<p><br></p>") {
			alert("내용을 입력하세요. ");
			f.eveCont.focus();
			return false;
		}

		let mode = "${mode}";
		if ((mode === "write") && (!f.selectFile.value)) {
			alert("이미지 파일을 추가 하세요. ");
			f.selectFile.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/event/${mode}_ok.do";
		f.submit();
	}

	$(function() {
		let img = "${dto.imageFilename}";
		if (img) { // 수정인 경우
			img = "${pageContext.request.contextPath}/uploads/photo/" + img;
			$(".write-form .img-viewer").empty();
			$(".write-form .img-viewer").css("background-image",
					"url(" + img + ")");
		}

		$(".write-form .img-viewer").click(function() {
			$("form[name=eventForm] input[name=selectFile]").trigger("click");
		});

		$("form[name=eventForm] input[name=selectFile]")
				.change(
						function() {
							let file = this.files[0];
							if (!file) {
								$(".write-form .img-viewer").empty();
								if (img) {
									img = "${pageContext.request.contextPath}/uploads/photo/"
											+ img;
									$(".write-form .img-viewer").css(
											"background-image",
											"url(" + img + ")");
								} else {
									img = "${pageContext.request.contextPath}/resources/images/add_photo.png";
									$(".write-form .img-viewer").css(
											"background-image",
											"url(" + img + ")");
								}
								return false;
							}

							if (!file.type.match("image.*")) {
								this.focus();
								return false;
							}

							let reader = new FileReader();
							reader.onload = function(e) {
								$(".write-form .img-viewer").empty();
								$(".write-form .img-viewer").css(
										"background-image",
										"url(" + e.target.result + ")");
							}
							reader.readAsDataURL(file);
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
					<h2>이벤트</h2>
				</div>

				<div class="body-main mx-auto">
					<form name="eventForm" method="post" enctype="multipart/form-data">
						<table class="table write-form  mt-5">
							<tr>
								<td scope="row">제 목</td>
								<td><input type="text" name="eveTitle"
									value="${dto.eveTitle}"></td>
							</tr>

							<tr>
								<td scope="row" id="backColor">작성자명</td>
								<td>
									<p>${sessionScope.member.userId}</p>
								</td>
							</tr>

							<tr>
								<td class="col-sm-2" scope="row">이벤트진행여부</td>
								<td><input type="checkbox" class="form-check-input"
									name="event" id="event" value="1"
									${dto.event==1 ? "checked='checked' ":"" }> <label
									class="form-check-label" for="event">이벤트 종료</label></td>
							</tr>

							<tr>
								<td scope="row" id="backColor">내 용</td>
								<td><textarea name="eveCont" id="ir1"
										style="width: 95%; height: 270px;">${dto.eveCont}</textarea></td>
							</tr>
							<tr>
								<td class="col-sm-2" scope="row">이미지</td>
								<td>
									<div class="img-viewer"></div> <input type="file"
									name="selectFile" accept="image/*" class="form-control"
									style="display: none;">
								</td>
							</tr>
						</table>

						<table class="table table-borderless">
							<tr>
								<td class="text-center">
									<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i
											class="bi bi-check2"></i>
									</button>
									<button type="reset" class="btn btn-light">다시입력</button>
									<button type="button" class="btn btn-light"
										onclick="location.href='${pageContext.request.contextPath}/event/list.do';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i
											class="bi bi-x"></i>
									</button> <c:if test="${mode=='update'}">
										<input type="hidden" name="eveNum" value="${dto.eveNum}">
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

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>