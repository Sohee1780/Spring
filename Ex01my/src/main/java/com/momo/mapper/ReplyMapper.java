package com.momo.mapper;

import java.util.List;

import com.momo.vo.ReplyVO;

public interface ReplyMapper {
	public List<ReplyVO> getList(int bno);
	
	public int insertReply(ReplyVO replyVO);
	
	public int deleteReply(int rno);
	
	public int updateReply(ReplyVO replyVO);
}
