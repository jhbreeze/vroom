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

.body-container {
	max-width: 600px;
	margin: auto;
}

.form-input {
	height: min-content;
}
</style>

<script type="text/javascript">
function userIdCheck() {
	let userId = $("#userId").val();

	if(!/^(?=.*[a-z])(?=.*\d)[a-z0-9]{5,10}$/i.test(userId)) {
		
		let str = "<span style='font-weight: bold;'>"+ userId + "</span>는 사용불가능합니다.";
		$(".userId-box").find(".help-block2").html(str);
		
		$("#id-possible").hide();
		$("#id-impossible").show();
		
		$("#userIdValid").val("false");
		
		$("#userId").val("");
		$("#userId").focus();
		
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
				let str = "<span style='font-weight: bold;'>"+ userId + "</span>는 사용가능합니다.";
				$(".userId-box").find(".help-block1").html(str);
				
				$("#id-possible").show();
				$("#id-impossible").hide();
				
				$("#userIdValid").val("true");
			} else {
				let str = "<span style='font-weight: bold;'>"+ userId + "</span>는 중복된 아이디입니다.";
				$(".userId-box").find(".help-block2").html(str);
				
				$("#id-possible").hide();
				$("#id-impossible").show();
				
				$("#userId").val("");
				$("#userIdValid").val("false");
				$("#userId").focus();
			}
		}
	});
}

function memberOk() {
		const f = document.memberForm;
		let str;
	
		let mode = "${mode}";
		if (mode === "member" && f.userIdValid.value === "false") {
			alert("아이디 중복 검사가 필요합니다.");
			f.userId.focus();
			return;
		}
	
		str = f.userPwd.value;
		if (!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) {
			alert("비밀번호를 다시 입력해주세요.");
			f.userPwd.focus();
			return;
		}
	
		if (str !== f.userPwd2.value) {
			alert("비밀번호가 일치하지 않습니다. ");
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
	
		f.action = "${pageContext.request.contextPath}/member/${mode}_ok.do";
		f.submit();
		alert("${mode=="member"?"회원가입 성공!":"수정완료"}");
}


function chooseEmail() {
	const f = document.memberForm;

	let str = f.selectEmail.value;
	if (str !== "direct") {
		f.email2.value = str;
		f.email2.readOnly = true;
	} else {
		f.email2.value = "";
		f.email2.readOnly = false;
		f.email2.focus();
	}
}


$(function(){
	$("#pwd-correct").hide();
	$("#pwd-wrong").hide();
	
	$("input").keyup(function(){
		var pwd1 = $("#userPwd").val();
		var pwd2 = $("#userPwd2").val();
		
		if(pwd1 != "" && pwd2 != ""){
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
		
	});
});	


</script>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main>
		<div class="container">
			<div class="body-container">
				<div class="body-title mb-5">
					<div class="fs-4 fw-bolder">👋&nbsp;${title}</div>
				</div>
				<div class="box ">
					<form name="memberForm" method="post">
						<div class="row mb-3 userId-box">
							<label class="mb-2 fw-bold" for="userId">아이디</label>
							<div class="input-group ps-0">
								<div class="form-control pt-0" style="border-style:none;">
									<input type="text" name="userId" id="userId" class="form-control p-2" 
										placeholder="5~10자의 영문 소문자와 하나이상의 숫자 사용" maxlength="10"
										value="${dto.userId}" ${mode=="update" ? "readonly='readonly' ":""}>
								</div>		
								<div class="p-0">
									<c:if test="${mode=='member'}">
										<button type="button" class="btn btn-primary p-2 ps-3 pe-3"
											onclick="userIdCheck();">중복검사</button>
									</c:if>
								</div>
							</div>
							<c:if test="${mode=='member'}">
								<div class="p-1 ps-3 text-primary help-block1" id="id-possible"></div>
								<div class="p-1 ps-3 text-danger help-block2" id="id-impossible"></div>
							</c:if>
						</div>

						<div class="row mb-3">
							<label class="mb-2 fw-bold" for="userPwd">비밀번호</label>
							<div>
								<input type="password" name="userPwd" id="userPwd"
									class="form-control p-2" autocomplete="off"
									placeholder="5~10자의 영문자와 하나이상의 숫자 또는 특수문자 포함">
							</div>
						</div>

						<div class="row mb-3">
							<label class="mb-2 fw-bold" for="userPwd2">비밀번호 확인</label>
							<div class="row-3">
								<input type="password" name="userPwd2" id="userPwd2"
									class="form-control p-2" autocomplete="off">
							</div>
							<div class="p-1 ps-3 text-primary" id="pwd-correct">비밀번호가 일치합니다.</div>
							<div class="p-1 ps-3 text-danger" id="pwd-wrong">비밀번호가 일치하지 않습니다.</div>
						</div>

						<div class="row mb-3">
							<label class="mb-2 fw-bold" for="userName">이름</label>
							<div class="row-3">
								<input type="text" name="userName" id="userName" maxlength="5"
									class="form-control p-2" value="${dto.userName}">
							</div>
						</div>

						<div class="row mb-3">
							<label class="mb-2 fw-bold" for="birth">생년월일</label>
							<div class="row-3">
								<input type="date" name="birth" id="birth"
									class="form-control p-2" value="${dto.birth}">
							</div>
						</div>

						<div class="row mb-3">
							<label class="mb-2 fw-bold" for="selectEmail">이메일</label>
							<div class="col row">
								<div class="col input-group">
									<input type="text" name="email1" class="form-control p-2" style="border-radius: 0.375rem;" maxlength="30" value="${dto.email1}">
										<span class="input-group-text p-1" 	style="border: none; background: none;">@</span> 
									<input type="text" name="email2" class="form-control p-2" style="border-radius: 0.375rem;" maxlength="30" value="${dto.email2}" readonly="readonly">
								</div>
								<div class="col-3 p-0">
									<select name="selectEmail" id="selectEmail" class="form-select p-2" onchange="chooseEmail();">
										<option value="">: : 선 택 : :</option>
										<option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>naver.com</option>
										<option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>gmail.com</option>
										<option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>hanmail.net</option>
										<option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>hotmail.com</option>
										<option value="direct">직접입력</option>
									</select>
								</div>
							</div>
						</div>
						
						<div class="row mb-3">
							<label class="mb-2 fw-bold" for="tel1">휴대전화</label>
							<div class="col-sm-10 row">
								<div class="col-sm-3 pe-2">
									<input type="text" name="tel1" id="tel1"
										class="form-control p-2" value="${dto.tel1}" maxlength="3">
								</div>
								<div class="col-sm-1 px-1" style="width: 2%;">
									<p class="form-control-plaintext text-center">-</p>
								</div>
								<div class="col-sm-3 pe-2">
									<input type="text" name="tel2" id="tel2"
										class="form-control p-2" value="${dto.tel2}" maxlength="4">
								</div>
								<div class="col-sm-1 px-1" style="width: 2%;">
									<p class="form-control-plaintext text-center">-</p>
								</div>
								<div class="col-sm-3 pe-2">
									<input type="text" name="tel3" id="tel3"
										class="form-control p-2" value="${dto.tel3}" maxlength="4">
								</div>
							</div>

						</div>

						<c:if test="${mode == 'member'}">
							<div class="row mb-3">
								<div class="d-flex">
									<div class="m-2">
										<input type="checkbox" id="agree" name="agree" class="form-check-input" checked="checked"
											style="margin-left: 0;" onchange="form.sendButton.disabled = !checked"> 
									</div>	
									<div class="m-2 ms-0 ">
										<label class="form-check-label"> 
										<!--  <a href="#" class="text-decoration-none">이용약관</a> 에 동의합니다.  -->
										개인정보 수집 및 이용에 동의합니다.
										</label>
									</div>
								</div>
							</div>
						</c:if>

						<div class="row" style="width: 100%; margin:auto">
								<button type="button" name="sendButton" class="btn btn-primary p-3"
									onclick="memberOk();"> ${mode=="member"?"가입하기":"수정완료"}
								</button>
								<input type="hidden" name="userIdValid" id="userIdValid" value="false">
						</div>
					</form>
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