package com.pcwk.ehr.charger;

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

import com.pcwk.ehr.charger.dao.ChargerDao;
import com.pcwk.ehr.charger.domain.ChargerVO;
import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JWebChargerDao {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	ChargerDao dao;
	
	ChargerVO charger01;
	
	evSearchVO searchVO;
	ChargerVO search;
	
	
	@Before
	public void setUp() throws Exception {
		charger01 = new ChargerVO(99, "aa", "aa", "aa", "aa", "aa", "aa", "aa");
		
		search = new ChargerVO(99, "aa", "aa", "aa", "aa", "aa", "aa", "aa");
		
		searchVO = new evSearchVO(10, 1, "", "", "", "", "", "", "", "","","","","");
	}
	
	@Test
	@Ignore
	public void doSelectOne() throws SQLException{
		dao.doDelete(charger01);
		dao.doSave(charger01);
		dao.doSelectOne(charger01);
	}
	
	@Test
	@Ignore
	public void doUpdate() throws SQLException{
		dao.doDelete(charger01);
		dao.doSave(charger01);
		
		String upStr = "_U";
		
		charger01.setConnector(charger01.getConnector()+upStr);
		
		dao.doUpdate(charger01);
		
		dao.doSelectOne(charger01);
	}
	
	@Test
	@Ignore
	public void doSave() throws SQLException{
		dao.doDelete(charger01);
		dao.doSave(charger01);
		dao.doSelectOne(charger01);
	}
	
	@Test
	//@Ignore
	public void doDelete() throws SQLException{
		dao.doDelete(charger01);
		dao.doSave(charger01);
		dao.doDelete(charger01);
		dao.doSelectOne(charger01);
	}
	
	@Test
	@Ignore
	public void doRetrieve() throws SQLException{
		dao.doDelete(charger01);
		dao.doSave(charger01);
		List<ChargerVO> list = dao.doRetrieve(searchVO);
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
