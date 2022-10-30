<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>VROONG</title>
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
	max-width: 600px;
	margin: auto;
}

.form-input {
	height: min-content;
}
</style>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">

				<div class="row justify-content-md-center">
					<div class="mt-5 pb-2">
						<h3 class="text-center fw-bold mb-4">🚄🚌🚄🚌 예매 완료 🚄🚌🚄🚌</h3>

						<div class="d-grid">
							<p class="form-control-plaintext text-center mt-3">거래가 정상적으로
								처리되었습니다.</p>
							<p class="form-control-plaintext text-center mb-3">이용해주셔서
								감사합니다.</p>
						</div>
						<div align="center">
							<button type="button" class="btn btn-lg btn-primary"
								onclick="location.href='${pageContext.request.contextPath}/reserve/list.do';">예매내역 확인</button>
						</div>
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