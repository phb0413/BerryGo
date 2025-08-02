<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addOrder</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<c:set var="total" value="0"/>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
		<div class="container mt-5 mb-5">
    <div class="card shadow">
        <div class="card-header bg-dark text-white text-center">
            <h3 class="mb-0">주문 정보 확인 및 결제</h3>
        </div>
        <div class="card-body">
            <div class="table-responsive mb-4">
                <table class="table table-bordered align-middle text-center">
                    <thead class="table-light">
                        <tr>
                            <th>상품명</th>
                            <th>이미지</th>
                            <th>수량</th>
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cart" items="${cartList}">
                            <tr>
                                <td>${cart.item_name}</td>
                                <td>
                                    <img src="${contextPath}/resources/image/${cart.item_image}" style="width:100px;">
                                </td>
                                <td>${cart.cart_buycount}</td>
                                <td><fmt:formatNumber value="${cart.item_price * cart.cart_buycount}" type="currency" /></td>
                            </tr>
                            <c:set var="total" value="${total + cart.item_price * cart.cart_buycount}" />
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="text-end mb-4">
                <h5>총 결제 금액: <fmt:formatNumber value="${total}" type="currency" /></h5>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label">주문자명</label>
                    <input type="text" id="buyer" class="form-control" placeholder="주문자 이름">
                </div>
                <div class="col-md-4">
                    <label class="form-label">연락처</label>
                    <input type="text" id="tel" class="form-control" placeholder="010-1234-5678">
                </div>
                <div class="col-md-4">
                    <label class="form-label">주소</label>
                    <input type="text" id="addr" class="form-control" placeholder="배송지 주소">
                </div>
            </div>

            <div class="text-center">
                <button id="btn-requestPay" class="btn btn-primary btn-lg w-50">결제하기</button>
            </div>
        </div>
    </div>
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
    					type: "POST",
    					url: cp + "/shop/addOrderPro.do",
    					contentType: "application/json",
    					data: JSON.stringify({
    				        buyer: $buyer.value, // 입력 필드 값
    				        tel: $tel.value,
    				        addr: $addr.value
    				    }),
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