package com.momo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.momo.service.BookService;
import com.momo.vo.BookVO;
import com.momo.vo.Criteria;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/book/*")
@Log4j
public class BookController {

	@Autowired
	BookService bookService;
	
	/**
	 * 리스트 조회
	 * @param model
	 */
	@GetMapping("list")
	public void list(Criteria cri, Model model) {
		
		bookService.getList(cri, model);

		// void일 경우 "/book/list" -> WEB-INF/views/book/list.jsp
	}
	
	@GetMapping("view")
	public String view(int no, Model model) {
		
		BookVO book = bookService.getOne(no);
		
		model.addAttribute("book",book);
		
		return "/book/view";
	}

}
