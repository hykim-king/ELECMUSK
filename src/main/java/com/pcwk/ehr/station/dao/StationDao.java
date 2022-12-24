package com.pcwk.ehr.station.dao;

import java.sql.SQLException;

import com.pcwk.ehr.evcar.cmn.evWorkDiv;
import com.pcwk.ehr.station.domain.StationVO;

public interface StationDao extends evWorkDiv<StationVO> {
	
	StationVO stationCheck(StationVO inVO) throws SQLException;
}
