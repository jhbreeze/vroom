<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.backColor{
background: #0E6EFD;
color: white;
border-radius: 30px;
}
</style>

<div class="reply-info">
	<span class="reply-count">답변 ${replyCount}개</span> <span>[목록,
		${pageNo}/${total_page} 페이지]</span>
</div>

<table class='table table-borderless reply-list'>
	<c:forEach var="vo" items="${listReply}">
		<tr class="backColor">
			<td width='50%'><span>${vo.name}</span></td>
			<td width='50%' align='right'><span>${vo.evReplyDate}</span> | <c:choose>
					<c:when
						test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==vo.userId}">
						<span class='deleteReply' data-replyNum='${vo.replyNum}'
							data-pageNo='${pageNo}'>삭제</span>
					</c:when>
					<c:otherwise>
						<span class="notifyReply">신고</span>
					</c:otherwise>
				</c:choose></td>
		</tr>
		<tr>
			<td>${vo.evReplyContent}</td>
		</tr>
	</c:forEach>
</table>