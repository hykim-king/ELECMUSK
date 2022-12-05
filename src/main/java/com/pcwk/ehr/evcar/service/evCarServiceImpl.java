package com.pcwk.ehr.evcar.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.evcar.dao.EvCarDao;
import com.pcwk.ehr.evcar.domain.EvCarVO;

@Service("evCarService")
public class evCarServiceImpl implements evCarService {
	final Logger LOG = LogManager.getFormatterLogger(getClass());
	
	@Autowired
	private EvCarDao evCarDao;
	
	public evCarServiceImpl() {}
	
	@Override
	public List<EvCarVO> doRetrieve(evDTO inVO) throws SQLException {
		return evCarDao.doRetrieve(inVO);
	}

}
