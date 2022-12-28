package com.pcwk.ehr.board.comment.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.board.cmn.DTO;
import com.pcwk.ehr.board.comment.dao.BoardCommentDao;
import com.pcwk.ehr.board.comment.domain.BoardCommentVO;


@Service("BCommentService")
public class BoardCommentServiceImpl implements BoardCommentService {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	BoardCommentDao boardCommentDao;
	@Override
	public int doSave(BoardCommentVO inVO) throws SQLException {
		return boardCommentDao.doSave(inVO);
	}

	@Override
	public int doDelete(BoardCommentVO inVO) throws SQLException {
		return boardCommentDao.doDelete(inVO);
	}

	@Override
	public int doUpdate(BoardCommentVO inVO) throws SQLException {
		return boardCommentDao.doUpdate(inVO);
	}

	@Override
	public BoardCommentVO doSelectOne(BoardCommentVO inVO) throws SQLException {
		BoardCommentVO outVO = boardCommentDao.doSelectOne(inVO);
		return outVO;
	}

	@Override
	public List<BoardCommentVO> doRetrieve(DTO inVO) throws SQLException {
		return boardCommentDao.doRetrieve(inVO);
	}


}
