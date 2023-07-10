package com.momo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.momo.vo.ReplyVO;

@Service
public interface ReplyService {
	List<ReplyVO> getList(int bno);
	
	public int insertReply(ReplyVO replyVO);
	
	public int deleteReply(int rno);
	
	public int updateReply(ReplyVO replyVO);
}
