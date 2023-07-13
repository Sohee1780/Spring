<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Fixed top navbar example · Bootstrap v5.2</title>

	<!-- 부트스트랩을 사용하기 위해서 css, js를 추가합니다. -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link href="/resources/css/style.css" rel="stylesheet">

<script type="text/javascript">
	//history.replaceState({}, null, location.pathname);

	function request(url) {
		// 폼 이름을 확인
		viewForm.action=url;
		viewForm.submit();
	}
	
	window.addEventListener('load', function() {
		btnList.addEventListener('click', function() {
			viewForm.action='/board/list';
			viewForm.method='get';
			viewForm.submit();
		});
	});
</script>

</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
	<main class="container">
	  <div class="bg-light p-5 rounded">
	    <h1>게시판</h1>
	    <p class="lead">부트스트랩을 이용한 게시판 만들기</p>
	    <a class="btn btn-lg btn-primary" href="#" id="btnList" role="button">리스트로 이동&raquo;</a>
	  </div>
	  <p></p>
	  
	  <!-- 글쓰기 -->
	  <div class="list-group w-auto">
		<form name="viewForm" method="post">
		
			<!-- 페이지, 검색유지 -->
			<input type="text" value="${param.pageNo }" name="pageNo">
			<input type="text" value="${param.searchField}" name="searchField">
			<input type="text" value="${param.searchWord}" name="searchWord">
		
			<div class="mb-3">
			  <label for="title" class="form-label">제목</label>
			  <input id="title" name="title" type="text" class="form-control" value="${board.title }">
			</div>
			
			<div class="mb-3">
			   <label for="writer" class="form-label">작성자</label>
			  <input id="writer" name="writer" type="text" class="form-control" ${empty board.bno ? "" : "readonly" } value="${board.writer }">
			</div>
			
			<div class="mb-3">
			  <label for="content" class="form-label">내용</label>
			  <textarea id="content" name="content" class="form-control" rows="6">${board.content }</textarea>
			</div>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
				
				<input type="hidden" name="bno" value="${empty board.bno ? 0 : board.bno}">

				<c:if test="${empty board.bno }" var="result">
					<button type="submit" class="btn btn-primary btn-lg" onclick="request('/board/write')" >글쓰기</button>
				</c:if>
				<c:if test="${not result }">
					<button type="submit" class="btn btn-primary btn-lg" onclick="request('/board/edit')">수정</button>
				</c:if>
				<button type="reset" class="btn btn-secondary btn-lg">초기화</button>
			</div>
		</form>
	  <!-- 글쓰기 끝 -->
	  </div>
	</main>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>