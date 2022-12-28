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
import com.pcwk.ehr.user.domain.UserSearchVO;
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
	
	UserSearchVO searchVO;
	
	@Before
	public void setUp(){ 
		
		
		userVO1 = new UserVO("rlaehdwn60_1", "rlaehdwn60_1", "password", "김동주");
		userVO2 = new UserVO("rlaehdwn60_2", "rlaehdwn60_2", "password", "김동주");
		userVO3 = new UserVO("rlaehdwn60_3", "rlaehdwn60_3", "password", "김동주");
	
		searchVO = new UserSearchVO(10, 1, "20", "rla", "20");
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
		UserVO userVOkk = new UserVO("rlaehdwn60", "rlaehdwn60_U", "save418", "김동_U");
		userVOkk.setmSeq(1000041);
		userDao.doUpdate(userVOkk);
	}
	
	@Test
	@Ignore
	public void doDelete() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userVO1.setmSeq(1000021);
		userDao.doDelete(userVO1);
	}
	
	@Test
	@Ignore
	public void doSelectOne() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userVO1.setmSeq(1000041);
		UserVO outVO = userDao.doSelectOne(userVO1);
		System.out.println(outVO);
	}
	
	@Test
	@Ignore
	public void doRetrieve() throws Exception{
		List<UserVO> list = userDao.doRetrieve(searchVO);
		
		LOG.debug("list: "+list);
	}
	
	@Test
	@Ignore
	public void idCheck() throws Exception{
		LOG.debug("flag: "+userDao.idCheck(userVO1));
	}
	
	@Test
	@Ignore
	public void nicknameCheck() throws Exception{
		userDao.doSave(userVO1);
		LOG.debug("flag: "+userDao.nicknameCheck(userVO1));
	}
	
	@Test
	@Ignore
	public void passwordCheck() throws Exception{
		LOG.debug("userVO1: "+userVO1);
		userDao.doSave(userVO1);
		LOG.debug("flag: "+userDao.passwordCheck(userVO1));
	}
	
	@Test
	@Ignore
	public void findIdByEmail() throws Exception{
		userVO1.setEmail("5n044@naver.com");
		LOG.debug("KKKKKKKKKKKKKKK:"+userDao.findIdByEmail(userVO1));
	}
	
	@Test
	@Ignore
	public void findIdByNameBirth() throws Exception{
		userVO1.setBirth("19300101");
		userVO1.setName("김동주");
		LOG.debug("userVO: "+userDao.findIdByNameBirth(userVO1));
	}
	
	@Test
	@Ignore
	public void findPwByBackup() throws Exception{
		userVO1.setBackupQuestion("1+1은?");
		userVO1.setBackupAnswer("2");
		userVO1.setUserId("testId02");
		LOG.debug("UserVO: "+userDao.findPwByBackup(userVO1));
	}
	
	@Test
	@Ignore
	public void updateThings() throws Exception{
		userVO1.setmSeq(1000225);
		userVO1.setNickname("떼잉");
		userVO1.setEmail("떼잉");
		userVO1.setUserPw("떼잉");
		userDao.updateNickname(userVO1);
		userDao.updateEmail(userVO1);
		userDao.updatePassword(userVO1);
	}
	
	@Test
	public void loginPostPointAdd() throws Exception{
		userVO1.setmSeq(3333);
		userDao.loginAddPoint(userVO1);
		LOG.debug("point: "+userVO1.getPoint());
		userDao.postAddPoint(userVO1);
		LOG.debug("point: "+userVO1.getPoint());
	}
	
	@Test
	public void beans() {
		LOG.debug("userDao"+userDao);
		
		assertNotNull(userDao);
	}
	

}
