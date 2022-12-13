package com.pcwk.ehr.subsidy.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.evcar.cmn.evDTO;
import com.pcwk.ehr.subsidy.domain.SubsidyVO;

@Repository("subsidyDao")
public class SubsidyDaoImpl implements SubsidyDao {

	final Logger LOG = LogManager.getFormatterLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.subsidy";
	final String DOT = ".";
	
	public SubsidyDaoImpl() {}
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;//db연결 객체
	
	@Override
	public int doSave(SubsidyVO inVO) throws SQLException {
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave", inVO);
	}

	@Override
	public int doUpdate(SubsidyVO inVO) throws SQLException {
		return sqlSessionTemplate.update(NAMESPACE+DOT+"doUpdate", inVO);
	}

	@Override
	public int doDelete(SubsidyVO inVO) throws SQLException {
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete", inVO);
	}

	@Override
	public SubsidyVO doSelectOne(SubsidyVO inVO) throws SQLException {
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}

	@Override
	public List<SubsidyVO> doRetrieve(evDTO inVO) throws SQLException {
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"doRetrieve", inVO);
	}

}
