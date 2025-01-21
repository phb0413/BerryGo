function updateBoardCheck() {
	let subject = document.querySelector(".subject");
	let content = document.querySelector(".content");
	
	if(!subject.value) {
		alert("제목을 입력해주세요.");
		subject.focus();
	} else if(!content.value) {
		alert("내용을 입력해주세요");
		content.focus();
	} else {
		alert("수정 완료");
		let formData = document.querySelector(".formData");
		formData.submit();	
	}
}

function reWriteBoardCheck() {
	let writer = document.querySelector(".writer");
	let subject = document.querySelector(".subject");
	let content = document.querySelector(".content");
	
	if(!writer.value) {
		alert("작성자를 입력해주세요");
		writer.focus();
	} else if(!subject.value) {
		alert("제목을 입력해주세요");
		subject.focus();
	} else if(!content.value) {
		alert("내용을 입력해주세요");
		content.focus();
	} else {
		alert("댓글 작성을 완료했습니다.");
		let formData = document.querySelector(".formData");
		formData.submit();	
	}
}