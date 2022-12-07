package com.pcwk.ehr.code.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.code.domain.CodeVO;

@Repository("codeDao")
public class CodeDaoImpl implements CodeDao {
	final Logger LOG = LogManager.getFormatterLogger(getClass());
	final String NAMESPACE = "com.pcwk.ehr.code";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<CodeVO> doRetrive(List<String> list) throws SQLException {
		List<CodeVO> outList = new ArrayList<CodeVO>(); 
		
		String statement = NAMESPACE+DOT+"doRetrive";
		LOG.debug("┌─────────────────────────┐");
		LOG.debug("│statement: "+statement);
		for(String str : list) {
			LOG.debug("│str: "+str);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		outList = sqlSessionTemplate.selectList(statement,map);
		
		for(CodeVO vo : outList) {
			LOG.debug("│vo: "+vo);
		}
		LOG.debug("└─────────────────────────┘");
		
		
		return outList;
	}
	
	@Override
	public int doSave(CodeVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doUpdate(CodeVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(CodeVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public CodeVO doSelectOne(CodeVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CodeVO> doRetrieve(DTO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}



}
