package com.pcwk.ehr.subsidy;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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

import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.station.domain.StationVO;
import com.pcwk.ehr.subsidy.dao.SubsidyDao;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JWebSubsidyDao {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	SubsidyDao dao;
	
	SubsidyVO subsidy01;
	
	SearchVO searchVO;
	SubsidyVO search;
	
	@Before
	public void setUp() throws Exception {
	}
	
	public void isSameData(StationVO actual, StationVO expected) {
		assertEquals(actual.getStation_seq(), expected.getStation_seq());
		assertEquals(actual.getAddr(), expected.getAddr());
		assertEquals(actual.getChargetp(), expected.getChargetp());
		assertEquals(actual.getCpid(), expected.getCpid());
		assertEquals(actual.getCpnm(), expected.getCpnm());
		assertEquals(actual.getCpstat(), expected.getCpstat());
		assertEquals(actual.getCptp(), expected.getCptp());
		assertEquals(actual.getCsid(), expected.getCsid());
		assertEquals(actual.getCsnm(), expected.getCsnm());
		assertEquals(actual.getLat(), expected.getLat());
		assertEquals(actual.getLongi(), expected.getLongi());
		assertEquals(actual.getStatupdatetime(), expected.getStatupdatetime());
		
	}
	
	
	@Test
	//@Ignore
	public void doRetrieve() throws SQLException{
		
		
		List<SubsidyVO> list = dao.doRetrieve(searchVO);
	}

	
	@Test
	@Ignore
	public void beans() {
		LOG.debug("┌─────────────────────────────────────┐");
		LOG.debug("│context:" + context);
		LOG.debug("│dao:" + dao);
		LOG.debug("└─────────────────────────────────────┘");
		
		assertNotNull(context);
		assertNotNull(dao);
	}

}
