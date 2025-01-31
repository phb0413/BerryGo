<!-- Updated boardWriteForm.jsp with Bootstrap -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 게시글 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script src="${contextPath}/resources/js/board.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="container mt-5">
        <div class="card p-4">
            <h2 class="text-center mb-4">새 게시글 쓰기</h2>
            <form id="FILE_FORM" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">작성자</label>
                    <input type="text" id="writer" name="writer" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">제목</label>
                    <input type="text" id="subject" name="subject" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">내용</label>
                    <textarea rows="5" id="content" name="content" class="form-control" required></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">사진 첨부</label>
                    <div id="box" class="d-flex flex-column gap-2">
                        <button id="button-addPicture" class="btn btn-outline-primary">사진 추가</button>
                    </div>
                </div>
                <div class="text-center">
                    <button id="button-boardWritePro" class="btn btn-primary">글쓰기</button>
                    <button id="button-boardMain" class="btn btn-outline-dark">메인화면</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let addPicture = (event) => {
            event.preventDefault();
            if(num >= 6) {
                alert("사진은 5장까지 업로드 가능합니다");
                return;
            }
            let box = document.getElementById("box");
            let line = document.createElement('div');
            line.className = 'd-flex gap-2';
            line.innerHTML = `<input type='file' name='file${num}' class='form-control'>
                              <button type='button' class='btn btn-danger' onclick='delPicture(this)'>삭제</button>`;
            box.appendChild(line);
            num++;
        };
        let delPicture = (event) => {
            event.parentElement.remove();
            num--;
        };
        let boardWritePro = (event) => {
            event.preventDefault();
            if (!$('#writer').val()) {
                alert("작성자 입력바랍니다.");
                $('#writer').focus();
                return false;
            }
            if (!$('#subject').val()) {
                alert("제목을 입력해주세요.");
                $('#subject').focus();
                return false;
            }
            if (!$('#content').val()) {
                alert("내용을 입력해주세요.");
                $('#content').focus();
                return false;
            }
            let formData = new FormData($('#FILE_FORM')[0]);
            $.ajax({
                url: '${contextPath}/board/boardWritePro.do',
                processData: false,
                contentType: false,
                data: formData,
                type: 'POST',
                success: function() {
                    alert("게시물을 작성했습니다.");
                    location.href='${contextPath}/board/boardList.do';
                },
                error: function() {
                    alert("error");
                }
            });
            return true;
        };
        let boardMain = (event) => {
            event.preventDefault();
            location.href = '${contextPath}/board/boardList.do';
        };
        let num = 1;
        $('#button-addPicture').on('click', addPicture);
        $('#button-boardWritePro').on('click', boardWritePro);
        $('#button-boardMain').on('click', boardMain);
    </script>
</body>
</html>
