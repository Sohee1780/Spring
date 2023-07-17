<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>게시판</title>
    
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sign-in/">
    
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
      
      html,
      body {
	  height: 100%;
      }
	
      body {
	  display: flex;
	  align-items: center;
	  padding-top: 40px;
	  padding-bottom: 40px;
	  background-color: #f5f5f5;
      }
	
      .form-signin {
	  max-width: 330px;
	  padding: 15px;
      }
	
      .form-signin .form-floating:focus-within {
	  z-index: 2;
      }
	
      .middle{
	    border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        margin-bottom: -1px;
        
	  }
      .start  {
        margin-bottom: -1px;
        border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
      }
	  
      .end  {
        margin-bottom: 10px;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
      }
    </style>
    
	<script type="text/javascript" src="/resources/js/common.js"></script>
	<script type="text/javascript">
		window.addEventListener('load', function() {
	
			// 로그인
			btnLogin.addEventListener('click', function (e) {
				// 이벤트 객체 받아서 기본이벤트 제거
				e.preventDefault();
				
				
				
				// 1. 파라메터 수집해서 javascript객체로 생성
				let obj = {
					id : document.querySelector("#idLogin").value,
					pw : document.querySelector("#pwLogin").value
				}
				
				console.log(obj);
				
				// 2. 요청
				fetchPost('/loginAction', obj, loginCheckCallback);
			});
			
			// 회원가입
			btnSignup.addEventListener('click', function (e) {
				e.preventDefault();
				
				if(!idSignup.value){
					pwMsg.innerHTML = '아이디를 입력해주세요';
					return;
				}
				
				if(!pwSignup.value){
					pwMsg.innerHTML = '비밀번호를 입력해주세요';
					return;
				}
				
				if(!nameSignup.value){
					pwMsg.innerHTML = '이름을 입력해주세요';
					return;
				}
				
				if(idCheckRes.value != '1'){
					pwMsg.innerHTML = '아이디 중복체크를 해주세요';
					idSignup.focus();
					return;
				}
				
				if(pwCheckRes.value != '1'){
					pwMsg.innerHTML = '비밀번호가 일치하는지 확인해주세요';
					pwCheck.focus();
					return;
				}
				
				pwMsg.innerHTML = '';
				
				let id = document.querySelector("#idSignup").value;
				let name = document.querySelector("#nameSignup").value;
				let pw = document.querySelector("#pwSignup").value;
				
				let obj = {
						id : id,
						name : name,
						pw : pw
				}
				
				console.log(obj);
				
				fetchPost('/register',obj, (map) => {
					console.log(map);
					
					if(map.result=='success'){	
						location.href='/login';
					} else{
						pwMsg.value=map.message;
					}
				});
			});
			
			// 로그인 폼
			btnSigninView.addEventListener('click', function() {
				
				idSignup.value = '';
				pwSignup.value = '';
				nameSignup.value = '';
				pwCheck.value = '';
				signupForm.style.display='none';
				signinForm.style.display='';
			});
			
			// 회원가입 폼
			btnSignupView.addEventListener('click', function() {
				idLogin.value = '';
				pwLogin.value = '';
				loginMsg.value= '';
				signupForm.style.display='';
				signinForm.style.display='none';
			});
			
			// 아이디 입력 칸의 포커스가 빠졋을때 아이디 중복 체크 -> 서버에 다녀와야 함
			idSignup.addEventListener('blur', function() {
				
				if(!idSignup.value){
					pwMsg.innerHTML = '아이디를 입력해주세요';
					return;
				}
				
				let obj={
						id:document.querySelector("#idSignup").value
				};
				
				console.log("아이디 체크", obj);
				
				fetchPost('/idCheck',obj, (map) => {
					if(map.result == 'success'){
						// 아이디 사용가능
						idCheckRes.value='1';
						nameSignup.focus();
					} else {
						// 아이디 사용불가
						idCheckRes.value='0';
						idSignup.value='';
						idSignup.focus();
					}
					pwMsg.innerHTML = map.message;
				});
			});
			
			// 비밀번호 체크 -> 서버 필요X
			pwCheck.addEventListener('blur', function() {
				
				if(!pwSignup.value) {
					pwMsg.innerHTML = '비밀번호를 입력해주세요.';
					return;
				}
				
				if(!pwCheck.value) {
					pwMsg.innerHTML = '비밀번호 확인을 입력해주세요.';
					return;
				}
				
				if(pwSignup.value == pwCheck.value){
					pwCheckRes.value='1';
					pwMsg.innerHTML = '';
				} else {
					pwMsg.innerHTML = '비밀번호가 일치하지 않습니다.';
					pwSignup.value='';
					pwCheck.value='';
					pwCheckRes.value='0';
				}
			});
			
		});
		
		// 로그인 체크
		function loginCheckCallback(map) {
			console.log(map);
			
			if(map.result == 'success') {
				// 로그인 성공 -> list로 이동
				location.href=map.url;
			} else {
				// 실패 -> 메세지 처리
				msg.innerHTML = map.message;
			}
		}
		
		// 아이디 체크 콜백함수
		/*function idCheckCallback(map) {
			if(map.result == 'success'){
				// 아이디 사용가능
				idCheckRes.value='1';
			} else {
				// 아이디 사용불가
				idCheckRes.value='0';
			}
			signupMsg.innerHTML = map.message;
		}*/
		
	</script>
</head>

<body class="text-center">
    
	<main class="form-signin w-100 m-auto">
	
	  <!-- 로그인 폼 -->
	  <form name="signinForm">
	  <!-- <img class="mb-4" src="/resources/css/bootstrap-logo.svg" alt="" width="72" height="57"> -->
	  
	    <img class="mb-4" src="/resources/css/loginimg.png" alt="" >
	    <h1 class="h3 mb-3 fw-normal">게시판 로그인</h1>
	
		<div id="loginMsg">${param.message }</div>
	
	    <div class="form-floating">
	      <input type="text" class="form-control start" id="idLogin" required="required">
	      <label for="id">id</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control end" id="pwLogin" required="required">
	      <label for="pw">Password</label>
	    </div>
			
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="remember-me"> Remember me
	      </label>
	    </div>
	    <div id="msg">${param.msg}</div>
	    <button class="w-100 btn btn-lg btn-primary" type="submit" id="btnLogin">로그인</button>
		<p></p>
	  </form>
	  
	   <!-- 회원가입 폼 -->
	  <form name='signupForm' style='display:none'>
	  	<input type="text" value="0" id="idCheckRes">
	  	<input type="text" value="0" id="pwCheckRes">	  	
	  
	    <img class="mb-4" src="/resources/css/loginimg.png" alt="" >
	    <h1 class="h3 mb-3 fw-normal">게시판 회원가입</h1>
	
	    <div class="form-floating">
	      <input type="text" class="form-control start" id="idSignup" required="required">
	      <label for="id">id</label>
	    </div>
	    
	    <div class="form-floating">
	      <input type="text" class="form-control middle" id="nameSignup" required="required">
	      <label for="nameSignup">name</label>
	    </div>
	    
	    <div class="form-floating">
	      <input type="password" class="form-control middle" id="pwSignup" required="required">
	      <label for="pw">Password</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control end" id="pwCheck" required="required">
	      <label for="pwCheck">PasswordCheck</label>
	    </div>
	    <div id="pwMsg"></div>
	    
	    <button class="w-100 btn btn-lg btn-primary" id='btnSignup' type="submit">회원가입</button>
	    <p></p>
	  </form>
	  
	  <button class="btn btn-primary" id="btnSigninView" >로그인</button>
	  <button class="btn btn-primary" id="btnSignupView" >회원가입</button>
	  
	</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
