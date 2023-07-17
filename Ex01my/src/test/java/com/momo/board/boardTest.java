package com.momo.board;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.BoardMapper;
import com.momo.vo.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class boardTest {

	// BoardMapper 주입
	@Autowired
	BoardMapper boardMapper;
	
	@Test
	public void getList() {
		assertNotNull(boardMapper);
		List<BoardVO> list = boardMapper.getList();
		
		list.forEach(board -> {
			log.info("boardVO=========");
			log.info(board.getBno());
			log.info(board.getTitle());
			log.info(board.getContent());
		});
	}
	
	@Test
	public void getListXml() {
		assertNotNull(boardMapper);
		/*List<BoardVO> list = boardMapper.getListXml();
		
		list.forEach(board -> {
			log.info("boardVO=========");
			log.info(board.getBno());
			log.info(board.getTitle());
			log.info(board.getContent());
			log.info(board.getWriter());
		});*/
	}
	
	@Test
	public void insert() {
		BoardVO board = new BoardVO();
		board.setTitle("택배가");
		board.setContent("늦게오면");
		board.setWriter("좋겠다ㅠㅠ");
		
		int res = boardMapper.insert(board);
		log.info("====insert result=====");
		log.info(res);
		log.info("======================");
		
		assertEquals(res, 1);
	}
	
	@Test
	public void insertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("selectKey룰루");
		board.setContent("랄라");
		board.setWriter("점심");
		
		int res = boardMapper.insertSelectKey(board);
		log.info("====insert result=====");
		log.info("bno : "+board.getBno());
		log.info("======================");
		
		assertEquals(res, 1);
	}
	
	@Test
	public void getOne() {
		BoardVO board = boardMapper.getOne(20);

		assertEquals(board.getBno(), 20);
	}
	
	@Test
	public void delete() {
		int res = boardMapper.delete(5);
		assertEquals(res, 1);
	}
	
	@Test
	public void update() {
		int bno = 10;
		BoardVO board = new BoardVO();
		board.setBno(bno);
		board.setTitle("업데이트");
		board.setContent("테스트");
		
		int res = boardMapper.update(board);
		
		BoardVO getBoard = boardMapper.getOne(bno);
		assertEquals("업데이트", getBoard.getTitle());
		
	}
	
	@Test
	public void totlaCnt() {
		int totalCnt = boardMapper.totalCnt();
		
		assertEquals(totalCnt, 18);
	}
	
	@Test
	public void updateReplyCnt() {
		int res = boardMapper.updateReplyCnt(121, 1);
		
		assertEquals(1, res);
	}
}
