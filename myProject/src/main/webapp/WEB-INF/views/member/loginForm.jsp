<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">	
	<script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	<div class="container mt-5 mb-5">
    <div class="card shadow mx-auto" style="max-width: 500px;">
        <div class="card-header bg-dark text-white text-center">
            <h3 class="mb-0">로그인</h3>
        </div>
        <div class="card-body">
            <form id="loginForm">
                <div class="mb-3">
                    <label for="input-memberId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="input-memberId" placeholder="아이디 입력">
                </div>
                <div class="mb-3">
                    <label for="input-memberPw" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="input-memberPw" placeholder="비밀번호 입력">
                </div>
                <div class="text-center">
                    <button type="button" id="button-memberLoginPro" class="btn btn-primary w-100">로그인</button>
                </div>
            </form>
            <div class="mt-4 text-muted text-center small">
                <p>예시 아이디: <strong>qwer1234</strong></p>
                <p>예시 비밀번호: <strong>Qwer1234!</strong></p>
            </div>
        </div>
    </div>
</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	<script>
		let memberLoginPro = (event) => {
			if($inputMemberId.value=="") {
				alert("아이디 입력바랍니다.");
				$inputMemberId.focus();
				return false;
			}
			if($inputMemberPw.value=="") {
				alert("비밀번호 입력바랍니다.");
				$inputMemberPw.focus();
				return false;
			}
			
			let member = {"id" : $inputMemberId.value, "pw" : $inputMemberPw.value};
			
			$.ajax({
				url : cp + "/member/loginPro.do",
				type : "POST",
				dataType: "json",
				data : JSON.stringify(member),
				contentType:'application/json; charset=utf-8',
				success: function(dataResult) {
					if(dataResult==-1) {
						alert("로그인 실패");
					} else {
						alert("로그인 성공");
						location.href=cp+ "/";
					}
				},
				error: function() {
					alert("loginPro error");
				}
				
			});
			
			return true;
		};
		
		let $inputMemberId = document.querySelector("#input-memberId");
		let $inputMemberPw = document.querySelector("#input-memberPw");
		let $buttonMemberLoginPro = document.querySelector("#button-memberLoginPro");
		
		$buttonMemberLoginPro.addEventListener("click", memberLoginPro);
	</script>
</body>
</html>