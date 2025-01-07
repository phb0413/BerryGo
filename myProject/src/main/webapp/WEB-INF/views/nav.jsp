<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css" />	

<%-- 위 경로설정을 반드시 해줘야 정상적으로 이동한다. --%>


<div class="nav">
	<a href="${contextPath}/member/joinForm.do">회원가입</a>&nbsp;&nbsp;&nbsp;
	<a href="${contextPath}/member/loginForm.do">로그인</a>&nbsp;&nbsp;&nbsp;
	<a href="${contextPath}/member/memberList.do">회원목록</a>&nbsp;&nbsp;&nbsp;

	<a href="${contextPath}/index.do">홈으로</a>
</div>
<c:if test="${sessionScope.log ne null}">
	<div class="nav">
		[${sessionScope.log } 로그인]
		<a href="${contextPath}/member/logout.do">로그아웃</a>&nbsp;&nbsp;&nbsp;
		<a href="${contextPath}/member/modifyForm.do">회원정보 수정</a>&nbsp;&nbsp;&nbsp;
	</div>
</c:if>