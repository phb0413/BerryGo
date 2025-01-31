<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cp" value="${pageContext.request.contextPath}"></c:set>      
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="text-center">전체 게시글 (${allArticlesCount}개)</h2>
            <button class="btn btn-primary" onclick="location.href='${cp}/board/boardWriteForm.do'">새글쓰기</button>
        </div>
        <div class="card p-4">
            <table class="table table-striped table-bordered text-center">
                <thead class="table-dark">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="number" value="${number}" />
                    <c:forEach var="board" items="${boardList}">
                        <tr>
                            <td>${number}</td>
                            <td class="text-start">
                                <c:if test="${board.re_step > 1}">
                                    <span class="text-muted">[답글]</span>
                                </c:if>
                                <a href="${cp}/board/boardInfo.do?num=${board.num}" class="text-decoration-none">${board.subject}</a>
                            </td>
                            <td>${board.writer}</td>
                            <td>${board.reg_date}</td>
                            <td>${board.readcount}</td>
                        </tr>
                        <c:set var="number" value="${number - 1}" />
                    </c:forEach>
                </tbody>
            </table>
            <div class="d-flex justify-content-center mt-3">
                <c:if test="${allArticlesCount > 0}">
                    <c:if test="${startPageNum > clickablePageCount}">
                        <a href="${cp}/board/boardList.do?currentPageNumber=${startPageNum - clickablePageCount}" class="btn btn-outline-primary">이전</a>
                    </c:if>
                    <c:forEach var="i" begin="${startPageNum}" end="${endPageNum}">
                        <a href="${cp}/board/boardList.do?currentPageNumber=${i}" class="btn btn-outline-secondary mx-1">${i}</a>
                    </c:forEach>
                    <c:if test="${endPageNum < allPageCount}">
                        <a href="${cp}/board/boardList.do?currentPageNumber=${startPageNum + clickablePageCount}" class="btn btn-outline-primary">다음</a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
