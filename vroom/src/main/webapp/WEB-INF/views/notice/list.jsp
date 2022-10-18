<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 공지사항</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.container { min-height: 500px; }
main { 
	position: relative; top: -55px; background: white;
}
.body-container {
	max-width: 800px; margin: auto;
}
tr { font-size: 13px; }

tr:hover { background: #fff; box-shadow: 0px 0px 4px rgb(72, 92, 161, 0.4); }

.sort{
	font-size: 8px; border: 1px solid #e2e2e2; width: 50px; 
	height: 20px; border-radius: 20px;
	display : flex; justify-content : center; align-items : center;
}
.sort-td { width: 80px; }
.date-th { width: 100px; }
.date-div { font-size: 10px; line-height: 20.5px; }
</style>

<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
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
			<div class="body-title">
				<div class="fs-5 fw-bolder">&nbsp;공지사항</div>
			</div>
			
			<div class="body-main">
		        <div class="row board-list-header">
		            <div class="col-auto">&nbsp;</div>
		        </div>				
				
				<table class="table">
					<tbody>
						<tr>
							<td scope="row" class="text-center">1</td>
							<td scope="row" class="text-center sort-td"><div class="sort">알림</div></td>
							<td class="left">
								<a href="#" class="text-reset text-decoration-none">기차 운행정보 공지</a>
							</td>
							<td class="text-center date-th"><div class="date-div">2022-01-01</div></td>
						</tr>
						<tr>
							<td scope="row" class="text-center">2</td>
							<td scope="row" class="text-center sort-td"><div class="sort">보도기사</div></td>
							<td class="left">
								<a href="#" class="text-reset text-decoration-none">"부릉" 편리한 예매 서비스</a>
							</td>
							<td class="text-center date-th"><div class="date-div">2022-01-01</div></td>
						</tr>
						<tr>
							<td scope="row" class="text-center">3</td>
							<td scope="row" class="text-center sort-td"><div class="sort">알림</div></td>
							<td class="left">
								<a href="#" class="text-reset text-decoration-none">버스 운행정보 공지</a>
							</td>
							<td class="text-center date-th"><div class="date-div">2022-01-01</div></td>
						</tr>
						<tr>
							<td scope="row" class="text-center">4</td>
							<td scope="row" class="text-center sort-td"><div class="sort">알림</div></td>
							<td class="left">
								<a href="#" class="text-reset text-decoration-none">환불 정책 공지</a>
							</td>
							<td class="text-center date-th"><div class="date-div">2022-01-01</div></td>
						</tr>
						<tr>
							<td scope="row" class="text-center">5</td>
							<td scope="row" class="text-center sort-td"><div class="sort">알림</div></td>
							<td class="left">
								<a href="#" class="text-reset text-decoration-none">비회원 아동, 노약자 인증 방법</a>
							</td>
							<td class="text-center date-th"><div class="date-div">2022-01-01</div></td>
						</tr>
						<tr>
							<td scope="row" class="text-center">6</td>
							<td scope="row" class="text-center sort-td"><div class="sort">알림</div></td>
							<td class="left">
								<a href="#" class="text-reset text-decoration-none">예매 순서 및 방법</a>
							</td>
							<td class="text-center date-th"><div class="date-div">2022-01-01</div></td>
						</tr>
						<tr>
							<td scope="row" class="text-center">7</td>
							<td scope="row" class="text-center sort-td"><div class="sort">알림</div></td>
							<td class="left">
								<a href="#" class="text-reset text-decoration-none">부릉 인사드립니다.</a>
							</td>
							<td class="text-center date-th"><div class="date-div">2022-01-01</div></td>
						</tr>
						
					</tbody>
				</table>
				
				<div class="page-navigation">
					페이지 들어갈 곳
				</div>

				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn btn-light"></button>
					</div>
					<div class="col-6 text-center">
						<form class="row" name="searchForm" action="" method="post">
							<div class="col-auto p-1">
								<select name="condition" class="form-select form-select-sm">
									<option value="all" >제목+내용</option>
									<option value="userName">작성자</option>
									<option value="reg_date">등록일</option>
									<option value="subject">제목</option>
									<option value="content">내용</option>
								</select>
							</div>
							<div class="col-auto p-1">
								<input type="text" name="keyword" value="" class="form-control form-control-sm">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light btn-sm" onclick="searchList()">검색</button>
							</div>
						</form>
					</div>
					<div class="col text-end">
						<button type="button" class="btn btn-light btn-sm" onclick="location.href='">글올리기</button>
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