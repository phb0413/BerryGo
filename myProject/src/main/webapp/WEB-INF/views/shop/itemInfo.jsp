<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
        .product-image {
            max-width: 100%;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
    </style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<div class="container mt-5 mb-5">
    <h2 class="text-center mb-4">상품 상세페이지</h2>
    <div class="card shadow p-4">
        <div class="row g-4">
            <div class="col-md-5 text-center">
                <c:set var="imagePath" value="${pageContext.request.contextPath}/resources/image/${item.item_image}" />
                <img src="${imagePath}" alt="${item.item_name}" class="product-image">
                <input type="hidden" id="itemImg" value="${imagePath}" />
            </div>
            <div class="col-md-7">
                <h3>${item.item_name}</h3>
                <p class="text-muted">${item.item_info}</p>
                <input type="hidden" id="itemNumber" value="${item.item_number}">
                <input type="hidden" id="itemName" value="${item.item_name}">

                <p><strong>정가:</strong> <fmt:formatNumber value="${item.item_price}" type="currency" /></p>

                <fmt:parseNumber var="price" value="${item.item_price - item.item_price * item.item_discount / 100}" />
                <p><strong>판매가:</strong> <fmt:formatNumber value="${price}" type="currency" />
                    <input type="hidden" id="itemPrice" value="${price}">
                </p>

                <p><strong>판매단위:</strong> 1개</p>
                <p><strong>배송비:</strong> 무료배송</p>
                <p><strong>배송일정:</strong><br />
                    <c:choose>
                        <c:when test="${item.item_stock > 0}">
                            지금 주문하면 다음날 오후 도착 예정입니다.<br />
                            [당일 수령] 인터넷으로 주문하고 매장에서 직접 수령 가능
                        </c:when>
                        <c:otherwise>
                            재입고 이후 순차 배송예정입니다.
                        </c:otherwise>
                    </c:choose>
                </p>

                <div class="mb-3">
                    <label class="form-label"><strong>구매수량:</strong></label>
                    <c:choose>
                        <c:when test="${item.item_stock > 0}">
                            <input type="number" id="buyCount" class="form-control w-25 d-inline" value="1" min="1" max="${item.item_stock}">
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger">품절</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="text-center mt-4">
                    <c:choose>
                        <c:when test="${item.item_stock > 0}">
                            <button id="btn-addCart" class="btn btn-primary btn-lg">장바구니 담기</button>
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">재입고 예정</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	
	<script>
	document.addEventListener("DOMContentLoaded", () => {
	    const $addCart = document.querySelector("#btn-addCart");
	    const $itemNumber = document.querySelector("#itemNumber");
	    const $buyCount = document.querySelector("#buyCount");
	    const $itemName = document.querySelector("#itemName");
	    const $itemPrice = document.querySelector("#itemPrice");
	    const $itemImg = document.querySelector("#itemImg");

	    if ($addCart) {
	        $addCart.addEventListener("click", (event) => {
	            event.preventDefault();
	            
	            if (!"${sessionScope.log}") {
	                alert("로그인 후 이용 가능합니다.");
	                location.href = cp + "/member/loginForm.do";
	                return;
	            }

	            // 입력값 유효성 검사
	            if (!$itemNumber.value || !$buyCount.value || isNaN($buyCount.value) || parseInt($buyCount.value) <= 0) {
	                alert("올바른 수량을 입력해주세요.");
	                return;
	            }

	            // AJAX 요청
	            fetch(cp + "/shop/addCartPro.do", {
	                method: "POST",
	                headers: {
	                    "Content-Type": "application/json; charset=UTF-8"
	                },
	                body: JSON.stringify({
	                    itemNumber: $itemNumber.value,
	                    buyCount: $buyCount.value,
	                    log: "${sessionScope.log}", // 서버에서 세션으로 제공된 사용자 정보
	                    itemName: $itemName.value,
	                    itemPrice: $itemPrice.value,
	                    itemImg: $itemImg.value,
	                })
	            })
	                .then((response) => response.text())
	                .then((data) => {
	                    console.log("응답 데이터:", data);

	                    let match = data.trim().match(/<p id='check'>(-?\d+)<\/p>/);
	                    if (match && match[1] === "-1") {
	                        alert("장바구니에 담겼습니다.");
	                        location.href = cp + "/shop/cartList.do";
	                    } else {
	                        alert("장바구니 추가 실패");
	                    }
	                })
	                .catch((error) => {
	                    console.error("AJAX 요청 실패:", error);
	                    alert("장바구니 추가 중 오류가 발생했습니다.");
	                });
	        });
	    } else {
	        console.error("btn-addCart 버튼을 찾을 수 없습니다.");
	    }
	});
	</script>
</body>
</html>