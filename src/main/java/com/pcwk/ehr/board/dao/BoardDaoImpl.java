package com.pcwk.ehr.board.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pcwk.ehr.board.cmn.DTO;
import com.pcwk.ehr.board.cmn.SearchVO;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.user.domain.UserVO;

@Repository("boardDao")
public class BoardDaoImpl implements BoardDao {
	
	final Logger LOG = LogManager.getFormatterLogger(getClass());
	final String NAMESPACE = "com.pcwk.ehr.board";
	final String DOT = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<BoardVO> getAll(BoardVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getCount(BoardVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doSave(BoardVO inVO) throws SQLException {
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		
		String statement = NAMESPACE+DOT+"doSave";
		//LOG.debug("│statement: "+statement);
		
		int flag = sqlSessionTemplate.insert(statement, inVO);
		
		//LOG.debug("│flag: "+flag);
		LOG.debug("└─────────────────────────┘");
		return flag;
	}

	@Override
	public int doDelete(BoardVO inVO) throws SQLException {
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
	public int doUpdate(BoardVO inVO) throws SQLException {
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
	public BoardVO doSelectOne(BoardVO inVO) throws SQLException {
		BoardVO outVO = null;
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
	public List<BoardVO> doRetrieve(DTO inVO) throws SQLException {
		SearchVO search = (SearchVO)inVO;
		List<BoardVO> list = new ArrayList<BoardVO>();
		String statement = NAMESPACE+DOT+"doRetrieve";
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		LOG.debug("│statement: "+statement);
		
		list = sqlSessionTemplate.selectList(statement,search);
		
		for(BoardVO vo : list) {
			LOG.debug("|vo : " + vo);
		}
		
		LOG.debug("└─────────────────────────┘");
		
		return list;
	}

	@Override
	public int updateReadCnt(BoardVO inVO) throws SQLException {
		
		int flag = 0;
		
		String statement = NAMESPACE+DOT+"updateReadCnt";
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│param: "+inVO);
		LOG.debug("│statement: "+statement);
		
		flag = sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("└─────────────────────────┘");
		return flag;
	}

}
