package com.pcwk.ehr.board.cmn;

import java.sql.SQLException;
import java.util.List;

public interface WorkDiv<T> {
	/**
	 * 등록
	 * @param t
	 * @return 1/0(0이면 실패)(1이면 성공)
	 * @throws SQLException
	 */
	int doSave(T inVO)throws SQLException;
	
	/**
	 * 삭제
	 * @param t
	 * @return 1/0(0이면 실패)(1이면 성공)
	 * @throws SQLException
	 */
	int doDelete(T inVO)throws SQLException;
	
	/**
	 * 수정
	 * @param t
	 * @return 1/0(0이면 실패)(1이면 성공)
	 * @throws SQLException
	 */
	int doUpdate(T inVO)throws SQLException;
	
	/**
	 * 단건조회
	 * @param t
	 * @return 1/0(0이면 실패)(1이면 성공)
	 * @throws SQLException
	 */
	T doSelectOne(T inVO)throws SQLException;
	
	/**
	 * 목록조회
	 * @param t
	 * @return 1/0(0이면 실패)(1이면 성공)
	 * @throws SQLException
	 */
	List<T> doRetrieve(DTO inVO)throws SQLException;
}
