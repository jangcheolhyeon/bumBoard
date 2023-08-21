package egovframework.example.sample.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.dao.UserDao;
import egovframework.example.sample.vo.UserVo;

@Controller
public class TestController {
	@Autowired
	private UserDao userDao;

	@GetMapping("/home.do")
	public String home(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				System.out.println("cookieName : " + cookie.getName());
				System.out.println("cookieValue : " + cookie.getValue());
			}
		}
		
		
		return "home";
	}
	
	@GetMapping("/login.do")
	public String login() {
		
		
		return "loginPage";
	}
	
	
	@PostMapping("/login.do")
	public String checkLogin(String id, String password, Model m, HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("password", password);
		
		UserVo user = userDao.selectUser(map);
		
		if(user == null) {
			m.addAttribute("errorMsg", "error1");
			
			return "redirect:/login.do?msg=error";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("id", user.getId());
		
		Cookie cookie = new Cookie("id", user.getId());
		cookie.setMaxAge(60 * 60);
		response.addCookie(cookie);
		
		
		return "home";
	}
	
	@ResponseBody
	@GetMapping("/cookieReset.do")
	public String cookieReset(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("id");
		session.setAttribute("id", userId);

		Cookie cookie = new Cookie("id", userId);
		cookie.setMaxAge(60 * 60);
		response.addCookie(cookie);
		
		return "reset";
	}
	
	@GetMapping("/logout.do")
	public String Logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
//		Cookie cookie = new Cookie("id", null);
//		cookie.setMaxAge(0);
//		response.addCookie(cookie);
//		
//		cookie = new Cookie("boardView", null);
//		cookie.setMaxAge(0);
//		response.addCookie(cookie);
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}
		
		
		return "redirect:/home.do";
	}
	
	
	@GetMapping("/loginCheck.do")
	public String loginCheck(String user_id, HttpServletRequest request) {
		System.out.println("logincheck.do");
		int rowCnt = userDao.checkId(user_id);
		HttpSession session = request.getSession();
		System.out.println("rowcnt : " + rowCnt);
		if(rowCnt == 1) {
			session.setAttribute("result", 1);
		} else {
			session.setAttribute("result", 0);
		}
		
		return "duplication";
	}
	
	
	@GetMapping("/registerUser.do")
	public String registerUser(){
		
		
		return "registerUser";
	}
	
	
	@PostMapping("/regiserSuccess.do")
	public String registerOk(UserVo user) {
		System.out.println(user.toString());
		int rowCnt = userDao.insertUser(user);
		
		return "successRegister";
	}
	
	
	@GetMapping("/myPage.do")
	public String myPage(@RequestParam(value = "error", defaultValue="false") String error, Model m) {
		m.addAttribute("error", error);
		
		return "myPage";
	}
	
	
	@PostMapping("/isUserPassword.do")
	public String isUserPassword(String password, HttpServletRequest request, Model m) {
		HttpSession session = request.getSession();
		
		Map<String, String> map = new HashMap<>();
		map.put("id", (String)session.getAttribute("id"));
		map.put("password", password);
		
		UserVo user = userDao.selectUser(map);
		System.out.println("user = " + user);
		if(user == null) {
			return "redirect:/myPage.do?error=wrong";
		}
		
		m.addAttribute("user", user);
		
		return "myInfoPage";
	}
	
	@PostMapping("/updateMyInfo.do")
	public String updateMyInfo(HttpServletRequest request, UserVo user) {
		System.out.println("user = " + user);
		
		int rowCnt = userDao.updateUser(user);
		if(rowCnt == 0) {
			request.setAttribute("msg", "수정실패.");
			request.setAttribute("url", "/home.do");
			return "alert";
		} else {
			request.setAttribute("msg", "수정되었습니다.");
			request.setAttribute("url", "/home.do");
			return "alert";			
		}
	}
	
	
}
