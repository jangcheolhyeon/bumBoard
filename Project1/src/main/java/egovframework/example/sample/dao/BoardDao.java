package egovframework.example.sample.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.vo.BoardVo;

@Repository
public class BoardDao {
	@Autowired
	private SqlSession session;
	
	String namespace = "egovframework.sample.vo.BoardVo.";
	
	public void insertBoard(BoardVo boardVo) {
		session.insert(namespace + "insertBoard", boardVo);  
	}
	
	public List<BoardVo> BoardList(Map map){
		return session.selectList(namespace + "selectBoardList", map);
	}
	
	public BoardVo getBoard(int bno) {
		return session.selectOne(namespace + "selectBoard", bno);
	}
	
	public int removeBoard(BoardVo boardVo) {
		return session.delete(namespace + "deleteBoard", boardVo);
	}
	
	public int modifyBoard(BoardVo boardVo) {
		return session.update(namespace + "modifyBoard", boardVo);
	}
	
	public int increaseBoardViewCnt(Map map) {
		return session.update(namespace + "updateBoardViewCnt", map);
	}
	
	public int boardListAllCnt(Map map) {
		return session.selectOne(namespace + "BoardListAllCnt", map);
	}
	
	
	public List<BoardVo> searchBoard(Map map){
		return session.selectList(namespace + "searchBoard", map);
	}
	
	public int searchBoardCnt(Map map) {
		return session.selectOne(namespace + "searchBoardCnt", map);
	}	
	
	public List<BoardVo> selecMytBoardList(Map map){
		return session.selectList(namespace + "selecMytBoardList", map);
	}
	
	public int selectMyBoardListAllCnt(String id) {
		return session.selectOne(namespace + "selectMyBoardListAllCnt", id);
	}
	
	public List<BoardVo> selectSearchMyBoardList(Map map){
		return session.selectList(namespace + "selectSearchMyBoardList", map);
	}
	
	public int selectSearchMyBoardCnt(Map map) {
		return session.selectOne(namespace + "selectSearchMyBoardCnt", map);
	}
	
	
	
}
