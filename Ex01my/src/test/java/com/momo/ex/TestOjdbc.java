package com.momo.ex;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.junit.Test;

public class TestOjdbc {
   
	@Test
	public void calcTest() {
		Calc calc = new Calc();
		int res = calc.add(1, 2);
		
		
		// 예상 결과값, 실제 결과값
		assertEquals(3, res);
	}
	
	@Test
   public void ojdbcTest() {
      
      String url = "jdbc:oracle:thin:@localhost:1521:orcl";
      String id = "library";
      String pw = "1234";
      
      String sql = "SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') || ' 입니다.' FROM DUAL";
      
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection conn = DriverManager.getConnection(url, id, pw);
         ResultSet rs = conn.createStatement().executeQuery(sql);
         
         rs.next();
         System.out.println(rs.getString(1));
         System.out.println(conn);
         
         assertNotNull(conn);
         
      } catch (ClassNotFoundException e) {
         System.err.println("라이브러리를 확인해주세요!");
         System.err.println(e.getMessage());
         e.printStackTrace();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
   }
   
}