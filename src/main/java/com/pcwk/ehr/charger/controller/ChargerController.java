package com.pcwk.ehr.charger.controller;

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
import com.pcwk.ehr.charger.domain.ChargerVO;
import com.pcwk.ehr.charger.service.ChargerService;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.evcar.cmn.evMessageVO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.evcar.cmn.evStringUtil;

@Controller("chargerController")
@RequestMapping("charger")
public class ChargerController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ChargerService chargerService;
	
	@Autowired
	CodeService   codeService;
	
	public ChargerController() {}
	
	@RequestMapping(value="/view.do" , method = RequestMethod.GET)
	public String View() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 View()                    │");
		LOG.debug("└───────────────────────────────────────────┘");	
		return "charger/charger";
	}
	
	@RequestMapping(value="/moveToView.do", method = RequestMethod.GET)
	public String moveToView(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "charger/charger";
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value="/moveToReg.do", method = RequestMethod.GET)
	public String moveToReg(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "charger/charger_reg";
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value="/moveToManagerPage.do", method = RequestMethod.GET)
	public String moveToManagerPage(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "charger/charger_list";
		
		return VIEW_NAME;
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
		
		List<ChargerVO> list = chargerService.doRetrieve(inVO);
		
		jsonString = new Gson().toJson(list);
		LOG.debug("│jsonString:" + jsonString);
		LOG.debug("└─────────────────────────────────────┘");
		
		return jsonString;
	}
	
	@RequestMapping(value="/chargerView.do",method = RequestMethod.GET)
	public String subsidyView(Model model, evSearchVO inVO) throws SQLException{
		String viewPage = "charger/charger";
		//검색 Default값 설정
		
		//페이지 번호
		if(null !=inVO && inVO.getPageNo()==0) {
			inVO.setPageNo(1);
		}
		
		//페이지사이즈
		if(null !=inVO && inVO.getPageSize()==0) {
		    inVO.setPageSize(10);
		}
		   
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		
		List<ChargerVO> list = chargerService.doRetrieve(inVO);
		
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
		
		//Java 8 lambda
//		1. 람다 함수(Lambda Function)란?
//				람다 함수는 함수형 프로그래밍 언어에서 사용되는 개념으로 익명 함수라고도 한다.
//				Java 8 부터 지원되며, 불필요한 코드를 줄이고 가독성을 향상시키는 것을 목적으로 두고있다.
//
//		2. 람다 함수의 특징
//		메소드의 매개변수로 전달될 수 있고, 변수에 저장될 수 있다.
//		즉, 어떤 전달되는 매개변수에 따라서 행위가 결정될 수 있음을 의미한다.
//		컴파일러 추론에 의지하고 추론이 가능한 코드는 모두 제거해 코드를 간결하게 한다.		
//		pageSizeList = outCodeList.stream()
//				       .filter(vo -> vo.getMstCode().equals("PAGE_SIZE") )
//				       .collect(Collectors.toList());
//		
		
		LOG.debug("|outCodeList="+outCodeList);
		model.addAttribute("list", list);
		model.addAttribute("PAGE_SIZE",pageSizeList);
		return viewPage;
	}
	
	@RequestMapping(value="/doSelectOne.do",method = RequestMethod.GET)
	public String doSelectOne(ChargerVO inVO, Model model)throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);		
		
		ChargerVO outVO = chargerService.doSelectOne(inVO);
		
		model.addAttribute("vo", outVO);
		
		jsonString = new Gson().toJson(outVO);
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");		
		return "charger/charger_mod";
	}
	
	@RequestMapping(value="/doUpdate.do",method = RequestMethod.POST
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String doUpdate(ChargerVO inVO) throws SQLException{
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = chargerService.doUpdate(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getConnector()+"수정 되었습니다.";
		}else {
			message = inVO.getConnector()+"수정 실패";
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
	public String doSave(ChargerVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = chargerService.doSave(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getConnector()+"등록 되었습니다.";
		}else {
			message = inVO.getConnector()+"등록 실패";
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
	public String doDelete(ChargerVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("┌=============================┐");
		LOG.debug("|inVO:"+inVO);
		
		int flag = chargerService.doDelete(inVO);
			
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
