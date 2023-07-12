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

// callback 함수의 이름을 넘겨주면 괄호를 붙이면 함수를 실행시킴
function fetchGet(url, callback) {
	try{
		// url 요청
		fetch(url)
			// 요청결과 json문자열을 javascript 객체로 반환
			.then(response => response.json())
			// 콜백함수 실행
			.then(map => callback(map))
	}catch(e){
		console.log('fetchGet', e);
		
	}
}

// 페이지 설정
function getPage(page) {
	console.log("page호출");
	document.querySelector("#page").value = page;
	getReplyList();
}

// 댓글 조회 및 출력
function getReplyList() {
	let bno = document.querySelector("#bno").value;
	let page = document.querySelector("#page").value;
	
	// console.log(`/reply/list/${bno}/${page}`);
	
	// url : 요청경로
	// callback : 응답결과로 실행시킬 함수
	fetchGet(`/reply/list/${bno}/${page}`, replyView);
};

// 리스트 출력
function replyView(map) {
	let list = map.list;
	let pageDto = map.pageDto;
	
	console.log(list);
	console.log(pageDto);
	
	replyDiv.innerHTML = '';
	
	let replyDivStr = '';
		
	if(list.length > 0){
		replyDivStr += '<table class="table text-break text-center">'
					+'<thead>'
					+'<tr>'
					+'<th scope="col" class="col-1">작성자</th>'
					+'<th scope="col" class="col-9 ">댓글</th>'
					+'<th scope="col" class="col-1">등록날짜</th>'
					+'<th scope="col" class="col-1"></th>'
					+'</tr>'
					+'</thead>'
					+'<tbody>';
		
		list.forEach(reply => {
			replyDivStr += '<tr id="tr'+reply.rno+'">'
						+'<td>'+reply.replyer+'</td>'
						+'<td class="text-start">'+reply.reply+'</td>'
						+'<td>'+reply.replydate+'</td>'
						+'<td><i class="fa-solid fa-pen" onclick="replyEdit('+reply.rno+')"></i>&nbsp;&nbsp;'
						+'<i class="fa-solid fa-trash" onclick="replyDelete('+reply.rno+')" ></i></td>'
						+'</tr>';			
		})
		
		
		replyDivStr += '</tbody>'
					+'</table>';
		
		// 화면에 출력
		replyDiv.innerHTML += replyDivStr;
		
		// 페이지 블럭 생성
		
		let pageBlock = `<nav aria-label="Page navigation example">`
			 			+`<ul class="pagination justify-content-center">`;
		
		if(pageDto.prev) {
			pageBlock += `<li class="page-item">`
						+`<a class="page-link" href="javascript:;" aria-label="Previous" onclick="getPage(${pageDto.startNo-1})">`
						+`<span aria-hidden="true">&laquo;</span>`
						+`</a>`
						+`</li>`;
		}
			
		for(let i=pageDto.startNo; i<=pageDto.endNo; i++){
			pageBlock += `<li class="page-item"><a class="page-link ${pageDto.cri.pageNo==i?"active":""}" href="javascript:;" onclick="getPage(${i})">${i}</a></li>`			
		}
						
		if(pageDto.next) {	
			pageBlock += `<li class="page-item">`
						+`<a class="page-link" href="javascript:;" aria-label="Next" onclick="getPage(${pageDto.endNo+1})">`
						+`<span aria-hidden="true">&raquo;</span>`
						+`</a>`
						+`</li>`;
		}
			
			pageBlock += `</ul>`
					 	+ `</nav>`;
		
		replyDiv.innerHTML += pageBlock;
		
	} else {
		
	}
}    


// 댓글 등록
function replyWrite() {
	// bno, reply, replyer
	let bno = document.querySelector("#bno").value;
	let reply = document.querySelector("#reply").value;
	let replyer = document.querySelector("#replyer").value;
	
	let obj = {
		bno : bno,
		reply : reply,
		replyer : replyer
	}
	
	console.log(obj)

	// url : 요청경로(/reply/insert 호출)
	// obj : JSON 형식으로 전달할 데이터
	// callback : 콜백함수(응답결과를 받아서 처리할 함수)
	fetchPost('/reply/insert', obj, replyRes);
}

// 댓글 삭제
function replyDelete(rno) {
	fetchGet(`/reply/delete/${rno}`, replyRes);
}

// 댓글 수정 칸 출력
function replyEdit(rno) {
	let tr = document.querySelector("#tr"+rno);
	let reply = tr.children[1].innerText;
	let replyer = tr.children[0].innerText;
	
	tr.innerHTML ='<td colspan="4"><div class="input-group">'
			+'<span class="input-group-text">'+replyer.replace(/\"/gi, "&quot;")+'</span>'
			+'<input type="text" id="reply'+rno+'" aria-label="First name" class="form-control" value="'+reply.replace(/\"/gi, "&quot;")+'">'
			+'<input type="button" onclick="replyEditAction('+rno+')" aria-label="Last Name" class="input-group-text" value="수정하기">'
			+'</div></td>';
}

// 댓글 수정
function replyEditAction(rno) {
	// 파라메터 수집
	let reply = document.querySelector("#reply"+rno).value;
	
	// 전송할 데이터를 JSON객체로 생성
	let obj = {
			rno : rno,
			reply : reply
	};
	
	// console.log(obj);
	// 서버에 요청
	fetchPost('/reply/update', obj, replyRes);
}

// 결과를 받아서 처리하는 함수
function replyRes(map) {
	if(map.result == 'success'){
		// 성공 : 리스트 조회 및 출력
		getReplyList();
		document.querySelector("#reply").value = '';		
	} else {
		// 실패 : 메세지 출력
		alert(map.message);
	}
}
