package com.pcwk.ehr.user.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	UserDao userDao;
	
	public UserServiceImpl() {}
	
	@Override
	public int multiDelete(List<UserVO> users) throws SQLException {
		int cnt = 0;
		try {
			for(UserVO vo: users) {
				cnt += userDao.doDelete(vo);
			}
		}catch (Exception e) {
			LOG.debug("삭제중 예외가 발생해 롤백합니다.: "+e.getMessage());
			LOG.debug("삭제중 예외가 발생해 롤백합니다.: "+e.getMessage());
			LOG.debug("삭제중 예외가 발생해 롤백합니다.: "+e.getMessage());
			throw e;
		}
		return cnt;
	}
	
	@Override
	public int idPassCheck(UserVO inVO) throws SQLException {
		int flag =  userDao.idCheck(inVO);
		if (1 != flag) {
			LOG.debug("id가 존재하지 않음");
			return 20;
		}
		
		flag = userDao.passwordCheck(inVO);
		if (1 != flag) {
			LOG.debug("비밀번호 불일치");
			return 40;
		}
		
		LOG.debug("아이디, 비밀번호 일치");
		return 10;
		
	}
	
	@Override
	public int idCheck(UserVO inVO) throws SQLException {
		return userDao.idCheck(inVO);
	}

	@Override
	public int passwordCheck(UserVO inVO) throws SQLException {
		return userDao.passwordCheck(inVO);
	}

	@Override
	public int doSave(UserVO inVO) throws SQLException {
		return userDao.doSave(inVO);
	}

	@Override
	public int doUpdate(UserVO inVO) throws SQLException {
		return userDao.doUpdate(inVO);
	}

	@Override
	public int doDelete(UserVO inVO) throws SQLException {
		return userDao.doDelete(inVO);
	}

	@Override
	public UserVO doSelectOne(UserVO inVO) throws SQLException {
		return userDao.doSelectOne(inVO);
	}

	@Override
	public List<UserVO> doRetrieve(DTO inVO) throws SQLException {
		return userDao.doRetrieve(inVO);
	}

	@Override
	public UserVO findIdByEmail(UserVO inVO) throws SQLException {
		return userDao.findIdByEmail(inVO);
	}

	@Override
	public UserVO findIdByNameBirth(UserVO inVO) throws SQLException {
		return userDao.findIdByNameBirth(inVO);
	}

	@Override
	public UserVO findPwByBackup(UserVO inVO) throws SQLException {
		return userDao.findPwByBackup(inVO);
	}

	

}
