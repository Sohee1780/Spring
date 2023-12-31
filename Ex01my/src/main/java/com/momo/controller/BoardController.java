package com.momo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StopWatch;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.momo.service.BoardService;
import com.momo.vo.BoardVO;
import com.momo.vo.Criteria;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {

	@Autowired
	BoardService boardService;
	
	// board/reply/test
	@GetMapping("/reply/test")
	public String test() {
		
		return "/reply/test";
	}
	
	
	/**
	 * /board/msg
	 * WEB-INF/views/board/msg.jsp
	 */
	@GetMapping("msg")
	public void msg() {
		
	}
	
	@GetMapping("message")
	public void message(Model model) {
		
	}
	
	/**
	 * 
	 * 파라메터의 자동수집
	 * 기본생성자를 이용해서 객체를 생성
	 * @param model
	 * @param cri
	 */
	@GetMapping("list")
	public void list(Model model, Criteria cri) {
		
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		boardService.getListXml(cri, model);
		log.info("============================list");
		log.info("cri : "+cri);
		log.info("================================");
		// List<BoardVO> list = boardService.getListXml(cri, model);
		// model.addAttribute("list", list);
		stopWatch.stop();
		log.info("수행시간 : "+stopWatch.getTotalTimeMillis()+"(ms)초");
	}
	
	@GetMapping("view")
	public void getOne(Model model, BoardVO paramVO, Criteria cri) {

		BoardVO board = boardService.getOne(paramVO.getBno());
		
		log.info(board);
		log.info("cri==================="+cri);
		model.addAttribute("cri", cri);
		model.addAttribute("board", board);
	}
	
	/**
	 * 수정하기
	 * - bno 파라메터로 받아야함
	 * - 버튼, 버튼의 액션이 달라짐
	 * @return
	 */
	@GetMapping("edit")
	public String edit(BoardVO paramVO, Model model) {
		
		BoardVO board = boardService.getOne(paramVO.getBno());
		
		
		model.addAttribute("board", board);
		
		return "/board/write";
	}
	
	@PostMapping("edit")
	public String editU(BoardVO paramVO, RedirectAttributes rttr, Model model, Criteria cri) {
		
		log.info("************************************");
		int res = boardService.update(paramVO);
		log.info("cri : "+cri);
		log.info("************************************");
		
		// ?pageNo=1 -> request.getParam("pageNo"); 파라메터로 넘어오는거 받음 ${param.pageNo}
		// request.setAttribute("pageNo") request 내장객체에 저장하면 -> request.getAttribute("pageNo")로 받음 session.setAttribute()도
		// ${pageNo}로 이름으로 불러올 수 있음
		String msg = "";
		if(res > 0) {
			// addFlashAttribute 는 세션에 저장됨 세션에 잠깐 저장됐다가 지워짐
			// redirect시 request영역이 공유되지 않으므로  RedirectAttributes 를 이용
			msg = "수정 되었습니다.";
			rttr.addFlashAttribute("msg", msg);
			
			// 파라메터로 넘겨줌
			rttr.addAttribute("pageNo", cri.getPageNo());
			rttr.addAttribute("searchField", cri.getSearchField());
			rttr.addAttribute("searchWord", cri.getSearchWord());
			return "redirect:/board/view?bno="+paramVO.getBno();
		}else {
			msg = "수정 중 오류가 발생 하였습니다.";
			model.addAttribute("msg", msg);
			return "/board/message";
		}
	}
	
	/**
	 * requestMapping에 /board/ 가 설정되어 있으므로
	 * /boadr/wirte
	 * @return
	 */
	@GetMapping("write")
	public void write() {
		
	}
	
	/**
	 * ✨ RedirectAttributes
	 * - 리다이렉트 URL의 화면화면까지 데이터를 전달
	 * 
	 * ✨ Model과 같이 매개변수로 받아서 사용
	 * addFlashAttribute : 세션에 저장후 페이지 전환
	 */
	@PostMapping("write")
	public String write(BoardVO board, RedirectAttributes rttr,
						Model model) {
		// 시퀀스 조회 후 시퀀스 번호를 bno에 저장
		int res = boardService.insertSelectKey(board);
		// log.info("===== res : "+res); 
		// log.info("===== board.getBno "+board.getBno());
		
		String msg = "";
		if(res>0) {
			msg = board.getBno()+"번 등록되었습니다.";
			// url?msg=등록되었습니다. (쿼리스트링으로 전달 -> 화면에서 param.msg로 받아야함)
			// rttr.addAttribute("msg", msg);
			// 세션영역에 저장 -> 화면에서 msg 사용 
			// 새로고침시 유지되지 않는다.
			rttr.addFlashAttribute("msg", msg);
			return "redirect:/board/list";
		} else {
			msg = "등록 중 예외사항이 발생 하였습니다.";
			model.addAttribute("msg", msg);
			return "/board/message";
		}		
	}
	
	@GetMapping("delete")
	public String delete(BoardVO paramVO, RedirectAttributes rttr,
			Model model) {
		
		// 글 삭제
		int res = boardService.delete(paramVO.getBno());
		
		log.info("delete");
		
		String msg ="";
		if(res > 0) {
			msg = paramVO.getBno() + "번 삭제되었습니다.";
			rttr.addFlashAttribute("msg", msg);
			return "redirect:/board/list";
		} else {
			msg = "삭제 중 예외사항이 발생하였습니다.";
			model.addAttribute("msg", msg);
			return "/board/message";
		}
	}
}
