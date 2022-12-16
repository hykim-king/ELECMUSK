package com.pcwk.ehr.board;

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
		
		boardVO01 = new BoardVO(6, "lyk01", 9, "이영관 test01", "test01", 1, 1, "허승휘 충전소", "date", "lyk01", "date", "lyk01");
		boardVO02 = new BoardVO(6, "lyk01", 9, "이영관 test01", "test01", 1, 1, "허승휘 충전소", "date", "lyk01", "date", "lyk01");
		boardVO03 = new BoardVO(6, "lyk01", 9, "이영관 test01", "test01", 1, 1, "허승휘 충전소", "date", "lyk01", "date", "lyk01");
		boardVO04 = new BoardVO(6, "lyk01", 9, "이영관 test01", "test01", 1, 1, "허승휘 충전소", "date", "lyk01", "date", "lyk01");
		boardVO05 = new BoardVO(6, "lyk01", 9, "이영관 test01", "test01", 1, 1, "허승휘 충전소", "date", "lyk01", "date", "lyk01");
		
		
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
	@Ignore
	public void updateReadCnt() throws SQLException{
		//1. 삭제
		//2. 등록
		//3.한건조회
		//4.조회카운트 증가
		//5.단건조회:
		//6.조회 카운트 증가
		//7.비교
		
		//1
		
		//2
		
		//3
		BoardVO out01 = dao.doSelectOne(boardVO01);
		
		
		//4.
		dao.updateReadCnt(out01);
		LOG.debug("│out012: "+out01);
		out01 = dao.doSelectOne(boardVO01);
		LOG.debug("│out012: "+out01);
		assertEquals(out01.getReadCnt(), boardVO01.getReadCnt()+1);
	}
	
	@Test
	@Ignore
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
	//@Ignore
	public void doSave()throws SQLException{
		
		//1 한건등록
		dao.doSave(boardVO01);
		dao.doSave(boardVO02);
		dao.doSave(boardVO03);
		dao.doSave(boardVO04);
		dao.doSave(boardVO05);
		
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
	public void doDelete()throws SQLException{
		boardVO01.setBdSeq(1);
		dao.doDelete(boardVO01);	
	}
	
	
	@Test
	@Ignore
	public void bean() {
		assertNotNull(dao);

	}

}
