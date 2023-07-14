package com.momo.service;

import org.springframework.stereotype.Service;

import com.momo.vo.Member;

@Service
public interface MemberService {
	
	public Member login(Member member);
	
	public int singupMember(Member member);
	
	public int idCheck(Member member);
}