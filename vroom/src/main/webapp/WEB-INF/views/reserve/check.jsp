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
	max-width: 800px;
	margin: auto;
}

</style>

<script type="text/javascript">

function sendOk() {
	const f = document.checkForm;

	let str = f.reserveNum.value.trim();
	if (!str) {
		alert("예매번호를 입력하세요. ");
		f.reserveNum.focus();
		return;
	}
	
	str = f.reserveNum.value;
	if (!/^\d+$/.test(str)) {
		alert("예매번호를 다시 입력해주세요.")
		f.reserveNum.focus();
		return;
	}
	
	str = f.tel.value.trim();
	if (!str) {
		alert(" 전화번호를 입력하세요. ");
		f.tel.focus();
		return;
	}
	
	/*
	let str = f.reserveNum.value.trim();
	if ( str !== f.reserveNum.valuetrim) {
		alert("예매번호 혹은 전화번호가 존재하지 않습니다. ");
		f.reserveNum.focus();
		return;
	}
	
	let str =  f.tel.value.trim();
	if ( str !== f.tel.valuetrim) {
		alert("예매번호 혹은 전화번호가 존재하지 않습니다. ");
		f.tel.focus();
		return;
	}
		
	*/	
	
	
	f.action = "${pageContext.request.contextPath}/reserve/check_ok.do";
	f.submit();
}



</script>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">

				<div class="row justify-content-md-center">
					<div class="col-md-7">
						<div class="mt-5 pb-2">
							<form name="checkForm" method="post" class="row g-3">
								<h3 class="text-center fw-bold">비회원 조회</h3>

								<div class="d-grid mb-3">
									<label class="mb-2 fw-bold">예매번호</label>
									<div class="d-grid">
										<input type="text" name="reserveNum" class="form-control form-control-lg" placeholder="예매번호를 입력해주세요">
									</div>
								</div>

								<div class="d-grid mb-3">
									<label class="mb-2 fw-bold">전화번호</label>
									<div class="d-grid">
										<input type="text" name="tel" class="form-control form-control-lg" placeholder="전화번호를 입력해주세요">
									</div>
								</div>

								<div class="d-grid">
									<button type="button" class="btn btn-lg btn-primary"
										onclick="sendOk();">조회하기</button>
								</div>
								<div class="d-grid">
									<p class="form-control-plaintext text-center p-1 ps-3 text-danger">${message}</p>
								</div>
							</form>
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