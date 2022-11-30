package com.pcwk.ehr;

import static org.junit.Assert.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
        ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class KDJTestDontTouchPleaseThankYou {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	UserDao userDao;
	
	UserVO userVO1;
	UserVO userVO2;
	UserVO userVO3;
	
	@Before
	public void setUp(){
		userVO1 = new UserVO("rlaehdwn60_1", "rlaehdwn60_1", "password", "김동주");
		userVO2 = new UserVO("rlaehdwn60_2", "rlaehdwn60_2", "password", "김동주");
		userVO3 = new UserVO("rlaehdwn60_3", "rlaehdwn60_3", "password", "김동주");
	}

	@Test
	@Ignore
	public void doSave() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userDao.doSave(userVO1);
	}
	
	@Test
	@Ignore
	public void doUpdate() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		UserVO userVOkk = new UserVO("rlaehdwn60_U", "rlaehdwn60_U", "password_U", "김동_U");
		userVOkk.setMemberSeq(1000042);
		userDao.doUpdate(userVOkk);
	}
	
	@Test
	@Ignore
	public void doDelete() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userVO1.setMemberSeq(1000042);
		userDao.doDelete(userVO1);
	}
	
	@Test
	public void doSelectOne() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userVO1.setMemberSeq(1000041);
		UserVO outVO = userDao.doSelectOne(userVO1);
		System.out.println(outVO);
	}
	
	@Test
	public void beans() {
		LOG.debug("userDao"+userDao);
		
		assertNotNull(userDao);
	}
	

}
