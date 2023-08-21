package egovframework.example.sample.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.dao.BoardDao;
import egovframework.example.sample.dao.CommentDao;
import egovframework.example.sample.vo.BoardVo;
import egovframework.example.sample.vo.Pagination;

@Controller
public class BoardController {
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	CommentDao commentDao;
	
	@GetMapping("/board.do")
	public String board(HttpServletRequest request, Model m, Integer page, Integer pageSize, 
			@RequestParam(value = "condition", required = false) String condition, @RequestParam(value = "keyword", required = false) String keyword, 
			@RequestParam(value = "startDate", required = false) String startDate, @RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam(value = "hideNotice", defaultValue="false", required = false) boolean hideNotice,
			@RequestParam(value = "category", required = false, defaultValue="All" ) String category
			) {
		HttpSession session = request.getSession();
		if(!isLogin(session)) {
			return "redirect:/login.do";
		}
		
		System.out.println("hideNotice = " + hideNotice);
//		System.out.println("startDate = " + startDate);
//		System.out.println("endDate = " + endDate);
		System.out.println("category입니다. = " + category);
		
		if(startDate == null && endDate == null) {
			startDate = "2023-01-01";
			LocalDate now = LocalDate.now().plusDays(1);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			endDate = now.format(formatter);
		}
		
		if(startDate.equals("")) {
			startDate = "2023-01-01";
		} 
		if(endDate.equals("")) {
			LocalDate now = LocalDate.now().plusDays(1);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			endDate = now.format(formatter);
		}
		
//		System.out.println("startDate = " + startDate);
//		System.out.println("endDate = " + endDate);

		
		
		
		if(page == null) page = 1;
		if(pageSize == null) pageSize = 10;
		if(keyword == null || keyword.equals("")) keyword = "";
		if(condition == null) condition = "A";
		
//		System.out.println("keyword = " + keyword);
//		System.out.println("condition = " + condition);
//		System.out.println("keyword.equals('')" + keyword.equals(""));

		System.out.println("category kind = " + category);
		
		//검색조건이 있을 경우
		//금요일 category 추가
		if(!keyword.trim().equals("") || !category.equals("All")) {
			System.out.println("조건o");
			Map map1 = new HashMap();
			map1.put("condition", condition);
			map1.put("keyword", keyword);
			map1.put("startDate", startDate);
			map1.put("endDate", endDate);
			map1.put("hideNotice", hideNotice);
			map1.put("category", category);
			
			System.out.println("조건 o에서 pageNavi를 클릭했을때");
			System.out.println("condition = " + condition + ", keyword = " +keyword + ", pageSize = " + pageSize);
			
			int boardAllCnt = boardDao.searchBoardCnt(map1);
			Pagination pageInfo = new Pagination(boardAllCnt, page, pageSize, keyword, condition);
			m.addAttribute("pageInfo", pageInfo);
			System.out.println("pageInfo = " + pageInfo);
			
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("keyword", keyword);
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			map.put("hideNotice", hideNotice);
			map.put("category", category);
			List<BoardVo> list = boardDao.searchBoard(map);
			System.out.println(list);
			m.addAttribute("boardList", list);

			return "boardList";
		} else {
			System.out.println("조건x");
			Map map1 = new HashMap();
			map1.put("startDate", startDate);
			map1.put("endDate", endDate);
			map1.put("hideNotice", hideNotice);
			int boardAllCnt = boardDao.boardListAllCnt(map1);
			Pagination pageInfo = new Pagination(boardAllCnt, page, pageSize);
			m.addAttribute("pageInfo", pageInfo);			
			System.out.println("pageInfo = " + pageInfo);
			
			Map map = new HashMap();
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			map.put("hideNotice", hideNotice);
			List<BoardVo> list = boardDao.BoardList(map);
			System.out.println(list);
			m.addAttribute("boardList", list);
			
			return "boardList";
		}
		
		
//		Map<String, Integer> map = new HashMap<>();
//		map.put("offset", (page-1)*pageSize);
//		map.put("pageSize", pageSize);
//		List<BoardVo> list = boardDao.BoardList(map);
//		m.addAttribute("boardList", list);
		
//		return "boardList";
	}
	
	
	@GetMapping("/boardRead.do")
	public String boardRead(Model m, int bno, HttpServletRequest request, HttpServletResponse response) {
		BoardVo currentBoard = boardDao.getBoard(bno);
		
		//쿠키에다가 bno를 넘겨서 있으면 view_cnt를 올리지 않기
		Cookie[] cookies = request.getCookies();
		Cookie oldCookie = null;
		
		
		// boardView가 key인 값이 있으면 oldCookie에다가 쿠키값 넣어주기
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				
				if(cookie.getName().equals("boardView")) {
					oldCookie = cookie;
				}
			}
		} 
		
		//위에서 쿠키가 발견됐을 경우
		if(oldCookie != null) {
			if(!oldCookie.getValue().contains(bno + "")) {
				Map<String, Integer> map = new HashMap<>();
				map.put("viewCount", currentBoard.getView_cnt() + 1);
				map.put("bno", currentBoard.getBno());
				boardDao.increaseBoardViewCnt(map);
				
				oldCookie = new Cookie("boardView", bno + "");
				oldCookie.setMaxAge(60 * 2);
				response.addCookie(oldCookie);
			} 
		} else {
			Map<String, Integer> map = new HashMap<>();
			map.put("viewCount", currentBoard.getView_cnt() + 1);
			map.put("bno", currentBoard.getBno());
			boardDao.increaseBoardViewCnt(map);
			
			oldCookie = new Cookie("boardView", bno + "");
			oldCookie.setMaxAge(60 * 2);
			response.addCookie(oldCookie);
		}

		currentBoard = boardDao.getBoard(bno);
		m.addAttribute("board", currentBoard);
		
		return "board";
	}
	
	@GetMapping("/boardWrite.do")
	public String boardWriteForm() {
		
		return "board";
	}
	
	@PostMapping("/boardWrite.do")
	public String boardWrite(BoardVo boardVo, HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		boardVo.setWriter((String)session.getAttribute("id"));
		
		String fileName=null;
        MultipartFile uploadFile = boardVo.getUploadFile();
        if (!uploadFile.isEmpty()) {
            String originalFileName = uploadFile.getOriginalFilename();
            String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
            UUID uuid = UUID.randomUUID();	//UUID 구하기
            fileName=uuid+"."+ext;
            uploadFile.transferTo(new File("C:\\Users\\장철현\\eclipse-workspace\\Project1\\src\\main\\webapp\\upload\\" + fileName));
        }
        boardVo.setFile_name(fileName);		
		
		boardDao.insertBoard(boardVo);
		
		return "redirect:/board.do";
	}
	
	@GetMapping("/removeBoard.do")
	public String removeBoard(int bno, String fileUID, HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		BoardVo board = boardDao.getBoard(bno);
		if(!board.getWriter().equals(session.getAttribute("id"))) {
			request.setAttribute("msg", "삭제가 불가능합니다.");
			request.setAttribute("url", "/board.do");
			return "alert";
		}
		
		File file = new File("C:\\Users\\장철현\\eclipse-workspace\\Project1\\src\\main\\webapp\\upload\\" + fileUID );
		if(file.exists()) {
			file.delete();
		}
		
		boardDao.removeBoard(board);
		commentDao.deleteBoard(bno);
		
		request.setAttribute("msg", "삭제되었습니다.");
		request.setAttribute("url", "/board.do");
		return "alert";

	}
	
	@PostMapping("/modifyBoard.do")
	public String modifyBoard(BoardVo boardVo, int bno, String fileUID, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		
		boardVo.setBno(bno);
		boardVo.setWriter((String)session.getAttribute("id"));
		System.out.println("fileUID = " + fileUID);
		
		//기존 db에 이미지 파일이 있고 파일을 삭제한 경우
		//기존 db에 이미지 파일이 있고 파일을 교체한 경우
		
		BoardVo prevBoard = boardDao.getBoard(bno);
		
		//기존 db에 이미지 파일이 없다
		if(prevBoard.getFile_name() == null) {
			System.out.println("db에 이미지파일이름이 없다");
			if(boardVo.getUploadFile() != null) {
				System.out.println("첨부파일이 있다");
				
				String fileName=null;
				MultipartFile uploadFile = boardVo.getUploadFile();
				if (!uploadFile.isEmpty()) {
					String originalFileName = uploadFile.getOriginalFilename();
					String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
					UUID uuid = UUID.randomUUID();	//UUID 구하기
					fileName=uuid+"."+ext;
					uploadFile.transferTo(new File("C:\\Users\\장철현\\eclipse-workspace\\Project1\\src\\main\\webapp\\upload\\" + fileName));
				}
				boardVo.setFile_name(fileName);		
				
			}
	        
		} 
		
		//기존 db에 이미지 파일이 있음
		else {
			// 이미지업로드 했음
			if(boardVo.getUploadFile().getSize() != 0) {
				System.out.println("db에도 파일이 있고 첨부파일 있음");
				System.out.println("boardVo = " + boardVo);
				System.out.println("prevBoard = " + prevBoard);
				
				System.out.println("첨부파일의 유무? = " + boardVo.getFile_name());
				
					
				File file = new File("C:\\Users\\장철현\\eclipse-workspace\\Project1\\src\\main\\webapp\\upload\\" + fileUID );
				
				if(file.exists()) {
					file.delete();
				}
				
				
				
				String fileName=null;
				MultipartFile uploadFile = boardVo.getUploadFile();
				if (!uploadFile.isEmpty()) {
					String originalFileName = uploadFile.getOriginalFilename();
					String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
					UUID uuid = UUID.randomUUID();	//UUID 구하기
					fileName=uuid+"."+ext;
					uploadFile.transferTo(new File("C:\\Users\\장철현\\eclipse-workspace\\Project1\\src\\main\\webapp\\upload\\" + fileName));
				}
				
				boardVo.setFile_name(fileName);		
				

			} 
				
					
			
			//업로드 안했음
			else {
				System.out.println("디비에 파일이 있고 첨부파일 없음");
				System.out.println("input board = " + boardVo);
				System.out.println("prevBoard = " + prevBoard);
				
				boardVo.setFile_name(fileUID);
				
				
			}
			
		}
		

		System.out.println("수정할 boardVo = " + boardVo);
		
		boardDao.modifyBoard(boardVo);
		
		request.setAttribute("msg", "수정되었습니다.");
		request.setAttribute("url", "/board.do");
		return "alert";
	}
	
	//내가 쓴글
	@GetMapping("/myBoard.do")
	public String myBoard(HttpServletRequest request, Model m, Integer page, Integer pageSize, 
			@RequestParam(value = "condition", required = false) String condition, 
			@RequestParam(value = "keyword", required = false) String keyword) {
		if(page == null) page = 1;
		if(pageSize == null) pageSize = 10;
		if(keyword == null || keyword.equals("")) keyword = "";
		if(condition == null) condition = "A";
		
//		System.out.println("keyword = " + keyword);
//		System.out.println("condition = " + condition);
//		System.out.println("keyword.equals('')" + keyword.equals(""));

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		//검색조건이 있을 경우
		if(!keyword.trim().equals("")) {
			System.out.println("myBoard 조건o");
			Map<String, String> map1 = new HashMap<>();
			map1.put("condition", condition);
			map1.put("keyword", keyword);
			map1.put("id", id);
			
			System.out.println("조건 o에서 pageNavi를 클릭했을때");
			System.out.println("condition = " + condition + ", keyword = " +keyword);
			
			int boardAllCnt = boardDao.selectSearchMyBoardCnt(map1);
			System.out.println("boardAllCnt = " + boardAllCnt);
			Pagination pageInfo = new Pagination(boardAllCnt, page, pageSize, keyword, condition);
			m.addAttribute("pageInfo", pageInfo);
			System.out.println("pageInfo = " + pageInfo);
			
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("keyword", keyword);
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			map.put("id", id);
			List<BoardVo> list = boardDao.selectSearchMyBoardList(map);
			m.addAttribute("boardList", list);

			return "myBoard";
		} else {
			System.out.println("myboard조건x");

			int boardAllCnt = boardDao.selectMyBoardListAllCnt(id);
			Pagination pageInfo = new Pagination(boardAllCnt, page, pageSize);
			m.addAttribute("pageInfo", pageInfo);			
			System.out.println("pageInfo = " + pageInfo);
			
			Map map = new HashMap();
			map.put("offset", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			map.put("id", id);
			List<BoardVo> list = boardDao.selecMytBoardList(map);
			System.out.println(list);
			m.addAttribute("boardList", list);
			
			return "myBoard";
		}
		
	}
	

	
	private boolean isLogin(HttpSession session) {
		// TODO Auto-generated method stub
		if(session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
			return false;
		}
		
		return true;
	}

}
