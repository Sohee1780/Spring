package com.momo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.momo.service.BoardService;
import com.momo.vo.BoardVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {

	@Autowired
	BoardService boardService;

	@GetMapping("list")
	public void getList(Model model) {
		List<BoardVO> list = boardService.getListXml();
		log.info(list);
		model.addAttribute("list", list);
	}
	
	@GetMapping("view")
	public void getOne(int bno, Model model) {
		BoardVO board = boardService.getOne(bno);
		log.info(board);
		model.addAttribute("board", board);
	}
	
	@GetMapping("write")
	public void write() {
		
	}
	
	@PostMapping("write")
	public String write(BoardVO board, Model model) {
		int res = boardService.insertSelectKey(board);
		log.info("===== res : "+res); 
		log.info("===== board.getBno "+board.getBno());
		model.addAttribute("bno", board.getBno());
		
		return "";
	}
}
