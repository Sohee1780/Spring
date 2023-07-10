package com.momo.reply;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.service.ReplyService;
import com.momo.vo.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyServiceTest {
	
	@Autowired
	ReplyService replyService;
	
	@Test
	public void test() {
		assertNotNull(replyService);
		List<ReplyVO> list = replyService.getList(112);
		log.info("===========================");
		log.info("list : "+list);
	}
	
	// 등록
	@Test
	public void insertReplyTest() {
		ReplyVO reply = new ReplyVO();
		reply.setBno(111);
		reply.setReply("댓~글~~~!!!!");
		reply.setReplyer("작성자~~~");
		
		int res = replyService.insertReply(reply);
		
		log.info("===========================");
		log.info("insertReply : "+res);
		log.info("===========================");
	}
	
	// 삭제
	@Test
	public void deleteReplyTest() {
		int res = replyService.deleteReply(3);
		
		log.info("===========================");
		log.info("deleteReplyTest : "+res);
		log.info("===========================");
	}
	
	// 수정
	@Test
	public void updateReplyTest() {
		ReplyVO vo = new ReplyVO();
		vo.setRno(31);
		vo.setReply("수정수정");
		
		int res = replyService.updateReply(vo);
		
		log.info("===========================");
		log.info("updateReply : "+res);
		log.info("===========================");
	}
}
