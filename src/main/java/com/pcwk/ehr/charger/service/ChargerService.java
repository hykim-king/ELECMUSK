package com.pcwk.ehr.charger.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.charger.domain.ChargerVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

public interface ChargerService {
	/**
	    * 등록
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doSave(ChargerVO inVO)throws SQLException;
	   
	   /**
	    * 삭제
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doDelete(ChargerVO inVO)throws SQLException;
	   
	   /**
	    * 수정
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doUpdate(ChargerVO inVO)throws SQLException;
	   
	   
	   /**
	    * 단건조회
	    * @param t
	    * @return T
	    * @throws SQLException
	    */
	   ChargerVO doSelectOne(ChargerVO inVO)throws SQLException;
	   
	   /**
	    * 목록조회
	    * @param t
	    * @return List<DTO>
	    * @throws SQLException
	    */
	   List<ChargerVO> doRetrieve(evDTO inVO)throws SQLException;
}
