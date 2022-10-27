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

.myTable { width: 70%; }

.tth { width: 20%; }


</style>

<script type="text/javascript">
	
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
				<div class="list-group" align="center">
					<a href="#" class="list-group-item list-group-item-action active"
						aria-current="true">회원정보 확인</a>
					<a href="${pageContext.request.contextPath}/reserve/list.do"
						class="list-group-item list-group-item-action">예매내역 확인</a> 
					<a href="#" class="list-group-item list-group-item-action">1:1 문의내역</a>
				</div>

				<div class="myTable ms-5">
						<table class="table table-bordered">
							<tbody class="text-center">
								<tr>
									<th class="table-primary text-center tth" >아이디</th>
									<td>${sessionScope.member.userId}</td>
									<th class="table-primary text-center tth">회원명</th>
									<td>${sessionScope.member.userName}</td>
								</tr>

								<tr>
									<th class="table-primary text-center tth">생년월일</th>
									<td colspan="3">${sessionScope.member.birth}</td>
								</tr>

								<tr>
									<th class="table-primary text-center tth">전화번호</th>
									<td colspan="3">${sessionScope.member.tel}</td>
								</tr>

								<tr>
									<th class="table-primary text-center tth">이메일</th>
									<td colspan="3">${sessionScope.member.email}</td>
								</tr>
							</tbody>
						</table>
						<div align="right"> 
							<button class="btn btn-primary"
								onclick="location.href='${pageContext.request.contextPath}/member/pwd.do?mode=update';">
								정보 수정</button>
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