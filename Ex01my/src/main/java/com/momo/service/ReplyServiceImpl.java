package com.momo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.momo.mapper.BoardMapper;
import com.momo.mapper.ReplyMapper;
import com.momo.vo.Criteria;
import com.momo.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyMapper replyMapper;
	
	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<ReplyVO> getList(int bno, Criteria cri) {
		// TODO Auto-generated method stub
		return replyMapper.getList(bno, cri);
	}

	/**
	 * Transactional
	 * 	서비스 로직에 대한 트랜젝션 처리를 지원
	 *  오류 발생시 롤백
	 */
	@Transactional
	@Override
	public int insertReply(ReplyVO replyVO) {
		// 댓글 입력시 게시물 테이블의 댓글수를 1 증가 시킵니다.
		// 업데이트와 인서트를 묶어서 처리 해주기위해 트랜젝션 처리
		boardMapper.updateReplyCnt(replyVO.getBno(), 1);
		return replyMapper.insertReply(replyVO);
	}
	
	@Transactional
	@Override
	public int deleteReply(int rno) {
		// 댓글 삭제시 게시물 테이블의 댓글수를 1 감소 시킵니다.
		// 댓글 조회, 업데이트, 딜리트 총 세개를 묶어서 처리 해주기위해 트랜젝션 처리
		ReplyVO replyVO = replyMapper.getOne(rno);
		boardMapper.updateReplyCnt(replyVO.getBno(), -1);
		return replyMapper.deleteReply(rno);
	}

	@Override
	public int updateReply(ReplyVO replyVO) {
		// TODO Auto-generated method stub
		return replyMapper.updateReply(replyVO);
	}

	@Override
	public int totalCount(int bno) {
		// TODO Auto-generated method stub
		return replyMapper.totalCount(bno);
	}
	
}
