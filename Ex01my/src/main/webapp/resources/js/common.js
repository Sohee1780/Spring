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