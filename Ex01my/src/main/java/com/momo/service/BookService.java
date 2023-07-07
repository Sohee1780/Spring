package com.momo.service;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.momo.vo.BookVO;
import com.momo.vo.Criteria;

@Service
public interface BookService {
	
	// 조회
	public void getList(Criteria cri, Model model);
	
	// 총건수
	public int getTotal(Criteria cri);
	
	// 한권 조회
	public BookVO getOne(int no);
}
