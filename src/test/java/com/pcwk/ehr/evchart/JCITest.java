package com.pcwk.ehr.evchart;

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

import com.pcwk.ehr.chart.dao.evChartDao;
import com.pcwk.ehr.chart.domain.evChartVO;
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
	evChartDao evDao;
	evChartVO search;
	evSearchVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("=================================");
		LOG.debug("=context= : "+context);
		LOG.debug("=EvCarDao= : "+evDao);
		LOG.debug("=================================");	
		searchVO = new evSearchVO(10, 1,"","", "", "", "", "","", "","","","","");
	}
	
	@Test
	public void doRetrieve() throws SQLException {
		List<evChartVO> list = evDao.doRetrieve(searchVO);
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
