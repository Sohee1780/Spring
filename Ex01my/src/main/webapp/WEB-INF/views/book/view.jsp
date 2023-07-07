<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<%@include file="./haeder.jsp" %>

<!-- 상세보기 -->

<div id="page-wrapper">
<div class="row">
<p></p>
	<div class="col-lg-4">
		<div class="panel panel-default">
			<div class="panel-heading">
			    ${book.title }
			</div>
			<div class="panel-body">
				<div>
				<img src="../img/408.jpg"  width="200px" alt="히카루가 죽은 여름">
				</div>
			    <p>줄거리</p>
			</div>
			<div class="panel-footer">
			   ${book.author }
			</div>
			</div>
		</div>
	</div>
</div>
<!-- 상세보기 -->
<%@ include file="./footer.jsp"%>