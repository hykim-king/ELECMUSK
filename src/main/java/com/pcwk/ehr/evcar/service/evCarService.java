package com.pcwk.ehr.evcar.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.evcar.domain.EvCarVO;

public interface evCarService {
	
	public List<EvCarVO> doRetrieve(evDTO inVO) throws SQLException;
	
}
