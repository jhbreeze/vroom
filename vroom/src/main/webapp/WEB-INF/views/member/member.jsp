<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

*, ::after, ::before {
	box-sizing: border-box;
}

.body-container {
	margin: auto;
	max-width: 800px;
	display: flex;
	justify-content: center;
}

.body-title {
	color: #424951;
	padding-top: 10px;
	padding-bottom: 5px;
	margin: 0 0 25px 0;
}

.body-main {
	width: 70%;
}

.row {
	margin: 10px;
}

.row-3, .row-4-btn {
	margin: 5px;
}

.form-control {
	margin: 5px 0;
	padding: 10px;
	height: min-content;
	width: 90%;
	border: 1px solid #ccc;
	-webkit-transition: 0.5s;
	transition: 0.5s;
	outline: none;
	border-radius: 5px;
}

.form-id { width: 72%; }

input[type=text]:focus {
	border: 3px solid #555;
}

button {
	background-color: #4971FF;
	cursor: pointer;
	margin: 0;
	padding: 0.5rem 1rem;
	font-family: "Noto Sans KR", sans-serif;
	font-weight: bold;
	font-size: 1rem;
	text-align: center;
	text-decoration: none;
	color: white;
	display: inline-block;
	border: none;
	border-radius: 4px;
	height: 100%;
}

.inputbox {
	display: flex;
}

.emailbox {
	width: 30%;
}

.input-group-text {
	margin: 3px;
    padding: 6px 2px;
}

.form-select {
	width: 20%;
    margin: 4px 10px 4px 0;
	padding: 5px
}

.btn-join {
	margin: auto;
	height: 4em;
	width: 90%;
}

.btn-check {
	height: 2.5rem;
}

.row-1-label {
	font-weight: bold;
}
</style>

<script type="text/javascript">
	function memberOk() {
		const f = document.memberForm;
		let str;

		str = f.userId.value;
		if (!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
			alert("아이디를 다시 입력 하세요. ");
			f.userId.focus();
			return;
		}

		let mode = "${mode}";
		if (mode === "member" && f.userIdValid.value === "false") {
			str = "아이디 중복 검사가 실행되지 않았습니다.";
			$("#userId").parent().find(".help-block").html(str);
			f.userId.focus();
			return;
		}

		str = f.userPwd.value;
		if (!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) {
			alert("패스워드를 다시 입력 하세요. ");
			f.userPwd.focus();
			return;
		}

		if (str !== f.userPwd2.value) {
			alert("패스워드가 일치하지 않습니다. ");
			f.userPwd.focus();
			return;
		}

		str = f.userName.value;
		if (!/^[가-힣]{2,5}$/.test(str)) {
			alert("이름을 다시 입력하세요. ");
			f.userName.focus();
			return;
		}

		str = f.birth.value;
		if (!str) {
			alert("생년월일를 입력하세요. ");
			f.birth.focus();
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
			alert("숫자만 가능합니다. ");
			f.tel2.focus();
			return;
		}

		str = f.tel3.value;
		if (!/^\d{4}$/.test(str)) {
			alert("숫자만 가능합니다. ");
			f.tel3.focus();
			return;
		}

		str = f.email1.value.trim();
		if (!str) {
			alert("이메일을 입력하세요. ");
			f.email1.focus();
			return;
		}

		str = f.email2.value.trim();
		if (!str) {
			alert("이메일을 입력하세요. ");
			f.email2.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/member/${mode}_ok.do";
		f.submit();
	}

	function changeEmail() {
		const f = document.memberForm;

		let str = f.selectEmail.value;
		if (str !== "direct") {
			f.email2.value = str;
			f.email2.readOnly = true;
			f.email1.focus();
		} else {
			f.email2.value = "";
			f.email2.readOnly = false;
			f.email1.focus();
		}
	}

	function userIdCheck() {
		// 아이디 중복 검사
		let userId = $("#userId").val();

		if (!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) {
			let str = "아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
			$("#userId").focus();
			$("#userId").parent().find(".help-block").html(str);
			return;
		}

		let url = "${pageContext.request.contextPath}/member/userIdCheck.do";
		let query = "userId=" + userId;
		$.ajax({
			type : "POST",
			url : url,
			data : query,
			dataType : "json",
			success : function(data) {
				let passed = data.passed;

				if (passed === "true") {
					let str = "<span style='color:blue; font-weight: bold;'>"
							+ userId + "</span> 아이디는 사용가능 합니다.";
					$(".userId-box").find(".help-block").html(str);
					$("#userIdValid").val("true");
				} else {
					let str = "<span style='color:red; font-weight: bold;'>"
							+ userId + "</span> 아이디는 사용할수 없습니다.";
					$(".userId-box").find(".help-block").html(str);
					$("#userId").val("");
					$("#userIdValid").val("false");
					$("#userId").focus();
				}
			}
		});
	}
	
	$(function(){
		$("#pwd-correct").hide();
		$("#pwd-wrong").hide();
		
		$("input").keyup(function(){
			var pwd1 = $("#userPwd").val();
			var pwd2 = $("#userPwd2").val();
			
			if(pwd1 != "" || pwd2 != ""){
				if(pwd1 != pwd2){
					$("#pwd-correct").hide();
					$("#pwd-wrong").show();
					
					return false;
					
				} else {
					$("#pwd-correct").show();
					$("#pwd-wrong").hide();
					
					return true;
				}
			}
			
			
		})
		
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
				<!-- div class="body-title">
				<h3><i class="bi bi-person-square"></i> ${title} </h3>
			</div> -->

				<div class="body-main">

					<form name="memberForm" method="post">
						<div class="row">
							<label class="row-1-label" for="userId">아이디</label>
								<div class="row-3 inputbox">
									<input type="text" name="userId" id="userId"
										class="form-control form-id" value="${dto.userId}"
										${mode=="update" ? "readonly='readonly' ":""}>
									<div class="row-4-btn">
										<c:if test="${mode=='member'}">
											<button type="button" class="btn btn-check"
												onclick="userIdCheck();">중복검사</button>
										</c:if>
								</div>
							</div>
						</div>

						<div class="row">
							<label class="row-1-label" for="userPwd">비밀번호</label>
							<div class="row-3">
								<input type="password" name="userPwd" id="userPwd"
									class="form-control" autocomplete="off"
									placeholder="5~10자 영문자와 하나이상의 숫자 또는 특수문자 포함">
							</div>
						</div>

						<div class="row">
							<label class="row-1-label" for="userPwd2">비밀번호 확인</label>
							<div class="row-3">
								<input type="password" name="userPwd2" id="userPwd2"
									class="row-3 form-control" autocomplete="off">
							</div>
							<div class="pwd-correct" id="pwd-correct">비밀번호가 일치합니다.</div>
							<div class="pwd-wrong" id="pwd-wrong">비밀번호가 일치하지 않습니다.</div>
						</div>

						<div class="row">
							<label class="row-1-label" for="userName">이름</label>
							<div class="row-3">
								<input type="text" name="userName" id="userName"
									class="form-control" value="${dto.userName}"
									${mode=="update" ? "readonly='readonly' ":""}>
							</div>
						</div>

						<div class="row">
							<label class="row-1-label" for="birth">생년월일</label>
							<div class="row-3">
								<input type="date" name="birth" id="birth" class="form-control"
									value="${dto.birth}">
							</div>
						</div>

						<div class="row">
							<label class="row-1-label" for="selectEmail">이메일</label>
							<div class="row-3 inputbox">
								<input type="text" name="email1" class="form-control emailbox"
									maxlength="30" value="${dto.email1}"> <span
									class="input-group-text p-1"
									style="border: none; background: none;">@</span> <select
									name="selectEmail" id="selectEmail" class="form-select"
									onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="naver.com"
										${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버
										메일</option>
									<option value="gmail.com"
										${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지
										메일</option>
									<option value="hanmail.net"
										${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한
										메일</option>
									<option value="hotmail.com"
										${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫
										메일</option>
									<option value="direct">직접입력</option>
								</select> <input type="text" name="email2" class="form-control emailbox"
									maxlength="30" value="${dto.email2}" readonly="readonly">
							</div>
						</div>

						<div class="row">
							<label class="row-1-label" for="tel1">휴대전화</label>
							<div class="row-3">
								<input type="text" name="tel" id="tel" class="form-control"
									value="${dto.tel}" placeholder="ex) 01012341234"
									${mode=="update" ? "readonly='readonly' ":""}>
							</div>
						</div>

							<c:if test="${mode == 'member' }">
								<div class="row">
										<input type="checkbox" id="agree" name="agree"
											class="form-check-input" checked="checked"
											style="margin-left: 0;"
											onchange="form.sendButton.disabled = !checked"> <label
											class="form-check-label"> <a href="#"
											class="text-decoration-none">이용약관</a>에 동의합니다.
										</label>
								</div>
							</c:if>

							<div class="row">
								<div class="text-center">
									<button type="button" name="sendButton" class="btn btn-join"
										onclick="memberOk();">
										${mode=="member"?"가입하기":"정보수정"} <i class="bi bi-check2"></i>
									</button>
									<input type="hidden" name="userIdValid" id="userIdValid"
										value="false">
								</div>
							</div>

							<div class="row">
								<p class="form-control-plaintext text-center">${message}</p>
							</div>
					</form>

				</div>
			</div>
		</div>

		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script>
			function daumPostcode() {
				new daum.Postcode(
						{
							oncomplete : function(data) {
								// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

								// 각 주소의 노출 규칙에 따라 주소를 조합한다.
								// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
								var fullAddr = ''; // 최종 주소 변수
								var extraAddr = ''; // 조합형 주소 변수

								// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
								if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
									fullAddr = data.roadAddress;

								} else { // 사용자가 지번 주소를 선택했을 경우(J)
									fullAddr = data.jibunAddress;
								}

								// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
								if (data.userSelectedType === 'R') {
									//법정동명이 있을 경우 추가한다.
									if (data.bname !== '') {
										extraAddr += data.bname;
									}
									// 건물명이 있을 경우 추가한다.
									if (data.buildingName !== '') {
										extraAddr += (extraAddr !== '' ? ', '
												+ data.buildingName
												: data.buildingName);
									}
									// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
									fullAddr += (extraAddr !== '' ? ' ('
											+ extraAddr + ')' : '');
								}

								// 우편번호와 주소 정보를 해당 필드에 넣는다.
								document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
								document.getElementById('addr1').value = fullAddr;

								// 커서를 상세주소 필드로 이동한다.
								document.getElementById('addr2').focus();
							}
						}).open();
			}
		</script>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>