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
		table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        #content-itemInfo {
            margin: 0 auto;
            width: 600px;
        }
        #title {
            text-align: center;
        }
        #item-image {
        	width: 300px;
        	border: 1px solid lightgray;        
        }        
            
	</style>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<table id="content-itemInfo">
		<tr>
			<td colspan="3" id="title"><h1>상품 상세페이지</h1></td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<h2>${item.item_name}</h2>
				<input type="hidden" id="itemNumber" value="${item.item_number}">
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center"><h3>${item.item_info}</h3></td>
		</tr>
		<tr>
			<td rowspan="7" width="100px">
				<c:set var="imagePath" value="${pageContext.request.contextPath}/resources/image/${item.item_image}"></c:set>
				<img id="item-image" src="${imagePath}">
			</td>
			<td colspan="2" align="right">정가 ${item.item_price }</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<fmt:parseNumber var="price" value="${item.item_price - item.item_price * item.item_discount / 100}"></fmt:parseNumber>
				판매가 <fmt:formatNumber value="${price}" type="currency"></fmt:formatNumber>
			</td>
		</tr>
		<tr>
			<td>판매단위</td>
			<td align="right">1개</td>
		</tr>
		<tr>
			<td>배송비</td>
			<td align="right">무료배송</td>
		</tr>
		<tr>
			<td>배송일정</td>
			<td align="right">
			<c:choose>
				<c:when test="${item.item_stock > 0}">
					지금 주문하면 다음날 오후 도착 예정입니다.
					<br />
					[당일 수령] 인터넷으로 주문하고 매장에서 직접 수령 가능
				</c:when>
				<c:otherwise>
					재입고 이후 순차 배송예정입니다.							
				</c:otherwise>				
			</c:choose>
			</td>
		</tr>
		<tr>
			<td>구매수량</td>
			<td align="right">
			<c:choose>
				<c:when test="${item.item_stock>0}">
					<input type="number" id="buyCount" min="1" max="${item.item_stock}" value="1">	
				</c:when>
				<c:otherwise>
					품절
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<c:choose>
				<c:when test="${item.item_stock > 0}">
					<button id="btn-addCart">장바구니 담기</button>
				</c:when>
				<c:otherwise>
					재입고 예정
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
	</table>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	
	<script>
	document.addEventListener("DOMContentLoaded", () => {
	    const $addCart = document.querySelector("#btn-addCart");
	    const $itemNumber = document.querySelector("#itemNumber");
	    const $buyCount = document.querySelector("#buyCount");

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
	                    log: "${sessionScope.log}" // 서버에서 세션으로 제공된 사용자 정보
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