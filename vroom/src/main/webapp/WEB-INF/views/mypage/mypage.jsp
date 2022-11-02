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
.container {
	min-height: 700px;
}

main {
	position: relative;
	top: -55px;
	background: white;
}

.myTable { width: 70%; }

.tth { width: 20%; }


.myRow { margin : 20px; align-items: center; }

</style>

<script type="text/javascript">
function deleteOK(){
	if(confirm("회원을 탈퇴하시겠습니까 ? ")) {
		location.href="${pageContext.request.contextPath}/member/pwd.do?mode=delete";
	}


}
</script>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-title mb-5">
				<div class="fs-4 fw-bolder">🔉&nbsp;마이페이지</div>
			</div>

			<div class="body-container d-flex">
				<div class="list-group" style="width: 20%">
					<a href="#" class="list-group-item list-group-item-action active"
						aria-current="true">회원정보 확인</a>
					<a href="${pageContext.request.contextPath}/reserve/list.do"
						class="list-group-item list-group-item-action">예매내역 확인</a> 
				</div>

				<div class="myTable ms-5 ">
						<div class="d-flex myRow">
							<div class="me-3 fw-bold" >🔹 아이디</div>
							<div class="ms-3"><input class="form-control" readonly="readonly" value="${sessionScope.member.userId}" style="border-radius: 10px;"></div>
						</div>
						<div class="d-flex myRow">
							<div class="me-3 fw-bold">🔹 회원명</div>
							<div class="ms-3"><input class="form-control" readonly="readonly" value="${sessionScope.member.userName}" style="border-radius: 10px;"></div>
						</div>
						<div class="d-flex myRow">
							<div ><label class="me-2 fw-bold" for="userId">🔹 생년월일</label></div>
							<div class="ms-3"><input class="form-control" readonly="readonly" value="${sessionScope.member.birth}" style="border-radius: 10px;"></div>
						</div>
						<div class="d-flex myRow">
							<div ><label class="me-2 fw-bold" for="userId">🔹 전화번호</label></div>
							<div class="ms-3"><input class="form-control" readonly="readonly" value="${sessionScope.member.tel}" style="border-radius: 10px;"></div>
						</div>
						<div class="d-flex myRow">
							<div ><label class="me-3 fw-bold" for="userId">🔹 이메일</label></div>
							<div class="ms-3"><input class="form-control" readonly="readonly" value="${sessionScope.member.email}" style="border-radius: 10px;"></div>
						</div>
						
						<div class="myRow mt-5 ms-5"> 
							<button class="btn btn-primary me-4"
								onclick="location.href='${pageContext.request.contextPath}/member/pwd.do?mode=update';">
								정보 수정</button>
							<button class="btn btn-primary delete" onclick="deleteOK();">회원 탈퇴</button>	
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