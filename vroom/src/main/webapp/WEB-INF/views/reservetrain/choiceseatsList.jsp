<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 예약된 좌석 목록
	String[] cc = (String[]) request.getAttribute("reservedSeatsArr");
	String gradetHoNum = (String) request.getAttribute("gradetHoNum");
	String grade = (String) request.getAttribute("grade");
	if(gradetHoNum!=null){
		grade = gradetHoNum;
	}
	int cols, rows, step, ais;
	if (grade.equals("premium")) {
		cols = 3;
		rows = 11;
		step = 4;
		ais = 2;
	} else {
		cols = 4;
		rows = 15;
		step = 5;
		ais = 3;
	}
%>
<% for (int i = 0; i < cc.length; i++) { %>
	$("input[value=<%=cc[i]%>]").prop("disabled", true);
<% } %>

<form name="seatForm">
	<input type="hidden" name="gradetHoNum" value="${gradetHoNum}">
	<div class="hocha-button d-flex justify-content-between"
		style="width: 80%; margin: 0 auto">
		<div class="top-section">
			<select class="form-select fw-bolder" id="ho-select"
				aria-label=".form-select-lg example" style="color: #9B9B9B">
				<c:forEach var="dto" items="${list}" varStatus="status">
				<option class="hocha-list" value="${dto.tHoNum}" data-hoDiv="${dto.hoDiv}">${dto.num} 호차 잔여 ${dto.leftSeats}석 / ${dto.hoNum}석</option>
				</c:forEach>
			</select>
		</div>
		<div class="top-section-btn">
			<button class="btn btn-primary" type="reset">새로고침</button>
			<button class="btn btn-primary" type="button" id="select-complete">선택완료</button>
		</div>
	</div>

	<div class="mb-3" id="choice-seats">
		<% for (int i = 0; i < rows; i++) { %>
		<div class="form_toggle d-flex flex-row justify-content-center">
			<% for (int j = 1; j <= cols; j++) { %>
			<% if (j == ais) { %>
			<div class="aisle" style="text-align: center;">
				<i class="bi bi-caret-down-fill" style="color: white;"></i>
			</div>
			<% } %>
			<% if (j == step) { %>
			<br>
			<% } %>
			<% if (j != step) { %>
			<div class="form_check_btn">
				<input id="<%=(char) (65+i) + "-" + j%>" type="checkbox" name="seats" value="<%=(char) (65+i) + "-" + j%>">
				<% if (i > 15 / 2) { %>
				<label for="<%=(char) (65+i) + "-" + j%>" style="height: 100%;">
					<span class="inner-text"><%=(char) (65+i) + "-" + j%></span>
					<br>
					<span class="direction direction1">순방향</span>
				</label>
				<% } else { %>
				<label for="<%=(char) (65+i) + "-" + j%>" style="height: 100%;">
					<span class="inner-text"><%=(char) (65+i) + "-" + j%></span>
					<br>
					<span class="direction direction2">역방향</span>
				</label>
				<% } %>
			</div>
			<% } %>
			<% } %>
		</div>
		<% } %>
	</div>
</form>