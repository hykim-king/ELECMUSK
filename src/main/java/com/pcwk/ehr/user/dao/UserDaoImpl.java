package com.pcwk.ehr.user.dao;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

@Repository("userDao")
public class UserDaoImpl {
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE="com.pcwk.ehr.user";
	final String DOT = ".";
	
	
}
