package com.pcwk.ehr.subsidy.controller;

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
import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;
import com.pcwk.ehr.subsidy.service.SubsidyService;

@Controller("subsidyController")
@RequestMapping("subsidy")
public class SubsidyController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	SubsidyService subsidyService;
	
	public SubsidyController() {}
	
	/**
	 * 목록조회
	 * @param inVO
	 * @return JSON(String)
	 * @throws SQLException
	 */
	@RequestMapping(value="/doRetrieve.do", method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doRetrieve(SearchVO inVO) throws SQLException{
		String jsonString = "";
		
		if (null != inVO && inVO.getPageNo() == 0) {
			inVO.setPageNo(1);
		}
		//페이지 사이즈
		if (null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(10);
		}
		//검색구분
		if (null != inVO && null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
		}
		//검색어
		if (null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchWord(StringUtil.nvl(inVO.getSearchWord()));
		}
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│inVO" + inVO);
		
		List<SubsidyVO> list = subsidyService.doRetrieve(inVO);
		
		jsonString = new Gson().toJson(list);
		LOG.debug("│jsonString:" + jsonString);
		LOG.debug("└─────────────────────────────────────┘");
		
		return jsonString;
	}
	
}
