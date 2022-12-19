package com.pcwk.ehr.login.controller;

import java.sql.SQLException;
import java.util.List;

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
		if(null != inVO && inVO.getBackupQuestion() == null) {
			inVO.setBackupQuestion("");;
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
	
	@RequestMapping(value="/doUpdate.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String doUpdate(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		//null처리가 필요없도록 꽉꽉 받으세여
		LOG.debug("inVO: "+inVO);
		
		int flag = userService.doUpdate(inVO);
		
		String message = "";
		if (1 == flag) {
			message = "무언가 바꾸기 성공!!";
		} else {
			message = "무언가 바꾸기 실패!!";
		}
		
		MessageVO messageVO = new MessageVO(String.valueOf(flag),message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("doUpdate의 결과로 생성된 jsonstring: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/renewSession.do",produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String renewSession(HttpSession session) throws SQLException{
		String jsonString = "";
		UserVO inVO = (UserVO)session.getAttribute("userInfo");
		
		LOG.debug("inVO: "+inVO);
		
		UserVO outVO = null;
		
		if(null !=session.getAttribute("userInfo")) {
			session.removeAttribute("userInfo");//이건 실제 삭제하는 건 아님. 옵션
			outVO = userService.doSelectOne(inVO);
			session.setAttribute("userInfo", outVO);
		}
		
		jsonString = new Gson().toJson(outVO);
		
		return jsonString;
	}
	
	@RequestMapping(value="/doLogin.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doLogin(UserVO inVO,HttpSession session) throws SQLException{
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
			
			UserVO loginSuccessVO = userService.doSelectOne(userService.passwordCheck(inVO));
			
			LOG.debug("loginSuccessVO: "+loginSuccessVO);
			
			//세션 던진 부분. 이름 userInfo로 수업과 똑같이 던졌음
			session.setAttribute("userInfo", loginSuccessVO);
			
		}else if(20==loginStatus) {
			message= "id "+inVO.getUserId() + "은(는) 존재하지 않습니다.";
		}else if(40 == loginStatus) {
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
	
	@RequestMapping(value="/doLogout.do")
	public String doLogout(HttpSession session) {
		LOG.debug("doLougout");
		if(null != session.getAttribute("userInfo")) {
			session.removeAttribute("userInfo");
			session.invalidate();
			LOG.debug("세션 invalidate성공");
		}
			
		return "elecmusk/main_home";
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
	
	@RequestMapping(value="/nicknameCheck.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String nicknameCheck(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("inVO: "+inVO);
		int cnt = userService.nicknameCheck(inVO);
		
		LOG.debug("cnt: "+cnt);
		
		String message = "";
		
		if(1 <= cnt) {
			message = "닉네임 "+inVO.getNickname()+"은(는) 중복되었습니다.";
		}else {
			message = "닉네임 "+inVO.getNickname()+"은(는) 사용가능합니다.";
		}
		
		jsonString = new Gson().toJson(new MessageVO(String.valueOf(cnt),message));
		
		LOG.debug("nicknameCheck의 jsonString: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/passwordCheck.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String passwordCheck(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("inVO: "+inVO);
		UserVO resultVO = userService.passwordCheck(inVO);
		
		LOG.debug("resultVO: "+resultVO);
		
		String message = "";
		
		MessageVO messageVO = new MessageVO(); 
		
		if(null != resultVO) {
			messageVO.setMsgId("1");
			message = "비밀번호가 일치합니다.";
		}else {
			messageVO.setMsgId("0");
			message = "비밀번호가 일치하지 않습니다.";
		}
		
		messageVO.setMsgContents(message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("passwordCheck의 jsonString: "+jsonString);
		
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
