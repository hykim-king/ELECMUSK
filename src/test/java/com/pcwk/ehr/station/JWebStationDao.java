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
import com.pcwk.ehr.station.dao.StationDAO;
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
	StationDAO dao;
	
	StationVO station01;
	
	SearchVO searchVO;
	StationVO search;
	
	@Before
	public void setUp() throws Exception {
		station01 = new StationVO(9999, "aaaa", "9", 9999, "aa99", "99", "9", 9999, "aaaa", "9999", "9999", "");
		
		search = new StationVO(9999, "aaaa", "9", 9999, "aa99", "99", "9", 9999, "aaaa", "9999", "9999", "");
		
		searchVO = new SearchVO(10, 1, "", "");
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
	@Ignore
	public void doSave() throws SQLException{
		dao.doSave(station01);
		
	}
	
	@Test
	@Ignore
	public void doRetrieve() throws SQLException{
		dao.doDelete(station01);
		
		dao.doSave(station01);
		
		List<StationVO> list = dao.doRetrieve(searchVO);
	}

	@Test
	//@Ignore
	public void doUpdate() throws SQLException{
		//1.삭제
		//2.등록
		//3.한건조회
		//4.한건조회 데이터 수정
		//5.수정
		//6.한건조회
		//7.비교
		
		//1.
		dao.doDelete(station01);
		//2.
		dao.doSave(station01);
		//3.
		StationVO upVO01 = dao.doSelectOne(station01);
		isSameData(upVO01, station01);
		//4.
		String upStr = "_U";
		int upInt = 10;
		upVO01.setAddr(upVO01.getAddr()+upStr);
		upVO01.setCpid(upVO01.getCpid()+upInt);
		
		//5.
		//assertEquals(1,dao.doUpdate(upVO01));
		
		//6.
		StationVO vsResult = dao.doSelectOne(upVO01);
		
		//7.
		isSameData(vsResult, upVO01);
		
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
