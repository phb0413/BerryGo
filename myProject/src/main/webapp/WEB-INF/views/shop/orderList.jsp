<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    <div class="container mt-5 mb-5">
    <div class="card shadow">
        <div class="card-header bg-dark text-white text-center">
            <h3 class="mb-0">주문 목록</h3>
        </div>
        <div class="card-body">
            <c:if test="${empty orderList}">
                <div class="alert alert-warning text-center">
                    주문 목록이 없습니다.
                </div>
            </c:if>

            <c:if test="${not empty orderList}">
                <div class="table-responsive mb-4">
                    <table class="table table-bordered text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>주문번호</th>
                                <th>상품명</th>
                                <th>이미지</th>
                                <th>수량</th>
                                <th>가격</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>${order.order_number}</td>
                                    <td>${order.item_name}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/resources/image/${order.item_image}" 
                                             alt="${order.item_name}" style="width: 100px;">
                                    </td>
                                    <td>${order.order_buycount}</td>
                                    <c:set var="price" value="${(order.item_price - order.item_price * order.item_discount / 100) * order.order_buycount}" />
                                    <td><fmt:formatNumber value="${price}" type="number" maxFractionDigits="0" /> 원</td>
                                    <c:set var="total" value="${total + price}" />
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="text-end">
                    <h5>총 결제 금액: <strong><fmt:formatNumber value="${total}" type="number" /> 원</strong></h5>
                </div>
            </c:if>
        </div>
    </div>
</div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>