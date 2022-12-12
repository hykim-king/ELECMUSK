package com.pcwk.ehr.chart.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.chart.domain.evChartVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

public interface evChartService {

	public List<evChartVO> doRetrieve(evDTO inVO) throws SQLException;
}
