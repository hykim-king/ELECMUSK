package com.pcwk.ehr.station.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.station.domain.StationVO;

public interface StationService {

		/**
	    * 등록
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doSave(StationVO inVO)throws SQLException;
	   
	   /**
	    * 삭제
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doDelete(StationVO inVO)throws SQLException;
	   
	   /**
	    * 수정
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doUpdate(StationVO inVO)throws SQLException;
	   
	   
	   /**
	    * 단건조회
	    * @param t
	    * @return T
	    * @throws SQLException
	    */
	   StationVO doSelectOne(StationVO inVO)throws SQLException;
	   
	   /**
	    * 목록조회
	    * @param t
	    * @return List<DTO>
	    * @throws SQLException
	    */
	   List<StationVO> doRetrieve(evDTO inVO)throws SQLException;
	   
	   StationVO stationCheck(StationVO inVO) throws SQLException;
}
