<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardUpdateForm.jsp</title>
<script src="${contextPath}/resources/js/board.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<div class="center">
		<br>
		<h1>게시글 수정 페이지</h1>
		<br>
		
		<form class="formData" method="post" action="${contextPath}/board/boardUpdatePro.do" onsubmit="return false">
			<table border="1">
				<tr>
					<td>번호</td>
					<td>${board.num}</td>
					<td>작성자</td>
					<td>${board.writer}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3">
						<input type="text" name="subject" class="subject" value="${board.subject}">
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3">
						<textarea rows="5" cols="30" class="content" name="content">${board.content}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="hidden" name="num" value="${board.num}">
						<input type="button" value="수정하기" onclick="updateBoardCheck()">
						<input type="button" value="목록보기" onclick="location.href='${contextPath}/board/boardList.do'" >
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>