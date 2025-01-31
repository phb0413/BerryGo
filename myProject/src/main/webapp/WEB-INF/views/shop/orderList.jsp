<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    <h1 style="text-align: center;">주문 목록</h1>
    <table>
        <thead>
            <tr>
                <th>주문번호</th>
                <th>상품명</th>
                <th>이미지</th>
                <th>수량</th>
                <th>가격</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orderList}">
                <tr>
                    <td>${order.order_number}</td>
                    <td>${order.item_name}</td>
                    <td>
                        <img src="${pageContext.request.contextPath}/resources/image/${order.item_image}" 
                             alt="${order.item_name}" style="width: 100px; height: auto;">
                    </td>
                    <td>${order.order_buycount}</td>
                    <c:set var="price" value="${(order.item_price - order.item_price * order.item_discount / 100) * order.order_buycount }"/>
                    <td><fmt:formatNumber value="${price}" type="number" maxFractionDigits="0" />원</td>
                </tr>
                <c:set var="total" value="${(total + price).intValue()}"/>
            </c:forEach>
        </tbody>
    </table>
    <table>
    	<tr>
    		<td><c:out value="총 가격 : ${total}원"></c:out></td>
    	</tr>
    </table>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>