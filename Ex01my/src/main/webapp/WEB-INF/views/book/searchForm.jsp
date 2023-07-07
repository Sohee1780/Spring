<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<!-- searchForm include -->
<form name="searchForm"> 
	<input type="hidden" name="pageNo" value="1">
	<input type="hidden" name="bno" value=""> 
	
	<div class="form-inline text-center"> 
		<div class="form-group">
			<select class="form-control" name="searchField" >
				<option value="title" ${pageDto.cri.searchField eq 'title' ? 'selected':''}>도서명</option>
				<option value="author" ${pageDto.cri.searchField eq 'author' ? 'selected':''}>작가명</option>
			</select>
		</div>
		    
		<div class="form-group">
			<input class="form-control" name="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
		</div>
		     
		<button type="submit" class="btn btn-default" >검색</button>
	</div>
</form>
<!-- 검색폼  끝-->
<p></p>

</body>
</html>