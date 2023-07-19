<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	window.addEventListener('load', function () {
		
		// 리스트 조회
		btnList.addEventListener('click', function () {
			getFileList();
		});
		
		// 파일 업로드
		btnFileupload.addEventListener('click', function() {
			// 웹 개발에서 HTML 폼 데이터를 
			// JavaScript로 쉽게 조작하고 전송하는 방법을 제공하는 API 
			let formData = new FormData(fileuploadForm);
			formData.append('name','momo');
			console.log("formData : ", formData);
			// FormData값 확인
			for(var pair of formData.entries()){
				//console.log(pair);
				//console.log(pair[0]+':'+pair[1]);
				
				if(typeof(pair[1])=='object'){
					let fileName = pair[1].name;
					let fileSize = pair[1].size;
					
					// 파일 확장자, 크기 체크
					// 서버에 전송 가능한 형식인지 확인
					// 최대 전송가능한 용량을 초과 하지 않는지
					if(!checkExtension(fileName, fileSize)) {
						return;	
					}
					
					console.log('fileName',pair[1].name);
					console.log('fileSize', pair[1].size);
				}
			}
			
			fetch('/file/fileuploadActionFetch', {method : 'post', body : formData})
				.then(response=>response.json())
				.then(map => fileuploadRes(map));
		});
	});
	
	function checkExtension(fileName, fileSize) {
		let maxSize = 1024*1024*10; // 10MB
		// 정규표현식 : 특정규칙을 가진 문자열을 검색 하거나 치환할때 사용
		// RegExp("체크할 형식문자")
		// .exe .sh .zip .alz로 끝나는 문자열
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		if(maxSize <= fileSize){
			// 파일사이즈 초과
			alert("파일 사이즈 초과");
			return false;
		}
		// 문자열에 정규식 패턴을 만족하는  값이 있으면 true, 없으면 false를 리턴
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		
		return true;
		
	}
	
	function fileuploadRes(map) {
		if(map.result=='success') {			
			divFileuploadRes.innerHTML = map.message;
		}
	}
	
	function getFileList() {
		// /file/list/{bno}
		let bno = document.querySelector("#bno").value;

		fetch('/file/list/'+bno) 
			.then(response => response.json())
			.then(map => viewFileList(map));
	}
	
	function viewFileList(map) {
		console.log(map);

		let content = '';
		if(map.list.length>0){			
			map.list.forEach(function(item, index) {
				content += item.filename +'<br>';
			})
		} else {
			cnotent = '등록된 파일이 없습니다.';
		}
		divFileupload.innerHTML = content;

	}
</script>
</head>
<body>

	<h2>파일업로드</h2>
	<form name="fileuploadForm" method="post" enctype="multipart/form-data" action="/file/fileuploadAction">
		<h2>파일선택</h2><br>
		bno : <input type="text" name="bno" id="bno" value="121"><br>
		<input type="file" name="files"><br>
		<input type="file" name="files"><br>
		<input type="file" name="files"><br>
		<button type="submit">파일업로드</button>
		<button type="button" id="btnFileupload">Fetch파일업로드</button><br>
		res : ${param.msg}<br>
		<div id="divFileuploadRes">
			res : ${param.msg}<br>
		</div>
	</form>
	
	<h2>파일리스트 조회</h2>
	<button type="button" name="btnList" id="btnList">리스트 조회</button>
	<div id="divFileupload"></div>
</body>
</html>