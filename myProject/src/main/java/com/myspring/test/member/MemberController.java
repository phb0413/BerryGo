package com.myspring.test.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.test.mapper.MemberMapper;

@RequestMapping("/member")
@Controller
public class MemberController {
	
	@Autowired
	private MemberMapper mapper;

	@GetMapping(value = "/loginForm.do")
	public String loginForm() {
		return "member/loginForm";
	}
	
	@ResponseBody
	@PostMapping(value = "/loginPro.do")
	public int loginPro(@RequestBody Map<String, Object> data, HttpSession session) {
	
		System.out.println("loginPro.do");
		Member member = mapper.loginMemberCheck(data);
		
		int check = -1;
		if(member != null) {
			check = 1;
			session.setAttribute("log", member.getMember_id());
			System.out.println("member = " + member.getMember_id());
		} else {
			session.setAttribute("log", null);
		}
		
		
		return check;
	}
	
	@GetMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		
		session.setAttribute("log", null);
		
		return "redirect:/shop/itemList.do";
	}
	
	@GetMapping(value = "/joinForm.do")
	public String joinForm() {
		return "member/joinForm";
	}
	
	@ResponseBody
	@PostMapping(value = "/doubleIdCheckPro.do")
	public int doubleIdCheckPro(@RequestBody Map<String, Object> data) {
	
		System.out.println("doubleIdCheckPro.do");
		
		int check = 1;
		Member member = mapper.checkDoubleId(data);
		if(member != null) {
			check = -1; 
		}
		
		return check;
	}
	
	@ResponseBody
	@PostMapping(value = "/doubleEmailCheckPro.do")
	public int doubleEmailCheckPro(@RequestBody Map<String, Object> data) {
	
		System.out.println("doubleEmailCheckPro.do");
		
		int check = 1;
		Member member = mapper.checkDoubleEmail(data);
		if(member != null) {
			check = -1; 
		}
		
		return check;
	}
	
	
	
	@ResponseBody
	@PostMapping(value = "/joinPro.do")
	public int joinPro(@RequestBody Map<String, Object> data) {
		
		System.out.println("joinPro.do");
		int check = mapper.insertMember(data);
		System.out.println("check = " + check);
		
		return check;
	}
	
	
}






