package com.pcwk.ehr.user.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.user.domain.UserVO;

@Repository("userDao")
public class UserDaoImpl implements UserDao{
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE="com.pcwk.ehr.user";
	final String DOT = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public UserDaoImpl() {}
	
	public int doSave(UserVO inVO) throws SQLException{
		LOG.debug("param: "+inVO);
		
		String statement = NAMESPACE+DOT+"doSave";
		LOG.debug("statement: "+statement);
		
		int flag = sqlSessionTemplate.insert(statement,inVO);
		LOG.debug("flag: "+flag);
		
		return flag;
	}

	public int doUpdate(UserVO inVO) throws SQLException {
		LOG.debug("param: "+inVO);
		
		String statement = NAMESPACE+DOT+"doUpdate";
		LOG.debug("statement: "+statement);
		
		int flag = sqlSessionTemplate.update(statement,inVO);
		LOG.debug("flag: "+flag);
		
		return flag;
	}

	public int doDelete(UserVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	public UserVO doSelectOne(UserVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public List<UserVO> doRetrieve(UserVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}
