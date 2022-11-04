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
main {
	position: relative;
	top: -55px;
	background: white;
}

.container {
	min-height: 900px;
}
</style>
<script type="text/javascript">
function searchList(){
	const f = document.searchForm;
	f.submit();
}

</script>



</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container body-container">
			<div class="body-title mb-4">
				<div class="fs-4 fw-bolder">회원정보조회</div>
			</div>

			<div class="mb-3">
				<form class="d-flex justify-content-end" name="searchForm" action="${pageContext.request.contextPath}/manage/member.do"
					method="post">
					<div class="col-auto p-1">
						<select name="condition" class="form-select form-select-sm">
							<option value="cusNum" ${condition=="cusNum"?"selected='selected'":""}>고객번호</option>
							<option value="userId" ${condition=="userId"?"selected='selected'":""}>아이디</option>
							<option value="name" ${condition=="name"?"selected='selected'":""}>이름</option>
						</select>
					</div>
					<div class="col-auto p-1">
						<input type="text" name="keyword" value="${keyword}" class="form-control form-control-sm">
					</div>
					<div class="col-auto p-1">
						<button type="button" class="btn btn-primary btn-sm" onclick="searchList()">검색</button>
						<button type="button" class="btn btn-primary btn-sm"
							onclick="location.href='${pageContext.request.contextPath}/manage/member.do'">검색 초기화</button>
					</div>
				</form>
			</div>

			<table class="table">
				<thead class="table-primary text-center">
					<tr>
						<th>고객번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>생년월일</th>
						<th>전화번호</th>
						<th>이메일</th>
						<th>가입일</th>
						<th>최근 정보수정일</th>
					</tr>
				</thead>
				<tbody class="text-center">
					<c:forEach var="dto" items="${list}">
						<tr>
							<td scope="row">${dto.cusNum}</td>
							<td scope="row">${dto.userId}</td>
							<td scope="row"><div class="sort">${dto.userName}</div></td>
							<td><div class="date-div">${dto.birth}</div></td>
							<td class="left">${dto.tel}</td>
							<td scope="row">${dto.email}</td>
							<td scope="row">${dto.reg_date}</td>
							<td scope="row">${dto.mod_date}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>
				
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>