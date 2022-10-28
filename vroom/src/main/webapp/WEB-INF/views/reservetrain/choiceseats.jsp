<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	/* int rows = 10;
	int cols = 15;
	
	int width = cols * 30 + 20 * (cols/5) + 30;
	if(cols/5 == 0) width -= 20; */
	String[] list = (String[])request.getAttribute("checkedList");
	
	String []cc = {"B-3","B-4","E-1","E-2","H-2","H-3"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 기차예매</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { position: relative; top: -55px; background: white; }
.container { min-height: 900px; }
#ho-select { width: 300px; text-align: center; border-radius: 40px; }
.top-section { margin: 40px 0 0 0; width: 80px; }
.top-section-btn{margin: 40px 0 0 0}
#ho-select:hover { cursor: pointer; }
.form_check_btn {
	width: 80px; height: 80px;
	border-radius: 10px; background: white; margin: 3px;
}
.form_check_btn input[type=checkbox] { display: none; }
.form_check_btn label {
	display: block; border-radius: 10px; margin: 0 auto; text-align: center; color: #9B9B9B;
	
	/* height: -webkit-fill-available; line-height: 60px; */ }
.form_check_btn input[type=checkbox]:checked+label { background: #0E6EFD; color: white; }
.form_check_btn label:hover { color: #666; cursor: pointer; }
.form_check-btn input[type=checkbox]+label { background: white; color: #DEDEDE; }
.aisle { width: 80px; height: 60px; background: #D6D9DE; }
#choice-seats { background: #D6D9DE; width: 80%; height: 500px; 
	border-radius: 20px; margin: 30px auto; overflow: scroll;  }
.form_toggle { margin: 0 auto; }
.direction { position: relative; top: 8px; font-size: 14px; }
.inner-text { position: relative; top: 15px; font-size: 20px; }
.aisle { padding-top: 30px }
.form_check_btn input[type=checkbox]:disabled+label { background: #A2A6AD; color: white; }
</style>
<script type="text/javascript">
$(function(){
	<% for(int i=0; i<cc.length; i++) { %>
		$("input[value=<%=cc[i]%>]").prop("checked", true);
		$("input[value=<%=cc[i]%>]").prop("disabled", true);
	<% } %>
	let grade = $("input[name=grade]").val();
});
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
		
		<form name="seatForm">
			<div class="hocha-button d-flex justify-content-between" style="width: 80%; margin: 0 auto">
				<div class="top-section">
				<select class="form-select fw-bolder" id="ho-select" aria-label=".form-select-lg example" style="color: #9B9B9B">
				  	<option selected value="1">1 호차 잔여 17석 / 일반석 60석</option>
				  	<option value="2">2 호차</option>
				  	<option value="3">3 호차</option>
				  	<option value="4">4 호차</option>
				  	<option value="5">5 호차</option>
				  	<option value="6">6 호차</option>
				</select>
				</div>
				<div class="top-section-btn">
					<button class="btn btn-primary" type="reset">새로고침</button>	
					<button class="btn btn-primary" type="button" onclick="sendOk()">선택완료</button>	
				</div>
			</div>
			
			<div class="mb-3" id="choice-seats">
				<% for(int i=0; i<15; i++) {%>
					<div class="form_toggle d-flex flex-row justify-content-center">
					<% for(int j=1; j<=5; j++) {%>
						<% if(j==3) {%>
							<div class="aisle"><div style="text-align: center;"><i class="bi bi-caret-down-fill" style="color: white;"></i></div></div>
						<% } %>
						<% if(j==5) {%>
							<br>
						<% } %>
						<% if(j!=5) {%>
						<div class="form_check_btn">
							<input id="<%=(char)(65+i)+"-"+j%>" type="checkbox" name="seats" value="<%= (char)(65+i)+"-"+j %>">
							<% if(i>15/2) {%>
								<label for="<%=(char)(65+i)+"-"+j%>" style="height: 100%;"><span class="inner-text"><%= (char)(65+i)+"-"+j %></span><br><span class="direction">순방향</span></label>
							<% } else {%>
								<label for="<%=(char)(65+i)+"-"+j%>" style="height: 100%;"><span class="inner-text"><%= (char)(65+i)+"-"+j %></span><br><span class="direction">역방향</span></label>
							<% } %>
						</div>
						<% } %>
					<% } %>
					</div>
				<%} %>
			</div>
		</form>
	</div>
</main>
<form name="hiddenForm">
	<input name="grade" value="${grade}">
</form>
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>