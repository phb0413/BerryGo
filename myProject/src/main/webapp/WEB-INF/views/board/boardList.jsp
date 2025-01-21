<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cp" value="${pageContext.request.contextPath}"></c:set>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<style>
		table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        #content-boardList {
            margin: 0 auto;
            width: 600px;
        }
        #title {
            text-align: center;
        }
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
		<table>
			<tr>
				<td>
					<button onclick="location.href='${cp}/board/boardWriteForm.do'">새글쓰기</button>
				</td>
			</tr>
		</table>
	<table id="content-boardList">
		<tr>
			<td id="title" colspan="7"><h2>전체 게시글 (${allArticlesCount}개)</h2></td>
		</tr>
		
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
	<c:set var="number" value="${number}"></c:set>
	<c:forEach var="board" items="${boardList}">
		<tr>
			<td>${number}</td>
			<td width="400px">
				<c:if test="${board.re_step > 1}">
					<c:forEach var="j" begin="1" end="${(board.re_step - 1) * 3}">
						&nbsp;
					</c:forEach>
					[답글]
				</c:if>
				<a href="${cp}/board/boardInfo.do?num=${board.num}">${board.subject}</a>
			</td>
			<td>${board.writer}</td>
			<td>${board.reg_date}</td>
			<td>${board.readcount}</td>
		</tr>
		<c:set var="number" value="${number - 1}"></c:set>
	</c:forEach>
	</table>
	<br>
	
	<c:if test="${allArticlesCount > 0}">
		<c:if test="${startPageNum > clickablePageCount}">
			<a href="${cp}/board/boardList.do?currentPageNumber=${startPageNum - clickablePageCount}">[이전]</a>
		</c:if>
		
		<c:forEach var="i" begin="${startPageNum}" end="${endPageNum}">
			<a href="${cp}/board/boardList.do?currentPageNumber=${i}">[${i}]</a>
		</c:forEach>
		
		<c:if test="${endPageNum < allPageCount}">
			<a href="${cp}/board/boardList.do?currentPageNumber=${startPageNum + clickablePageCount}">[다음]</a>
		</c:if>
	</c:if>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>