package egovframework.example.sample.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.vo.AdminVo;
import egovframework.example.sample.vo.BoardVo;
import egovframework.example.sample.vo.UserVo;

@Repository
public class AdminDao {
	@Autowired
	private SqlSession session;
	
	String namespace = "egovframework.example.sample.vo.AdminVo.";
	
	public AdminVo selectAdmin(Map map) {
		return session.selectOne(namespace + "selectAdmin", map);
	}
		
	public List<BoardVo> selectTodayWriteBoard(Map map){
		return session.selectList(namespace + "selectTodayWriteBoard", map);
	}
	
	public List<UserVo> selectTodayRegisterUser(Map map){
		return session.selectList(namespace + "selectTodayRegisterUser", map);
	}
	
	public List<BoardVo> selectHighViewCnt(Map map){
		return session.selectList(namespace + "selectHighViewCnt", map);
	}
	
	public List<UserVo> selectAllUserInfo(Map map){
		return session.selectList(namespace + "selectAllUserInfo", map);
	}
	
	public int selectAllUserCnt() {
		return session.selectOne(namespace + "selectAllUserCnt");
	}
	
	public List<UserVo> selectSearchUserInfo(Map map){
		return session.selectList(namespace + "searchUser", map);
	}
	
	public int selectSearchUserCnt(Map map) {
		return session.selectOne(namespace + "searchUserCnt", map);
	}
	
	public int deleteUser(String userId) {
		return session.delete(namespace + "deleteUser", userId);
	}
	
	
	
	public List<BoardVo> selectAllBoard(Map map){
		return session.selectList(namespace + "selectAllBoard", map);
	}
	
	public int selectAllBoardCnt(){
		return session.selectOne(namespace + "selectAllBoardCnt");
	}
	
	public List<BoardVo> searchBoard(Map map){
		return session.selectList(namespace + "searchBoard", map);
	}
	
	public int searchBoardCnt(Map map) {
		return session.selectOne(namespace + "searchBoardCnt", map);
	}
	
	
	public int deleteBoard(int bno) {
		return session.delete(namespace + "deleteBoard", bno);
	}
	
	public UserVo selectUserInfo(String id) {
		return session.selectOne(namespace + "selectUserInfo", id);
	}
	
	public int updateUserInfo(UserVo userData) {
		return session.update(namespace + "updateUserInfo", userData);
	}
	
	public BoardVo selectBoard(int bno) {
		return session.selectOne(namespace + "selectBoard", bno);
	}
	
	public int insertBoard(Map map) {
		return session.insert(namespace + "insertBoard", map);
	}
	
	public int updateBoard(BoardVo board) {
		return session.update(namespace + "updateBoard", board);
	}
	

	
}
