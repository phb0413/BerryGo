<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 화면</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="container text-center mt-5">
        <div class="card p-5 shadow-lg">
            <h1 class="display-4">메인 화면입니다.</h1>
            <p class="lead">앞으로도 잘 부탁합니다.</p>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>