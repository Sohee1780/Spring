<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 조회 -->
<!-- 
	select * from (
    		select rownum rn, t.* 
    		from (
        		select b.no, b.title, decode(b.rentyn, 'Y', '대여중', '대여가능') rentynStr, b.author, b.sfile, b.ofile, 
                d.id, to_char(d.rentday, 'yy/mm/dd') rentday, to_char(d.reternableday, 'yy/mm/dd') reternableday, d.reternday, d.rentno
        		from book b, (select * from rent where 대여여부='Y') d
        		where b.no = d.bookno(+)   
        		order by b.no desc
        	)t
    	) where rn between 1 and 10
-->
<!-- 총건수 -->
<!-- 
	select count(*) from book;
-->

</body>
</html>