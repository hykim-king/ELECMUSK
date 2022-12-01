package com.pcwk.ehr;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hamcrest.core.IsSame;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.board.cmn.SearchVO;
import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.user.domain.UserVO;


@RunWith(SpringJUnit4ClassRunner.class)//spring-test lib에 있음!
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
								   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class JWebBoardDao {
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 의해 자동으로 값으 주입된다.
	ApplicationContext context;
	
	@Autowired
	BoardDao dao;
	
	BoardVO boardVO01;
	BoardVO boardVO02;
	BoardVO boardVO03;
	BoardVO boardVO04;
	BoardVO boardVO05;
	
	BoardVO search;
	
	SearchVO searchVO;
	
	

	
	@Before
	public void setUp() throws Exception {
		LOG.debug("==============================");
		LOG.debug("context:"+context);
		LOG.debug("boardDao:"+dao);
		LOG.debug("==============================");
		
		boardVO01 = new BoardVO(2, "lyk01", 1, "이영관 test01", "test01", 1, 1, "허승휘 충전소", "date", "lyk01", "date", "lyk01");
		
		searchVO = new SearchVO(10, 1, "10", "01","1");
	}
	
	public void isSameUser(BoardVO actUser, BoardVO addUser) {
		assertEquals(actUser.getBdSeq(), addUser.getBdSeq());
		assertEquals(actUser.getNickName(), addUser.getNickName());
		assertEquals(actUser.getCategory(), addUser.getCategory());
		assertEquals(actUser.getTitle(), addUser.getTitle());
		assertEquals(actUser.getContents(), addUser.getContents());
		assertEquals(actUser.getReadCnt(), addUser.getReadCnt());
		assertEquals(actUser.getRecommendation(), addUser.getRecommendation());
		assertEquals(actUser.getCsnm(), addUser.getCsnm());
		assertEquals(actUser.getRegDt(), addUser.getRegDt());
		assertEquals(actUser.getRegId(), addUser.getRegId());
		assertEquals(actUser.getModDt(), addUser.getModDt());
		assertEquals(actUser.getModId(), addUser.getModId());
		
	}
	
	@Test
	public void doRetrieve()throws SQLException{
		
		List<BoardVO> list = dao.doRetrieve(searchVO);
	}
	
	@Test
	@Ignore
	public void doSelectOne()throws SQLException{
		BoardVO outVO123 = dao.doSelectOne(boardVO01);
		LOG.debug("outVO123: "+outVO123);
	}
	
	@Test
	@Ignore
	public void doSave()throws SQLException{
		
		//1 한건등록
		dao.doSave(boardVO01);
		
	}
	
	@Test
	@Ignore
	public void doDelete()throws SQLException{
		boardVO01.setBdSeq(1);
		dao.doDelete(boardVO01);	
	}
	
	@Test
	@Ignore
	public void doUpdate()throws SQLException{
		dao.doSave(boardVO01);
		
		String up = "__uptest";
		
		boardVO01.setNickName(boardVO01.getNickName()+up);
		
		dao.doUpdate(boardVO01);
	}
	
	@Test
	@Ignore
	public void bean() {
		assertNotNull(dao);

	}

}
