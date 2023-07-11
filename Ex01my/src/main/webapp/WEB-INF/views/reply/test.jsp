<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/580fe16cf3.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	// 이 방식으로 하면 새로고침 했을때 댓글페이지 고정은 힘듬
	let first = true;
	// 버튼이 생성되고 나서 이벤트를 부여하기위해 onload이벤트에 작성
	window.onload = function() {
		getList();
		
		btnWrite.addEventListener('click', function() {
			// 1. 파라메터 수집
			let bno = document.querySelector('#bno').value;
			let reply = document.querySelector('#reply').value;
			let replyer = document.querySelector('#replyer').value;
			
			// console.log('bno', bno);
			
			// 2. 전송할 데이터를 javascript객체로 생성
			let replyObj ={
					bno : bno,
					reply : reply,
					replyer : replyer
			};
			// 3. 생성된 객체를 json타입 문자열로 변환
			let replyJson = JSON.stringify(replyObj);
			
			// console.log('replyObj', replyObj);
			// console.log('replyJson', replyJson);
			
			// 4. 서버에 요청(post방식) 
			//		fetch(url,header 부분에 어떤 형태의 데이터를 사용할지 지정,http body에 데이터를 넣어 전달)
			fetch('/reply/insert', {method: 'post',
				headers : {'Content-Type' : 'application/json'}, body : replyJson})
				// 5. 응답처리
				.then(response => response.json())
				.then(map => replyRes(map));
		});
		
		
	}
	
	function getPage(page) {
		document.querySelector('#page').value = page;
		getList();
	}

	// 리스트 요청
	function getList() {
		
		let bno = document.querySelector('#bno').value;
		let page = document.querySelector('#page').value;
		
		fetchGet('/reply/list/'+bno+'/'+page, replyView);
		
		/*
		// url요청 결과를 받아옵니다.
		fetch('/reply/list/'+bno+'/'+page) 
		// response.json() : 요청결과를 js object형식으로  반환
		.then(response => response.json())
		// 반환받은 오브젝트를 이용하여 화면에 출력합니다.
		.then(map => replyView(map));
		*/
	}
	
	// 리스트를 화면에 출력
	function replyView(map) {
		
		let list = map.list;
		let pageDto = map.pageDto;
		/*
		if(first) {			
			document.querySelector('#page').value = pageDto.endNo;
			first = false;
			getList();
		}*/
		
		// 콘솔창에 리스트 출력
		console.log(list);
		console.log(pageDto);
		console.log(pageDto.startNo);
		console.log(pageDto.endNo);
		
		
		// div 초기화
		replyDiv.innerHTML = '';
		
		// 댓글 리스트로 부터 댓글을 하나씩 읽어와서  div에 출력
		list.forEach((reply, index) => {
			replyDiv.innerHTML += '<figure id="reply'+index+'" data-value="'+reply.reply.replace(/\"/gi, "&quot;")+'" data-rno="'+reply.rno+'">'
								 + '<blockquote class="blockquote">'
								 + '<p>'+reply.reply.replace(/ /gi, "&nbsp;")
								 + '<i class="fa-regular fa-pen-to-square" onclick="replyEdit('+index+')"></i>'
								 + '&nbsp;<i class="fa-solid fa-eraser" onclick="replyDelete('+ reply.rno +')"></i>'
								 + '</p>'
								 + '</blockquote>'
								 
								 + '<figcaption class="blockquote-footer">'
								 + reply.replyer
								 + '<cite title="Source Title">'+reply.replydate+'</cite>'
								 + '</figcaption>'
								 + '</figure>'
		});
		
		let pageBlock = '';
		// 페이지 블럭 생성
		let prev = pageDto.prev? "" : "disabled";
		let next = pageDto.next? "" : "disabled";
		
		pageBlock += '<nav aria-label="Page navigation example">'
		 				    + '<ul class="pagination">'
		 				    // 이전 버튼
		  					+ '<li class="page-item">'
		   					+ '<a class="page-link '+prev+'" href=javascript:;" onclick="getPage('+(pageDto.startNo-1)+')" aria-label="Previous">'
		    				+ '<span aria-hidden="true">&laquo;</span>'
		     				+ '</a>'
		    				+ '</li>';
		// 페이지 버튼
		for(i=pageDto.startNo; i<=pageDto.endNo; i++) {
			let activeStr = pageDto.cri.pageNo == i ? "active" : "";
			pageBlock += '<li class="page-item"><a class="page-link '+activeStr+'" href=javascript:;" onclick="getPage('+i+')">'+i+'</a></li>';
		}
	
		// 이후 버튼
		pageBlock += '<li class="page-item">'
		     				+ '<a class="page-link '+next+'" href=javascript:;" onclick="getPage('+(pageDto.endNo+1)+')" aria-label="Next">'
		      				+ '<span aria-hidden="true">&raquo;</span>'
		      				+ '</a>'
		    				+ '</li>'
		  					+ '</ul>'
							+ '</nav>';
		replyDiv.innerHTML += pageBlock;				
	}
	
	function replyDelete(rno) {
		// url요청 결과를 받아옵니다.
		fetch('/reply/delete/'+rno) 
		// response.json() : 요청결과를 js object형식으로  반환
		.then(response => response.json())
		// 반환받은 오브젝트를 이용하여 화면에 출력합니다.
		.then(map => replyRes(map));
	}
	
	// 수정 화면 보여주기
	function replyEdit(index) {
		let edit = document.querySelector("#reply"+index);
		let replyTxt = edit.dataset.value;
		let rno = edit.dataset.rno;
		
		console.log("replyTxt : "+replyTxt);
		
		edit.innerHTML = '<div class="input-group mb-3">'
		 				+ '<input type="text" class="form-control" id="editReply'+rno+'" name="reply" value="'+replyTxt.replace(/\"/gi, "&quot;")+'" aria-describedby="basic-addon2">'
		  				+ '<span class="input-group-text" id="btnWrite" onclick="replyEditAction('+rno+')">수정하기</span>'
						+ '</div>';
		
	}
	
	function replyEditAction(rno) {
		// 1. 파라메터 수집
		let bno = document.querySelector('#bno').value;
		let reply = document.querySelector('#editReply'+rno).value;
		let replyer = document.querySelector('#replyer').value;
		
		// console.log('bno', bno);
		
		// 2. 전송할 데이터를 javascript객체로 생성
		let replyObj ={
				rno : rno,
				reply : reply,
		};
		
		fetchPost('/reply/update', replyObj, replyRes);
		/*
		// 3. 생성된 객체를 json타입 문자열로 변환
		let replyJson = JSON.stringify(replyObj);
		
		// console.log('replyObj', replyObj);
		// console.log('replyJson', replyJson);
		
		// 4. 서버에 요청(post방식) 
		//		fetch(ur0l,header 부분에 어떤 형태의 데이터를 사용할지 지정,http body에 데이터를 넣어 전달)
		fetch('/reply/update', {method: 'post',
			headers : {'Content-Type' : 'application/json'}, body : replyJson})
			// 5. 응답처리
			.then(response => response.json())
			.then(map => replyRes(map));
		*/
	}
	
	// callback 함수의 이름을 넘겨주면 괄호를 붙이면 함수를 실행시킴
	function fetchGet(url, callback) {
		// url 요청
		fetch(url)
			// 요청결과 json문자열을 javascript 객체로 반환
			.then(response => response.json())
			// 콜백함수 실행
			.then(map => callback(map))
	}
	
	function fetchPost(url, obj, callback) {
		try{
			fetch(url, {method:'post', 
				headers : {'Content-Type' : 'application/json'}, 
				// obj를 JSON타입으로 변환
				body : JSON.stringify(obj)})
				.then(response => response.json())
				.then(map => callback(map));			
		}catch(e){
			console.log('fetchPost', e);
			
		}
	}
	
	function replyRes(map) {
		if(map.result=='success') {
			// 등록성공
			// 리스트 조회 및 출력
			getList();
			reply.value='';
			replyer.value='';
		} else {
			// 등록실패
			alert(map.message);
		}
		
	}

</script>

</head>
<body>

<h2>답글달기</h2>
<input type="hidden" name="page" id="page" value="1">

<div class="input-group mb-3">
  <input type="text" class="form-control" id="replyer" placeholder="작성자 입력">
  <input type="text" class="form-control" id="reply" name="reply" placeholder="댓글을 입력하세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
  <span class="input-group-text" id="btnWrite">댓글 작성</span>
</div>

<div id="replyDiv" >
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</body>
</html>