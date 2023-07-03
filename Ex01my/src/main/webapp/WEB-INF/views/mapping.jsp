<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
반갑습니다.<br><br>
name : ${name } / age : ${age } <br><br>
=================================== <br>
<h3>vo객체 출력</h3>
${member.name } <br>
${member.age } <br>
${member.dueDate } <br>
${message } <br> <br>
=================================== <br>
<h3>배열 출력</h3>
${ids[0] } ${ids[1] } ${ids[2] }<br>

<a href="/mapping/requestMapping">requestMapping GET</a><br>

<a href="/mapping/getMapping?name=모모&age=123">RequestParam getMapping 호출</a><br>

<a href="/mapping/getMappingVO?name=모모&age=123&dueDate=2023/07/03">getMappingVO 호출</a><br>

<a href="/mapping/getMappingArr?ids=id1&ids=id2&ids=id3">getMappingArr 호출</a><br>

<a href="/mapping/getMappingList?ids=id1&ids=id2&ids=id3">getMappingList 호출</a><br>

<h3>객체 리스트를 파라메터로 전달해봅시다.</h3>
	파라메터 전달 방법 : 
	list[0].name=momo&list[0].age=123&list[1].name=admin&list[1].age=120<br><br>
<script>
	// url 인코딩
	function voList() {
		let url = "/mapping/getMappingMemberList?list[0].name=momo&list[0].age=123&list[1].name=admin&list[1].age=120";
		
		url = encodeURI(url);
		alert(url);
		location.href=url;
	}
</script>

<a href="#" onclick="voList()">getMappingMemberList 객체리스트 전달</a><br>

<br>
<form action="/mapping/requestMapping" method="post">
	<input type="submit" value="requestMapping POST">
</form>

</body>
</html>