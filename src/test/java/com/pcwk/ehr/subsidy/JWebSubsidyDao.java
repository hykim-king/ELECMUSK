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
import com.pcwk.ehr.evcar.cmn.evSearchVO;
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
	
	evSearchVO searchVO;
	SubsidyVO search;
	
	@Before
	public void setUp() throws Exception {
		subsidy01 = new SubsidyVO(99999, "aa", "aa", 99, "aa", "aa");
		
		search = new SubsidyVO(99999, "aa", "aa", 99, "aa", "aa");
		
		searchVO = new evSearchVO(10, 1, "", "", "", "", "", "", "", "","","","","");
	}
	
	@Test
	//@Ignore
	public void doSelectOne() throws SQLException{
		dao.doDelete(subsidy01);
		dao.doSave(subsidy01);
		dao.doSelectOne(subsidy01);
	}
	
	@Test
	//@Ignore
	public void doUpdate() throws SQLException{
		dao.doDelete(subsidy01);
		dao.doSave(subsidy01);
		
		String upStr = "_U";
		
		subsidy01.setName(subsidy01.getName()+upStr);
	
		dao.doUpdate(subsidy01);
		
		dao.doSelectOne(subsidy01);
	}
	
	@Test
	//@Ignore
	public void doSave() throws SQLException{
		dao.doDelete(subsidy01);
		dao.doSave(subsidy01);
		dao.doSelectOne(subsidy01);
	}
	
	@Test
	//@Ignore
	public void doDelete() throws SQLException{
		dao.doDelete(subsidy01);
		dao.doSave(subsidy01);
		dao.doDelete(subsidy01);
		dao.doSelectOne(subsidy01);
	}
	
	
	@Test
	//@Ignore
	public void doRetrieve() throws SQLException{
		
		dao.doDelete(subsidy01);
		
		dao.doSave(subsidy01);
		
		List<SubsidyVO> list = dao.doRetrieve(searchVO);
	}

	
	@Test
	//@Ignore
	public void beans() {
		LOG.debug("┌─────────────────────────────────────┐");
		LOG.debug("│context:" + context);
		LOG.debug("│dao:" + dao);
		LOG.debug("└─────────────────────────────────────┘");
		
		assertNotNull(context);
		assertNotNull(dao);
	}

}
