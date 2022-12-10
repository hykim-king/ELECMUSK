package com.pcwk.ehr.chargingfee.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.chargingfee.domain.ChargingFeeVO;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.WorkDiv;

public interface ChargingFeeDao extends WorkDiv<ChargingFeeVO> {
	
	//완속요금조회
	List<ChargingFeeVO> showSlow(DTO inVO) throws SQLException;
}
