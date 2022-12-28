package com.pcwk.ehr.board.comment.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.board.cmn.DTO;
import com.pcwk.ehr.board.comment.domain.BoardCommentVO;


public interface BoardCommentService {
	   final String DOT = ".";

	   /**
	    * 등록
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doSave(BoardCommentVO inVO)throws SQLException;
	   
	   /**
	    * 삭제
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doDelete(BoardCommentVO inVO)throws SQLException;
	   
	   /**
	    * 수정
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doUpdate(BoardCommentVO inVO)throws SQLException;
	   
	   
	   /**
	    * 단건조회
	    * @param t
	    * @return T
	    * @throws SQLException
	    */
	   BoardCommentVO doSelectOne(BoardCommentVO inVO)throws SQLException;
	   
	   /**
	    * 목록조회
	    * @param t
	    * @return List<DTO>
	    * @throws SQLException
	    */
	   List<BoardCommentVO> doRetrieve(DTO inVO)throws SQLException;

}
