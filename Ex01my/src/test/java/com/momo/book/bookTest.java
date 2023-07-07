package com.momo.book;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.BookMapper;
import com.momo.vo.BookVO;
import com.momo.vo.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class bookTest {
	
	@Autowired
	BookMapper bookMapper;
	
	@Test
	public void getList() {
		Criteria cri = new Criteria();
		cri.setSearchField("title");
		cri.setSearchWord("시노다");
		
		List<BookVO> list = bookMapper.getList(cri);
		
		log.info(list);
		
		assertNotNull(bookMapper);
	}
	
	@Test
	public void getOne() {
		
		BookVO book = bookMapper.getOne(187);
		
		log.info("book : "+book);
	}

}
