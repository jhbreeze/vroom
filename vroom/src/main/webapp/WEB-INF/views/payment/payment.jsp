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
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container { min-height: 480px; }
.ticket { 
	width: 500px; box-shadow: 0px 0px 8px rgb(72, 92, 161, 0.3); min-height: 50px; 
	border-radius: 10px; margin: 0 auto; margin-top: 20px; padding: 20px 30px 20px 30px;
}
/* #check-title { 
	background: #0E6EFD; width: 250px; height: 40px; font-size: 17px;
	text-align: center; color: white; line-height: 40px; vertical-align: 40px;
	border-radius: 40px;
} */
#check-title { 
	font-size: 25px; font-weight: 600; width: 500px; margin: 0 auto;
}
#ticket-info { margin: 0 auto; width: 500px; }
.date { color: #0E6EFD; }
.info1 { color: gray; }
.info2 { font-weight: 600; font-size: 20px; }
.ticket-count { float: right; }
.direction { color: #0E6EFD; }
.btn-pay { margin-top: 20px; width: 500px; height: 60px; font-size: 20px; border-radius: 10px; }
</style>

<script type="text/javascript">

</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
		<div class="body-title mb-5">
			<div class="fs-4 fw-bolder">💳&nbsp;결제하기</div>
		</div>
		<div id="ticket-info">
			<div class="ticket">
				<span class="date">2022.10.31 월</span>
				<span class="ticket-count">어른&nbsp; 3매</span>
				<div class="info1">KTX&nbsp;&nbsp; 003</div>
				<div class="info2">서울&nbsp; 05:30 &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; 대전&nbsp; 06:32</div>
				<div class="info3">일반&nbsp;&nbsp; 1호차&nbsp;&nbsp; A-3, A-4, B-1&nbsp; <span class="direction">(역방향)</span></div>
			</div>
			<div class="ticket">
				<span class="date">2022.11.1 화</span>
				<span class="ticket-count">어른&nbsp; 3매</span>
				<div class="info1">KTX&nbsp;&nbsp; 005</div>
				<div class="info2">대전&nbsp; 05:30 &nbsp;<i class="bi bi-arrow-right"></i>&nbsp; 서울&nbsp; 06:32</div>
				<div class="info3">일반&nbsp;&nbsp; 2호차&nbsp;&nbsp; A-3, A-4, B-1&nbsp; <span class="direction">(상행)</span></div>
			</div>
			<div class="d-flex justify-content-center">
				<button id="check_module" class="btn btn-primary" type="button">결제하기</button>
			</div>
		</div>
	</div>
</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
<script>
	$("#check_module").click(function () {
		var IMP = window.IMP; // 생략가능
		IMP.init('imp63805620'); 
		var msg;
		
		IMP.request_pay({
			pg : 'kakaopay',
			pay_method: 'card',
			merchant_uid: 'merchant_' + new Date().getTime(),
			/* 
			 *  merchant_uid에 경우 
			 *  https://docs.iamport.kr/implementation/payment
			 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
			 */
			name: ' : 아메리카노',
			// 결제창에서 보여질 이름
			// name: '주문명 : ${auction.a_title}',
			// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
			amount: 2000,
			// amount: ${bid.b_bid},
			// 가격 
			buyer_name: '이름',
			// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
			// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
			buyer_postcode: '123-456',
			},  function(rsp) {
	            if ( rsp.success ) {
	                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	                jQuery.ajax({
	                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
	                    type: 'POST',
	                    dataType: 'json',
	                    data: {
	                        imp_uid : rsp.imp_uid
	                        //기타 필요한 데이터가 있으면 추가 전달
	                    }
	                }).done(function(data) {
	                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	                    if ( everythings_fine ) {
	                        msg = '결제가 완료되었습니다.';
	                        msg += '\n고유ID : ' + rsp.imp_uid;
	                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	                        msg += '\결제 금액 : ' + rsp.paid_amount;
	                        msg += '카드 승인번호 : ' + rsp.apply_num;
	                        
	                        alert(msg);
	                    } else {
	                        //[3] 아직 제대로 결제가 되지 않았습니다.
	                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	                    }
	                });
	                //성공시 이동할 페이지
	                location.href='<%=request.getContextPath()%>/payment/pay_ok.do?msg='+msg;
	            } else {
	                msg = '결제에 실패하였습니다.';
	                msg += '에러내용 : ' + rsp.error_msg;
	                //실패시 이동할 페이지
	                location.href="<%=request.getContextPath()%>/payment/pay.do";
	                alert(msg);
	            }
	        });
	        
	    });
	    </script>
	 
	</body>
	</html>

