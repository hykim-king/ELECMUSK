package com.pcwk.ehr.user.controller;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller("userContorller")
@RequestMapping("elecmusk")
public class UserController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	UserService userService;
	
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
