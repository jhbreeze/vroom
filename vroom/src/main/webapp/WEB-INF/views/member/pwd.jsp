<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>VROONG</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

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

</style>

<script type="text/javascript">
function sendOk() {
	const f = document.pwdForm;

	let str = f.userPwd.value;
	if(!str) {
		alert("비밀번호를 입력하세요. ");
		f.userPwd.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/member/pwd_ok.do";
	f.submit();
}
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="container">
		<div class="body-container">	

	        <div class="row justify-content-md-center">
	            <div class="col-md-7">
	                <div class="mt-5 pb-2">
	                    <form name="pwdForm" method="post" class="row g-3">
	                        <h3 class="text-center fw-bold">🔹 비밀번호 확인 🔹</h3>
	                        
			                <div class="d-grid">
								<p class="form-control-plaintext text-center mb-3">본인확인을 위해 비밀번호를 입력해주세요.</p>
			                </div>
	                        
	                        <div class="d-grid">
	                            	<input type="text" name="userId" class="form-control form-control-lg" placeholder="아이디"
	                            		value="${sessionScope.member.userId}" readonly="readonly">
	                        </div>
	                        <div class="d-grid">
	                            <input type="password" name="userPwd" class="form-control form-control-lg" placeholder="비밀번호">
	                        </div>
	                        <div class="d-grid">
	                            <button type="button" class="btn btn-lg btn-primary" onclick="sendOk();">다음 단계</button>
	                            <input type="hidden" name="mode" value="${mode}">
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
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>

</body>
</html>