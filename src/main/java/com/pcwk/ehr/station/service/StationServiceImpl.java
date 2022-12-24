package com.pcwk.ehr.station.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.station.dao.StationDao;
import com.pcwk.ehr.station.domain.StationVO;

@Service("stationService")
public class StationServiceImpl implements StationService {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	StationDao stationDao;
	
	public StationServiceImpl() {}
	
	
	@Override
	public int doSave(StationVO inVO) throws SQLException {
		return stationDao.doSave(inVO);
	}

	@Override
	public int doDelete(StationVO inVO) throws SQLException {
		return stationDao.doDelete(inVO);
	}

	@Override
	public int doUpdate(StationVO inVO) throws SQLException {
		return stationDao.doUpdate(inVO);
	}

	@Override
	public StationVO doSelectOne(StationVO inVO) throws SQLException {
		return stationDao.doSelectOne(inVO);
	}

	@Override
	public List<StationVO> doRetrieve(evDTO inVO) throws SQLException {
		return stationDao.doRetrieve(inVO);
	}


	@Override
	public StationVO stationCheck(StationVO inVO) throws SQLException {
		return stationDao.stationCheck(inVO);
	}

}
