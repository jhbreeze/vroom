<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부릉부릉 - 기차예매</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<style type="text/css">
main { 
	position: relative; top: -55px; background: white;
}
.container { min-height: 900px; }
tr { font-size: 15px; }

tr:hover { background: #fff; box-shadow: 0px 0px 4px rgb(72, 92, 161, 0.4); }

.trainNum { font-size: 15px;}
.date-th { width: 100px; }
.date-div { font-size: 12px; line-height: 20.5px; }
.takeTime, arrow { width: 100%; color: #727272; margin: auto; }
.right{ text-align: left; }
.arrow { color: #727272; }
.ktx-td { width: 13% }
.train-td{ width: 8% }
.reserve-table { width: 100%; height: 500px; margin: 30px auto; overflow: scroll; }
.table { width: 78%; margin: 5px auto; }
.trainNum { margin-left: 5%; }
.destinationTime, .destination { text-align: right }
.top-section { width: 70%; margin: 50px auto 0; }
.small-arrow { color: #0E6EFD; } 
.small-arrow:hover { color: #0D5ED7; } 
</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="reserveTrain-top">
	    	<div class="top-section d-flex justify-content-between">
		    	<p class="fw-bold fs-4">가는날</p>
		    	<div>
		    		<a class="small-arrow"><i class="bi bi-caret-left-fill" style="width: 20px;"></i></a>
		    		<span class="fw-bold fs-5" id="selected-date">${staDate}</span>
		    		<a class="small-arrow"><i class="bi bi-caret-right-fill" style="width: 20px;"></i></a>
		    	</div>
	    	</div>
		    <div class="reserve-table">
		    	<table class="table">
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr style="height: 70px">
								<td scope="row" class="ktx-td text-center align-middle"><img src="${pageContext.request.contextPath}/resources/images/ktx_logo.png" title="ktx" width="70"></td>
								<td scope="row" class="text-center train-td align-middle">
									<div class="trainNum sort align-middle">${dto.tNumId}</div>
								</td>
								<td class="place1" style="width: 25%">
									<span class="departureTime ms-4 fw-bold fs-5">${dto.tStaTime}</span>
									<br>
									<span class="ms-4 departure">${deptStationName}</span>
								</td>
								<td class="time align-middle" style="width: 15%">
									<img class="arrow d-flex justify-content-center" src="${pageContext.request.contextPath}/resources/images/arrow.png" style="width: 100px; margin: auto">
									<span class="takeTime d-flex justify-content-center">${tTotalTimeString} 소요</span>
								</td>
								<td class="place2" style="width: 25%; padding-right: 4%; padding-left: 10px;">
									<span class="d-flex justify-content-end fw-bold fs-5 destinationTime">${dto.tendTime}</span>
									<span class="d-flex justify-content-end destination">${destStationName}</span>
								</td>
								<td class="text-center date-th align-middle" style="width: 85px"><button class="btn btn-primary" type="button" style="width: 85px">좌석선택</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
	    </div>
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>