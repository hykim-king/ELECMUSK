package com.pcwk.ehr.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.board.cmn.DTO;
import com.pcwk.ehr.board.cmn.WorkDiv;
import com.pcwk.ehr.board.domain.BoardVO;

public interface BoardDao extends WorkDiv<BoardVO>{

	/*
	 UserDao를 interface로 만든 이유는 확장성 때문.
	 객체 생성 시 UserDao 인터페이스로 객체를 생성하면
	 해당 인터페이스를 구현한 여러 구현체로 활용가능하다.
	 ex) Mybatis, hibernate
	*/
	
	// like 전체 데이터 리턴
	List<BoardVO> getAll(BoardVO inVO) throws SQLException;
	
	// 등록된 데이터 건수 확인
	int getCount(BoardVO inVO) throws SQLException;
	
	int updateReadCnt(BoardVO inVO) throws SQLException;

}