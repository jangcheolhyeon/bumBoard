package egovframework.example.sample.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.vo.UserVo;

@Repository
public class UserDao {
	@Autowired
	private SqlSession session;
	
	String namespace = "egovframework.sample.vo.UserVo.";
	
	public int checkId(String id) {
		return session.selectOne(namespace + "checkUser", id); 
	}
	
	public UserVo selectUser(Map<String, String> map) {
		return session.selectOne(namespace + "selectUser", map);
	}
	
	public int insertUser(UserVo userVo) {
		return session.insert(namespace + "insertUser", userVo);
	}
	
	public int deleteUser(UserVo userVo) {
		return session.delete(namespace + "deleteUser", userVo); 
	}
	
	public int updateUser(UserVo userVo) {
		return session.update(namespace + "updateUser", userVo);
	}
	
	
}
