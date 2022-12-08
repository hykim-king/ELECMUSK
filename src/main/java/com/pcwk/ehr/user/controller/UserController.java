package com.pcwk.ehr.user.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("userContorller")
@RequestMapping("elecmusk")
public class UserController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	public UserController() {}
	
	@RequestMapping(value="/myPage.do")
	public String myPage() {
		
		return "user/myPage";
	}
	
	@RequestMapping(value="/userMng.do")
	public String userMng() {
		return "user/userMng";
	}
	
}
