package com.pcwk.ehr.charger.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.charger.domain.ChargerVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

@Repository("chargerDao")
public class ChargerDaoImpl implements ChargerDao {

	final Logger LOG = LogManager.getFormatterLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.charger";
	final String DOT = ".";
	
	public ChargerDaoImpl() {}
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;//db연결 객체
	
	@Override
	public int doSave(ChargerVO inVO) throws SQLException {
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave", inVO);
	}

	@Override
	public int doUpdate(ChargerVO inVO) throws SQLException {
		return sqlSessionTemplate.update(NAMESPACE+DOT+"doUpdate", inVO);
	}

	@Override
	public int doDelete(ChargerVO inVO) throws SQLException {
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete", inVO);
	}

	@Override
	public ChargerVO doSelectOne(ChargerVO inVO) throws SQLException {
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}

	@Override
	public List<ChargerVO> doRetrieve(evDTO inVO) throws SQLException {
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"doRetrieve", inVO);
	}

}
