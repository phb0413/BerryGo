<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${contextPath}/resources/js/board.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="container mt-5">
        <div class="card p-4">
            <h2 class="text-center mb-4">게시글 수정</h2>
            <form class="formData" method="post" action="${contextPath}/board/boardUpdatePro.do" onsubmit="return false">
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label">번호</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" value="${board.num}" readonly>
                    </div>
                    <label class="col-sm-2 col-form-label">작성자</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" value="${board.writer}" readonly>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">제목</label>
                    <input type="text" name="subject" class="form-control subject" value="${board.subject}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">내용</label>
                    <textarea rows="5" class="form-control content" name="content" required>${board.content}</textarea>
                </div>
                <input type="hidden" name="num" value="${board.num}">
                <div class="text-center">
                    <button type="button" class="btn btn-primary" onclick="updateBoardCheck()">수정하기</button>
                    <button type="button" class="btn btn-outline-dark" onclick="location.href='${contextPath}/board/boardList.do'">목록보기</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>