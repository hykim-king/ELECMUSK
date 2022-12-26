package com.pcwk.ehr.station.dao;

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
import com.pcwk.ehr.station.domain.StationVO;

@Repository("stationDao")
public class StationDaoImpl implements StationDao {

	final Logger LOG = LogManager.getFormatterLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.station";
	final String DOT = ".";
	
	public StationDaoImpl() {}
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;//db연결 객체
	
	@Override
	public int doSave(StationVO inVO) throws SQLException {
		
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave", inVO);
	}

	@Override
	public int doUpdate(StationVO inVO) throws SQLException {
		
		return sqlSessionTemplate.update(NAMESPACE+DOT+"doUpdate", inVO);
	}

	@Override
	public int doDelete(StationVO inVO) throws SQLException {
		
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete", inVO );
	}

	@Override
	public StationVO doSelectOne(StationVO inVO) throws SQLException {
		
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}

	@Override
	public List<StationVO> doRetrieve(evDTO inVO) throws SQLException {
		
		evSearchVO search =  (evSearchVO)inVO;
		List<StationVO> list = new ArrayList<StationVO>();
		String statement = NAMESPACE+DOT+"doRetrieve";
		
		LOG.debug("┌─────────────────────────────────────┐");
		LOG.debug("│param:"+inVO);
		LOG.debug("│statement:"+statement);
		
		list = sqlSessionTemplate.selectList(statement, search);
		
		for(StationVO vo : list) {
			LOG.debug("│vo:"+vo);
		}
		LOG.debug("└─────────────────────────────────────┘");
		
		return list;
	}

	@Override
	public StationVO stationCheck(StationVO inVO) throws SQLException {
		
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"stationCheck", inVO);
	}

}
