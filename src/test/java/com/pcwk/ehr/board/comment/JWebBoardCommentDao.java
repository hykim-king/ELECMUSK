package com.pcwk.ehr.board.comment;

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

import com.pcwk.ehr.board.Comment.Dao.BoardCommentDao;
import com.pcwk.ehr.board.Comment.domain.BoardCommentVO;
import com.pcwk.ehr.board.cmn.SearchVO;
import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.user.domain.UserVO;


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
	BoardCommentVO boardCommentVO2;
	BoardCommentVO boardCommentVO3;
	BoardCommentVO boardCommentVO4;
	BoardCommentVO boardCommentVO5;
	
	BoardCommentVO search;
	
	SearchVO searchVO;
	
	

	
	@Before
	public void setUp() throws Exception {
		LOG.debug("==============================");
		LOG.debug("context:"+context);
		LOG.debug("BoardCommentVO:"+dao);
		LOG.debug("==============================");
		
		boardCommentVO1 = new BoardCommentVO(125,1,"A","");
		boardCommentVO2 = new BoardCommentVO(126,2,"B","");
		boardCommentVO3 = new BoardCommentVO(127,3,"C","");
		boardCommentVO4 = new BoardCommentVO(128,4,"D","");
		boardCommentVO5 = new BoardCommentVO(129,5,"E","");
		
		
		//searchVO = new SearchVO(10, 1, "10","01","");
	}
	
	public void isSameUser(BoardCommentVO actUser, BoardCommentVO addUser) {
		assertEquals(actUser.getCmSeq(), addUser.getCmSeq());
		assertEquals(actUser.getBdSeq(), addUser.getBdSeq());
		assertEquals(actUser.getContents(), addUser.getContents());
		assertEquals(actUser.getRegDt(), addUser.getRegDt());
	}
	
	
	@Test
	public void doRetrieve()throws SQLException{
		
		List<BoardCommentVO> list = dao.doRetrieve(searchVO);
	}
	
	@Test
	@Ignore //완 
	public void doSelectOne()throws SQLException{
		BoardCommentVO outVO123 = dao.doSelectOne(boardCommentVO1);
		LOG.debug("outVO123: "+outVO123);
		
		
	}
	
	@Test 
	@Ignore //완 
	public void doSave()throws SQLException{
		
		
		//등록
		dao.doSave(boardCommentVO1);
		dao.doSave(boardCommentVO2);
		dao.doSave(boardCommentVO3);
		dao.doSave(boardCommentVO4);
		dao.doSave(boardCommentVO5);
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
		dao.doDelete(boardCommentVO2);	
		dao.doDelete(boardCommentVO3);	
		dao.doDelete(boardCommentVO4);	
		dao.doDelete(boardCommentVO5);	
	
	}
	
	
	@Test
	public void bean() {
		assertNotNull(dao);
		assertNotNull(context);
	}

}
