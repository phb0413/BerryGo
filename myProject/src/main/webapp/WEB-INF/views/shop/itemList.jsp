<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="cp" value="${ pageContext.request.contextPath }"></c:set>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
        .item-card img {
            width: 100%;
            height: auto;
            max-height: 150px;
            object-fit: cover;
            border: 1px solid #dee2e6;
            padding: 5px;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<div class="container mt-5 mb-5">
        <h2 class="text-center mb-4">전체 과일 목록</h2>
        <div class="row g-4">
            <c:forEach var="item" items="${itemList}">
                <div class="col-md-4">
                    <div class="card item-card h-100 text-center shadow-sm">
                        <c:set var="imagePath" value="${cp}/resources/image/${item.item_image}" />
                        <a href="${cp}/shop/itemInfo.do?itemNumber=${item.item_number}">
                            <img src="${imagePath}" alt="${item.item_name}" class="card-img-top">
                        </a>
                        <div class="card-body">
                            <h5 class="card-title">
                                <c:choose>
                                    <c:when test="${item.item_stock <= 0}">
                                        ${item.item_name}
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${cp}/shop/itemInfo.do?itemNumber=${item.item_number}" class="text-decoration-none text-dark">
                                            ${item.item_name}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <p class="card-text">
                                <c:choose>
                                    <c:when test="${item.item_stock <= 0}">
                                        <span class="text-danger fw-bold">품절</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-success fw-bold">${item.item_price}원</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>
