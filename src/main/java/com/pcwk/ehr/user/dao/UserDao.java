package com.pcwk.ehr.user.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.user.domain.UserVO;

public interface UserDao extends WorkDiv<UserVO> {

	//전체 데이터 조회
	List<UserVO> getAll(UserVO inVO) throws SQLException;
    //건수 조회
	int getCount(UserVO inVO) throws SQLException;
	
	
}
