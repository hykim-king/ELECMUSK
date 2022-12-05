package com.pcwk.ehr.evcar.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.evcar.cmn.evSearchVO;
import com.pcwk.ehr.evcar.domain.EvCarVO;

@Repository("evCarDao")
public class EvCarDaoImpl implements EvCarDao {
	final Logger LOG = LogManager.getLogger(getClass());

	final String NAMESPACE = "com.pcwk.ehr.evcar";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public EvCarDaoImpl() {}

	@Override
	public List<EvCarVO> doRetrieve(evDTO inVO) throws SQLException {
		evSearchVO search = (evSearchVO) inVO;
		List<EvCarVO> list = new ArrayList<EvCarVO>();
		String statement = NAMESPACE+DOT+"doRetrieve";
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│param : "+ inVO);
		LOG.debug("│statement : "+ statement);
		list = sqlSessionTemplate.selectList(statement, search);
		for(EvCarVO vo : list) {
			LOG.debug("│vo : "+ vo);
		}
		LOG.debug("└───────────────────────────────────┘");
		return list;
	}

}
