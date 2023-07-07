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
		document.searchForm.action="/book/list"
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
</script>

</head>
<body>

<div class="text-center">
  <ul class="pagination">
  
  	<c:if test="${pageDto.prev}">
	    <li class="page-item">
	      <a class="page-link" href="/book/list?pageNo=${pageDto.startNo-1 }&searchField=${pageDto.cri.searchField}&searchWord=${pageDto.cri.searchWord}" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
    </c:if>
    
    <c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo}" var="i">
	    <li class="page-item ${pageDto.cri.pageNo eq i ? 'active' : ''}" >
	    <a class="page-link" href="#" onclick="go(${i})">${i }</a>
	    </li>
    </c:forEach>

    <c:if test="${pageDto.next}">
	    <li class="page-item">
	      <a class="page-link" href="/book/list?pageNo=${pageDto.endNo+1 }&searchField=${pageDto.cri.searchField}&searchWord=${pageDto.cri.searchWord}" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
    </c:if>
      
  </ul>
</div>

</body>
</html>