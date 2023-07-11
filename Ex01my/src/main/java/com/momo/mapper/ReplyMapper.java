package com.momo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.momo.vo.Criteria;
import com.momo.vo.ReplyVO;

public interface ReplyMapper {
	
	/**
	 * 매개변수가 두개 이상 전달 되는 경우(두개이상은 인식이 안됨)
	 * -> Param 어노테이션을 사용
	 * @param bno
	 * @param cri
	 * @return
	 */
	public List<ReplyVO> getList(@Param(value="bno") int bno, @Param(value="cri") Criteria cri);
	
	public int insertReply(ReplyVO replyVO);
	
	public int deleteReply(int rno);
	
	public int updateReply(ReplyVO replyVO);
	
	public int totalCount(int bno);
	
	
}
