<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>	
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    <h1 style="text-align: center;">장바구니</h1>
    <div class="container mt-5 mb-5">
    <div class="card shadow">
        <div class="card-header bg-dark text-white text-center">
            <h3 class="mb-0">장바구니</h3>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered align-middle text-center">
                    <thead class="table-light">
                        <tr>
                            <th>상품명</th>
                            <th>이미지</th>
                            <th>수량</th>
                            <th>가격</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="0" />
                        <c:forEach var="cart" items="${cartList}">
                            <tr>
                                <td class="fw-semibold">${cart.item_name}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/resources/image/${cart.item_image}" 
                                         alt="${cart.item_name}" style="width: 100px;">
                                </td>
                                <td>${cart.cart_buycount}</td>
                                <td><fmt:formatNumber value="${cart.item_price * cart.cart_buycount}" type="currency" /></td>
                                <td>
                                    <button class="btn btn-sm btn-danger" onclick="removeItem(${cart.cart_number})">삭제</button>
                                </td>
                            </tr>
                            <c:set var="total" value="${total + cart.item_price * cart.cart_buycount}" />
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-4 text-end pe-3">
                <h5 class="fw-bold">총 주문 금액: <fmt:formatNumber value="${total}" type="currency" /></h5>
            </div>

            <div class="text-center mt-3">
                <a href="${contextPath}/shop/addOrder.do" class="btn btn-primary btn-lg">주문하기</a>
            </div>
        </div>
    </div>
</div>


    <script>
    function removeItem(cart_number) {
        if (confirm("정말 삭제하시겠습니까?")) {
            fetch(cp + "/shop/removeCartItem.do", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "cart_number=" + encodeURIComponent(cart_number)
            })
                .then((response) => {
                    if (!response.ok) {
                        throw new Error("HTTP 상태 코드: " + response.status);
                    }
                    return response.text();
                })
                .then((data) => {
                    if (data.trim() === "success") {
                        alert("삭제되었습니다.");
                        location.reload();
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                })
                .catch((error) => {
                    console.error("삭제 요청 실패:", error);
                    alert("오류가 발생했습니다.");
                });
        }
    }
    </script>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>
