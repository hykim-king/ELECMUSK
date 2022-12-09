package com.pcwk.ehr.chart.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.chart.dao.evChartDao;
import com.pcwk.ehr.chart.domain.evChartVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

@Service("evChartService")
public class evChartServiceImpl implements evChartService {
	
	@Autowired
	private evChartDao evChartDao;
	
	public evChartServiceImpl() {}
	
	@Override
	public List<evChartVO> doRetrieve(evDTO inVO) throws SQLException {
		return evChartDao.doRetrieve(inVO);
	}

}
