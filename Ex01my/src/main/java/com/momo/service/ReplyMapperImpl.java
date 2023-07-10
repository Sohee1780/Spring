package com.momo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.momo.mapper.ReplyMapper;
import com.momo.vo.ReplyVO;

@Service
public class ReplyMapperImpl implements ReplyService {

	@Autowired
	ReplyMapper replyMapper;
	
	@Override
	public List<ReplyVO> getList(int bno) {
		// TODO Auto-generated method stub
		return replyMapper.getList(bno);
	}

	@Override
	public int insertReply(ReplyVO replyVO) {
		// TODO Auto-generated method stub
		return replyMapper.insertReply(replyVO);
	}

	@Override
	public int deleteReply(int rno) {
		// TODO Auto-generated method stub
		return replyMapper.deleteReply(rno);
	}

	@Override
	public int updateReply(ReplyVO replyVO) {
		// TODO Auto-generated method stub
		return replyMapper.updateReply(replyVO);
	}
	
}
