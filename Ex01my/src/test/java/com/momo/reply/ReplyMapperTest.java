package com.momo.reply;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.ReplyMapper;
import com.momo.vo.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {
	
	@Autowired
	ReplyMapper replyMapper;
	
	@Test
	public void test() {
		assertNotNull(replyMapper);
		List<ReplyVO> list = replyMapper.getList(112);
		
		log.info("list : "+list);
	}
	
	@Test
	public void inReply() {
		ReplyVO reply = new ReplyVO();
		reply.setBno(111);
		reply.setReply("댓글테스트");
		reply.setReplyer("작성자");
		
		int res = replyMapper.insertReply(reply);
		log.info("insertReply : "+res);
		
	}
}
