package com.pcwk.ehr.naver.controller;

import java.io.IOException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.naver.service.NaverSearchService;

@Controller("naverSearchController")
@RequestMapping("elecmusk")
public class NaverSearchController {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	NaverSearchService naverSearchService;
	
	public NaverSearchController() {}
	
	@RequestMapping(value = "/naverview.do", method = RequestMethod.GET)
	public String view() throws IOException {
		LOG.debug("┌=============================┐");
		LOG.debug("|view:");
		LOG.debug("└=============================┘");
		
		return "elecmusk/naver_news_list";
	}
	
	@RequestMapping(value = "/blogView.do", method = RequestMethod.GET)
	public String blogView() throws IOException {
		LOG.debug("┌=============================┐");
		LOG.debug("|view:");
		LOG.debug("└=============================┘");
		
		return "elecmusk/naver_blog_list";
	}
	
	@RequestMapping(value = "/doNaverSearch.do", method = RequestMethod.GET
			,produces ="application/json;charset=UTF-8")
	@ResponseBody //이것을 줘야 데이터만 송출할 수 있음
	public String doNaverSearch(SearchVO inVO) throws IOException {
		String jsonString = "";
		MessageVO message = new MessageVO();
		
		//검색 default처리
		//10 blog, 20 뉴스, 30 책, 40 카페, 50 쇼핑
		if(null != inVO && null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv(), "10"));
		}
		//페이지 사이즈
		if(null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(10);
		}
		//페이지 번호
		if(null != inVO && inVO.getPageNo() == 0) {
			inVO.setPageNo(1);
		}
		//검색어: 필수(JSON return)
		if(null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchWord(StringUtil.nvl(inVO.getSearchWord()));
			message.setMsgId("100");
			message.setMsgContents("검색어는 필수 입력 입니다.");
			return new Gson().toJson(message);
		}
		
		jsonString = this.naverSearchService.doNaverSearch(inVO);
		LOG.debug("┌=============================┐");
		LOG.debug("|jsonString:"+jsonString);
		LOG.debug("└=============================┘");
		
		
		return jsonString;
	}
	
	
}
