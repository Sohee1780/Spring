package com.momo.member;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.service.MemberService;
import com.momo.vo.Member;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberTest {
	
	@Autowired
	MemberService memberService;
	

	
	@Test
	public void loginTest() {
		
		assertNotNull(memberService);
		Member member = new Member();
		member.setId("RURU");
		member.setPw("1234");
		
		Member m = memberService.login(member);
		
		assertEquals(member.getId(), m.getId());
		log.info("로그인 : "+memberService.login(member));
	}
	
	@Test
	public void singupTest() {
		
		Member member = new Member();
		member.setId("SS");
				
		assertEquals(1, memberService.idCheck(member));
			
	}
}
