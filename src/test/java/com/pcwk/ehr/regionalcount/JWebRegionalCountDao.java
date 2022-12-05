package com.pcwk.ehr.regionalcount;

import static org.junit.Assert.*;

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
import com.pcwk.ehr.regionalcount.dao.RegionalCountDao;
import com.pcwk.ehr.regionalcount.domain.RegionalCountVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JWebRegionalCountDao {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	RegionalCountDao dao;
	
	RegionalCountVO rc01;
	
	SearchVO searchVO;
	
	RegionalCountVO search;
	
	@Before
	public void setUp() throws Exception {
		rc01 = new RegionalCountVO(99, 99, 999999, 99, 99, 99, 99, 99, "aaaaaa", 99, 99, 99, 99, 99, 99, 99, 99, 99, 99);
		
		search = new RegionalCountVO(99, 99, 999999, 99, 99, 99, 99, 99, "aaaaaa", 99, 99, 99, 99, 99, 99, 99, 99, 99, 99);
		
		searchVO = new SearchVO(10, 1, "", "");
	}
	
	@Test
	//@Ignore
	public void doSelectOne() throws SQLException{
		dao.doDelete(rc01);
		dao.doSave(rc01);
		dao.doSelectOne(rc01);
	}
	
	@Test
	//@Ignore
	public void doUpdate() throws SQLException{
		dao.doDelete(rc01);
		dao.doSave(rc01);
		
		int upInt = 1000;
		
		rc01.setUlsan(rc01.getUlsan()+upInt);
		
		dao.doUpdate(rc01);
		
		dao.doSelectOne(rc01);
	}
	
	@Test
	//@Ignore
	public void doSave() throws SQLException{
		dao.doDelete(rc01);
		dao.doSave(rc01);
		dao.doSelectOne(rc01);
	}
	
	@Test
	//@Ignore
	public void doDelete() throws SQLException{
		dao.doDelete(rc01);
		dao.doSelectOne(rc01);
	}
	
	@Test
	//@Ignore
	public void doRetrieve() throws SQLException{
		dao.doDelete(rc01);
		dao.doSave(rc01);
		List<RegionalCountVO> list = dao.doRetrieve(searchVO);
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
