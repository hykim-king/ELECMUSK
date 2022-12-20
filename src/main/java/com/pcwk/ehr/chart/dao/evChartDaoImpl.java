package com.pcwk.ehr.chart.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.chart.domain.evChartVO;
import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;

@Repository("evChart")
public class evChartDaoImpl implements evChartDao {
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.evchart";
	final String DOT = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public evChartDaoImpl() {}

	@Override
	public List<evChartVO> doRetrieve(evDTO inVO) throws SQLException {
		evSearchVO search = (evSearchVO) inVO;
		List<evChartVO> list = new ArrayList<evChartVO>();
		String statement = NAMESPACE+DOT+"doRetrieve";
		list = sqlSessionTemplate.selectList(statement, search);
		return list;
	}

	@Override
	public int doSave(evChartVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doUpdate(evChartVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(evChartVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public evChartVO doSelectOne(evChartVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


}
