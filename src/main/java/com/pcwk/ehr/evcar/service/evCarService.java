package com.pcwk.ehr.evcar.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.evcar.domain.EvCarVO;

public interface evCarService {
	
	public List<EvCarVO> doRetrieve(evDTO inVO) throws SQLException;
	
	public int doSave(EvCarVO inVO) throws SQLException;
	
	public int doDelete(EvCarVO inVO) throws SQLException;
	
	public int doUpdate(EvCarVO inVO) throws SQLException;
	
	public EvCarVO doSelectOne(EvCarVO inVO) throws SQLException;
}
