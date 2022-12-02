package com.pcwk.ehr.subsidy.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;

@Repository("subsidyDao")
public class SubsidyDaoImpl implements SubsidyDao {

	final Logger LOG = LogManager.getFormatterLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.subsidy";
	final String DOT = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;//db연결 객체
	
	@Override
	public int doSave(SubsidyVO inVO) throws SQLException {
		return 0;
	}

	@Override
	public int doUpdate(SubsidyVO inVO) throws SQLException {
		return 0;
	}

	@Override
	public int doDelete(SubsidyVO inVO) throws SQLException {
		return 0;
	}

	@Override
	public SubsidyVO doSelectOne(SubsidyVO inVO) throws SQLException {
		return null;
	}

	@Override
	public List<SubsidyVO> doRetrieve(DTO inVO) throws SQLException {
		SearchVO search =  (SearchVO)inVO;
		List<SubsidyVO> list = new ArrayList<SubsidyVO>();
		String statement = NAMESPACE+DOT+"doRetrieve";
		
		LOG.debug("┌─────────────────────────────────────┐");
		LOG.debug("│param:"+inVO);
		LOG.debug("│statement:"+statement);
		
		list = sqlSessionTemplate.selectList(statement, search);
		
		for(SubsidyVO vo : list) {
			LOG.debug("│vo:"+vo);
		}
		LOG.debug("└─────────────────────────────────────┘");
		
		return list;
	}

}
