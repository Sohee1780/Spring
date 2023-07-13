package com.momo.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.momo.service.MemberServiceImpl;
import com.momo.vo.Member;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController extends CommonRestController{
	
	@Autowired
	MemberServiceImpl mService;

	/**
	 * 로그인 페이지로 이동
	 * @return
	 */
	@GetMapping("/login")
	public String login() {
		return "login";
	}

	/**
	 * 
	 * @RequestBody 를 붙이면 json형식을 내가 원하는 형식으로 받아옴
	 * -> json 형식의 데이터를 주고받고 싶을때 페이지를 갱신하지 않고 원하는 데이터만 요청함
	 */
	@PostMapping("/loginAction")
	public @ResponseBody Map<String,Object> loginAction(@RequestBody Member member, Model model, HttpSession session) {
		
		member = mService.login(member); 
		//log.info("m*********"+member);
		
		if(member != null) {
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getId());
		}

		return responseLoginMap(member);
	}
}