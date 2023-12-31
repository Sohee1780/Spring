package com.momo.mapper;

import java.util.List;

import org.springframework.ui.Model;

import com.momo.vo.BookVO;
import com.momo.vo.Criteria;

public interface BookMapper {

	public List<BookVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public BookVO getOne(int no);
}
