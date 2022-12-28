package com.pcwk.ehr.user.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	UserDao userDao;
	
	public UserServiceImpl() {}
	
	@Override
	public int multiBan(List<UserVO> users) throws SQLException {
		int cnt = 0;
		try {
			for(UserVO vo: users) {
				cnt += withdraw(vo);
			}
		}catch (Exception e) {
			LOG.debug("삭제중 예외가 발생해 롤백합니다.: "+e.getMessage());
			LOG.debug("삭제중 예외가 발생해 롤백합니다.: "+e.getMessage());
			LOG.debug("삭제중 예외가 발생해 롤백합니다.: "+e.getMessage());
			cnt = 0;
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
		
		UserVO outVO = userDao.passwordCheck(inVO);
		if (null == outVO) {
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
	public int nicknameCheck(UserVO inVO) throws SQLException {
		return userDao.nicknameCheck(inVO);
	}

	@Override
	public UserVO passwordCheck(UserVO inVO) throws SQLException {
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
	public List<UserVO> findIdByEmail(UserVO inVO) throws SQLException {
		return userDao.findIdByEmail(inVO);
	}

	@Override
	public List<UserVO> findIdByNameBirth(UserVO inVO) throws SQLException {
		return userDao.findIdByNameBirth(inVO);
	}

	@Override
	public UserVO findPwByBackup(UserVO inVO) throws SQLException {
		return userDao.findPwByBackup(inVO);
	}

	@Override
	public int updateNickname (UserVO inVO) throws SQLException{
		return userDao.updateNickname(inVO);
	}
	
	@Override
	public int updatePassword (UserVO inVO) throws SQLException{
		return userDao.updatePassword(inVO);
	}
	
	@Override 
	public int updateEmail (UserVO inVO) throws SQLException{
		return userDao.updateEmail(inVO);
	}

	@Override
	public int withdraw(UserVO inVO) throws SQLException {
		
		LOG.debug("inVO: "+inVO);
		
		UserVO outVO = userDao.doSelectOne(inVO);
		
		LOG.debug("정지해서 수정 전 유저정보: "+outVO);
		
		outVO.setmSeq(inVO.getmSeq());
		
		if(outVO.getUserId().length()>12) {
			if (!(outVO.getUserId().substring(0, 12).equals("Deleted_User"))) {
				outVO.setUserId("Deleted_User" + StringUtil.getCurrentDate() + outVO.getUserId());
			}
		}else {
			outVO.setUserId("Deleted_User" + StringUtil.getCurrentDate() + outVO.getUserId());
		}
		if (outVO.getNickname().length() > 12) {
			if (!(outVO.getNickname().substring(0, 12).equals("Deleted_User"))) {
				outVO.setNickname("Deleted_User" + StringUtil.getCurrentDate() + outVO.getNickname());
			}
		}else {
			outVO.setNickname("Deleted_User" + StringUtil.getCurrentDate() + outVO.getNickname());
		}
		
		outVO.setStatus(0);
		
		if(outVO != null && outVO.getName() == null) {
			outVO.setName("");
		}
		if(outVO != null && outVO.getBirth() == null) {
			outVO.setBirth("");
		}
		if(outVO != null && outVO.getEmail() == null) {
			outVO.setEmail("");
		}
		if(outVO != null && outVO.getBackupQuestion() == null) {
			outVO.setBackupQuestion("");
		}
		if(outVO != null && outVO.getBackupAnswer() == null) {
			outVO.setBackupAnswer("");
		}
		if(outVO != null && outVO.getJoinDate() == null) {
			outVO.setJoinDate("");
		}
		
		int flag = userDao.doUpdate(outVO);
		
		return flag;
	}

	@Override
	public List<UserVO> pointRank(UserVO inVO) throws SQLException {
		return userDao.pointRank(inVO);
	}

	@Override 
	public int loginAddPoint (UserVO inVO) throws SQLException{
		return userDao.loginAddPoint(inVO);
	}
	
	@Override 
	public int postAddPoint (UserVO inVO) throws SQLException{
		return userDao.postAddPoint(inVO);
	}
	
}
