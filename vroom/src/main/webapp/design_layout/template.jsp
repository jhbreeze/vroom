<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<style type="text/css">
@import url("header.css");
@import url("footer.css");
main { 
	position: relative; top: -50px; 
}
.container { min-height: 900px; }

</style>

</head>
<body>

<header>
	<jsp:include page="header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="body-title">
			<h2><i class="fa-regular fa-square"></i> 제목 </h2>
	    </div>
	    
	    <div class="body-main mx-auto">
			내용 입니다. ... <!-- 여기 들어가는 폼은 알아서 짜야함 -->
	    </div>
	</div>
</main>

<footer>
    <jsp:include page="footer.jsp"></jsp:include>
</footer>

</body>
</html>