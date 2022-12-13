package com.pcwk.ehr.subsidy.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;

public interface SubsidyService {

	
		/**
	    * 등록
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doSave(SubsidyVO inVO)throws SQLException;
	   
	   /**
	    * 삭제
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doDelete(SubsidyVO inVO)throws SQLException;
	   
	   /**
	    * 수정
	    * @param t
	    * @return 1(성공)/0(실패)
	    * @throws SQLException
	    */
	   int doUpdate(SubsidyVO inVO)throws SQLException;
	   
	   
	   /**
	    * 단건조회
	    * @param t
	    * @return T
	    * @throws SQLException
	    */
	   SubsidyVO doSelectOne(SubsidyVO inVO)throws SQLException;
	   
	   /**
	    * 목록조회
	    * @param t
	    * @return List<DTO>
	    * @throws SQLException
	    */
	   List<SubsidyVO> doRetrieve(evDTO inVO)throws SQLException;
}
