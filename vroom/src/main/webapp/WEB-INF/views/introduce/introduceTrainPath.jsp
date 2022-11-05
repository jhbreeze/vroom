<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container2 { width: 1920px; height: 1000px; margin: 0 auto; text-align: center; }

.photo-1{
	width: 100vw;height: 100vh; 
	background-size: contain; object-fit: cover; overflow: hidden;
	background-position: center; background-repeat: no-repeat; text-align: center;
	background-size: cover;
	justify-content: center;
    align-items: center;
    position: absolute;
	background-image: url("${pageContext.request.contextPath}/resources/images/train_route3.png");
}
</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container2 body-container ">
		
		 <div class="photo-1">
		 	
		 </div>
	
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>