package com.pcwk.ehr.login.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

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

@Controller("LoginController")
@RequestMapping("elecmusk")
public class LoginController {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	UserService userService;
	
	public LoginController() {}
	
	//화면으로 가는  3개
	@RequestMapping(value="/login.do")
	public String loginView() {
		
		return "login/login";
	}
	
	@RequestMapping(value="/register.do")
	public String registerView() {
		
		return "login/register";
	}
	
	@RequestMapping(value="/findIdPw.do")
	public String findIdPwView() {
		
		return "login/findIdPw";
	}
	
	//화면에서 부르는 메서드들
	@RequestMapping(value="/doRegister.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String doSave(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("null 처리전 inVO: "+inVO);
		
		//null처리. 필수정보 외에는 String자리에는 null이 들어올 수 있으므로
		//null이 들어오면 ""으로 바꿔주는 과정
		if(null != inVO && inVO.getName() == null) {
			inVO.setName("");
		}
		if(null != inVO && inVO.getBirth() == null) {
			inVO.setBirth("");
		}
		if(null != inVO && inVO.getEmail() == null) {
			inVO.setEmail("");
		}
		if(null != inVO && inVO.getBackupQusetion() == null) {
			inVO.setBackupQusetion("");
		}
		if(null != inVO && inVO.getBackupAnswer() == null) {
			inVO.setBackupAnswer("");
		}
		
		LOG.debug("null 처리후 inVO: "+inVO);
		
		int flag = userService.doSave(inVO);
		
		String message = "";
		if(1== flag) {
			message = inVO.getUserId()+"님이 정상적으로 회원가입 되었습니다.";
		}else {
			message = inVO.getUserId()+"님이 회원가입 되지 않았습니다.";
		}
		
		MessageVO messageVO = new MessageVO(String.valueOf(flag),message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("doSave의 결과로 생성된 jsonstring: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/doLogin.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doLogin(UserVO inVO,HttpSession session ) throws SQLException{
		String jsonString = "";
		
		LOG.debug("inVO: "+inVO);
		
		//10 성공, 20 아이디 존재X ,30 아이디 입력X, 40 비밀번호 틀림, 50 비밀번호 입력X

		MessageVO outMessage = new MessageVO();
		
		if(null == inVO.getUserId() || "".equals(inVO.getUserId())) {
			outMessage.setMsgId("30");
			outMessage.setMsgContents("아이디를 입력하세요.");
			
			return new Gson().toJson(outMessage);
		}
		if(null == inVO.getUserPw() || "".equals(inVO.getUserPw())) {
			outMessage.setMsgId("50");
			outMessage.setMsgContents("비밀번호를 입력하세요.");
			
			return new Gson().toJson(outMessage);
		}
		
		int loginStatus = userService.idPassCheck(inVO);
		String message = "";
		
		if(10==loginStatus) {
			message = inVO.getUserId() + "로그인 되었습니다.";
			
			UserVO loginSuccessVO = userService.doSelectOne(inVO);
			
			//세션 던진 부분. 이름 userInfo로 수업과 똑같이 던졌음
			session.setAttribute("userInfo", loginSuccessVO);
			
		}else if(20==loginStatus) {
			message= inVO.getUserId() + "id가 존재하지 않습니다.";
		}else if(30 == loginStatus) {
			message = "비밀번호를 확인하세요.";
		}else {
			message = "알 수 없는 오류. 님 멀한거에여";
		}
				
		outMessage.setMsgId(String.valueOf(loginStatus));
		outMessage.setMsgContents(message);
		
		jsonString = new Gson().toJson(outMessage);
		
		LOG.debug("doLogin의 jsonString: "+jsonString);
		
		return jsonString;
	}
}
