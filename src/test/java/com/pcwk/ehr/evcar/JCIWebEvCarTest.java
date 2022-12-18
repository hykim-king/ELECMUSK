package com.pcwk.ehr.evcar;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.context.WebApplicationContext;

import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.evcar.dao.EvCarDao;
import com.pcwk.ehr.evcar.domain.EvCarVO;
import com.pcwk.ehr.evcar.service.evCarService;
import com.pcwk.ehr.user.domain.UserVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)//spring-test lib에 있음!
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		                          ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JCIWebEvCarTest {
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	//브라우저 대역(Mock)
	MockMvc  mockMvc;
	
	@Autowired
	EvCarDao dao;
	
	//테스트 픽스처
	List<EvCarVO> evCars;
	
	EvCarVO search;
	evSearchVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		searchVO = new evSearchVO(6, 1, "", "", "현대", "", "중형", "","", "","","","","");
	}
	
	@Test
	public void doRetrieve() throws Exception {
		MockHttpServletRequestBuilder  requestBuilder = MockMvcRequestBuilders.get("/elecmusk/doRetrieve.do")
										                .param("pageSize", searchVO.getPageSize()+"")
										                .param("pageNo", searchVO.getPageNo()+"")
										                .param("manufactureKeyword", searchVO.getManufactureKeyword())
										                .param("appearanceKeyword", searchVO.getAppearanceKeyword())
														.param("modelKeyword", searchVO.getModelKeyword())
														.param("batteryTypeKeyword", searchVO.getBatteryTypeKeyword());
		//대역 객체를 통해 호출
		ResultActions resultActions =mockMvc.perform(requestBuilder)
		                .andExpect(status().is2xxSuccessful());	
		
		String responseResult =  resultActions.andDo( print() )
		.andReturn().getResponse().getContentAsString();	
		LOG.debug("┌-------------------------------------------┐");
		LOG.debug("|responseResult:"+responseResult);
		LOG.debug("└-------------------------------------------┘");		
	}
	
	@Test
	@Ignore
	public void beans() {
		LOG.debug("┌-------------------------------------------┐");
		LOG.debug("|webApplicationContext:"+webApplicationContext);
		LOG.debug("|mockMvc:"+mockMvc);
		LOG.debug("|dao:"+dao);
		LOG.debug("└-------------------------------------------┘");		
		
		assertNotNull(dao);
		assertNotNull(mockMvc);
		assertNotNull(webApplicationContext);	
	}

}
