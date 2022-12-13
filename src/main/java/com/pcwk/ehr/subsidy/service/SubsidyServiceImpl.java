package com.pcwk.ehr.subsidy.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.subsidy.dao.SubsidyDao;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;

@Service("subsidyService")
public class SubsidyServiceImpl implements SubsidyService {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	SubsidyDao subsidyDao;
	
	public SubsidyServiceImpl() {}

	@Override
	public int doSave(SubsidyVO inVO) throws SQLException {
		return subsidyDao.doSave(inVO);
	}

	@Override
	public int doDelete(SubsidyVO inVO) throws SQLException {
		return subsidyDao.doDelete(inVO);
	}

	@Override
	public int doUpdate(SubsidyVO inVO) throws SQLException {
		return subsidyDao.doUpdate(inVO);
	}

	@Override
	public SubsidyVO doSelectOne(SubsidyVO inVO) throws SQLException {
		return subsidyDao.doSelectOne(inVO);
	}

	@Override
	public List<SubsidyVO> doRetrieve(evDTO inVO) throws SQLException {
		
		return subsidyDao.doRetrieve(inVO);
	}
	
	

}
