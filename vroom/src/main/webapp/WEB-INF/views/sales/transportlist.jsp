<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="dto" items="${list}">
	<tr>
		<td scope="row">${dto.payDay}</td>
		<td scope="row">${dto.payPrice}</td>
	</tr>
</c:forEach>
<input type="hidden" name="count" value="${dataCount}">