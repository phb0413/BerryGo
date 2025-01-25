<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addOrder</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
<style>
	talbe, tr, td {
		border: 1px solid black;
		border-collapse: collapse;
	}
	#content-addOrder {
		margin: 0 auto;
	}
	#title {
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<div align="center">
	<c:set var="total" value="0"/>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
		<table id="content-addOrder">
			<c:forEach var="cart" items="${cartList}">
					<tr>
						<td>
							${cart.item_name}
							<input type="hidden" id="a" value="${cart.item_name}">
						</td>
						<td>
	                    	<img src="${pageContext.request.contextPath}/resources/image/${cart.item_image}" 
	                         alt="${cart.item_name}" style="width: 100px; height: auto;">
               		 	</td>
               		 	<td>
               		 		${cart.cart_buycount}
               		 		<input type="hidden" id="b" value="${cart.cart_buycount}">
               		 	</td>
               		 	<td>
               		 		${cart.item_price * cart.cart_buycount}
               		 	</td>
					</tr>
					<c:set var="total" value="${total + cart.item_price * cart.cart_buycount}" />
				</c:forEach>
				<tr>
					<td>총 결제금액</td>
					<td colspan="4" align="right"><c:out value="총 결제금액 : ${total }원"></c:out></td>
				</tr>
				<tr>
					<td>주문자명</td>
					<td colspan="4" align="right"><input type="text" id="buyer"></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td colspan="4" align="right"><input type="text" id="tel"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="4" align="right"><input type="text" id="addr"></td>
				</tr>
				<tr>
					<td colspan="5" align="right">
						<button id="btn-requestPay">결제하기</button>
					</td>
				</tr>
		</table>
	</div>
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	
	<script>
	
		let requestPay = (event) => {
			
			let IMP = window.IMP; 
	        IMP.init("imp70784620"); 
	      
	        let today = new Date();   
	        let hours = today.getHours(); // 시
	        let minutes = today.getMinutes();  // 분
	        let seconds = today.getSeconds();  // 초
	        let milliseconds = today.getMilliseconds();
	        let makeMerchantUid = hours +  minutes + seconds + milliseconds;
	        
	        IMP.request_pay({
                pg : 'html5_inicis',
                pay_method : 'card',
                merchant_uid: "IMP"+makeMerchantUid, 
                name : 'FRUIT',
                amount : 10,
                buyer_email : 'Iamport@chai.finance',
                buyer_name : '아임포트 기술지원팀',
                buyer_tel : '010-1234-5678',
                buyer_addr : '서울특별시 강남구 삼성동',
                buyer_postcode : '123-456'
            }, function (rsp) { // callback
                if (rsp.success) {
                    console.log(rsp);
                    
                    let log = "<%= (String)session.getAttribute("log") %>";
                    
                    $.ajax({
    					type: "post",
    					url: cp + "/shop/addOrderPro.do",
    					data: {
    						log: log,
    						buyer: $buyer.value,
    						tel: $tel.value,
    						addr: $addr.value
    					},
    					success: function(data) {
    						alert("결제가 완료되었습니다.");
    						location.href= cp+ "/shop/orderList.do";
    					},
    					error: function() {
    						alert("addOrderForm error");
    					}
                    });
                    
                } else {
                    console.log(rsp);
                }
            });			
	        
	        
		}
	
		let $requestPay = document.querySelector("#btn-requestPay");
		$requestPay.addEventListener("click", requestPay);
		
		let $buyer = document.querySelector("#buyer");
		let $tel = document.querySelector("#tel");
		let $addr = document.querySelector("#addr");
		
	</script>
</body>
</html>