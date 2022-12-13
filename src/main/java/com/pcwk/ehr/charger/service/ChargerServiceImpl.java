package com.pcwk.ehr.charger.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.charger.dao.ChargerDao;
import com.pcwk.ehr.charger.domain.ChargerVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

@Service("chargerService")
public class ChargerServiceImpl implements ChargerService {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ChargerDao chargerDao;
	
	public ChargerServiceImpl() {}
	
	@Override
	public int doSave(ChargerVO inVO) throws SQLException {
		return chargerDao.doSave(inVO);
	}

	@Override
	public int doDelete(ChargerVO inVO) throws SQLException {
		return chargerDao.doDelete(inVO);
	}

	@Override
	public int doUpdate(ChargerVO inVO) throws SQLException {
		return chargerDao.doUpdate(inVO);
	}

	@Override
	public ChargerVO doSelectOne(ChargerVO inVO) throws SQLException {
		return chargerDao.doSelectOne(inVO);
	}

	@Override
	public List<ChargerVO> doRetrieve(evDTO inVO) throws SQLException {
		return chargerDao.doRetrieve(inVO);
	}

}
