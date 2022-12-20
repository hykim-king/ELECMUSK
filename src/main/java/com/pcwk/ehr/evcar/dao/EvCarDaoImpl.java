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
		list = sqlSessionTemplate.selectList(statement, search);
		return list;
	}

	@Override
	public int doSave(EvCarVO inVO) throws SQLException {
		int flag = 0;
		String statement = NAMESPACE+DOT+"evCarSave";
		flag = sqlSessionTemplate.insert(statement, inVO);
		
		return flag;
	}

	@Override
	public int doUpdate(EvCarVO inVO) throws SQLException {
		return sqlSessionTemplate.update(NAMESPACE+DOT+"evCarUpdate", inVO);
	}

	@Override
	public int doDelete(EvCarVO inVO) throws SQLException {
		String statement = NAMESPACE+DOT+"evCarDelete";
		int flag = sqlSessionTemplate.delete(statement, inVO);
		return flag;
	}

	@Override
	public EvCarVO doSelectOne(EvCarVO inVO) throws SQLException {
		EvCarVO outVO = null;
		return outVO = sqlSessionTemplate.selectOne(NAMESPACE+DOT+"evCarSelectOne", inVO);
	}

}
