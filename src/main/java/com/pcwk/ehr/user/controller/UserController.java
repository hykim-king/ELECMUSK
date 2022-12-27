package com.pcwk.ehr.user.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.chart.domain.evChartVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.user.domain.UserSearchVO;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller("userContorller")
@RequestMapping("elecmusk")
public class UserController {

	final Logger LOG = LogManager.getLogger(getClass());

	@Autowired
	UserService userService;

	@Autowired
	CodeService codeService;

	public UserController() {
	}

	@RequestMapping(value = "/myPage.do")
	public String myPage() {

		return "user/myPage";
	}
	
	@PostMapping(value="userMng.do")
	@RequestMapping(value = "/userMng.do",method = RequestMethod.POST)
	public String userMng(Model model) throws SQLException {

		// 코드 목록 조회
		List<String> codeList = new ArrayList<String>();
		codeList.add("PAGE_SIZE");
		codeList.add("USER_SEARCH");
		codeList.add("USER_BACKUPQUESTION");

		List<CodeVO> outCodeList = codeService.doRetrive(codeList);

		List<CodeVO> pageSizeList = new ArrayList<CodeVO>();
		List<CodeVO> searchList = new ArrayList<CodeVO>();
		List<CodeVO> questionList = new ArrayList<CodeVO>();

		for (CodeVO vo : outCodeList) {
			if (vo.getMstCode().equalsIgnoreCase("PAGE_SIZE")) {
				pageSizeList.add(vo);
			} else if (vo.getMstCode().equalsIgnoreCase("USER_SEARCH")) {
				searchList.add(vo);
			}else if(vo.getMstCode().equalsIgnoreCase("USER_BACKUPQUESTION")) {
				questionList.add(vo);
			}
		}

		model.addAttribute("PAGE_SIZE", pageSizeList);
		model.addAttribute("USER_SEARCH", searchList);
		model.addAttribute("USER_BACKUPQUESTION", questionList);

		return "user/userMng";
	}

	@RequestMapping(value = "/updateNickname.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String updateNickname(UserVO inVO) throws SQLException {
		String jsonString = "";

		// null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: " + inVO);

		int flag = userService.updateNickname(inVO);

		String message = "";
		if (1 == flag) {
			message = inVO.getNickname() + "으로 닉네임이 변경되었습니다.";
		} else {
			message = "닉네임 변경에 실패했습니다.";
		}

		MessageVO messageVO = new MessageVO(String.valueOf(flag), message);

		jsonString = new Gson().toJson(messageVO);

		LOG.debug("닉네임 변경으로 생성된 jsonstring: " + jsonString);

		return jsonString;
	}

	@RequestMapping(value = "/updatePassword.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String updatePassword(UserVO inVO) throws SQLException {
		String jsonString = "";

		// null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: " + inVO);

		int flag = userService.updatePassword(inVO);

		String message = "";
		if (1 == flag) {
			message = "비밀번호가 변경되었습니다.";
		} else {
			message = "비밀번호 변경에 실패했습니다.";
		}

		MessageVO messageVO = new MessageVO(String.valueOf(flag), message);

		jsonString = new Gson().toJson(messageVO);

		LOG.debug("비밀번호 변경으로 생성된 jsonstring: " + jsonString);

		return jsonString;
	}

	@RequestMapping(value = "/updateEmail.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String updateEmail(UserVO inVO) throws SQLException {
		String jsonString = "";

		// null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: " + inVO);

		int flag = userService.updateEmail(inVO);

		String message = "";
		if (1 == flag) {
			message = inVO.getEmail() + "로 이메일이 변경되었습니다.";
		} else {
			message = "이메일 변경에 실패했습니다.";
		}

		MessageVO messageVO = new MessageVO(String.valueOf(flag), message);

		jsonString = new Gson().toJson(messageVO);

		LOG.debug("이메일 변경으로 생성된 jsonstring: " + jsonString);

		return jsonString;
	}

	@RequestMapping(value = "/deleteUser.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String deleteUser(UserVO inVO) throws SQLException {
		String jsonString = "";

		// null처리가 필요없음. 닉네임이랑 mSeq만받으니
		LOG.debug("inVO: " + inVO);

		int flag = userService.withdraw(inVO);

		String message = "";
		if (1 == flag) {
			message = "정상적으로 회원탈퇴 되었습니다.";
		} else {
			message = "회원탈퇴에 실패했습니다.";
		}

		MessageVO messageVO = new MessageVO(String.valueOf(flag), message);

		jsonString = new Gson().toJson(messageVO);

		LOG.debug("회원탈퇴로 생성된 jsonstring: " + jsonString);

		return jsonString;
	}

	@RequestMapping(value = "/doUserRetrieve.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doRetrieve(UserSearchVO inVO) throws SQLException {
		String jsonString = "";

		LOG.debug("Retrieve SearchVO인 inVO: " + inVO);

		if (0 == inVO.getPageSize()) {
			inVO.setPageSize(10);
		}

		// 페이지 번호(default =1)
		if (0 == inVO.getPageNo()) {
			inVO.setPageNo(1);
		}

		// 검색구분(default ="")
		if (null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
		}

		// 검색어(default ="")
		if (null == inVO.getSearchWord()) {
			inVO.setSearchWord(StringUtil.nvl(inVO.getSearchWord()));
		}

		// userDiv(default="")
		if (null == inVO.getUserDiv()) {
			inVO.setUserDiv(StringUtil.nvl(inVO.getUserDiv()));
		}

		LOG.debug("┌=============================┐");
		LOG.debug("|inVO=" + inVO);

		List<UserVO> list = userService.doRetrieve(inVO);

		LOG.debug("list: " + list);

		jsonString = new Gson().toJson(list);

		LOG.debug("jsonString: " + jsonString);

		return jsonString;
	}

	@RequestMapping(value = "/multiBan.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String multiBan(HttpServletRequest req) throws SQLException {
		String jsonString = "";

		String mSeqString = req.getParameter("mSeqString");
		LOG.debug("mSeqString: " + mSeqString);

		String[] mSeqArray = mSeqString.split(",");

		List<UserVO> list = new ArrayList<UserVO>();

		for (String mSeq : mSeqArray) {
			UserVO tempVO = new UserVO();
			tempVO.setmSeq(Integer.parseInt(mSeq));
			list.add(tempVO);
		}

		LOG.debug("list: " + list);

		int flag = userService.multiBan(list);

		MessageVO messageVO = new MessageVO();
		messageVO.setMsgId(flag + "");
		if (flag > 0) {
			messageVO.setMsgContents(flag + "건의 유저가 정지되었습니다.");
		}else {
			messageVO.setMsgContents("유저 정지가 제대로 되지 않았습니다.");
		}
		jsonString = new Gson().toJson(messageVO);

		return jsonString;
	}

	@RequestMapping(value = "/doSelectOne.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doSelectOne(UserVO inVO) throws SQLException {
		String jsonString = "";

		UserVO outVO = userService.doSelectOne(inVO);

		LOG.debug("outVO: " + outVO);

		jsonString = new Gson().toJson(outVO);

		return jsonString;
	}

	@RequestMapping(value = "/doUserUpdate.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // 메세지만 뿌려줄건 바디 추가해야함
	public String doUpdate(UserVO inVO) throws SQLException {
		String jsonString = "";

		// null처리가 필요없도록 꽉꽉 받으세여
		LOG.debug("inVO: " + inVO);

		int flag = userService.doUpdate(inVO);

		String message = "";
		if (1 == flag) {
			message = "수정 성공!!";
		} else {
			message = "수정 실패!!";
		}

		MessageVO messageVO = new MessageVO(String.valueOf(flag), message);

		jsonString = new Gson().toJson(messageVO);

		LOG.debug("doUpdate의 결과로 생성된 jsonstring: " + jsonString);

		return jsonString;
	}

	@RequestMapping(value = "/pointRank.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody // 비동기 처리를 하는 경우, HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String pointRank(UserVO inVO) throws SQLException {
		String jsonString = "";

		List<UserVO> list = userService.pointRank(inVO);

		jsonString = new Gson().toJson(list);

		return jsonString;
	}

}
