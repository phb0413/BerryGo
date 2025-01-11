<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<style>
		table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        #content-boardWrite {
            margin: 0 auto;
            width: 600px;
        }
        #title, #boarWrite {
            text-align: center;
        }
	</style>
	<script>
		let cp = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<form id="FILE_FORM" method="post" enctype="multipart/form-data">
		<table id="content-boardWrite">
			<tr>
				<td colspan="2" id="title"><h2>새 게시글 쓰기</h2></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" id="writer" name="writer"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" id="subject" name="subject"></td>
			</tr>
			
			<tr>
				<td>글내용</td>
				<td><textarea rows="10" cols="50" id="content" name="content"></textarea></td>
			</tr>
			<tr>
				<td>사진첨부</td>
				<td id="box">
					 <p></p>	
					 <button id="button-addPicture">사진추가</button>
					 <p></p>					
				</td>
			</tr>
			<tr>
				<td colspan="2" id="boarWrite">
	              		<button id="button-boardWritePro">글쓰기</button>
					<button id="button-boardMain">메인화면</button>					
				</td>
			</tr>	
		</table>
	</form>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	
	<script>
		let addPicture = (event) => {
			event.preventDefault();
			if(num==6) {
				alert("사진은 5장까지 업로드 가능합니다");
				return;
			}
			
			let $box = document.getElementById("box");
			
			let $line = document.createElement('span');
			$line.className = 'line';
			
			let $newP1 = document.createElement('span');
            let fileNumber = "file" + num + "";
            let str = "<input type='file' value='추가' name='";            
            str += fileNumber + "'>";
            $newP1.innerHTML = str;
            $line.appendChild($newP1); 
            
            let $newP2 = document.createElement('span');
            str = "<input type='button' value='삭제'  onclick='delPicture(this)'><p></p>";       
        	$newP2.innerHTML = str;
            $line.appendChild($newP2);
            
            $box.appendChild($line);
            
            num += 1;
		}
		
		let delPicture = (event) => {
			let $lineList = document.querySelectorAll('.line');
			
			for(let i=0; i<$lineList.length; i++) {
				if($lineList[i].children[i].children[0] == event) {
					console.log(i);
					$lineList[i].remove();
					num -= 1;
					break;
				}
			}
		}
		
		let boardWritePro = (event) => {
			event.preventDefault();
			
			if($writer.value=="") {
				$writer.focus();
				alert("작성자 입력바랍니다.");
				return false;
			}
			if($subject.value == "") {
            	$subject.focus();
                alert("제목을 입력해주세요.");
                return false;
            }
			if($content.value == "") {
            	$content.focus();
                alert("내용을 입력해주세요.");
                return false;
            }
			let form = $('#FILE_FORM')[0];
		    let formData = new FormData(form);
		    
		    $.ajax({
		    	url: cp + '/board/boardWritePro.do',
		    	processData: false,
		    	contentType: false,
		    	data : formData,
		    	type: 'POST',
		    	success: function(result) {
		    		alert("게시물을 작성했습니다.");
		    		location.href=cp+'/board/boardList.do';
		    	},
		    	error: function() {
		    		alert("error");
		    	}
		    });
		    return true;
		}
		
		let boardMain = (event) => {
			event.preventDefault();
			location.href = cp + "/board/boardList.do";
		}
		
		let num = 1;	
		
		let $btnAddPicture = document.querySelector("#button-addPicture");
	   	$btnAddPicture.addEventListener("click", addPicture);
		
		let $btnBoardWritePro = document.querySelector("#button-boardWritePro");
	   	$btnBoardWritePro.addEventListener("click", boardWritePro);
		
	    let $writer = document.querySelector("#writer");
	    let $subject = document.querySelector("#subject");
	    let $content = document.querySelector("#content");
		
	    let $btnBoardMain = document.querySelector("#button-boardMain");
	    $btnBoardMain.addEventListener("click", boardMain);
	</script>
</body>
</html>