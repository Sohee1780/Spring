package com.momo.aop;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.logMapper;
import com.momo.vo.LogVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LogAdviceTest {

	@Autowired
	logMapper log;
	
	@Test
	public void insertTest() {
		LogVO vo = new LogVO();
		vo.setClassname("test");
		vo.setErrmsg("test");
		vo.setMethodname("test");
		vo.setParams("test");
		
		assertEquals(1, log.insert(vo));
	}
}
