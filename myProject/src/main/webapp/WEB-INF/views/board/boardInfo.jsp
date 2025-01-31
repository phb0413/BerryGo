<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"   uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
         
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="container mt-5">
        <h1 class="text-center">게시글 상세 페이지</h1>
        <div class="card p-4 mt-4">
            <table class="table table-bordered">
                <tr><th>번호</th><td>${board.num}</td><th>조회수</th><td>${board.readcount}</td></tr>
                <tr><th>작성자</th><td>${board.writer}</td><th>작성일</th><td>${board.reg_date}</td></tr>
                <tr><th>제목</th><td colspan="3">${board.subject}</td></tr>
                <tr><th>내용</th><td colspan="3">${board.content}</td></tr>
                <tr>
                    <th>사진</th>
                    <td colspan="3">
                        <c:forEach var="boardimage" items="${boardimageList}">
                            <img src="${cp}/resources/upload/${boardimage.boardimage_name}" class="img-thumbnail" style="width: 100px;">
                        </c:forEach>
                    </td>
                </tr>
            </table>
            <div class="text-center mt-3">
                <a href="${cp}/board/boardUpdateForm.do?num=${board.num}" class="btn btn-primary">수정하기</a>
                <a href="${cp}/board/boardDelete.do?num=${board.num}" class="btn btn-danger">삭제하기</a>
                <a href="${cp}/board/boardReWriteForm.do?num=${board.num}" class="btn btn-warning">답글쓰기</a>
                <a href="${cp}/board/boardList.do" class="btn btn-secondary">목록보기</a>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>