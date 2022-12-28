package com.pcwk.ehr.user.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.UserSearchVO;
import com.pcwk.ehr.user.domain.UserVO;

@Repository("userDao")
public class UserDaoImpl implements UserDao {
	final Logger LOG = LogManager.getLogger(getClass());

	final String NAMESPACE = "com.pcwk.ehr.user";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public UserDaoImpl() {
	}

	public int doSave(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		String statement = NAMESPACE + DOT + "doSave";
		LOG.debug("statement: " + statement);

		int flag = sqlSessionTemplate.insert(statement, inVO);
		LOG.debug("flag: " + flag);

		return flag;
	}

	public int doUpdate(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		String statement = NAMESPACE + DOT + "doUpdate";
		LOG.debug("statement: " + statement);

		int flag = sqlSessionTemplate.update(statement, inVO);
		LOG.debug("flag: " + flag);

		return flag;
	}

	public int doDelete(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		String statement = NAMESPACE + DOT + "doDelete";
		LOG.debug("statement: " + statement);

		int flag = sqlSessionTemplate.delete(statement, inVO);
		LOG.debug("flag: " + flag);

		return flag;
	}

	public UserVO doSelectOne(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		UserVO outVO = null;

		String statement = NAMESPACE + DOT + "doSelectOne";
		LOG.debug("statement: " + statement);

		outVO = sqlSessionTemplate.selectOne(statement, inVO);

		return outVO;
	}

	public List<UserVO> doRetrieve(DTO inVO) throws SQLException {
		UserSearchVO search = (UserSearchVO) inVO;

		LOG.debug("inVO: " + inVO);

		List<UserVO> list = new ArrayList<UserVO>();
		
		String statement = NAMESPACE + DOT + "doRetrieve";
		LOG.debug("statement: " + statement);

		list = sqlSessionTemplate.selectList(statement, search);

		LOG.debug("list: " + list);

		return list;
	}
	
	@Override
	public int idCheck(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		String statement = NAMESPACE + DOT + "idCheck";
		LOG.debug("statement: " + statement);

		int flag = sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("flag: " + flag);

		//flag=1이면 있음, 0이면 없음.
		return flag;
	}
	
	@Override
	public int nicknameCheck(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);
		
		String statement = NAMESPACE + DOT + "nicknameCheck";
		LOG.debug("statement: " + statement);
		
		int flag = sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("flag: " + flag);
		
		//flag=1이면 있음, 0이면 없음.
		return flag;
	}

	@Override
	public UserVO passwordCheck(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		String statement = NAMESPACE + DOT + "passwordCheck";
		LOG.debug("statement: " + statement);
		
		UserVO outVO = sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("outVO: " + outVO);

		//mSeq만 들어있는 UserVO 리턴. 없으면?? null이겠지?
		return outVO;
	}

	@Override
	public List<UserVO> findIdByEmail(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		List<UserVO> list = new ArrayList<UserVO>();
		
		String statement = NAMESPACE + DOT + "findIdByEmail";
		LOG.debug("statement: " + statement);
		
		list = sqlSessionTemplate.selectList(statement, inVO);
		
		LOG.debug("list: "+list);
		
		return list;
	}

	@Override
	public List<UserVO> findIdByNameBirth(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		List<UserVO> list = new ArrayList<UserVO>();
		
		String statement = NAMESPACE + DOT + "findIdByNameBirth";
		LOG.debug("statement: " + statement);
		
		list = sqlSessionTemplate.selectList(statement, inVO);
		
		LOG.debug("list: "+list);
		
		return list;
	}

	@Override
	public UserVO findPwByBackup(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		String statement = NAMESPACE + DOT + "findPwByBackup";
		LOG.debug("statement: " + statement);
		
		UserVO userVO = sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("userVO: " + userVO);
		
		//비밀번호만 들어있는 userVO가 리턴됨. 없으면??
		return userVO;
	}

	public int updateNickname(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		String statement = NAMESPACE + DOT + "updateNickname";
		LOG.debug("statement: " + statement);

		int flag = sqlSessionTemplate.update(statement, inVO);
		LOG.debug("flag: " + flag);

		return flag;
	}
	
	public int updatePassword(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);
		
		String statement = NAMESPACE + DOT + "updatePassword";
		LOG.debug("statement: " + statement);
		
		int flag = sqlSessionTemplate.update(statement, inVO);
		LOG.debug("flag: " + flag);
		
		return flag;
	}
	
	public int updateEmail(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);
		
		String statement = NAMESPACE + DOT + "updateEmail";
		LOG.debug("statement: " + statement);
		
		int flag = sqlSessionTemplate.update(statement, inVO);
		LOG.debug("flag: " + flag);
		
		return flag;
	}

	@Override
	public List<UserVO> pointRank(UserVO inVO) throws SQLException {
		LOG.debug("param: " + inVO);

		List<UserVO> list = new ArrayList<UserVO>();
		
		String statement = NAMESPACE + DOT + "pointRank";
		LOG.debug("statement: " + statement);
		
		list = sqlSessionTemplate.selectList(statement, inVO);
		
		LOG.debug("list: "+list);
		
		return list;
	}
	
	@Override
	public int loginAddPoint(UserVO inVO) throws SQLException{
		LOG.debug("param: " + inVO);
		
		String statement = NAMESPACE + DOT + "loginAddPoint";
		LOG.debug("statement: " + statement);
		
		int flag = sqlSessionTemplate.update(statement, inVO);
		LOG.debug("flag: " + flag);
		
		return flag;
	}
	
	@Override
	public int postAddPoint(UserVO inVO) throws SQLException{
		LOG.debug("param: " + inVO);
		
		String statement = NAMESPACE + DOT + "postAddPoint";
		LOG.debug("statement: " + statement);
		
		int flag = sqlSessionTemplate.update(statement, inVO);
		LOG.debug("flag: " + flag);
		
		return flag;
	}
}
