<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        .btn {
            padding: 5px 10px;
            background-color: red;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>	
	
    <h1 style="text-align: center;">장바구니</h1>
    <table>
        <thead>
            <tr>
                <th>상품명</th>
                <th>이미지</th>
                <th>수량</th>
                <th>가격</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="cart" items="${cartList}">
                <tr>
                    <td>${cart.item_name}</td>
                     <td>
                    	<img src="${pageContext.request.contextPath}/resources/image/${cart.item_image}" 
                         alt="${cart.item_name}" style="width: 100px; height: auto;">
               		 </td>
                    <td>${cart.cart_buycount}</td>
                    <td>${cart.item_price * cart.cart_buycount}</td>
                    <td>
                        <button class="btn" onclick="removeItem(${cart.cart_number})">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

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
