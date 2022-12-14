package com.pcwk.ehr.board.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.board.cmn.DTO;
import com.pcwk.ehr.board.domain.BoardVO;


public interface BoardService {
	   final String DOT = ".";

	   /**
	    * 등록
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doSave(BoardVO inVO)throws SQLException;
	   
	   /**
	    * 삭제
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doDelete(BoardVO inVO)throws SQLException;
	   
	   /**
	    * 수정
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doUpdate(BoardVO inVO)throws SQLException;
	   
	   
	   /**
	    * 단건조회
	    * @param t
	    * @return T
	    * @throws SQLException
	    */
	   BoardVO doSelectOne(BoardVO inVO)throws SQLException;
	   
	   /**
	    * 목록조회
	    * @param t
	    * @return List<DTO>
	    * @throws SQLException
	    */
	   List<BoardVO> doRetrieve(DTO inVO)throws SQLException;
	   


}
