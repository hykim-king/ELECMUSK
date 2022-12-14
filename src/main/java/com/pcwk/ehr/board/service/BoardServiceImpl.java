package com.pcwk.ehr.board.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.board.cmn.DTO;
import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;


@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	BoardDao boardDao;
	@Override
	public int doSave(BoardVO inVO) throws SQLException {
		return boardDao.doSave(inVO);
	}

	@Override
	public int doDelete(BoardVO inVO) throws SQLException {
		return boardDao.doDelete(inVO);
	}

	@Override
	public int doUpdate(BoardVO inVO) throws SQLException {
		return boardDao.doUpdate(inVO);
	}

	@Override
	public BoardVO doSelectOne(BoardVO inVO) throws SQLException {
		BoardVO outVO = boardDao.doSelectOne(inVO);
		boardDao.updateReadCnt(inVO);
		return outVO;
	}

	@Override
	public List<BoardVO> doRetrieve(DTO inVO) throws SQLException {
		return boardDao.doRetrieve(inVO);
	}


	

}
