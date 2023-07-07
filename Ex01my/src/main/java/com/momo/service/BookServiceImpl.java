package com.momo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.momo.mapper.BookMapper;
import com.momo.vo.BookVO;
import com.momo.vo.Criteria;
import com.momo.vo.PageDto;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BookServiceImpl implements BookService{
	
	@Autowired
	BookMapper bookMapper;

	@Override
	public void getList(Criteria cri, Model model) {
		// 리스트 조회
		List<BookVO> list = bookMapper.getList(cri);
		// 총건수 조회
		int total = bookMapper.getTotal(cri);
		// pageDto 객체 생성
		PageDto pageDto = new PageDto(cri, total);
		
		model.addAttribute("list", list);
		model.addAttribute("total", total);
		model.addAttribute("pageDto", pageDto);

		log.info("==============cri : "+cri);
		log.info("==============pageDto : "+pageDto);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return bookMapper.getTotal(cri);
	}

	@Override
	public BookVO getOne(int no) {
		// TODO Auto-generated method stub
		return bookMapper.getOne(no);
	}
	
}
