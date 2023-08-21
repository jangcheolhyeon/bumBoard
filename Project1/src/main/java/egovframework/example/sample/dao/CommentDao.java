package egovframework.example.sample.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.vo.CommentVo;

@Repository
public class CommentDao {
	@Autowired
	SqlSession session;
	
	String namespace = "egovframework.sample.vo.CommentVo.";
	
	public List<CommentVo> getCommentList(Integer bno){
		return session.selectList(namespace + "getCommentList", bno);
	}
	
	public CommentVo getComment(Integer cno) {
		return session.selectOne(namespace + "getComment", cno);
	}
	
	public int writeComment(CommentVo commentVo) {
		return session.insert(namespace + "writeComment", commentVo);
	}
	
	public int deleteComment(Integer cno) {
		return session.delete(namespace + "deleteComment", cno);
	}
	
	public int updateComment(Map map) {
		return session.update(namespace + "updateComment", map);
	}

	public int deleteBoard(Integer bno) {
		return session.delete(namespace + "deleteBoardInComments", bno);
	}
	
	
	
}
