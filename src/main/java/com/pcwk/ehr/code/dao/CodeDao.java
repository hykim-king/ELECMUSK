package com.pcwk.ehr.code.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.code.domain.CodeVO;

public interface CodeDao extends WorkDiv<CodeVO> {

	public List<CodeVO> doRetrive(List<String> list) throws SQLException;
}
