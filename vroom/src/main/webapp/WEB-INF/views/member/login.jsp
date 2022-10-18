<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

*, ::after, ::before {
	box-sizing: border-box;
}

div.row {
	display: flex;
	justify-content: center;
}

div.member {
	border-bottom: 1px solid lightgray;
	border-right: 1px solid lightgray;
	box-shadow: 5px 5px 5px lightgray;
	border-radius: 20px;
	width: 450px;
	margin: 20px;
	padding: 10px;
	display: inline-block;
	height: 250px;
}

div.member-2 {
	width: 300px;
}

button {
	background-color: #4971FF;
	cursor: pointer;
	margin: 0;
	padding: 0.5rem;
	font-family: "Noto Sans KR", sans-serif;
	font-weight: bold;
	font-size: 1rem;
	text-align: center;
	text-decoration: none;
	color: white;
	display: inline-block;
	width: 20%;
	border: none;
	border-radius: 4px;
}

h4.semi-title {
	margin-bottom: 30px;
}

form {
	margin: 20px 20px 0 20px;
	display: flex;
	justify-content: center;
}

div.form-1{ width: 80%;}

div.form-2 {
	display: flex;
	justify-content: space-between;
}

input.form-control {
	background-color: #E7E7E7;
	border-style: none;
	margin: 5px;
	padding: 10px;
    height: 4em;
    width: 90%;
}

div.form-check {
	margin: 10px;
	font-size: small;
    display: flex;
    justify-content: space-between;
}

div.notmember {
	display: flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
	margin: 20px
}

button.btn-notmember {
	margin: 10px 15px;
	height: 4em;
	width: 200px;
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
				<div class="row">
					<div class="member">
						<div class="title">
							<h3>회원 로그인</h3>
						</div>
						<form name="loginForm" action="" method="post" class="row-3">
							<div class="form-1">
								<input type="text" name="userId" class="form-control"
									placeholder="아이디를 입력하세요"> <input type="password"
									name="userPwd" class="form-control" placeholder="비밀번호를 입력하세요">
							</div>
							<button type="button" class="btn form-control"
								onclick="sendLogin();">&nbsp;로그인&nbsp;</button>
						</form>
						<div class="form-check">
							<div>
							<input class="form-check-input" type="checkbox" id="rememberMe">
							<label class="form-check-label" for="rememberMe"> 아이디
								기억하기 </label>
							</div>
							<div>
								<a href="#" class="text-decoration-none me-2">아이디 찾기</a> <span>/</span>
								<a href="#" class="text-decoration-none me-2">비밀번호 찾기</a> <span>/</span>
								<a href="${pageContext.request.contextPath}/member/member.do"
									class="text-decoration-none">회원가입</a>
							</div>
						</div>
					</div>
					<div class="member member-2">
						<div class="title">
							<h3>비회원 예매</h3>
						</div>
						<div class="notmember">
							<div class="col-12">
								<button type="button" class="btn btn-notmember" 
								onclick="${pageContext.request.contextPath}/reserve/list.do">&nbsp;비회원
									조회&nbsp;</button>
							</div>
							<div class="col-12">
								<button type="button" class="btn btn-notmember" onclick="#">&nbsp;비회원
									예매&nbsp;</button>
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