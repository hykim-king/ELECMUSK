package com.pcwk.ehr.station;

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
import com.pcwk.ehr.station.dao.StationDao;
import com.pcwk.ehr.station.domain.StationVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JWebStationDao {

	final Logger LOG = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context;

	@Autowired
	StationDao dao;

	StationVO station01;

	evSearchVO searchVO;
	StationVO search;

	@Before
	public void setUp() throws Exception {
		station01 = new StationVO(9999, "aaaa", "9", 9999, "aa99", "99", "9", 9999, "aaaa", "9999", "9999", "");

		search = new StationVO(9999, "aaaa", "9", 9999, "aa99", "99", "9", 9999, "aaaa", "9999", "9999", "");

		searchVO = new evSearchVO(10, 1, "", "", "", "", "", "", "", "","","","","2");
	}

	@Test
	@Ignore
	public void doSelectOne() throws SQLException {
		dao.doDelete(station01);
		dao.doSave(station01);
		dao.doSelectOne(station01);
	}

	@Test
	@Ignore
	public void doDelete() throws SQLException {
		dao.doDelete(station01);
		dao.doSave(station01);
		dao.doDelete(station01);
		dao.doSelectOne(station01);
	}

	@Test
	@Ignore
	public void doSave() throws SQLException {
		dao.doDelete(station01);
		dao.doSave(station01);
		dao.doSelectOne(station01);
	}

	@Test
	//@Ignore
	public void doRetrieve() throws SQLException {
//		dao.doDelete(station01);
//
//		dao.doSave(station01);

		List<StationVO> list = dao.doRetrieve(searchVO);
	}

	@Test
	@Ignore
	public void doUpdate() throws SQLException {
		dao.doDelete(station01);
		dao.doSave(station01);

		String upStr = "_U";
		station01.setAddr(station01.getAddr() + upStr);

		dao.doUpdate(station01);

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
