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
    </style>

    
    <!-- Custom styles for this template -->
    <link href="/resources/css/signin.css" rel="stylesheet">
    
	<script type="text/javascript" src="/resources/js/common.js"></script>
	<script type="text/javascript">
		window.addEventListener('load', function() {
	
			btnLogin.addEventListener('click', function (e) {
				// 이벤트 객체 받아서 기본이벤트 제거
				e.preventDefault();
				
				// 1. 파라메터 수집해서 javascript객체로 생성
				let obj = {
					id : document.querySelector("#id").value,
					pw : document.querySelector("#password").value
				}
				
				console.log(obj);
				
				// 2. 요청
				fetchPost('/loginAction', obj, loginCheck);
			});
			
			btnSigninView.addEventListener('click', function() {
				signupForm.style.display='none';
				signinForm.style.display='';
			});
			
			btnSignupView.addEventListener('click', function() {
				signupForm.style.display='';
				signinForm.style.display='none';
			});
		});
		
		// 로그인 체크
		function loginCheck(map) {
			console.log(map);
			
			if(map.result == 'success') {
				// 로그인 성공 -> list로 이동
				location.href='/board/list';
			} else {
				// 실패 -> 메세지 처리
				//msg.innerHTML = map.message;
			}
		}
	</script>
</head>

<body class="text-center">
    
	<main class="form-signin w-100 m-auto">
	
	  <form name="signinForm">
	  <!-- <img class="mb-4" src="/resources/css/bootstrap-logo.svg" alt="" width="72" height="57"> -->
	  
	    <img class="mb-4" src="/resources/css/loginimg.png" alt="" >
	    <h1 class="h3 mb-3 fw-normal">게시판 로그인</h1>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" id="id">
	      <label for="id">id</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" id="password" >
	      <label for="password">password</label>
	    </div>
	
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="remember-me"> Remember me
	      </label>
	    </div>
	    <button class="w-100 btn btn-lg btn-primary" type="submit" id="btnLogin">로그인</button>
		<p></p>
	  </form>
	  
	  <form name="signupForm" style="display:none;">
	  <!-- <img class="mb-4" src="/resources/css/bootstrap-logo.svg" alt="" width="72" height="57"> -->
	  
	    <img class="mb-4" src="/resources/css/loginimg.png" alt="" >
	    <h1 class="h3 mb-3 fw-normal">게시판 회원가입</h1>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" id="idSingup">
	      <label for="idSingup">id</label>
	    </div>
	    
	    <div class="form-floating">
	      <input type="password" class="form-control" id="passwordSingup" >
	      <label for="passwordSingup">password</label>
	    </div>
	
	    <button class="w-100 btn btn-lg btn-primary" type="submit" id="btnSingup">회원가입</button>
		<p></p>
	  </form>
	  
	  <button class="btn btn-primary" id="btnSigninView" >로그인</button>
	  <button class="btn btn-primary" id="btnSignupView" >회원가입</button>
	  
	</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
