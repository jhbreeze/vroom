<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		
		    <table class="table">
			<tbody>
				<c:forEach var="dto" items="${list}" varStatus="status">
					<tr style="height: 70px" class="times" data-tStaTime="${dto.tStaTime}">
						<td scope="row" class="ktx-td text-center align-middle"><img src="${pageContext.request.contextPath}/resources/images/ktx_logo.png" title="ktx" width="70"></td>
						<td scope="row" class="text-center train-td align-middle">
							<div class="trainNum sort align-middle">${dto.tNumId}</div>
							<input type="hidden" name="tOperCode" class="tOperCode" value="${dto.tOperCode}">
							<input type="hidden" name="tDiscern" class="tDiscern" value="${tDiscern}">
						</td>
						<td class="place1" style="width: 25%">
							<span class="departureTime ms-4 fw-bold fs-5 staTime">${dto.tStaTime}</span>
							<br>
							<span class="ms-4 departure">${deptStationName}</span>
						</td>
						<td class="time align-middle" style="width: 15%">
							<img class="arrow d-flex justify-content-center" src="${pageContext.request.contextPath}/resources/images/arrow.png" style="width: 100px; margin: auto">
							<span class="takeTime d-flex justify-content-center">${tTotalTimeString} 소요</span>
						</td>
						<td class="place2" style="width: 25%; padding-right: 4%; padding-left: 10px;">
							<span class="d-flex justify-content-end fw-bold fs-5 destinationTime endTime">${dto.tendTime}</span>
							<span class="d-flex justify-content-end destination">${destStationName}</span>
						</td>
						<td class="text-center date-th align-middle" style="width: 85px">
							<button class="btn btn-primary next-btn" type="button" style="width: 85px">다음</button>
						</td>
					</tr>
					<form name='reserveTrainFrom'>
						<span></span>
					</form>
				</c:forEach>
			</tbody>
			</table>