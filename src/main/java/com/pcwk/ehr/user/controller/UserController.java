package com.pcwk.ehr.user.controller;

import java.sql.SQLException;

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
	
	@RequestMapping(value="/idCheck.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idCheck(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("inVO: "+inVO);
		int cnt = userService.idCheck(inVO);
		
		LOG.debug("cnt: "+cnt);
		
		String message = "";
		
		if(1 <= cnt) {
			message = "아이디 "+inVO.getUserId()+"은(는) 중복되었습니다.";
		}else {
			message = "아이디 "+inVO.getUserId()+"은(는) 사용가능합니다.";
		}
		
		jsonString = new Gson().toJson(new MessageVO(String.valueOf(cnt),message));
		
		LOG.debug("idCheck의 jsonString: "+jsonString);
		
		return jsonString;
	}
	
}
