package com.pcwk.ehr.station.controller;

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
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.evcar.cmn.evMessageVO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.evcar.cmn.evStringUtil;
import com.pcwk.ehr.station.domain.StationVO;
import com.pcwk.ehr.station.service.StationService;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;

@Controller("stationController")
@RequestMapping("station")
public class StationController {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	StationService stationService;
	
	@Autowired
	CodeService codeService;
	
	public StationController() {}
	
	@RequestMapping(value="/view.do" , method = RequestMethod.GET)
	public String View() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 View()                    │");
		LOG.debug("└───────────────────────────────────────────┘");	
		return "elecmusk/GoogleMap";
	}
	
	@RequestMapping(value="/moveToMap.do", method = RequestMethod.GET)
	public String moveToMap(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "station/GoogleMap";
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value="/moveToReg.do", method = RequestMethod.GET)
	public String moveToReg(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "station/station_reg";
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value="/moveToManagerPage.do", method = RequestMethod.GET)
	public String moveToManagerPage(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "station/station_list";
		
		return VIEW_NAME;
	}

	@RequestMapping(value="/moveToRvList.do", method = RequestMethod.GET)
	public String moveToRvList(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "rvboard/rvboard_list";
		
		return VIEW_NAME;
	}

	@RequestMapping(value="/moveToRvReg.do", method = RequestMethod.GET)
	public String moveToRvReg(Model model, evSearchVO inVO) throws SQLException{
		String VIEW_NAME = "rvboard/rvboard_reg";
		
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
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│inVO" + inVO);
		
		List<StationVO> list = stationService.doRetrieve(inVO);
		
		jsonString = new Gson().toJson(list);
		LOG.debug("│jsonString:" + jsonString);
		LOG.debug("└─────────────────────────────────────┘");
		
		return jsonString;
	}
	
	@RequestMapping(value="/stationView.do",method = RequestMethod.GET)
	public String stationView(Model model, evSearchVO inVO) throws SQLException{
		String viewPage = "elecmusk/GoogleMap";
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
		
		List<StationVO> list = stationService.doRetrieve(inVO);
		
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
	public String doSelectOne(StationVO inVO, Model model)throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);		
		
		StationVO outVO = stationService.doSelectOne(inVO);
		
		model.addAttribute("vo", outVO);
		
		jsonString = new Gson().toJson(outVO);
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");		
		return "station/station_mod";
	}

	@RequestMapping(value="/stationCheck.do",method = RequestMethod.GET)
	public String stationCheck(StationVO inVO, Model model)throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);		
		
		StationVO outVO = stationService.stationCheck(inVO);
		
		model.addAttribute("vo", outVO);
		
		jsonString = new Gson().toJson(outVO);
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");		
		return "rvboard/rvboard_reg";
	}
	
	@RequestMapping(value="/doUpdate.do",method = RequestMethod.POST
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String doUpdate(StationVO inVO) throws SQLException{
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = stationService.doUpdate(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getStation_seq()+"수정 되었습니다.";
		}else {
			message = inVO.getStation_seq()+"수정 실패";
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
	public String doSave(StationVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		int flag = stationService.doSave(inVO);
		
		String message = "";//json으로 전달할 메시지
		if(1==flag) {
			message = inVO.getCsnm()+"등록 되었습니다.";
		}else {
			message = inVO.getCsnm()+"등록 실패";
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
	public String doDelete(StationVO inVO) throws SQLException {
		String jsonString = "";
		
		LOG.debug("┌=============================┐");
		LOG.debug("|inVO:"+inVO);
		
		int flag = stationService.doDelete(inVO);
			
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
