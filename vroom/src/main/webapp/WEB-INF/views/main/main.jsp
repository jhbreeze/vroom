<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 메인</title>
<jsp:include page="/WEB-INF/views/layout/static_mainHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.body-container { min-height: 900px; margin-top: 100px; }
.reserve-container { 
	background: #fff; width: 700px; height: 280px;
	position: relative; top: -400px; z-index: 100;  
	margin: 0px auto; border-radius: 20px;
}
.reserve-container div { border-radius: 5px; margin: 0; padding: 0; }
.tab-button {
	position: relative; top: -42px; background-color: rgba(0, 0, 0, 0.5); width: 250px;
	margin: 0px auto; border-radius: 30px; -webkit-backdrop-filter: blur(7px);backdrop-filter: blur(7px);
}
.nav-item {
	margin: 5px 10px;
}
.second-row, .third-row {
	height: 84px;
}
.reserve-tab { position: relative; top: -24px; }
.reserve-tab > div { width: 650px; margin: 0px auto; }
.countCus-btn { width: 100%; }
#countCus-left { color: #4971FF; font-weight: 600; float: left; } 
#countCus-right { text-align: right; float: right; font-weight: 600; color: #767676 }
#half, #full { padding: auto; }
.select-departure { margin-top: 10px; display: flex; width: 100%; }
.select-destination { margin-top: 10px; display: flex; width: 100%; }
.select-date { margin-top: 10px; display: flex; width: 100%; }
.small-text { font-size: 14px; text-align: left; }
.middle-hilight-text { font-weight: 600; color: #4971FF; font-size: 18px; text-align: left; }
.train-container {  }
</style>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap5/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap5/icon/bootstrap-icons.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap5/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
<form name="reserveForm" method="post">
	<div class="mb-2 pt-3 reserve-container">
		
		<ul class="nav nav-pills justify-content-center tab-button" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true">버 스</button>
			</li>
			<li class="nav-item" role="presentation" >
				<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true">기 차</button>
			</li>
		</ul>

		<div class="tab-content reserve-tab" id="nav-tabContent" role="group" aria-label="Basic radio toggle button group">
		
		
			<div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
				버스 부분
			</div>
			
			
			<div class="tab-pane fade train-container justify-content-center" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
				<div class="btn-goup row row-cols-3 text-dark text-center" style="margin: 0px;">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
  					<label class="col-3 btn btn-outline-primary" id="half" for="btnradio1" style="margin: 2px; width: 24%"><span>편 도</span></label>
					<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
  					<label class="col-3 btn btn-outline-primary" id="full" for="btnradio2" style="margin: 2px; width: 24%"><span>왕 복</span></label>

					<div class="col-6 border" style="margin: 2px; width: 49%">
					  <button type="button" class="btn countCus-btn position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal">
					  	<span id="countCus-left">인원</span>
					  	<span id="countCus-right">성인 1명</span>
					  </button>
					</div>
				</div>
				<div class="row row-cols-3 text-dark second-row">
					<div class="col-3 border" style="margin: 2px; width: 24%">
					  	<button type="button" class="btn select-departure position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal1">
					  		<div class="small-text">출발지</div>
					  		<div class="middle-hilight-text">선택</div>
					  	</button>
					</div>
					<div class="col-3 border" style="margin: 2px; width: 24%">
					  	<button type="button" class="btn select-destination position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal2">
						  	<div class="small-text">도착지</div>
						  	<div class="middle-hilight-text">선택</div>
					  	</button>
					</div>
					<div class="col-6 border" style="margin: 2px; width: 49%">
						<button type="button" class="btn select-date position-relative" data-bs-toggle="modal" data-bs-target="#myDialogModal3">
						  	<div class="small-text">가는날</div>
						  	<div class="middle-hilight-text">2022.10.13 목</div>
					 	 </button>
					</div>
				</div>
				<div class="row row-cols-3 text-dark text-center third-row">
					<div class="col-6 border" style="margin: 2px; width: 48.75%">
					 	등급
					</div>
					<div class="col-6 border" style="margin: 2px; width: 48.75%">
					  조회
					</div>
				</div>
			</div>
		</div>

	</div>
</form>
<div class="modal fade" id="myDialogModal" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">인원</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<p>인원수 늘리기</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal1" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">출발지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<p>출발지 지정</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal2" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">도착지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<p>도착지 지정</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myDialogModal3" tabindex="-1" 
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">가는날</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		<p>가는날 지정</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>

<main>
	<div class="container body-container">
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>