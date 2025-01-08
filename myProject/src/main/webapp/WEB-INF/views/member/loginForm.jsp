<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<style>
		table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        #content-login {
            margin: 0 auto;
            width: 600px;
        }
        #title, #loginPro {
            text-align: center;
        }
	</style>	
	<script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
	<table id = "content-login">
		<tr>
			<td>아이디 : qwer1234</td>
			<td>비밀번호 : Qwer1234!</td>
		</tr>
		<tr>
			<td colspan="2" id="title">로그인</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" id="input-memberId"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="text" id="input-memberPw"></td>
		</tr>
	</table>
	
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
			
			let member = {"id" : $inputMemberId.value, $inputMemberPw.value};
			
			$.ajax({
				url : cp + "/member/loginPro.do",
				type : "post",
				dataType: "json",
				data : JSON.stringify(member);
				contentType:'application/json; charset=utf-8',
				success: function(dataResult) {
					if(dataResult==-1) {
						alert("로그인 실패");
					} else {
						aelrt("로그인 성공");
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