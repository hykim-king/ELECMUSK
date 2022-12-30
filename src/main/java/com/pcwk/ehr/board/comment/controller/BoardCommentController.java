package com.pcwk.ehr.board.comment.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.board.cmn.MessageVO;
import com.pcwk.ehr.board.cmn.SearchVO;
import com.pcwk.ehr.board.cmn.StringUtil;
import com.pcwk.ehr.board.comment.domain.BoardCommentSearchVO;
import com.pcwk.ehr.board.comment.domain.BoardCommentVO;
import com.pcwk.ehr.board.comment.service.BoardCommentService;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;

@Controller("boardCommentController")
@RequestMapping("boardComment")
public class BoardCommentController {

	final Logger LOG = LogManager.getLogger(getClass());

	@Autowired
	BoardCommentService boardCommentService;

	@Autowired
	CodeService codeservice;

	public BoardCommentController() {
	}

	@RequestMapping(value = "/moveToReg.do", method = RequestMethod.GET)
	public String moveToReg(Model model, SearchVO inVO) throws SQLException {
		String VIEW_NAME = "boardComment/boardComment_reg";
		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│inVO = " + inVO);
		LOG.debug("│VIEW_NAME = " + VIEW_NAME);
		LOG.debug("└──────────────────────────────┘");

		return VIEW_NAME;
	}

	/**
	 * doUpdate
	 * 
	 * @param inVO
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/doUpdate.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doUpdate(BoardCommentVO inVO) throws SQLException {
		String jsonString = "";

		if (null != inVO && inVO.getContents() == null) {
			inVO.setContents("");
		}

		LOG.debug("┌──────────────────────────────┐");

		// 내용
		if (null != inVO && inVO.getContents() == null) {
			return StringUtil.validMessageToJson("30", "내용을 입력하세요.");
		}
		LOG.debug("│inVO = " + inVO);
		LOG.debug("└──────────────────────────────┘");

		int flag = boardCommentService.doUpdate(inVO);
		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│flag = " + flag);

		String message = "";
		if (1 == flag) {
			message = inVO.getContents() + " 수정 되었습니다.";
		} else {
			message = inVO.getContents() + " 수정 실패";
		}
		jsonString = new Gson().toJson(new MessageVO(flag + "", message));
		LOG.debug("│jsonString = " + jsonString);
		LOG.debug("└──────────────────────────────┘");

		return jsonString;
	}

	/**
	 * 상세조회doSelectOne
	 * 
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(BoardCommentVO inVO, Model model) throws SQLException {
		String jsonString = "";

		if (null != inVO && inVO.getCmSeq() == 0) {
			inVO.setCmSeq(0);
		}
		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│inVO = " + inVO);
		LOG.debug("└──────────────────────────────┘");
		// key생성
		if (null != inVO && inVO.getCmSeq() == 0) {
			return StringUtil.validMessageToJson("20", "seq를 입력하세요");
		}

		BoardCommentVO outVO = boardCommentService.doSelectOne(inVO);
		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│outVO = " + outVO);
		String message = "";

		model.addAttribute("vo", outVO);

		LOG.debug("└──────────────────────────────┘");

		return "boardComment/boardComment_mod";
	}

	/**
	 * 목록조회doRetrieve
	 * 
	 * @param inVO
	 * @return JSON(String)
	 * @throws SQLException
	 */
	@RequestMapping(value = "/doRetrieve.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doRetrive(BoardCommentSearchVO inVO) throws SQLException {
		String jsonString = "";

		MessageVO outMsg = new MessageVO();

		// 페이지 번호
		if (null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageNo(1);
		}

		// 페이지사이즈
		if (null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(10);
		}

		// 검색구분
		if (null != inVO && null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
		}

		// 검색어
		if (null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchWord(StringUtil.nvl(inVO.getSearchWord()));
		}

		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│inVO = " + inVO);

		List<BoardCommentVO> list = boardCommentService.doRetrieve(inVO);

		jsonString = new Gson().toJson(list);
		LOG.debug("│jsonString = " + jsonString);
		LOG.debug("└──────────────────────────────┘");

		return jsonString;
	}

	/**
	 * boardView
	 * 
	 * @param model
	 * @param inVO
	 * @return 화면, 목록 , code목록
	 * @throws SQLException
	 */
	@RequestMapping(value = "/boardView.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String boardView(Model model, SearchVO inVO) throws SQLException {
		String viewPage = "board/board_list";

		// 페이지 번호
		if (null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageNo(1);
		}

		// 페이지사이즈
		if (null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(10);
		}

		// 검색구분
		if (null != inVO && null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
		}

		// 검색어
		if (null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchWord(StringUtil.nvl(inVO.getSearchWord()));
		}

		// 1번 공지, 2번 자유게시판
		if (null != inVO && null == inVO.getCategory()) {
			inVO.setCategory(StringUtil.nvl(inVO.getCategory(), "1"));
		}

		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│inVO = " + inVO);

		List<BoardCommentVO> list = boardCommentService.doRetrieve(inVO);

		// code목록조회
		List<String> codeList = new ArrayList<String>();
		codeList.add("PAGE_SIZE");
		codeList.add("BOARD_SEARCH");

		List<CodeVO> outCodeList = codeservice.doRetrive(codeList);

		// 검색조건
		List<CodeVO> searchList = new ArrayList<CodeVO>();

		// 페이지 사이즈
		List<CodeVO> pageSizeList = new ArrayList<CodeVO>();
		for (CodeVO vo : outCodeList) {
			if (vo.getMstCode().equals("PAGE_SIZE") == true) {
				pageSizeList.add(vo);
			}
			if (vo.getMstCode().equals("BOARD_SEARCH") == true) {
				searchList.add(vo);
			}
		}
//		1. 람다 함수(Lambda Function)란?
//		람다 함수는 함수형 프로그래밍 언어에서 사용되는 개념으로 익명 함수라고도 한다.
//		Java 8 부터 지원되며, 불필요한 코드를 줄이고 가독성을 향상시키는 것을 목적으로 두고있다.
//
//2. 람다 함수의 특징
//메소드의 매개변수로 전달될 수 있고, 변수에 저장될 수 있다.
//즉, 어떤 전달되는 매개변수에 따라서 행위가 결정될 수 있음을 의미한다.
//컴파일러 추론에 의지하고 추론이 가능한 코드는 모두 제거해 코드를 간결하게 한다.	
//		pageSizeList = outCodeList.stream()
//				.filter(vo -> vo.getMstCode().equals("PAGE_SIZE"))
//				.collect(Collectors.toList());

		LOG.debug("│outCodeList = " + outCodeList);

		model.addAttribute("list", list);
		model.addAttribute("PAGE_SIZE", pageSizeList);
		model.addAttribute("BOARD_SEARCH", searchList);
		return viewPage;

	}

	/**
	 * 추가 doSave
	 * 
	 * @param inVO
	 * @return jsonString(JSON(MessageVO))
	 * @throws SQLException
	 */
	@RequestMapping(value = "/doSave.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // 비동기 처리를 하는 경우, HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doSave(BoardCommentVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌──────────────────────────────┐");

		MessageVO outMsg = new MessageVO();
		if (null != inVO && inVO.getCmSeq() == 0) {
			inVO.setCmSeq(0);
		}
		if (null != inVO && inVO.getBdSeq() == 0) {
			inVO.setBdSeq(0);
		}
		if (null != inVO && inVO.getMemberSeq() == 0) { 
			inVO.setMemberSeq(0);
		}
		if (null != inVO && inVO.getContents() == null) {
			inVO.setContents("");
		}
		if (null != inVO && inVO.getRegDt() == null) {
			inVO.setRegDt("");
		}

		// 내용
		if (null != inVO && inVO.getContents() == null) {
			return StringUtil.validMessageToJson("20", "내용을 입력하세요.");
		}
		LOG.debug("│inVO = " + inVO);
		LOG.debug("└──────────────────────────────┘");

		int flag = this.boardCommentService.doSave(inVO);

		String message = "";

		if (1 == flag) {
			message = "등록 되었습니다.";
		} else {
			message = " 등록 실패";
		}
		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│flag = " + flag);

		jsonString = new Gson().toJson(new MessageVO(flag + "", message));
		LOG.debug("│jsonString = " + jsonString);
		LOG.debug("└──────────────────────────────┘");
		return jsonString;

	}

	/**
	 * 삭제
	 * 
	 * @param inVO
	 * @return jsonString(JSON(MessageVO)
	 * @throws SQLException
	 */
	@RequestMapping(value = "/doDelete.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doDelete(BoardCommentVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌──────────────────────────────┐");
		LOG.debug("│inVO = " + inVO);
		int flag = boardCommentService.doDelete(inVO);

		LOG.debug("│flag = " + flag);

		String message = "";
		if (flag == 1) {
			message = "삭제 되었습니다.";
		} else {
			message = "삭제 실패";
		}

		jsonString = new Gson().toJson(new MessageVO(String.valueOf(flag), message));

		LOG.debug("│jsonString = " + jsonString);
		LOG.debug("└──────────────────────────────┘");

		return jsonString;
	}
}
