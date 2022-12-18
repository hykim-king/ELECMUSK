package com.pcwk.ehr.chargingfee;

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

import com.pcwk.ehr.chargingfee.dao.ChargingFeeDao;
import com.pcwk.ehr.chargingfee.domain.ChargingFeeVO;
import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JWebChargingFeeDao {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	ChargingFeeDao dao;
	
	ChargingFeeVO chargingfee01;
	
	evSearchVO searchVO;
	ChargingFeeVO search;
	
	@Before
	public void setUp() throws Exception {
		chargingfee01 = new ChargingFeeVO(99, "aa", "aa", 99, 99, 99);
		
		search = new ChargingFeeVO(99, "aa", "aa", 99, 99, 99);
		
		searchVO = new evSearchVO(10, 1, "", "", "", "", "", "", "", "","","","","");
	}
	
	@Test
	@Ignore
	public void doSelectOne() throws SQLException{
		dao.doDelete(chargingfee01);
		dao.doSave(chargingfee01);
		dao.doSelectOne(chargingfee01);
	}
	
	@Test
	@Ignore
	public void doUpdate() throws SQLException{
		dao.doDelete(chargingfee01);
		dao.doSave(chargingfee01);
		
		String upStr = "_U";
		
		chargingfee01.setEnterprenuer(chargingfee01.getEnterprenuer()+upStr);
		
		dao.doUpdate(chargingfee01);
		
		dao.doSelectOne(chargingfee01);
	}
	
	@Test
	@Ignore
	public void doSave() throws SQLException{
		dao.doDelete(chargingfee01);
		dao.doSave(chargingfee01);
		dao.doSelectOne(chargingfee01);
	}
	
	@Test
	@Ignore
	public void doDelete() throws SQLException{
		dao.doDelete(chargingfee01);
		dao.doSave(chargingfee01);
		dao.doDelete(chargingfee01);
		dao.doSelectOne(chargingfee01);
	}
	
	@Test
	//@Ignore
	public void doRetrieve() throws SQLException{
		dao.doDelete(chargingfee01);
		dao.doSave(chargingfee01);
		List<ChargingFeeVO> list = dao.doRetrieve(searchVO);
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
