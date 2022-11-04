<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
response.setStatus(HttpServletResponse.SC_OK);
// IE 등 자체 에러 페이지를 출력하며, 개발자가 설정한 에러 페이지 정보가 출력되지 않음
// 따라서 위 코드로 에러가 발생할때 출력되는 페이지가 아닌 정상페이지임을 알림
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

	<h3>경고 !!!</h3>
	<div>
		<p>요청하신 URL은 존재하지 않습니다.</p>
	</div>

</body>
</html>