package com.pcwk.ehr.user.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.UserVO;

@Service("userService")
public interface UserService {
	//트랜젝션이 들어가는 기능과 들어가지 않는 기능을 구분해야함.
	
	/**
	 * 다건삭제. 트랜젝션이 들어가는 기능
	 * @param users
	 * @return 삭제 건수
	 * @throws SQLException
	 */
	int multiDelete(List<UserVO> users) throws SQLException;
	
	/**
	 * id 중복확인, 로그인과 회원가입시에 쓰임
	 * @param inVO
	 * @return 중복이 있으면 1, 아니라면 0
	 * @throws SQLException
	 */
	int idCheck(UserVO inVO) throws SQLException;
	
	/**
	 * 아이디와 비밀번호 동시에 확인
	 * @param inVO
	 * @return 아이디와 비밀번호가 둘다 맞으면 1, 아니면 0
	 * @throws SQLException
	 */
	int passwordCheck(UserVO inVO) throws SQLException;
	
	/**
	 * 신규 등록
	 * @param inVO
	 * @return 성공1 실패0
	 * @throws SQLException
	 */
	int doSave(UserVO inVO) throws SQLException;
	
	/**
	 * 수정
	 * @param inVO
	 * @return 성공1 실패0
	 * @throws SQLException
	 */
	int doUpdate(UserVO inVO) throws SQLException;
	
	/**
	 * 삭제
	 * @param inVO
	 * @return 성공1 실패0
	 * @throws SQLException
	 */
	int doDelete(UserVO inVO) throws SQLException;
	
	/**
	 * 단건 조회
	 * @param inVO
	 * @return UserVO
	 * @throws SQLException
	 */
	UserVO doSelectOne(UserVO inVO) throws SQLException;
	
	/**
	 * 목록 조회
	 * @param inVO
	 * @return	List<UserVO>
	 * @throws SQLException
	 */
	List<UserVO> doRetrieve(DTO inVO) throws SQLException;
	
	/**
	 * 이메일로 아이디 찾기. 이메일만 맞추면 아이디 알려줌
	 * @param inVO
	 * @return UserVO(아이디만있고 나머지는 Null)
	 * @throws SQLException
	 */
	UserVO findIdByEmail(UserVO inVO) throws SQLException;
	
	/**
	 * 이름과 생일로 아이디 찾기. 이름과 생일을 맞추면 아이디를 알려줌
	 * @param inVO
	 * @return UserVO(아이디만 있고 나머지는 Null)
	 * @throws SQLException
	 */
	UserVO findIdByNameBirth(UserVO inVO) throws SQLException;
	
	/**
	 * 비밀번호찾기 질문/답변으로 비밀번호 찾기. 아이디와 질문과 답변 모두 일치해야 알려줌
	 * @param inVO
	 * @return UserVO(비밀번호만 있고 나머지는 Null)
	 * @throws SQLException
	 */
	UserVO findPwByBackup(UserVO inVO) throws SQLException;
}
