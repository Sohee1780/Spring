<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function go(page) {	
		searchForm.action='/board/list';
		searchForm.pageNo.value=page;
		searchForm.submit();
	}
</script>

</head>
<body>
	<!-- 페이지 블럭 생성 -->
	<nav aria-label="Page navigation example justify-content-center">
	  <ul class="pagination justify-content-center">
	    <li class="page-item ${pageDto.prev ? '': 'disabled'}">
	      <a class="page-link" href="#" onclick="go(${pageDto.startNo-1 })">Previous</a>
	    </li>
	    
	    <c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
		    <li class="page-item ${pageDto.cri.pageNo eq i ? 'active' : '' }">
		    	<a class="page-link" href="#" onclick="go(${i})">${i }</a>
		    </li>
	    </c:forEach>
	    
	    <li class="page-item ${pageDto.next ? '': 'disabled'}">
	      <a class="page-link" href="#" onclick="go(${pageDto.endNo+1 })">Next</a>
	    </li>
	  </ul>
	</nav>
</body>
</html>