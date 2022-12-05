package com.pcwk.ehr.evcar.cmn;

import java.sql.SQLException;
import java.util.List;

public interface evWorkDiv<T>{
	List<T> doRetrieve(evDTO inVO) throws SQLException;
}
