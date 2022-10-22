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

div.member {
	border-bottom: 1px solid lightgray;
	border-right: 1px solid lightgray;
	box-shadow: 5px 5px 5px lightgray;
	border-radius: 15px;
	display: inline-block;
	width: 90%;
}

div.member2 {
	border-bottom: 1px solid lightgray;
	border-right: 1px solid lightgray;
	box-shadow: 5px 5px 5px lightgray;
	border-radius: 15px;
	display: inline-block;
	width: 40%;
}

div.form-1 {
	width: 80%;
	margin: auto;
}

.form-control {
	background-color: #E7E7E7;
	border-style: none;
	margin: 5px;
	padding: 10px;
	height: 4em;
	width: 90%;
	box-shadow: 2px 2px 2px lightgrey
}

.btn-control {
	border-style: none;
	margin: 5px;
	padding: 10px;
	height: 4em;
	width: 90%;
	box-shadow: 2px 2px 2px lightgrey
}

.loginbtn {
	width: 20%;
}
</style>

<script type="text/javascript">
function sendLogin() {
	const f = document.loginForm;
	
	if(! f.userId.value.trim() ){
		f.userId.focus();
		return;
	}
	
	if(! f.userPwd.value.trim() ){
		f.userPwd.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/member/login_ok.do";
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
				<div class="body-title mb-5">
					<div class="fs-4 fw-bolder">&nbsp;로그인</div>
				</div>

				<div class="d-flex">
					<div class="member p-3 m-3">
						<div class="mb-4">
							<h5>회원 로그인</h5>
						</div>
						<div class="form">
							<form name="loginForm" action="" method="post" class="d-flex">
								<div class="form-1 row ">
									<input type="text" name="userId" class="form-control col-6"
										placeholder="아이디를 입력하세요"> <input type="password"
										name="userPwd" class="form-control col-6"
										placeholder="비밀번호를 입력하세요">
								</div>
								<div class="loginbtn">
									<button type="button" class="btn btn-primary fw-bold"
										style="height: 100%; box-shadow: 2px 2px 2px lightgrey" onclick="sendLogin();">&nbsp;로그인&nbsp;</button>
								</div>
							</form>
							<div>
								<div class="p-2 pb-3 text-danger">${message}</div>
								<div class="d-flex justify-content-between">
									<div>
										<input class="form-check-input flex-grow-1" type="checkbox"
											id="rememberMe"> <label class="form-check-label"
											for="rememberMe"> 아이디 기억하기 </label>
									</div>
									<div>
										<a href="#" class="text-decoration-none text-dark">아이디 찾기</a>
										<span>/</span> <a href="#"
											class="text-decoration-none text-dark">비밀번호 찾기</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="member2 p-3 m-3">
						<div class="mb-4">
							<h5>비회원 예매</h5>
						</div>
						<div class="row gy-3 mt-4">
							<div class="col-12 m-2">
								<button type="button"
									class="btn btn-primary btn-control btn-lg mx-auto fw-bold"
									onclick="#">&nbsp;비회원
									예매&nbsp;</button>
							</div>
							<div class="col-12 m-2">
								<button type="button"
									class="btn btn-primary btn-control btn-lg mx-auto fw-bold"
									onclick="${pageContext.request.contextPath}/reserve/list.do">&nbsp;비회원 조회&nbsp;</button>
							</div>
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