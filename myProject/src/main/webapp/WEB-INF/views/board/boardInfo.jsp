<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
         
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardInfo.jsp</title>
<style>
		table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        #content-boardInfo {
            margin: 0 auto;
            width: 600px;
        }
        #title, #boardInfo {
            text-align: center;
        }
        .boardImage {
        	width: 100px;
        	border: 1px solid lightgray;
        }
	</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>	
	
	<div class="center">
		<br>
		<h1>게시글 상세 페이지</h1>
		<br>
		
		<table border="1">
			<tr>
				<td>번호</td>
				<td>${board.board_number}</td>
				<td>조회수</td>
				<td>${board.board_readcount}</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${board.board_writer}</td>
				<td>작성일</td>
				<td>${board.board_date}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3">${board.board_subject}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3">${board.board_content}</td>
			</tr>
			<tr>
				<td>사진</td>
				<td>
					<c:forEach var="boardimage" items= "${boardimageList}">
						<c:set var="imagePath" value="${cp}/resources/upload/${boardimage.boardimage_name}"></c:set>
						<p>
							<img src="${imagePath}" class="boardImage">
						</p>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="button" value="수정하기" onclick="location.href='${cp}/board/boardUpdateForm.do?num=${board.board_number}'">
					<input type="button" value="삭제하기" onclick="location.href='${cp}/board/boardDelete.do?num=${board.board_number}'">
					<input type="button" value="답글쓰기" onclick="location.href='${cp}/board/boardReWriteForm.do?num=${board.board_number}'">
					<input type="button" value="목록보기" onclick="location.href='${cp}/board/boardList.do'" >
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>