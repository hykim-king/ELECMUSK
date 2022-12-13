package com.pcwk.ehr.chargingfee.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.chargingfee.dao.ChargingFeeDao;
import com.pcwk.ehr.chargingfee.domain.ChargingFeeVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

@Service("chargingfeeService")
public class ChargingFeeServiceImpl implements ChargingFeeService {

	final Logger LOG = LogManager.getLogger(getClass());

	@Autowired
	ChargingFeeDao chargingfeeDao;

	@Override
	public int doSave(ChargingFeeVO inVO) throws SQLException {
		return chargingfeeDao.doSave(inVO);
	}

	@Override
	public int doDelete(ChargingFeeVO inVO) throws SQLException {
		return chargingfeeDao.doDelete(inVO);
	}

	@Override
	public int doUpdate(ChargingFeeVO inVO) throws SQLException {
		return chargingfeeDao.doUpdate(inVO);
	}

	@Override
	public ChargingFeeVO doSelectOne(ChargingFeeVO inVO) throws SQLException {
		return chargingfeeDao.doSelectOne(inVO);
	}

	@Override
	public List<ChargingFeeVO> doRetrieve(evDTO inVO) throws SQLException {
		return chargingfeeDao.doRetrieve(inVO);
	}

	@Override
	public List<ChargingFeeVO> showSlow(evDTO inVO) throws SQLException {
		return chargingfeeDao.showSlow(inVO);
	}

	

	

}
