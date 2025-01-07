package com.myspring.test.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/")
@Controller
public class MainController {
	@GetMapping("/")
	public String home() {
		return "redirect:/index.do";
	}
	
	@GetMapping(value="/index.do")
	public String index() {
		return "index";
	}
}
