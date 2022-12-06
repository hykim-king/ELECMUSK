package com.pcwk.ehr.login.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("LoginController")
@RequestMapping("elecmusk")
public class LoginController {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	public LoginController() {}
	
	@RequestMapping(value="/login.do")
	public String view() {
		
		return "login/login";
	}
	
	@RequestMapping(value="/register.do")
	public String login() {
		
		return "login/register";
	}
	
	@RequestMapping(value="/findIdPw.do")
	public String findIdPw() {
		
		return "login/findIdPw";
	}
}
