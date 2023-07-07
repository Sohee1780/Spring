<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<%@include file="./haeder.jsp" %>

<!-- 게시판 시작-->
<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">도서 조회/대여</h1>
		</div>
	</div>
<div class="row">
<div class="col-lg-6">
    <div class="panel panel-default">
        <div class="panel-heading">
        	도서목록
        </div>
        
        <!-- /.panel-heading -->
        <div class="panel-body">
        
        <!-- searchForm -->
        <%@include file="./searchForm.jsp" %>
        
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th></th>
                            <th>도서명</th>
                            <th>저자</th>
                            <th>대여여부</th>
                            <th>반납예정일</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="book">
                    	
	                        <tr>
	                            <td><input type="checkbox"></td>
	                            <td><a href="view?no=${book.no}">${book.title}</a></td>
	                            <td>${book.author }</td>
	                            <td>${book.rentynStr }</td>
	                            <td>${book.endDate }</td>
	                            <td></td>
	                        </tr>
                        
                 		</c:forEach>
                    </tbody>
                </table>
                
            </div>
            <!-- /.table-responsive -->
				<!-- pageNavi include -->
				<%@include file="./pageNavi.jsp" %>
            
			
        </div>
        <!-- /.panel-body -->

    </div>
    <!-- /.panel -->
    </div>
</div>
</div>
<!-- 게시판 끝-->

<%@ include file="./footer.jsp"%>