package egovframework.example.sample.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.dao.CommentDao;
import egovframework.example.sample.vo.CommentVo;

@Controller
public class CommentController {
	@Autowired
	private CommentDao commentDao;

	
	
	@ResponseBody
	@GetMapping("/comments/{bno}.do")
	public ResponseEntity<List<CommentVo>> getCommentList(@PathVariable Integer bno){
		List<CommentVo> list = null;
		System.out.println("pathVariable bno : " + bno);
		try {
			list = commentDao.getCommentList(bno);
			System.out.println("list : " + list);
			return new ResponseEntity<List<CommentVo>>(list, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<CommentVo>>(HttpStatus.BAD_REQUEST);
		}
		
	}
	
	
	@ResponseBody
	@PostMapping("/comments.do")
	public ResponseEntity<String> writeComment(@RequestBody CommentVo commentVo){
		System.out.println("commentVo : " + commentVo);
		try {
			int result = commentDao.writeComment(commentVo);
			
			if(result == 1) {
				return new ResponseEntity<>("ok", HttpStatus.OK);
			} else {
				return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
	}
	
	@ResponseBody
	@DeleteMapping("/comments/{cno}.do")
	public ResponseEntity<String> deleteComment(@PathVariable Integer cno){
		System.out.println("cno : " + cno);
		
		try {
			int result = commentDao.deleteComment(cno);
			
			if(result == 1) {
				return new ResponseEntity<>("OK", HttpStatus.OK);
			} else {
				return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);			
		}
			
	}
	
	
	@ResponseBody
	@PutMapping("/comments/{cno}.do")
	public ResponseEntity<String> updateComment(@PathVariable Integer cno, @RequestBody CommentVo commentVo, HttpServletRequest request){
		System.out.println(commentVo);
		System.out.println("put exe");
		
		HttpSession session = request.getSession();
		String currentUser = (String) session.getAttribute("id");
		Map map = new HashMap();
		
		try {
			
			map.put("comment", commentVo.getComment());
			map.put("cno", cno);
			map.put("currentUser", currentUser);
			
			commentDao.updateComment(map);
			
			return new ResponseEntity<>("OK", HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
	}

	
	
}
