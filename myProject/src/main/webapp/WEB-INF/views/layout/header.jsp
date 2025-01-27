<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cp" value="${ pageContext.request.contextPath }" />

<div align="center">
	<c:if test="${ null eq sessionScope.log }">
		<table>
			<tr>
				<td><a href="${cp}/shop/itemList.do">쇼핑몰</a></td>
				<td><a href="${cp}/board/boardList.do">게시판</a></td>
				<td><a href="${cp}/member/joinForm.do">회원가입</a></td>
				<td><a href="${cp}/member/loginForm.do">로그인</a></td>
			</tr>
		</table>
	</c:if>
	<c:if test="${null ne sessionScope.log}">
		<table>
			<tr>
				<td><a href="${cp}/shop/itemList.do">쇼핑몰</a></td>
				<td><a href="${cp}/board/boardList.do">게시판</a></td>
				<td><a href="${cp}/member/logout.do">로그아웃</a></td>
				<td><a href="${cp}/shop/cartList.do">장바구니</a></td>
				<td><a href="${cp}/shop/orderList.do">주문목록</a></td>
			</tr>
		</table>
	</c:if>
</div>