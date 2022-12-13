package com.pcwk.ehr.subsidy.controller;

import java.sql.SQLException;
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
import com.pcwk.ehr.evcar.cmn.evMessageVO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;
import com.pcwk.ehr.subsidy.service.SubsidyService;

@Controller("subsidyController")
@RequestMapping("subsidy")
public class SubsidyController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	SubsidyService subsidyService;
	

	
	public SubsidyController() {}
	
	@RequestMapping(value="/view.do" , method = RequestMethod.GET)
	public String View() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 View()                    │");
		LOG.debug("└───────────────────────────────────────────┘");	
		return "elecmusk/subsidy";
	}
	
	/**
	 * 목록조회
	 * @param inVO
	 * @return JSON(String)
	 * @throws SQLException
	 */
	@RequestMapping(value="/doRetrieve.do", method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doRetrieve(evSearchVO inVO) throws SQLException{
		String jsonString = "";
		
		if (null != inVO && inVO.getPageNo() == 0) {
			inVO.setPageNo(1);
		}
		//페이지 사이즈
		if (null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(200);
		}

		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│inVO" + inVO);
		
		List<SubsidyVO> list = subsidyService.doRetrieve(inVO);
		
		jsonString = new Gson().toJson(list);
		LOG.debug("│jsonString:" + jsonString);
		LOG.debug("└─────────────────────────────────────┘");
		
		return jsonString;
	}
	
	@RequestMapping(value="/doSelectOne.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doSelectOne(SubsidyVO inVO, Model model)throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);		
		
		SubsidyVO outVO = subsidyService.doSelectOne(inVO);
		
		jsonString = new Gson().toJson(outVO);
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");		
		return jsonString;
	}
	
	
	@RequestMapping(value="/doUpdate.do",method = RequestMethod.POST
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String doUpdate(SubsidyVO inVO) throws SQLException{
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = subsidyService.doUpdate(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getSubsidy_no()+"수정 되었습니다.";
		}else {
			message = inVO.getSubsidy_no()+"수정 실패";
		}
		
		evMessageVO messageVO=new evMessageVO(String.valueOf(flag), message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");			
		return 	jsonString;	
	}
	
	@RequestMapping(value="/doSave.do",method = RequestMethod.POST
			,produces ="application/json;charset=UTF-8")
	@ResponseBody	
	public String doSave(SubsidyVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = subsidyService.doSave(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getSubsidy_no()+"등록 되었습니다.";
		}else {
			message = inVO.getSubsidy_no()+"등록 실패";
		}
		
		evMessageVO messageVO=new evMessageVO(String.valueOf(flag), message);
		
		jsonString = new Gson().toJson(messageVO);
		
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");			
		return 	jsonString;
	}
	
	@RequestMapping(value="/doDelete.do",method = RequestMethod.GET
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String doDelete(SubsidyVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("┌=============================┐");
		LOG.debug("|inVO:"+inVO);
		
		int flag = subsidyService.doDelete(inVO);
			
		LOG.debug("|flag:"+flag);
		
		String message = "";   	
		if(flag ==1) {
			message = "삭제 되었습니다.";
		}else {
			message = "삭제 실패";
		}
		
		jsonString = new Gson().toJson(new evMessageVO(String.valueOf(flag), message));
		LOG.debug("|jsonString:"+jsonString);
		LOG.debug("└=============================┘");
		return jsonString;
	}
	
}
