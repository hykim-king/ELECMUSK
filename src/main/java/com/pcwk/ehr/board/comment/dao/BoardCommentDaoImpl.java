package com.pcwk.ehr.board.comment.dao;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.board.cmn.DTO;
import com.pcwk.ehr.board.cmn.SearchVO;
import com.pcwk.ehr.board.comment.domain.BoardCommentSearchVO;
import com.pcwk.ehr.board.comment.domain.BoardCommentVO;

@Repository("boardCommentDao")
public class BoardCommentDaoImpl implements BoardCommentDao {
	
	final Logger LOG = LogManager.getFormatterLogger(getClass());
	final String NAMESPACE = "com.pcwk.ehr.board.comment";
	final String DOT = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public int doSave(BoardCommentVO inVO) throws SQLException {
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		String statement = NAMESPACE+DOT+"doSave";
		LOG.debug("│statement: "+statement);
		int flag = sqlSessionTemplate.insert(statement, inVO);
		
		LOG.debug("│flag: "+flag);
		LOG.debug("└─────────────────────────┘");
		return flag;
	}

	@Override
	public int doDelete(BoardCommentVO inVO) throws SQLException {
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		
		String statement = NAMESPACE+DOT+"doDelete";
		
		LOG.debug("│statement: "+statement);
		
		int flag = sqlSessionTemplate.delete(statement, inVO);
		
		LOG.debug("│flag: "+flag);
		LOG.debug("└─────────────────────────┘");
		return flag;
	}

	@Override
	public int doUpdate(BoardCommentVO inVO) throws SQLException {
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		
		String statement = NAMESPACE+DOT+"doUpdate";
		
		LOG.debug("│statement: "+statement);
		
		int flag = sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("│flag: "+flag);
		LOG.debug("└─────────────────────────┘");
		return flag;
	}

	@Override
	public BoardCommentVO doSelectOne(BoardCommentVO inVO) throws SQLException {
		BoardCommentVO outVO = null;
		String statement = NAMESPACE+DOT+"doSelectOne";
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		LOG.debug("│statement: "+statement);
		
		outVO = sqlSessionTemplate.selectOne(statement, inVO);
		
		LOG.debug("│outVO: "+outVO);
		LOG.debug("└─────────────────────────┘");
		return outVO;
		
	}

	@Override
	public List<BoardCommentVO> doRetrieve(DTO inVO) throws SQLException {
		BoardCommentSearchVO search = (BoardCommentSearchVO)inVO;
		List<BoardCommentVO> list = new ArrayList<BoardCommentVO>();
		String statement = NAMESPACE+DOT+"doRetrieve";
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		LOG.debug("│statement: "+statement);
		
		list = sqlSessionTemplate.selectList(statement,search);
		
		for(BoardCommentVO vo : list) {
			LOG.debug("|vo : " + vo);
		}
		
		LOG.debug("└─────────────────────────┘");
		
		return list;
	}

}
