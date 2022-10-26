<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 템플릿</title>
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
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deleteBoard() {
		if (confirm("게시글을 삭제 하시 겠습니까 ? ")) {
			let query = "qnaNum=${dto.qnaNum}&${query}";
			let url = "${pageContext.request.contextPath}/qna/delete.do?"
					+ query;
			location.href = url;
		}
	}
	</c:if>
</script>

<script type="text/javascript">
	function login() {
		location.href = "${pageContext.request.contextPath}/member/login.do";
	}

	function ajaxFun(url, method, query, dataType, fn) {
		$.ajax({
			type : method,
			url : url,
			data : query,
			dataType : dataType,
			success : function(data) {
				fn(data);
			},
			beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error : function(jqXHR) {
				if (jqXHR.status === 403) {
					login();
					return false;
				} else if (jqXHR.status === 400) {
					alert("요청 처리가 실패했습니다.");
					return false;
				}

				console.log(jqXHR.responseText);

			}
		});
	}
	
	$(function() {
		listPage(1);
	});
	function listPage(page) {
		let url = "${pageContext.request.contextPath}/qna/listReply.do";
		let query = "qnaNum=${dto.qnaNum}&pageNo="+page;
		let selector = "#listReply";
		
		const fn = function(data) {
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}
	
	$(function() {
		$(".btnSendReply").click(function() {
			let qnaNum = "${dto.qnaNum}"; 
			const $tb = $(this).closest("table");
			let qnaReplyCont = $tb.find("textarea").val().trim();
			if(!qnaReplyCont){
				$tb.find("textarea").focus();
				return false;
			}
			content = encodeURIComponent(qnaReplyCont);
			
			let url = "${pageContext.request.contextPath}/qna/insertReply.do";
			let query = "qnaNum="+qnaNum+"&qnaReplyCont="+qnaReplyCont;
			
			const fn = function(data) { // 데이터를 함수로 표현
				$tb.find("textarea").val("");
			    
				if(data.state === "true"){
					listPage(1); // 등록이 끝나면 리스트 페이지 부름
				} else {
					alert("댓글 등록에 실패했습니다.");
				}
			
			};
			
			ajaxFun(url,"post", query,"json", fn);
		});
	});
	
	$(function() {
		$("body").on("click", ".deleteReply", function() {
			if(! confirm('게시글을 삭제하시겠습니까 ? ')){
				return false;
			}
			
			let replyNum = $(this).attr("data-replyNum");
			let page = $(this).attr("data-pageNo");
			
			let url = "${pageContext.request.contextPath}/qna/deleteReply.do";
			let query = "replyNum="+replyNum;
			
			const fn = function(data) {
				listPage(page);
			};
			
			ajaxFun(url, "post", query, "json", fn);
			
		});
	});
</script>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>

	<main>
		<div class="container body-container">
			<div class="body-title">
				<h2>
					<i class="fa-regular fa-square"></i> 1:1 문의
				</h2>
			</div>

			<div class="body-main mx-auto">
				<table>
					<thead>
						<tr>
							<td>${dto.qnaSubject}</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>이름 : <c:choose>
									<c:when test="${dto.name == null }">${dto.qnaName}</c:when>
									<c:otherwise>${dto.name}</c:otherwise>
								</c:choose></td>
							<td>${dto.qnaRegDate}</td>
						</tr>
						<tr>
							<td colspan="2" valign="top" height="200">${dto.qnaContent}</td>
						</tr>
					</tbody>
				</table>

				<table class="table table-borderless">
					<tr>
						<td width="50%"><c:choose>
								<c:when
									test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
									<button type="button" class="btn btn-light"
										onclick="deleteBoard();">삭제</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
								</c:otherwise>
							</c:choose></td>
						<td class="text-end">
							<button type="button" class="btn btn-light"
								onclick="location.href='${pageContext.request.contextPath}/qna/list.do?${query}';">리스트</button>
						</td>
					</tr>
				</table>

				<div class="reply">
				<c:if test="${sessionScope.member.userId=='admin'}">
					<form name="replyForm" method="post">
						<div class='form-header'>
							<span class="bold">답변 등록</span>
						</div>

						<table class="table table-borderless reply-form">
							<tr>
								<td><textarea class='form-control' name="qnaContent"></textarea>
								</td>
							</tr>
							<tr>
								<td align='right'>
									<button type='button' class='btn btn-light btnSendReply'>답변
										등록</button>
								</td>
							</tr>
						</table>
					</form>
					</c:if>

					<div id="listReply"></div>
				</div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>