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
		<input type="hidden" name="statDiscern" value="${statDiscern}">
		<input type="hidden" name="endtDiscern" value="${endtDiscern}">
		
		<input type="hidden" name="cycle" value="${cycle}">
		
		<input type="hidden" name="adultCount" value="${adultCount}">
		<input type="hidden" name="childCount" value="${childCount}">
		
		<input type="hidden" name="staDate" value="${staDate}">
		<input type="hidden" name="endDate" value="${endDate}">
		
		<input type="hidden" name="deptStaDateTime" value="${deptStaDateTime}">
		<input type="hidden" name="deptEndDateTime" value="${deptEndDateTime}">
		<input type="hidden" name="destStaDateTime" value="${destStaDateTime}">
		<input type="hidden" name="destEndDateTime" value="${destEndDateTime}">
		
		<input type="hidden" name="depstatDetailCode" value="${depstatDetailCode}">
		<input type="hidden" name="desstatDetailCode" value="${desstatDetailCode}">
		<input type="hidden" name="dependtDetailCode" value="${dependtDetailCode}">
		<input type="hidden" name="desendtDetailCode" value="${desendtDetailCode}">
		<input type="hidden" name="staSeats" value="${staSeats}">
		<input type="hidden" name="endSeats" value="${endSeats}">
		
		<input type="hidden" name="staTHoNum" value="${staTHoNum}">
		<input type="hidden" name="endTHoNum" value="${endTHoNum}">
		
		<input type="hidden" name="staGrade" value="${staGrade}">
		<input type="hidden" name="endGrade" value="${endGrade}">
		
		<input type="hidden" name="staadultCost" value="${staadultCost}">
		<input type="hidden" name="stachildCost" value="${stachildCost}">
		<input type="hidden" name="endadultCost" value="${endadultCost}">
		<input type="hidden" name="endchildCost" value="${endchildCost}">
		<input type="hidden" name="statotalCost" value="${statotalCost}">
		<input type="hidden" name="endtotalCost" value="${endtotalCost}">
		
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
		money = $('input[name="statotalCost"]').val(); 
	} else {
		let money1 = $('input[name="statotalCost"]').val().replace(",", "");
		let money2 = $('input[name="endtotalCost"]').val().replace(",", "");
		money = Number(money1) + Number(money2);
		alert(money);
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
				
				f.action = "${pageContext.request.contextPath}/reservetrain/insertPayInfo.do";
				f.submit();
				
			} else {
				msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                location.href="${pageContext.request.contextPath}/reservetrain/beforePayment.do";
                alert(msg);
			}
		});
		
	}
</script>

</body>
</html>