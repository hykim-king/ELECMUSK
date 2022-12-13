package com.pcwk.ehr.chargingfee.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.chargingfee.domain.ChargingFeeVO;
import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.evcar.cmn.evWorkDiv;

public interface ChargingFeeDao extends evWorkDiv<ChargingFeeVO> {
	
	//완속요금조회
	List<ChargingFeeVO> showSlow(evDTO inVO) throws SQLException;
}
