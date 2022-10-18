<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="header">

	<div class="header-top">
		<a id="logo" href="${pageContext.request.contextPath}/"><img id="img-logo" src="${pageContext.request.contextPath}/resources/images/vroom.png" title="로고" width="100"></a>
		<div class="header-top">
			<div class="header-right">
	            <c:if test="${empty sessionScope.member}">
	                <a href="${pageContext.request.contextPath}/member/login.do" title="로그인">로그인</a>
					&nbsp;
	                <a href="${pageContext.request.contextPath}/member/member.do" title="회원가입">회원가입</a>
	            </c:if>
	            <c:if test="${not empty sessionScope.member}">
	            	<a href="#" title="알림"><i class="fa-regular fa-bell"></i></a>
	            	&nbsp;
					<a href="${pageContext.request.contextPath}/member/logout.do" title="로그아웃">로그아웃</a>
					<a href="${pageContext.request.contextPath}/mypage/update.do" title="마이페이지">마이페이지</a>
	            </c:if>
	            <c:if test="${sessionScope.member.userId == 'admin'}">
	            	&nbsp;
					<a href="#" title="관리자">관리자 로그인</a>
	            </c:if>
			</div>
		</div>
	</div>
	<div class="header-main">
		<nav class="main-nav">
			<ul class="main-menu">
				<li><a href="${pageContext.request.contextPath}/" class="main-menu-a">예매</a></li>
				<li><a href="#" class="main-menu-a">예매확인</a>
					<ul class="sub-menu">
						<li><a href="${pageContext.request.contextPath}/reserve/list.do" aria-label="subemnu">예매내역 조회</a></li>
					</ul>
				</li>
				<li><a href="#" class="main-menu-a">이용안내</a>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/notice/list.do" aria-label="subemnu">공지사항</a></li>
							<li><a href="${pageContext.request.contextPath}/faq/list.do" aria-label="subemnu">자주하는 질문</a></li>
							<li><a href="${pageContext.request.contextPath}/qna/list.do" aria-label="subemnu">1:1 문의</a></li>
							<li><a href="${pageContext.request.contextPath}/event/list.do" aria-label="subemnu">이벤트</a></li>
						</ul>
					</li>
				
				<c:if test="${sessionScope.member.userId == 'admin'}">
					<li><a href="#" class="main-menu-a">고객관리</a>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/manage/member.do" aria-label="subemnu">회원정보 조회</a></li>
							<li><a href="${pageContext.request.contextPath}/manage/mileage.do" aria-label="subemnu">마일리지 관리</a></li>
						</ul>
					</li>
		
					<li><a href="#" class="main-menu-a">매출관리</a>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/sales/reserve.do" aria-label="subemnu">예매내역 조회</a></li>
							<li><a href="${pageContext.request.contextPath}/sales/transport.do" aria-label="subemnu">매출조회</a></li>
						</ul>
					</li>
				</c:if>
			</ul>
		</nav>
	</div>
	<div class="fake-box"></div>
	<div class="blue-box"></div>

</div>
