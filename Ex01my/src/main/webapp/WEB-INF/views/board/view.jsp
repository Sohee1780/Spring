<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Fixed top navbar example · Bootstrap v5.2</title>

	<!-- 부트스트랩을 사용하기 위해서 css, js를 추가합니다. -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link href="/resources/css/style.css" rel="stylesheet">
	

</head>
<body>
<%@ include file="../common/header.jsp" %>
	
	<script type="text/javascript">	
		function request(url) {
			viewForm.action=url;
			viewForm.submit();
		}
		
		
	</script>
	
	<main class="container">
	  <div class="bg-light p-5 rounded">
	    <h1>게시판</h1>
	    <p class="lead">부트스트랩을 이용한 게시판 만들기</p>
	    <a class="btn btn-lg btn-primary" href="/board/list?pageNo=${cri.pageNo}&searchField=${cri.searchField}&searchWord=${cri.searchWord}" role="button">리스트로 이동&raquo;</a>
	  </div>
	  <p></p>
	  <!-- 상세보기 -->
	  <div class="list-group w-auto">
		<form method="get" name="viewForm">
			<input type="hidden" value="${board.bno }" name="bno">
			<div class="mb-3">
			  <label for="title" class="form-label">제목</label>
			  <input id="title" name="title" type="text" class="form-control" readonly value="${board.title }">
			</div>
			
			
			<div class="mb-3">
			  <label for="writer" class="form-label">작성자</label>
			  <input id="writer" name="writer"  type="text" class="form-control" readonly value="${board.writer }">
			</div>
			
			<div class="mb-3">
			  <label for="content" class="form-label">내용</label>
			  <textarea id="content" name="content" class="form-control" rows="6" readonly>${board.content }</textarea>
			</div>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
				<button type="submit" class="btn btn-primary btn-lg" onclick="request('/board/edit')">수정</button>
				<button type="submit" class="btn btn-secondary btn-lg" onclick="request('/board/delete')">삭제</button>
			</div>
		</form>
	  <!-- 상세보기 끝 -->
		
	  </div>
	</main>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>