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
					[바로드림] 인터넷으로 주문하고 매장에서 직접 수령 가능
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
		let addCart = (event) => {
			<c:if test="${null eq sessionScope.log}">
				alert("로그인 후 이용가능합니다.");
				location.href = cp + "/member/loginForm.do";
				return false;
			</c:if>
			
			$.ajax({
				type : "POST",
				url : cp + "/item/addCartPro.do",
				data : {
					itemNumber: $itemNumber.value,
					buyCount: $buyCount.value,
					log: log
				},
				success: function(data) {
					let str = '<p id = "check">';
					let length = str.length;
					let startIndex = data.indexOf(str);
					
					let checkValue = data.substr(startIndex + length);
					
					console.log("data = " + data);
					console.log("length = " + length);
					console.log("startIndex = " + startIndex);
					console.log("[checkValue = " + checkValue + "]");
					
					if(checkValue.trim() == "-1") {
						alert("장바구니에 담겼습니다.");
						location.href = "cartList.jsp";
					}
				},
				error : function() {
					alert("itemInfo error");
				}
				
			});
		}
		
		let $addCart = document.querySelector("#btn-addCart");
		$addCart.addEventListener("click", addCart);
		
		let $itemNumber = document.querySelector("#itemNumber");
		let $buyCount = document.querySelector("#buyCount");
	</script>
</body>
</html>