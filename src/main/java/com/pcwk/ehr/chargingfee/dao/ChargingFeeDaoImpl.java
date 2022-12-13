package com.pcwk.ehr.chargingfee.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.chargingfee.domain.ChargingFeeVO;
import com.pcwk.ehr.evcar.cmn.evDTO;

@Repository("chargingfeeDao")
public class ChargingFeeDaoImpl implements ChargingFeeDao {

	final Logger LOG = LogManager.getFormatterLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.chargingfee";
	final String DOT = ".";
	
	public ChargingFeeDaoImpl() {}
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;//db연결 객체
	
	@Override
	public int doSave(ChargingFeeVO inVO) throws SQLException {
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave", inVO);
	}

	@Override
	public int doUpdate(ChargingFeeVO inVO) throws SQLException {
		return sqlSessionTemplate.update(NAMESPACE+DOT+"doUpdate", inVO);
	}

	@Override
	public int doDelete(ChargingFeeVO inVO) throws SQLException {
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete", inVO);
	}

	@Override
	public ChargingFeeVO doSelectOne(ChargingFeeVO inVO) throws SQLException {
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}

	@Override
	public List<ChargingFeeVO> doRetrieve(evDTO inVO) throws SQLException {
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"doRetrieve", inVO);
	}

	@Override
	public List<ChargingFeeVO> showSlow(evDTO inVO) throws SQLException {
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"showSlow", inVO);
	}
	
	
	
	

}
