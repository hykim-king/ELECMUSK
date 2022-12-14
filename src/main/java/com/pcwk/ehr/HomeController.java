package com.pcwk.ehr;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.chart.dao.evChartDao;
import com.pcwk.ehr.chart.domain.evChartVO;
import com.pcwk.ehr.chart.service.evChartService;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.StringUtil;
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
	evChartService evChartService;
	
	public HomeController() {}
	
	@RequestMapping(value = "/view.do", method = RequestMethod.GET)
	public String mainHome() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 mainHome                  │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value = "/evcar.do", method = RequestMethod.GET)
	public String evCar() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                   evCar                   │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "elecmusk/evCar";
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
		
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		
		List<evChartVO> list = evChartService.doRetrieve(inVO);
		
		jsonString=new Gson().toJson(list);
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");		
		
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
		
		LOG.debug("┌=============================┐");	
		LOG.debug("|inVO="+inVO);
		
		List<EvCarVO> list = evCarService.doRetrieve(inVO);
		
		jsonString=new Gson().toJson(list);
		/*
		JSON 값																	
		
		문자열 (string)			{ "site":"cafe" }                                                                                       											
		숫자 (number)				{ "year":2022}                                                                                  											
		객체 (object)				{"UserVO":{"msgId":"1","msgContents":"p99_01수정 되었습니다.","totalCnt":0,"num":0}}                                                                                      											
		배열 (array)					                                                                                        											
		참거짓 (boolean)			{ "member":true }                                                                                       											
		널 (null)					{ "point":null }        											
		*/
		LOG.debug("|jsonString="+jsonString);
		LOG.debug("└=============================┘");		
		
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
		if(null != inVO && inVO.getCarNo() == -1) {
			return StringUtil.validMessageToJson("20", "순번을 확인하세요.");
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
