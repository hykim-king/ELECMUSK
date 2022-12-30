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
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.board.comment.dao.BoardCommentDao;
import com.pcwk.ehr.board.comment.domain.BoardCommentSearchVO;
import com.pcwk.ehr.board.comment.domain.BoardCommentVO;


@RunWith(SpringJUnit4ClassRunner.class) // spring-test lib에 있음!
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
public class JWebBoardCommentDao {
	final Logger LOG = LogManager.getLogger(getClass());

	@Autowired
	BoardCommentDao dao;

	BoardCommentVO boardCommentVO1;

	BoardCommentSearchVO searchVO;

	@Before
	public void setUp() throws Exception {
                                                       //401은 BOARD에 들어가있는 글 번호 ! (부모키)
		boardCommentVO1 = new BoardCommentVO(99999999, 401, 1000308,"contentsa1", "사용X");
		                                                   //순번     //1000321이 닉네임을 정해주는 memberseq
		searchVO = new BoardCommentSearchVO(401,10,1,"","");
	}

	

	@Test
    @Ignore
	public void doUpdate() throws Exception {
		boardCommentVO1.setCmSeq(1000043);//댓글번호(Cmseq)를 찾아 컨텐츠띄우기 
		boardCommentVO1.setContents("ㅋㅋㅋㅋㅋ");
        boardCommentVO1.setMemberSeq(2);
		dao.doUpdate(boardCommentVO1);

	}

	@Test
	@Ignore
	public void doDelete() throws Exception {
		boardCommentVO1.setCmSeq(1000308); //댓글번호(Cmseq)를 찾아 삭제 
		int flag = dao.doDelete(boardCommentVO1);

	}

	@Test
	@Ignore
	public void doSave() throws Exception {
		LOG.debug("doSave");
		dao.doSave(boardCommentVO1);

	}
	@Test
	public void doRetrieve() throws Exception {
		List<BoardCommentVO> list = dao.doRetrieve(searchVO);
	}

	@Test
	public void bean() {
		assertNotNull(dao);
	}

}
