package com.pcwk.ehr;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.board.cmn.SearchVO;
import com.pcwk.ehr.chart.dao.evChartDao;
import com.pcwk.ehr.chart.domain.evChartVO;
import com.pcwk.ehr.chart.service.evChartService;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.evcar.domain.EvCarVO;
import com.pcwk.ehr.evcar.service.evCarService;

/**
 * Handles requests for the application home page.
 */
@Controller("HomeController")
@RequestMapping("elecmusk")
public class HomeController {
	
	private static final Logger LOG = LoggerFactory.getLogger(HomeController.class);
	
	final String VIEW_NAME = "elecmusk/main_home";
	final String DOT = ".";
	
	@Autowired
	evCarService evCarService;
	
	@Autowired
	CodeService codeService;	
	
	@Autowired
	evChartService evChartService;
	
	public HomeController() {}
	
	@RequestMapping(value = "/view.do", method = RequestMethod.GET)
	public String mainHome() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 mainHome                  │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return VIEW_NAME;
	}
	
	@PostMapping(value="evcar.do")
	@RequestMapping(value = "/evcar.do",method = RequestMethod.GET)
	public String userMng(Model model) throws SQLException {

		// 코드 목록 조회
		List<String> codeList = new ArrayList<String>();
		codeList.add("MANUFACTURE_KEYWORD");
		codeList.add("APPEARANCE_KEYWORD");
		codeList.add("MODEL_KEYWORD");
		codeList.add("BATTERYTYPE_KEYWORD");

		List<CodeVO> outCodeList = codeService.doRetrive(codeList);

		List<CodeVO> manufactureKeyword = new ArrayList<CodeVO>();
		List<CodeVO> appearanceKeyword = new ArrayList<CodeVO>();
		List<CodeVO> modelKeyword = new ArrayList<CodeVO>();
		List<CodeVO> batteryTypeKeyword = new ArrayList<CodeVO>();

		for (CodeVO vo : outCodeList) {
			if (vo.getMstCode().equalsIgnoreCase("MANUFACTURE_KEYWORD")) {
				manufactureKeyword.add(vo);
			}else if(vo.getMstCode().equalsIgnoreCase("APPEARANCE_KEYWORD")) {
				appearanceKeyword.add(vo);
			}else if(vo.getMstCode().equalsIgnoreCase("MODEL_KEYWORD")) {
				modelKeyword.add(vo);
			}else if(vo.getMstCode().equalsIgnoreCase("BATTERYTYPE_KEYWORD")) {
				batteryTypeKeyword.add(vo);
			}
		}

		model.addAttribute("MANUFACTURE_KEYWORD", manufactureKeyword);
		model.addAttribute("APPEARANCE_KEYWORD", appearanceKeyword);
		model.addAttribute("MODEL_KEYWORD", modelKeyword);
		model.addAttribute("BATTERYTYPE_KEYWORD", batteryTypeKeyword);

		return "elecmusk/evCar";
	}
	
	@RequestMapping(value = "/regevcar.do", method = RequestMethod.GET)
	public String regEvCar() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                   evCar                   │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "elecmusk/reg_evcar";
	}
	
	@RequestMapping(value = "/evChart.do", method = RequestMethod.GET)
	public String evChart() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                   station                 │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "elecmusk/evChart";
	}
	
	@RequestMapping(value = "/chartRetrieve.do",method=RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody //비동기 처리를 하는 경우, HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.	
	public String chartRetrieve(evSearchVO inVO) throws SQLException  {
		String jsonString = "";
		// 페이지 사이즈(default =10)
		if( 10==inVO.getPageSize()) {
			inVO.setPageSize(10);
		}
		
		//페이지 번호(default =1)
		if( 0==inVO.getPageNo()) {
			inVO.setPageNo(1);
		}
		
		List<evChartVO> list = evChartService.doRetrieve(inVO);
		
		jsonString=new Gson().toJson(list);
		
		return jsonString;
	}
	
	//evCar부분 ------------------------------------------------------------------
	
	@RequestMapping(value = "/doRetrieve.do",method=RequestMethod.GET
			,produces = "application/json;charset=UTF-8")
	@ResponseBody //비동기 처리를 하는 경우, HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.	
	public String doRetrieve(evSearchVO inVO) throws SQLException  {
		String jsonString = "";
		// 페이지 사이즈(default =10)
		if( 0==inVO.getPageSize()) {
			inVO.setPageSize(6);
		}
		
		//페이지 번호(default =1)
		if( 0==inVO.getPageNo()) {
			inVO.setPageNo(1);
		}
		
		
		List<EvCarVO> list = evCarService.doRetrieve(inVO);
		
		jsonString=new Gson().toJson(list);
		
		return jsonString;
	}
	
	@RequestMapping(value="/evCarSave.do",method = RequestMethod.POST
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String evCarSave(EvCarVO inVO) throws SQLException {
		String jsonString = "";
		
		MessageVO outMsg = new MessageVO();
		
		int flag = this.evCarService.doSave(inVO);
		
		String message = "";
		if(1 == flag) {
			message = inVO.getCarName()+" 등록 완료";
		} else {
			message = inVO.getCarName()+" 등록 실패";
		}
		
		jsonString = new Gson().toJson(new MessageVO(flag+"", message));
		
		return jsonString;
	}
	
	@RequestMapping(value="/evCarDelete.do",method = RequestMethod.GET
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String evCarDelete(EvCarVO inVO) throws SQLException {
		String jsonString = "";
		
		int flag = evCarService.doDelete(inVO);
		
		String message = "";
		
		if(flag == 1) {
			message = "삭제 되었습니다.";
		} else {
			message = "삭제 실패";
		}
		
		jsonString = new Gson().toJson(new MessageVO(String.valueOf(flag),message));
		
		return jsonString;
	}
	
	@RequestMapping(value="/evCarSelectOne.do",method = RequestMethod.GET)
	public String evCarSelectOne(EvCarVO inVO, Model model) throws SQLException {
		
		if(null != inVO && inVO.getCarName() == null) {
			inVO.setCarName("");
		}
		if(null != inVO && inVO.getImgUrl() == null) {
			inVO.setImgUrl("");
		}
		if(null != inVO && inVO.getCarPrice() == null) {
			inVO.setCarPrice("");
		}
		if(null != inVO && inVO.getManufacture() == null) {
			inVO.setManufacture("");
		}
		if(null != inVO && inVO.getAppearance() == null) {
			inVO.setAppearance("");
		}		
		if(null != inVO && inVO.getCarModel() == null) {
			inVO.setCarModel("");
		}
		if(null != inVO && inVO.getMaxDistance() == null) {
			inVO.setMaxDistance("");
		}
		if(null != inVO && inVO.getBatteryType() == null) {
			inVO.setBatteryType("");
		}
		if(null != inVO && inVO.getBatteryCapa() == null) {
			inVO.setBatteryCapa("");
		}
		if(null != inVO && inVO.getOutPut() == null) {
			inVO.setOutPut("");
		}
		if(null != inVO && inVO.getProductYear() == 0) {
			inVO.setProductYear(0);
		}
		
		if(null != inVO && inVO.getCarNo() == -1) {
			return StringUtil.validMessageToJson("20", "차번호를 확인하세요.");
		}
		
		EvCarVO outVO = evCarService.doSelectOne(inVO);
		
		model.addAttribute("vo", outVO);
		return "elecmusk/select_evcar";
	}
	
	@RequestMapping(value="/evCarUpdate.do",method = RequestMethod.POST
			,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String evCarUpdate(EvCarVO inVO) throws SQLException {
		String jsonString = "";
		
		if(null != inVO && inVO.getCarName() == null) {
			inVO.setCarName("");
		}
		if(null != inVO && inVO.getImgUrl() == null) {
			inVO.setImgUrl("");
		}
		if(null != inVO && inVO.getCarPrice() == null) {
			inVO.setCarPrice("");
		}
		if(null != inVO && inVO.getManufacture() == null) {
			inVO.setManufacture("");
		}
		if(null != inVO && inVO.getAppearance() == null) {
			inVO.setAppearance("");
		}		
		if(null != inVO && inVO.getCarModel() == null) {
			inVO.setCarModel("");
		}
		if(null != inVO && inVO.getMaxDistance() == null) {
			inVO.setMaxDistance("");
		}
		if(null != inVO && inVO.getBatteryType() == null) {
			inVO.setBatteryType("");
		}
		if(null != inVO && inVO.getBatteryCapa() == null) {
			inVO.setBatteryCapa("");
		}
		if(null != inVO && inVO.getOutPut() == null) {
			inVO.setOutPut("");
		}
		if(null != inVO && inVO.getProductYear() == 0) {
			inVO.setProductYear(0);
		}
		
		MessageVO outMsg = new MessageVO();
		int flag = evCarService.doUpdate(inVO);
		
		String message = "";
		if(flag == 1) {
			message = inVO.getCarNo()+" 수정 완료";
		} else {
			message = inVO.getCarNo()+" 수정 실패";
		}
		
		jsonString = new Gson().toJson(new MessageVO(flag+"", message));
		
		return jsonString;
	}

}
