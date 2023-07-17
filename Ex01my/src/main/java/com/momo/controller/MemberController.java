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

import com.momo.service.MemberService;
import com.momo.vo.Member;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController extends CommonRestController{
	
	@Autowired
	MemberService mService;

	/**
	 * 로그인 페이지로 이동
	 * @return
	 */
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
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
			Map<String,Object> map = responseMapMessage(REST_SUCCESS, "로그인 되었습니다.");
			if(member.getRole() != null && member.getRole().contains("ADMIN_ROLE")) {
				map.put("url", "/admin");
			} else {
				map.put("url", "/board/list");
			}
			
			return map;
		} else {
			return responseMapMessage(REST_FAIL, "아이디/비밀번호를 확인해주세요.");
		}
		
	}
	
	@PostMapping("/idCheck")
	public @ResponseBody Map<String, Object> idCheck(@RequestBody Member member) {

		int res = mService.idCheck(member);
		
		if(res == 0) {
			return responseMapMessage(REST_SUCCESS, "사용가능한 아이디 입니다.");
		}else {
			return responseMapMessage(REST_FAIL, "이미 사용중인 아이디 입니다.");
		}
	}
	
	@PostMapping("/register")
	public @ResponseBody Map<String, Object> register(@RequestBody Member member) {

		try {			
			int res = mService.singupMember(member);
			return responseWriteMap(res);
		}catch (Exception e) {
			e.printStackTrace();
			return responseMapMessage(REST_FAIL, "등록 중 예외사항이 발생하였습니다.");
		}

	}
	
	
}