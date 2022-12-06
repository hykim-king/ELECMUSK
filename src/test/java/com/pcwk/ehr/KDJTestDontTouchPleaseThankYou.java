package com.pcwk.ehr;

import static org.junit.Assert.*;

import java.util.List;

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

import com.pcwk.ehr.cmn.SearchVO;
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
	
	SearchVO searchVO;
	
	@Before
	public void setUp(){
		userVO1 = new UserVO("rlaehdwn60_1", "rlaehdwn60_1", "password", "김동주");
		userVO2 = new UserVO("rlaehdwn60_2", "rlaehdwn60_2", "password", "김동주");
		userVO3 = new UserVO("rlaehdwn60_3", "rlaehdwn60_3", "password", "김동주");
	
		searchVO = new SearchVO(10, 1, "10", "rla");
	}

	@Test
	public void doSave() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userDao.doSave(userVO1);
	}
	
	@Test
	public void doUpdate() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		UserVO userVOkk = new UserVO("rlaehdwn60_U", "rlaehdwn60_U", "password_U", "김동_U");
		userVOkk.setMemberSeq(1000041);
		userDao.doUpdate(userVOkk);
	}
	
	@Test
	public void doDelete() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userVO1.setMemberSeq(1000021);
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
	public void doRetrieve() throws Exception{
		List<UserVO> list = userDao.doRetrieve(searchVO);
		
		LOG.debug("list: "+list);
	}
	
	@Test
	public void idCheck() throws Exception{
		LOG.debug("flag: "+userDao.idCheck(userVO1));
	}
	
	@Test
	public void passwordCheck() throws Exception{
		LOG.debug("flag: "+userDao.passwordCheck(userVO1));
	}
	
	@Test
	public void findIdByEmail() throws Exception{
		userVO1.setEmail("rlaehdwn60@gmail.com");
		LOG.debug("userVO: "+userDao.findIdByEmail(userVO1));
	}
	
	@Test
	public void findIdByNameBirth() throws Exception{
		userVO1.setBirth("99/01/31");
		userVO1.setName("이상무");
		LOG.debug("userVO: "+userDao.findIdByNameBirth(userVO1));
	}
	
	@Test
	public void findPwByBackup() throws Exception{
		userVO1.setBackupQusetion("1+1은?");
		userVO1.setBackupAnswer("2");
		userVO1.setUserId("testId02");
		LOG.debug("UserVO: "+userDao.findPwByBackup(userVO1));
	}
	
	@Test
	public void beans() {
		LOG.debug("userDao"+userDao);
		
		assertNotNull(userDao);
	}
	

}
