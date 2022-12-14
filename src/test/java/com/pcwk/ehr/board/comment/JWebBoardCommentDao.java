package com.pcwk.ehr.board.comment;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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

import com.pcwk.ehr.board.comment.dao.BoardCommentDao;
import com.pcwk.ehr.board.comment.domain.BoardCommentVO;
import com.pcwk.ehr.board.cmn.SearchVO;


@RunWith(SpringJUnit4ClassRunner.class)//spring-test lib에 있음!
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
								   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class JWebBoardCommentDao {
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 의해 자동으로 값으 주입된다.
	ApplicationContext context;
	
	@Autowired
	BoardCommentDao dao;
	
	BoardCommentVO boardCommentVO1;
	
	BoardCommentVO search;
	
	SearchVO searchVO;
	
	

	
	@Before
	public void setUp() throws Exception {
		LOG.debug("==============================");
		LOG.debug("context:"+context);
		LOG.debug("BoardCommentVO:"+dao);
		LOG.debug("==============================");
		
		boardCommentVO1 = new BoardCommentVO(12,1,"A","");

		
		
		//searchVO = new SearchVO(10, 1, "10","01","");
	}
	
	public void isSameUser(BoardCommentVO actUser, BoardCommentVO addUser) {
		assertEquals(actUser.getCmSeq(), addUser.getCmSeq());
		assertEquals(actUser.getBdSeq(), addUser.getBdSeq());
		assertEquals(actUser.getContents(), addUser.getContents());
		assertEquals(actUser.getRegDt(), addUser.getRegDt());
	}
	
	
	@Test
	@Ignore
	public void doRetrieve()throws SQLException{
		
		List<BoardCommentVO> list = dao.doRetrieve(searchVO);
	}
	
	@Test
	@Ignore //완 
	public void doSelectOne()throws SQLException{
		BoardCommentVO outVO123 = dao.doSelectOne(boardCommentVO1);
		LOG.debug("outVO123: "+outVO123);
		
		
	}
	
	@Test  //완 
	public void doSave()throws SQLException{
		
		
		dao.doSave(boardCommentVO1);
	}
	

	@Test //완
	@Ignore
		public void doUpdate()throws SQLException{
		dao.doSave(boardCommentVO1);
		
		String up = "__uptest";
		
       boardCommentVO1.setContents(boardCommentVO1.getContents()+up);
		
		dao.doUpdate(boardCommentVO1);
	}
	
	@Test 
	@Ignore //완
	public void doDelete()throws SQLException{
		dao.doDelete(boardCommentVO1);	
	}
	
	
	@Test
	public void bean() {
		assertNotNull(dao);
		assertNotNull(context);
	}

}
