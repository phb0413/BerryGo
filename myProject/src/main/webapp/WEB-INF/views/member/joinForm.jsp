<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style>
		table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        #content-join {
            margin: 0 auto;
            width: 600px;
        }
        #title, #joinPro {
            text-align: center;
        }
	</style>
	
	<script>
		console.log("window.location.pathname:", window.location.pathname);
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
		console.log("Context Path (cp):", cp);
	</script>
</head>
<body>
	
	
	<table id="content-join">
        <tr>
            <td colspan="3" id="title"><h2>회원가입</h2></td>
        </tr>
        <tr>
            <td rowspan="2">아이디</td>
            <td><input id="input-memberId" type="text" placeholder="아이디를 입력해주세요" value="test1234"></td>
            <td><button id="button-memberIdCheckPro">중복확인</button></td>
        </tr>
        <tr>
            <td id="msg-memberId" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">비밀번호</td>
            <td colspan="2"><input id="input-memberPw" type="text" placeholder="비밀번호를 입력해주세요" value="Test1234!"></td>
        </tr>
        <tr>
            <td id="msg-memberPw" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">비밀번호확인</td>
            <td colspan="2"><input id="input-memberPwRe" type="text" placeholder="비밀번호를 한번 더 입력해주세요" value="Test1234!"></td>
        </tr>
        <tr>
            <td id="msg-memberPwRe" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">이름</td>
            <td colspan="2"><input id="input-memberName" type="text" placeholder="이름을 입력해주세요" value="고유동"></td>
        </tr>
        <tr>
            <td id="msg-memberName" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">이메일</td>
            <td><input id="input-memberEmail" type="text" placeholder="이메일을 입력해주세요" value="test1234@naver.com"></td>
            <td><button id="button-memberEmailCheckPro">중복확인</button></td>
        </tr>
        <tr>
            <td id="msg-memberEmail" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">휴대폰</td>
            <td colspan="2"><input id="input-memberPhone" type="text" placeholder="숫자만 입력해주세요" value="01012345678"></td>
        </tr>
        <tr>
            <td id="msg-memberPhone" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">우편번호</td>
            <td><input id="input-memberAddr1" type="text" placeholder="우편번호를 입력해주세요" value="02830"></td>
            <td><button onclick="execDaumPostcode()">우편번호검색</button></td>
        </tr>
        <tr>
            <td id="msg-memberAddr1" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">도로명 주소</td>
            <td colspan="2"><input id="input-memberAddr2" type="text" placeholder="도로명 주소를 입력해주세요" value="서울 성북구 아리랑로 3"></td>
        </tr>
        <tr>
            <td id="msg-memberAddr2" colspan="2"></td>
        </tr>
        <tr>
            <td rowspan="2">남은 주소</td>
            <td colspan="2"><input id="input-memberAddr3" type="text" placeholder="남은 주소를 입력해주세요" value="남은주소"></td>
        </tr>
        <tr>
            <td id="msg-memberAddr3" colspan="2"></td>
        </tr>
        <tr>
            <td>성별</td>
            <td colspan="2">
                <label><input type="radio" class="radio-memberGender" name="gender" value="1">남자</label>
                <label><input type="radio" class="radio-memberGender" name="gender" value="2">여자</label>
                <label><input type="radio" class="radio-memberGender" name="gender" value="0" checked>선택안함</label>
            </td>
        </tr>
        <tr>
            <td>유입 경로</td>
            <td colspan="2">
                <select id="select-memberRoute">
                    <option value="1">인터넷 검색</option>
                    <option value="2">지인 권유</option>
                    <option value="3">SNS</option>
                    <option value="4">광고</option>
                    <option value="0" selected>기타</option>
                </select>
            </td>
        </tr>
        <tr>
            <td rowspan="2">이용약관동의</td>
            <td colspan="2">
                <label><input id="check-memberAllTerms" type="checkbox">전체 동의</label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label><input class="check-memberTerms" type="checkbox" value="1">이용약관 동의 (필수)<br></label>
                <label><input class="check-memberTerms" type="checkbox" value="2">개인정보취급 동의 (필수)<br></label>
                <label><input class="check-memberTerms" type="checkbox" value="3">만 14세 이상입니다. (필수)<br></label>
                <label><input class="check-memberTerms select-memberTerm" type="checkbox" value="0">마케팅 메일 수신 동의 (선택)<br></label>
            </td>
        </tr>
        <tr>
            <td colspan="3" id="joinPro">
                <button id="button-memberJoinPro">가입하기</button>
            </td>
        </tr>
    </table>

    <script>
		/* 아이디 유효성 검사 */
		let inputMemberIdInput = (event) => {
			let $msgMemberId = document.querySelector("#msg-memberId");

			let regExp = RegExp(/^[A-Za-z0-9_\-]{6,16}$/);
			if(regExp.test($inputMemberId.value)) {
				$msgMemberId.innerHTML = "";
			} else {
				$msgMemberId.innerHTML = "<span style='color:#F03F40; font-size:12px;'>6자 이상 16자 이하의 영문 혹은 영문과 숫자를 조합</span>";
			}
		}

		/* 아이디 중복검사 */
		let buttonMemberIdCheckProClick = (event) => {	
			let regExp = RegExp(/^[A-Za-z0-9_\-]{6,16}$/);

			if($inputMemberId.value == "") {
				alert("아이디를 입력해주세요.");
				$inputMemberId.focus();
			} else if(!regExp.test($inputMemberId.value)) {
				alert("6자 이상 16자 이하의 영문 혹은 영문과 숫자를 조합");
				$inputMemberId.value = "";
				$inputMemberId.focus();
			} else {
				idCheck = true;
				
				let member = {id: $inputMemberId.value};
				console.log("AJAX 요청 데이터:", member);
				 
				$.ajax({
					url: cp + "/member/doubleIdCheckPro.do",
					type: "POST",
					dataType: "json",
					data: JSON.stringify(member),
					contentType:'application/json; charset=utf-8',
					success: function(dataResult) {
						console.log("AJAX 응답 데이터:", dataResult);
						if(dataResult == -1) {
							alert("중복된 아이디입니다.");
							$inputMemberId.value = "";
							$inputMemberId.focus();
						} else {
							alert("사용할 수 있는 아이디입니다.");
							$inputMemberPw.focus();
						}
					},
					error: function() {
						alert("doubleIdCheckPro error"); 
					}
				});
				
			}
		}

		/* 비밀번호 유효성 검사 */
		let inputMemberPwInput = (event) => {
			let $msgMemberPw = document.querySelector("#msg-memberPw");
	
			let regExp = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);
			if(regExp.test($inputMemberPw.value)) {
				$msgMemberPw.innerHTML = "";
			} else {
				$msgMemberPw.innerHTML = "<span style='color:#F03F40; font-size:12px;'>영문 대문자와 소문자, 숫자, 특수문자를 하나 이상 포함하여 8~16자 조합</span>";
			}
        }

         /* 비밀번호확인 유효성 검사 */
		let inputMemberPwReInput = (event) => {
			let $msgMemberPwRe = document.querySelector("#msg-memberPwRe");

			if($inputMemberPw.value == $inputMemberPwRe.value) {
				$msgMemberPwRe.innerHTML = "";
			} else {
				$msgMemberPwRe.innerHTML = "<span style='color:#F03F40; font-size:12px;'>동일한 비밀번호 입력</span>";
            }
     	}

        /* 이름 유효성 검사 */
        let inputMemberNameInput = (event) => {
			let $msgMemberName = document.querySelector("#msg-memberName");

            let regExp = RegExp(/^[가-힣]{2,6}$/);
            if(regExp.test($inputMemberName.value)) {
                $msgMemberName.innerHTML = "";
            } else {
                $msgMemberName.innerHTML = "<span style='color:#F03F40; font-size:12px;'>2~6글자의 한글만 입력</span>";
            }
        }

		/* 이메일 유효성 검사 */
		let inputMemberEmailInput = (event) => {
			let $msgMemberEmail = document.querySelector("#msg-memberEmail");

			let regExp = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
            if(regExp.test($inputMemberEmail.value)) {
                $msgMemberEmail.innerHTML = "";
            } else {
				$msgMemberEmail.innerHTML = "<span style='color:#F03F40; font-size:12px;'>이메일 형식으로 입력해 주세요.</span>";
            }
		}

		/* 이메일 중복검사 */
		let buttonMemberEmailCheckProClick = (event) => {
			let regExp = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
			if($inputMemberEmail.value == "") {
				alert("이메일을 입력해주세요.");
				$inputMemberEmail.focus();
			} else if(!regExp.test($inputMemberEmail.value)) {
				alert("이메일 형식으로 입력해 주세요.");
				$inputMemberEmail.value = "";
				$inputMemberEmail.focus();
			} else {
				emailCheck = true;
				
				let member = {email: $inputMemberEmail.value};
				console.log("AJAX 요청 데이터:", member);
				$.ajax({
					url: cp + "/member/doubleEmailCheckPro.do",
					type: "POST",
					dataType: "json",
					data: JSON.stringify(member),
					contentType:'application/json; charset=utf-8',
					success: function(dataResult) {
						if(dataResult == -1) {
							
							alert("중복된 이메일입니다.");
							$inputMemberEmail.value = "";
							$inputMemberEmail.focus();
						} else {
							alert("사용할 수 있는 이메일입니다.");
							$inputMemberPhone.focus();
						}
					},
					error: function() {
						alert("doubleEmailCheckPro error"); 
					}
				});
				
			}
		}

        /* 휴대폰 유효성 검사 */
		let inputMemberPhoneInput = (event) => {
			let $msgMemberPhone = document.querySelector("#msg-memberPhone");
	
	        let regExp = RegExp(/^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/);
	        if(regExp.test($inputMemberPhone.value)) {
				$msgMemberPhone.innerHTML = "";
			} else {
				$msgMemberPhone.innerHTML = "<span style='color:#F03F40; font-size:12px;'>휴대폰 형식으로 입력해 주세요.</span>";
			}
		}

		/* 우편번호 검색 기능 */
		let execDaumPostcode = (event) => {
			new daum.Postcode( {
				oncomplete: function(data) {

					document.querySelector("#input-memberAddr1").value = data.zonecode;
					document.querySelector("#input-memberAddr2").value = data.address;

					document.querySelector("#input-memberAddr3").focus();
				}
			} ).open();
		}

		/* 전체동의 체크 자동화 기능 */
		let checkMemberAllTermsClick = (event) => {
			if($checkMemberAllTerms.checked) {
				for(let i=0; i<$checkMemberTerms.length; i++) {
					$checkMemberTerms[i].checked = true;
				}
			} else {
				for(let i=0; i<$checkMemberTerms.length; i++) {
					$checkMemberTerms[i].checked = false;
				}
			}
		}
        let checkMemberTermsClick = (event) => {
            let count = 0;
            for(let i=0; i<$checkMemberTerms.length; i++) {
                if($checkMemberTerms[i].checked) {
                    count += 1;
                }
            }
            if(count == $checkMemberTerms.length) {
                $checkMemberAllTerms.checked = true;
            } else {
                $checkMemberAllTerms.checked = false;
            }
        }

        /* 가입하기 */
        let buttonMemberJoinProClick = (event) => {
            // 아이디 입력 확인
            if($inputMemberId.value == "") {
                $inputMemberId.focus();
                alert("아이디를 입력해주세요.");
                return false;
            }
            // 아이디 중복확인
            if(idCheck == false) {
                alert("아이디를 중복확인을 해주세요.");
                return false;
            }
            // 비밀번호 입력 확인
            if($inputMemberPw.value == "") {
                alert("비밀번호를 입력해주세요.");
                return false;
            }
            // 비밀번호확인 입력 확인
            if($inputMemberPwRe.value == "") {
                alert("비밀번호 확인을 입력해주세요.");
                return false;
            }
            // 이름 입력 확인
            if($inputMemberName.value == "") {
                alert("이름을 입력해주세요.");
                return false;
            }
            // 이메일 입력 확인
            if($inputMemberEmail.value == "") {
                alert("이메일을 입력하세요.");
                return false;
            }
            // 이메일 중복확인
            if(emailCheck == false) {
                alert("이메일 중복 확인를 해주세요.");
                return false;
            }
            // 휴대폰 입력 확인
            if($inputMemberPhone.value == "") {
                alert("휴대폰 번호를 입력해주세요.");
                return false;
            }
            // 우편번호 입력 확인
            if($inputMemberAddr1.value == "") {
                alert("우편번호를 입력해주세요.");
                return false;
            }
            // 도로명 입력 확인
            if($inputMemberAddr2.value == "") {
                alert("도로명을 입력해주세요.");
                return false;
            }
            // 남은 주소 입력 확인
            if($inputMemberAddr3.value == "") {
                alert("남은 주소를 입력해주세요.");
                return false;
            }
            
            
            let $radioMemberGenderList = document.querySelectorAll(".radio-memberGender");
            let memberGender = "";
            for(let i=0; i<$radioMemberGenderList.length; i++) {
            	if($radioMemberGenderList[i].checked) {
            		memberGender = $radioMemberGenderList[i].value;
            	}
            }
            

            // 이용약관 동의 필수항목 선택 확인
            let $checkMemberTerms = document.querySelectorAll(".check-memberTerms");
            let checkResult = true;
            for(let i=0; i<$checkMemberTerms.length - 1; i++) {
                if(!$checkMemberTerms[i].checked) {
                    checkResult = false;
                    break;
                }
            }
            if(checkResult == false) {
                alert("필수 약관에 동의해주세요.");
                return false;
            } 
            
            let selectCheckTerm = 0;
            if($selectMemberTerm.checked) {
            	selectCheckTerm = 1;
            }
            
            let member = {
           		id : $inputMemberId.value,					
				pw  : $inputMemberPw.value,
				name : $inputMemberName.value,
				email : $inputMemberEmail.value,
				phone : $inputMemberPhone.value,
				addr1 : $inputMemberAddr1.value,
				addr2 : $inputMemberAddr2.value,
				addr3 : $inputMemberAddr3.value,	
				gender : memberGender,
				route : $selectMemberRoute.value,
				marketing : selectCheckTerm
            };
            
			$.ajax({
				url: cp + "/member/joinPro.do",
				type: "post",
				dataType: "json",
				data: JSON.stringify(member),
				contentType:'application/json; charset=utf-8',
				success: function(dataResult) {
					alert("회원가입 성공");
					location.href = cp + "/shop/itemList.do";
				},
				error: function() { 
					alert("joinPro error"); 
				}
			});
			         
            return true;
        }

        //--------------------------------------------------------------------------------------

        let idCheck = false;
        let emailCheck = false;

        let $inputMemberId = document.querySelector("#input-memberId");
        $inputMemberId.addEventListener("input", inputMemberIdInput);

        let $buttonMemberIdCheckPro = document.querySelector("#button-memberIdCheckPro");
        $buttonMemberIdCheckPro.addEventListener("click", buttonMemberIdCheckProClick);

        let $inputMemberPw = document.querySelector("#input-memberPw");
        $inputMemberPw.addEventListener("input", inputMemberPwInput);

        let $inputMemberPwRe = document.querySelector("#input-memberPwRe");
        $inputMemberPwRe.addEventListener("input", inputMemberPwReInput);

        let $inputMemberName = document.querySelector("#input-memberName");
        $inputMemberName.addEventListener("input", inputMemberNameInput);

        let $inputMemberEmail = document.querySelector("#input-memberEmail");
        $inputMemberEmail.addEventListener("input", inputMemberEmailInput);

        let $buttonMemberEmailCheckPro = document.querySelector("#button-memberEmailCheckPro");
        $buttonMemberEmailCheckPro.addEventListener("click", buttonMemberEmailCheckProClick);

        let $inputMemberPhone = document.querySelector("#input-memberPhone");
        $inputMemberPhone.addEventListener("input", inputMemberPhoneInput);

        let $inputMemberAddr1 = document.querySelector("#input-memberAddr1");
        let $inputMemberAddr2 = document.querySelector("#input-memberAddr2");
        let $inputMemberAddr3 = document.querySelector("#input-memberAddr3");
        
        
        let $selectMemberRoute = document.querySelector("#select-memberRoute");

        let $checkMemberAllTerms = document.querySelector("#check-memberAllTerms");
        $checkMemberAllTerms.addEventListener("click", checkMemberAllTermsClick);

        let $checkMemberTerms = document.querySelectorAll(".check-memberTerms");
        for(let i=0; i<$checkMemberTerms.length; i++) {
            $checkMemberTerms[i].addEventListener("click", checkMemberTermsClick);
        }
        
        let $selectMemberTerm = document.querySelector(".select-memberTerm");
        

        let $btnMemberJoinPro = document.querySelector("#button-memberJoinPro");
        $btnMemberJoinPro.addEventListener("click", buttonMemberJoinProClick);
    	
    </script>
	
	
</body>
</html>