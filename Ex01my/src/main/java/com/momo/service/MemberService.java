package com.momo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.momo.dao.MemberDao;
import com.momo.vo.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberDao dao;
	
	public Member login(Member paramMember, Model model) {
		Member member = dao.longin(paramMember);
		
		if(member==null) {
			model.addAttribute("message","아이디/비밀번호를 확인해주세요");
		}else {
			model.addAttribute("message", member.getId()+"님 환영합니다.");
		}
		
		return member;
	}
}
