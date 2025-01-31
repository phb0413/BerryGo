<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cp" value="${ pageContext.request.contextPath }" />

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${cp}/shop/itemList.do">쇼핑몰</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="${cp}/board/boardList.do">게시판</a></li>
                <c:choose>
                    <c:when test="${null eq sessionScope.log}">
                        <li class="nav-item"><a class="nav-link" href="${cp}/member/joinForm.do">회원가입</a></li>
                        <li class="nav-item"><a class="nav-link" href="${cp}/member/loginForm.do">로그인</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="${cp}/member/logout.do">로그아웃</a></li>
                        <li class="nav-item"><a class="nav-link" href="${cp}/shop/cartList.do">장바구니</a></li>
                        <li class="nav-item"><a class="nav-link" href="${cp}/shop/orderList.do">주문목록</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>