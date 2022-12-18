package com.pcwk.ehr.evcar;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.evcar.dao.EvCarDao;
import com.pcwk.ehr.evcar.domain.EvCarVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
        ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class JCITest {

	final Logger LOG = LogManager.getLogger(getClass());
	@Autowired //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 의해 자동으로 값이 주입된다.
	ApplicationContext context;
	
	@Autowired
	EvCarDao evDao;
	
	EvCarVO evDao01;
	EvCarVO evDao02;
	EvCarVO evDao03;
	EvCarVO evDao04;
	EvCarVO evDao05;
	EvCarVO search;
	evSearchVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("=================================");
		LOG.debug("=context= : "+context);
		LOG.debug("=EvCarDao= : "+evDao);
		LOG.debug("=================================");	
		
		evDao01 = new EvCarVO(27, "차이름01", "url", "200", "menu", 2022, "appe", "model", "dis", "batteryTP", "battery", 100, "out");
		evDao02 = new EvCarVO(28, "차이름02", "url", "200", "menu", 2022, "appe", "model", "dis", "batteryTP", "battery", 100, "out");
		evDao03 = new EvCarVO(29, "차이름03", "url", "200", "menu", 2022, "appe", "model", "dis", "batteryTP", "battery", 100, "out");
		evDao04 = new EvCarVO(30, "차이름04", "url", "200", "menu", 2022, "appe", "model", "dis", "batteryTP", "battery", 100, "out");
		evDao05 = new EvCarVO(31, "차이름05", "url", "200", "menu", 2022, "appe", "model", "dis", "batteryTP", "battery", 100, "out");
		search =  new EvCarVO(31, "차이름05", "url", "200", "menu", 2022, "appe", "model", "dis", "batteryTP", "battery", 100, "out");
		searchVO = new evSearchVO(10, 1, "", "", "", "", "", "", "", "","","","","");
	}
	
	@Test
	public void add() throws SQLException {
		evDao.doSave(evDao01);
	}
	
	@Test
	@Ignore
	public void addAndGet() throws SQLException {
		evDao.doDelete(evDao01);
		evDao.doDelete(evDao02);
		evDao.doDelete(evDao03);
		evDao.doDelete(evDao04);
		evDao.doDelete(evDao05);
		
		evDao.doSave(evDao01);
		evDao.doSave(evDao02);
		evDao.doSave(evDao03);
		evDao.doSave(evDao04);
		evDao.doSave(evDao05);
		
		EvCarVO out01 = evDao.doSelectOne(evDao01);
		LOG.debug("┌──────────────────────────");
		LOG.debug("│=evDao01= : "+evDao01);
		LOG.debug("│=out01= : "+out01);
		LOG.debug("└──────────────────────────");
		
		String upStr = "_U";
		
		out01.setCarName(out01.getCarName()+upStr);
		
		evDao.doUpdate(out01);
		
		LOG.debug("│=out01= : "+out01);
	}
	
	@Test
	@Ignore
	public void doRetrieve() throws SQLException {
		List<EvCarVO> list = evDao.doRetrieve(searchVO);
	}

	@Test
	public void beans() {
		LOG.debug("┌──────────────────────────");
		LOG.debug("│=evDao= : "+evDao);
		LOG.debug("│=context= : "+context);
		LOG.debug("└──────────────────────────");
		
		assertNotNull(evDao);
		assertNotNull(context);
	}

}
