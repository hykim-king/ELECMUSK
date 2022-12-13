package com.pcwk.ehr.chargingfee.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.chargingfee.domain.ChargingFeeVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

public interface ChargingFeeService {
	/**
	 * 등록
	 * 
	 * @param t
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doSave(ChargingFeeVO inVO) throws SQLException;

	/**
	 * 삭제
	 * 
	 * @param t
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doDelete(ChargingFeeVO inVO) throws SQLException;

	/**
	 * 수정
	 * 
	 * @param t
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doUpdate(ChargingFeeVO inVO) throws SQLException;

	/**
	 * 단건조회
	 * 
	 * @param t
	 * @return T
	 * @throws SQLException
	 */
	ChargingFeeVO doSelectOne(ChargingFeeVO inVO) throws SQLException;

	/**
	 * 목록조회
	 * 
	 * @param t
	 * @return List<DTO>
	 * @throws SQLException
	 */
	List<ChargingFeeVO> doRetrieve(evDTO inVO) throws SQLException;

	/**
	 * 완속요금조회
	 * 
	 * @param t
	 * @return List<DTO>
	 * @throws SQLException
	 */
	List<ChargingFeeVO> showSlow(evDTO inVO) throws SQLException;

}
