package egovframework.example.sample.dao;



import static org.junit.Assert.assertEquals;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import egovframework.example.sample.vo.UserVo;

public class UserDaoTest {
	@Autowired
	private SqlSession session;
	
	@Autowired
	private UserDao userDao;
	
	@Test
	public void checkIdTest() {
		String testId = "id1";
		int rowCnt = userDao.checkId(testId);
		assertEquals(rowCnt, 1);
	}
	
	@Test
	public void selectUserTest() {
		Map<String, String> map = new HashMap<>();
		map.put("id", "id1");
		map.put("password", "password1");
		
		UserVo user = userDao.selectUser(map);
		assertEquals(user.getName(), "name");
	}

}
