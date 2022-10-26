<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="reply-info">
	<span class="reply-count">답변 ${replyCount}개</span> <span>[목록,
		${pageNo}/${total_page} 페이지]</span>
</div>

<table>
	<c:forEach var="vo" items="${listReply}">
		<tr>
			<td><span>${vo.name}</span></td>
			<td><span>${vo.qnaReplyDate}</span> | <c:choose>
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
		<td>${vo.qnaReplyCont}</td>
		</tr>
	</c:forEach>
</table>