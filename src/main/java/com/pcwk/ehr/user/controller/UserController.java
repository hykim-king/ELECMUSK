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
	
	@RequestMapping(value="/findIdByEmail.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String findIdByEmail(UserVO inVO) throws SQLException{
		String jsonString = "";
		
		if(null==inVO.getEmail()) {
			inVO.setEmail("");
		}
		
		LOG.debug("inVO: "+inVO);
		
		List<UserVO> list = userService.findIdByEmail(inVO);
		
		jsonString = new Gson().toJson(list);
		
		LOG.debug("jsonString: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/findIdByNameBirth.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String findIdByNameBirth(UserVO inVO) throws SQLException{
		String jsonString = "";
		
		if(null==inVO.getEmail()) {
			inVO.setEmail("");
		}
		
		LOG.debug("inVO: "+inVO);
		
		List<UserVO> list = userService.findIdByNameBirth(inVO);
		
		jsonString = new Gson().toJson(list);
		
		LOG.debug("jsonString: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/findPwByBackup.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String findPwByBackup(UserVO inVO) throws SQLException{
		String jsonString = "";
		
		LOG.debug("으아아앙inVO: "+inVO);
		
		UserVO outVO = userService.findPwByBackup(inVO);
		
		jsonString = new Gson().toJson(outVO);
		
		LOG.debug("jsonString: "+jsonString);
		
		return jsonString;
	}
}
