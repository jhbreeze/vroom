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
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">
.container {
	min-height: 600px;
}

main {
	position: relative;
	top: -70px;
	background: white;
}

.body-container {
	max-width: 800px;
	margin: auto;
}
.next-btn {margin-top: 20px; width: 500px; height: 60px; font-size: 20px; border-radius: 8px;}
</style>

<script type="text/javascript">
function sendOk() {
	const f = document.checkForm;

	let str = f.userName.value;
	if (!str) {
		alert("탑승자 성함을 입력하세요. ");
		f.userName.focus();
		return;
	}

	str = f.userEmail.value;
	if (!str) {
		alert("이메일을 입력하세요. ");
		f.userEmail.focus();
		return;
	}

	str = f.tel1.value;
	if (!str) {
		alert("전화번호를 입력하세요. ");
		f.tel1.focus();
		return;
	}

	str = f.tel2.value;
	if (!/^\d{3,4}$/.test(str)) {
		alert("번호를 입력하세요. ");
		f.tel2.focus();
		return;
	}

	str = f.tel3.value;
	if (!/^\d{4}$/.test(str)) {
		alert("번호를 입력하세요. ");
		f.tel3.focus();
		return;
	}
	
	requestPay();
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

					<div class="col-md-7" style="width: 100%;">
						<div class="mt-5 pb-2" style="width: 500px; margin: 0px auto;">
							<form name="checkForm" method="post" class="row g-3">
								<h3 class="text-center fw-bold mb-4">예매자 정보 입력</h3>


								<div class="d-grid">
									<label class="mb-2 fw-bold">탑승자 성함</label>
									<div class="d-grid">
										<input type="text" name="userName"
											class="form-control form-control-lg" placeholder="성함">
									</div>
								</div>
								
								<label class="mb-2 fw-bold" for="tel1">휴대전화</label>
								<div class="col-sm-10 row">
									<div class="col-sm-3 pe-2">
										<input type="text" name="tel1" id="tel1"
											class="form-control p-2" value="" maxlength="3">
									</div>
									<div class="col-sm-1 px-1" style="width: 2%;">
										<p class="form-control-plaintext text-center">-</p>
									</div>
									<div class="col-sm-3 pe-2">
										<input type="text" name="tel2" id="tel2"
											class="form-control p-2" value="" maxlength="4">
									</div>
									<div class="col-sm-1 px-1" style="width: 2%;">
										<p class="form-control-plaintext text-center">-</p>
									</div>
									<div class="col-sm-3 pe-2">
										<input type="text" name="tel3" id="tel3"
											class="form-control p-2" value="" maxlength="4">
									</div>
								</div>
								<div class="d-grid">
									<label class="mb-2 fw-bold">이메일</label>
									<div class="d-grid">
										<input type="text" name="userEmail"
											class="form-control form-control-lg"
											placeholder="이메일을 입력해주세요">
									</div>
								</div>

								<div class="d-grid">
									<button type="button" class="btn btn-lg btn-primary next-btn"
										onclick="sendOk();">결제하기</button>
								</div>
								<div class="d-grid">
									<p
										class="form-control-plaintext text-center p-1 ps-3 text-danger">${message}</p>
								</div>
							</form>
						</div>

					</div>
				</div>

			</div>
	</main>
	
<form name="hiddenForm" method="post">
	<input type="hidden" name="bcycle" value="${bcycle}">
	
	<input type="hidden" name="bNor" value="${bNor}">
	<input type="hidden" name="bOld" value="${bOld}">
	<input type="hidden" name="bEle" value="${bEle}">
	
	<!-- 밑에 5개 추가함 -->
	<input type="hidden" name="bNumId" value="${bNumId}">
	<input type="hidden" name="bOperCode" value="${bOperCode}">
	<input type="hidden" name="busBoardDate" value="${busBoardDate}">
	<input type="hidden" name="reSeatArr" value="${reSeatArr}">
	<input type="hidden" name="seatTotNum" value="${seatTotNum}">
	
	<input type="hidden" name="busstaDate" value="${busstaDate}">
	<input type="hidden" name="busendDate" value="${busendDate}">
	
	<input type="hidden" name="bFirstStaTime" value="${bFirstStaTime}">
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	<input type="hidden" name="bFirstStaTime" value="${bFirstStaTime}">
	<input type="hidden" name="bEndStaTime" value="${bEndStaTime}">
	
	<input type="hidden" name="bSeatNum" value="${bSeatNum}">
	<input type="hidden" name="bSeatNum" value="${bSeatNum}">
	
	<input type="hidden" name="bName" value="${bName}">
	<input type="hidden" name="bType" value="${bType}">
	
	<input type="hidden" name="bNorFee" value="${bNorFee}">
	<input type="hidden" name="bOldFee" value="${bOldFee}">
	<input type="hidden" name="bEleFee" value="${bEleFee}">
	<input type="hidden" name="bNorFee" value="${bNorFee}">
	<input type="hidden" name="bOldFee" value="${bOldFee}">
	<input type="hidden" name="bEleFee" value="${bEleFee}">
	
	<input type="hidden" name="totFee" value="${totFee}">
	
	<input type="hidden" name="bRouteCode" value="${bRouteCode}">
	<input type="hidden" name="bRouteCode" value="${bRouteCode}">
	
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	<input type="hidden" name="bRouteDetailCode" value="${bRouteDetailCode}">
	
	<input type="hidden" name="name" >
	<input type="hidden" name="email">
	<input type="hidden" name="tel">
</form>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
	
<script>
	var IMP = window.IMP;
	IMP.init("imp63805620");

	var msg;
	var today = new Date();
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes(); // 분
	var seconds = today.getSeconds(); // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = hours + minutes + seconds + milliseconds;
	
	let money;

	if ( $('input[name="cycle"]').val() == "half" ) {
		money = $('input[name="totFee"]').val(); 
	} else {
		money = $('input[name="totFee"]').val() + $('input[name="bFee"]').val() 
	}		
	
	function requestPay() {
		let name = $("input[name=userName]").val();
		
		let tel1 = $("input[name=tel1]").val();
		let tel2 = $("input[name=tel2]").val();
		let tel3 = $("input[name=tel3]").val();
		let tel = tel1+'-'+tel2+'-'+tel3;
		
		let email = $("input[name=userEmail]").val();	
				
		const f = document.hiddenForm;
		f.name.value = name;
		f.email.value = email;
		f.tel.value = tel;
		
		IMP.request_pay({
			pg : 'kakaopay',
			merchant_uid : "IMP" + makeMerchantUid,
			name : ' : 운임요금',
			amount : money,
			buyer_name : name,
			buyer_email : email,
			buyer_tel : tel,
		}, function(rsp) {
			if (rsp.success) {
				
				alert("결제가 완료되었습니다.");
				
				f.action = "${pageContext.request.contextPath}/busreserve/insertpayinfo.do";
				f.submit();
				
			} else {
				msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                location.href="${pageContext.request.contextPath}/busreserve/buspassengerinfo.do";
                alert(msg);
			}
		});
		
	}
</script>

</body>
</html>