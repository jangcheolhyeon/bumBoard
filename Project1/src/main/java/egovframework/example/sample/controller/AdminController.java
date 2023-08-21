package egovframework.example.sample.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.sample.dao.AdminDao;
import egovframework.example.sample.vo.AdminVo;
import egovframework.example.sample.vo.BoardVo;
import egovframework.example.sample.vo.Pagination;
import egovframework.example.sample.vo.UserVo;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminDao adminDao;
	
	
	@GetMapping("/login.do")
	public String AdminLogin(HttpServletRequest request) {
		
//		HttpSession session = request.getSession();
//		if(session.getAttribute("adminId") == null) {
//			
//			return "redirect:/admin/home.do";
//		}
		
		
		return "adminLoginPage";
	}
	
	@PostMapping("/login.do")
	public String AdminLoginCheck(HttpServletRequest request, String id, String password) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);
		
		AdminVo admin = adminDao.selectAdmin(map);
		if(admin == null) {
			return "redirect:/admin/login.do";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("adminId", id);
		
		return "redirect:/admin/home.do";
	}
	
	@GetMapping("/home.do")
	public String AdminHome(HttpServletRequest request, Model m, Integer pageSize, Integer page) {
		HttpSession session = request.getSession();
		if(session.getAttribute("adminId") == null) {
			
			return "redirect:/admin/login.do";
		}
		
		System.out.println(session.getAttribute("adminId"));
		
		if(pageSize == null) pageSize = 5;
		if(page == null) page = 1;
		
		Map<String, Integer> map = new HashMap<>();
		map.put("pageSize", pageSize);
		map.put("offset", (page-1) * pageSize);
		
		
		List<BoardVo> todayWriteBoard = adminDao.selectTodayWriteBoard(map);
		List<UserVo> todayRegisterUser = adminDao.selectTodayRegisterUser(map);
		List<BoardVo> highViewCntBoard = adminDao.selectHighViewCnt(map);
		List<UserVo> AllUserInfo = adminDao.selectAllUserInfo(map);
		
		
		m.addAttribute("todayBoard", todayWriteBoard);
		m.addAttribute("todayUser", todayRegisterUser);
		m.addAttribute("highViewCntBoard", highViewCntBoard);
		m.addAttribute("AllUserInfo", AllUserInfo);
		
//		System.out.println("todayUser = " + todayRegisterUser);
//		System.out.println("todayBoard = " + todayWriteBoard);
//		System.out.println("highViewCntBoard = " + highViewCntBoard);
//		System.out.println("AllUserInfo = " + AllUserInfo);
		
		
		return "adminHome";
	}
	
	@GetMapping("/user.do")
	public String adminUserManage(HttpServletRequest request, Model m, Integer page, Integer pageSize, @RequestParam(value = "condition", required = false) String condition, @RequestParam(value = "keyword", required = false) String keyword) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("adminId") == null) {
			
			return "redirect:/admin/home.do";
		}
		
		if(pageSize == null) pageSize = 10;
		if(page == null) page = 1;
		if(keyword == null || keyword.equals("")) keyword = "";
		if(condition == null) condition = "A";
		
		//검색조건이 있을 경우
		if(!keyword.trim().equals("")) {
			System.out.println("조건o");
			Map<String, String> map1 = new HashMap<>();
			map1.put("condition", condition);
			map1.put("keyword", keyword);
			
			System.out.println("조건 o에서 pageNavi를 클릭했을때");
			System.out.println("condition = " + condition + ", keyword = " +keyword);
			
//			int boardAllCnt = boardDao.searchBoardCnt(map1);
			int userSearchCnt = adminDao.selectSearchUserCnt(map1);
			Pagination pageInfo = new Pagination(userSearchCnt, page, pageSize, keyword, condition);
			m.addAttribute("pageInfo", pageInfo);
			System.out.println("pageInfo = " + pageInfo);
			
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("keyword", keyword);
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			List<UserVo> list = adminDao.selectSearchUserInfo(map);
			m.addAttribute("userList", list);
	
			return "userManagePage";
		} else {
			System.out.println("조건x");
//			int boardAllCnt = boardDao.boardListAllCnt();
			int userAllCnt = adminDao.selectAllUserCnt();
			Pagination pageInfo = new Pagination(userAllCnt, page, pageSize);
			m.addAttribute("pageInfo", pageInfo);			
			System.out.println("pageInfo = " + pageInfo);
			
			Map<String, Integer> map = new HashMap<>();
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			List<UserVo> list = adminDao.selectAllUserInfo(map);
			System.out.println("list = " + list);
			
			
			m.addAttribute("userList", list);
			
			return "userManagePage";
		}
		
	}
	
	
	@GetMapping("/board.do")
	public String adminBoardManage(HttpServletRequest request, Model m, Integer page, Integer pageSize, @RequestParam(value = "condition", required = false) String condition, @RequestParam(value = "keyword", required = false) String keyword) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("adminId") == null) {
			
			return "redirect:/admin/home.do";
		}
		
		if(pageSize == null) pageSize = 10;
		if(page == null) page = 1;
		if(keyword == null || keyword.equals("")) keyword = "";
		if(condition == null) condition = "A";
		
		//검색조건이 있을 경우
		if(!keyword.trim().equals("")) {
			System.out.println("조건o");
			Map<String, String> map1 = new HashMap<>();
			map1.put("condition", condition);
			map1.put("keyword", keyword);
			
			System.out.println("조건 o에서 pageNavi를 클릭했을때");
			System.out.println("condition = " + condition + ", keyword = " +keyword);
			
//					int boardAllCnt = boardDao.searchBoardCnt(map1);
			int searchBoardCnt = adminDao.searchBoardCnt(map1);
			Pagination pageInfo = new Pagination(searchBoardCnt, page, pageSize, keyword, condition);
			m.addAttribute("pageInfo", pageInfo);
			System.out.println("pageInfo = " + pageInfo);
			
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("keyword", keyword);
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			List<BoardVo> list = adminDao.searchBoard(map);
			m.addAttribute("boardList", list);
	
			return "boardManagePage";
		} else {
			System.out.println("조건x");
			int boardAllCnt = adminDao.selectAllBoardCnt();
			Pagination pageInfo = new Pagination(boardAllCnt, page, pageSize);
			m.addAttribute("pageInfo", pageInfo);			
			System.out.println("pageInfo = " + pageInfo);
			
			Map<String, Integer> map = new HashMap<>();
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			List<BoardVo> list = adminDao.selectAllBoard(map);
			System.out.println("list = " + list);
			
			
			m.addAttribute("boardList", list);
			
			return "boardManagePage";
		}
		
	}
	
	@GetMapping("/deleteBoard.do")
	public String deleteBoard(HttpServletRequest request, int bno) {
		adminDao.deleteBoard(bno);				
		
		request.setAttribute("msg", "삭제되었습니다.");
		request.setAttribute("url", "/admin/board.do");
		return "alert";
	}
	
	
	
	@GetMapping("/deleteUser.do")
	public String deleteUser(HttpServletRequest request, String userId) {
		adminDao.deleteUser(userId);
		System.out.println(userId);
		
		request.setAttribute("msg", "삭제되었습니다.");
		request.setAttribute("url", "/admin/user.do");
		return "alert";
	}
	
	@GetMapping("/updateUser.do")
	public String updateUser(Model m, String userId) {
		System.out.println("userId = " + userId);
		UserVo user = adminDao.selectUserInfo(userId);
		m.addAttribute("user", user);
		
		return "updateUserAdminPage";
	}
	
	@PostMapping("/updateUser.do")
	public String completeUpdateUser(UserVo user, HttpServletRequest request) {
		adminDao.updateUserInfo(user);
		
		request.setAttribute("msg", "수정되었습니다.");
		request.setAttribute("url", "/admin/user.do");
		
		return "alert";
	}
	
	@GetMapping("/readBoard.do")
	public String adminReadBoard(Integer bno, Model m) {
		BoardVo board = adminDao.selectBoard(bno);
		m.addAttribute("board", board);
		
		return "readBoardAdminPage";
	}
	
	
	@GetMapping("/logout.do")
	public String adminLogout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
			
		return "redirect:/home.do";
	}
	
	
	@GetMapping("/writeBoard.do")
	public String adminWriteBoard() {
		
		
		return "adminWriteBoard";
	}
	
	@PostMapping("/writeBoard.do")
	public String adminWirteBoardPost(String title, String content, HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<>();
		map.put("title", title);
		map.put("content", content);
		
		adminDao.insertBoard(map);
		request.setAttribute("msg", "작성되었습니다.");
		request.setAttribute("url", "/admin/board.do");
		return "alert";
	}
	
	@PostMapping("/updateBoard.do")
	public String updateBoard(BoardVo board, int bno, HttpServletRequest request) {
		System.out.println(board.toString());
		board.setBno(bno);
		//관리자 글 수정

		adminDao.updateBoard(board);

		
		request.setAttribute("msg", "수정되었습니다.");
		request.setAttribute("url", "/admin/board.do");
		return "alert";
	}
	

	
	
}
