package egovframework.example.sample.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.MailSendService;

@Controller
public class MailController {
	@Autowired
	MailSendService mailSendService;

	
	@GetMapping("/mailTest.do")
	public String testMail() {
		return "mailTest";
	}
	
	
	@GetMapping("/getMailCode.do")
	@ResponseBody
	public String mailCode(String email) {
		System.out.println("email = " + email);
		System.out.println("joinEmail return = " + mailSendService.joinEmail(email));
		
		return mailSendService.joinEmail(email);
	}
}
