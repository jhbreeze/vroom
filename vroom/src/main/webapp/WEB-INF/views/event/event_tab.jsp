<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/bootstrap5/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/bootstrap5/icon/bootstrap-icons.css" type="text/css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/core.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/bootstrap5/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
$(function(){
	// 실행과 동시에 첫번째 탭에 출력할 내용
	$("#nav-1").load("서버주소");
	// $("#nav-1").html("<p> 탭-1 입니다.<p/>");
	
    // 탭을 클릭할 때 마다
    $("button[role='tab']").on("click", function(e){
		var tab = $(this).attr("aria-controls");
        var selector = "#nav-"+tab;
        
		// alert(selector);
		$(selector).load("/WEB-INF/views/layout/list2.jsp");
		// $(selector).html("<p> 탭-" + tab + " 입니다.<p/>");
    });
    
    // 탭이 변경 될때 마다
    $("button[role='tab']").on("shown.bs.tab", function(e){
		// var tab = $(this).attr("aria-controls");
        // var selector = "#nav-"+tab;
    });
});
</script>
</head>
<body>
	
<main>

		<div class="container mb-2 pt-3">

		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-1" type="button" role="tab" aria-controls="1" aria-selected="true">첫번째</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-2" type="button" role="tab" aria-controls="2" aria-selected="true">두번째</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="tab-3" data-bs-toggle="tab" data-bs-target="#nav-3" type="button" role="tab" aria-controls="3" aria-selected="true">세번째</button>
			</li>
		</ul>

		<div class="tab-content pt-2" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-tab-1">
			</div>
			<div class="tab-pane fade" id="nav-2" role="tabpanel" aria-labelledby="nav-tab-2">
			</div>
			<div class="tab-pane fade" id="nav-3" role="tabpanel" aria-labelledby="nav-tab-2">
			</div>
		</div>

	</div>

</main>

<footer>
</footer>

</body>
</html>