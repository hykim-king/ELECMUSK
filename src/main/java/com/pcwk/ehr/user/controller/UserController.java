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
import com.pcwk.ehr.chart.domain.evChartVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
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
	
	@RequestMapping(value="/updateNickname.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String updateNickname(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		//null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: "+inVO);
		
		int flag = userService.updateNickname(inVO);
		
		String message = "";
		if (1 == flag) {
			message = inVO.getNickname() + "으로 닉네임이 변경되었습니다.";
		} else {
			message = "닉네임 변경에 실패했습니다.";
		}
		
		MessageVO messageVO = new MessageVO(String.valueOf(flag),message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("닉네임 변경으로 생성된 jsonstring: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/updatePassword.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String updatePassword(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		//null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: "+inVO);
		
		int flag = userService.updatePassword(inVO);
		
		String message = "";
		if (1 == flag) {
			message = "비밀번호가 변경되었습니다.";
		} else {
			message = "비밀번호 변경에 실패했습니다.";
		}
		
		MessageVO messageVO = new MessageVO(String.valueOf(flag),message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("비밀번호 변경으로 생성된 jsonstring: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/updateEmail.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String updateEmail(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		//null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: "+inVO);
		
		int flag = userService.updateEmail(inVO);
		
		String message = "";
		if (1 == flag) {
			message = inVO.getEmail()+"로 이메일이 변경되었습니다.";
		} else {
			message = "이메일 변경에 실패했습니다.";
		}
		
		MessageVO messageVO = new MessageVO(String.valueOf(flag),message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("이메일 변경으로 생성된 jsonstring: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value="/deleteUser.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String deleteUser(UserVO inVO) throws SQLException {
		String jsonString = "";
		
		//null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: "+inVO);
		
		int flag = userService.withdraw(inVO);
		
		String message = "";
		if (1 == flag) {
			message = "정상적으로 회원탈퇴 되었습니다.";
		} else {
			message = "회원탈퇴에 실패했습니다.";
		}
		
		MessageVO messageVO = new MessageVO(String.valueOf(flag),message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("회원탈퇴로 생성된 jsonstring: "+jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value = "/pointRank.do",method=RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody //비동기 처리를 하는 경우, HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.	
	public String pointRank(UserVO inVO) throws SQLException  {
		String jsonString = "";
		
		List<UserVO> list = userService.pointRank(inVO);
		
		jsonString=new Gson().toJson(list);
		
		return jsonString;
	}

}
