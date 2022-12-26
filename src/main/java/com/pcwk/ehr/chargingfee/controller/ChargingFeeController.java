package com.pcwk.ehr.chargingfee.controller;

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
import com.pcwk.ehr.chargingfee.domain.ChargingFeeVO;
import com.pcwk.ehr.chargingfee.service.ChargingFeeService;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.evcar.cmn.evMessageVO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.evcar.cmn.evStringUtil;

@Controller("chargingfeeController")
@RequestMapping("chargingfee")
public class ChargingFeeController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ChargingFeeService chargingfeeService;
	
	@Autowired
	CodeService   codeService;
	
	public ChargingFeeController() {}
	
	@RequestMapping(value="/view.do" , method = RequestMethod.GET)
	public String View() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 View()                    │");
		LOG.debug("└───────────────────────────────────────────┘");	
		return "chargingfee/chargingFee";
	}
	
	@RequestMapping(value="/moveToView.do", method = RequestMethod.GET)
	public String moveToView(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "chargingfee/chargingFee";
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value="/moveToReg.do", method = RequestMethod.GET)
	public String moveToReg(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "chargingfee/chargingfee_reg";
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value="/moveToManagerPage.do", method = RequestMethod.GET)
	public String moveToManagerPage(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "chargingfee/chargingfee_list";
		
		return VIEW_NAME;
	}
	
	
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
			inVO.setPageSize(20);
		}
		//검색구분
		if (null != inVO && null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(evStringUtil.nvl(inVO.getSearchDiv()));
		}
		//검색어
		if (null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchWord(evStringUtil.nvl(inVO.getSearchWord()));
		}
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│inVO" + inVO);
		
		List<ChargingFeeVO> list = chargingfeeService.doRetrieve(inVO);
		
		jsonString = new Gson().toJson(list);
		LOG.debug("│jsonString:" + jsonString);
		LOG.debug("└─────────────────────────────────────┘");
		
		return jsonString;
	}
	
	/**
	 * 목록조회(form submit())
	 * @param model
	 * @param inVO
	 * @return 화면,목록,code목록
	 * @throws SQLException
	 */
	@RequestMapping(value="/chargingfeeView.do",method = RequestMethod.GET)
	public String chargingfeeView(Model model, evSearchVO inVO) throws SQLException{
		String viewPage = "chargingfee/chargingFee";
		//검색 Default값 설정
		
		//페이지 번호
		if(null !=inVO && inVO.getPageNo()==0) {
			inVO.setPageNo(1);
		}
		
		//페이지사이즈
		if(null !=inVO && inVO.getPageSize()==0) {
		    inVO.setPageSize(20);
		}
		   
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		
		List<ChargingFeeVO> list = chargingfeeService.doRetrieve(inVO);
		
		//code목록 조회
		List<String>  codeList=new ArrayList<String>();
		codeList.add("PAGE_SIZE");
		
		List<CodeVO> outCodeList = codeService.doRetrive(codeList);
		
		//페이지사이즈
		List<CodeVO> pageSizeList  = new ArrayList<CodeVO>();		
		for(CodeVO vo  :outCodeList) {
			if(vo.getMstCode().equals("PAGE_SIZE") ==true) {
				pageSizeList.add(vo);
			}
		}
		
		LOG.debug("|outCodeList="+outCodeList);
		model.addAttribute("list", list);
		model.addAttribute("PAGE_SIZE",pageSizeList);
		return viewPage;
	}
	
	@RequestMapping(value="/doSelectOne.do",method = RequestMethod.GET)
	public String doSelectOne(ChargingFeeVO inVO, Model model)throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);		
		
		ChargingFeeVO outVO = chargingfeeService.doSelectOne(inVO);
		
		model.addAttribute("vo", outVO);
		
		jsonString = new Gson().toJson(outVO);
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");		
		return "chargingfee/chargingfee_mod";
	}
	
	@RequestMapping(value="/doUpdate.do",method = RequestMethod.POST
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String doUpdate(ChargingFeeVO inVO) throws SQLException{
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = chargingfeeService.doUpdate(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getProvider_seq()+"수정 되었습니다.";
		}else {
			message = inVO.getProvider_seq()+"수정 실패";
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
	public String doSave(ChargingFeeVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = chargingfeeService.doSave(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getEnterprenuer()+"등록 되었습니다.";
		}else {
			message = inVO.getEnterprenuer()+"등록 실패";
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
	public String doDelete(ChargingFeeVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("┌=============================┐");
		LOG.debug("|inVO:"+inVO);
		
		int flag = chargingfeeService.doDelete(inVO);
			
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
	
	@RequestMapping(value="/showSlow.do", method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String showSlow(evSearchVO inVO) throws SQLException{
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
			inVO.setSearchDiv(evStringUtil.nvl(inVO.getSearchDiv()));
		}
		//검색어
		if (null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchWord(evStringUtil.nvl(inVO.getSearchWord()));
		}
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│inVO" + inVO);
		
		List<ChargingFeeVO> list = chargingfeeService.showSlow(inVO);
		
		jsonString = new Gson().toJson(list);
		LOG.debug("│jsonString:" + jsonString);
		LOG.debug("└─────────────────────────────────────┘");
		
		return jsonString;
	}
	


}
