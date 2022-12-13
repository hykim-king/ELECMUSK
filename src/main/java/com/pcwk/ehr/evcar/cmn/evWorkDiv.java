package com.pcwk.ehr.evcar.cmn;

import java.sql.SQLException;
import java.util.List;

public interface evWorkDiv<T>{
	
	/**
	 * 등록
	 * @param t
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doSave(T inVO) throws SQLException;
	
	/**
	 * 수정
	 * @param t
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doUpdate(T inVO) throws SQLException;
	
	/**
	 * 삭제
	 * @param t
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doDelete(T inVO) throws SQLException;
	
	/**
	 * 단건 조회
	 * @param t
	 * @return T
	 * @throws SQLException
	 */
	T doSelectOne(T inVO) throws SQLException;
	
	/**
	 * 목록 조회
	 * @param t
	 * @return
	 * @throws SQLException
	 */
	List<T> doRetrieve(evDTO inVO) throws SQLException;
}
