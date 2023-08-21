package egovframework.example.sample.controller;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SpringBeanCheck {
	private ApplicationContext applicationContext;
	
	public SpringBeanCheck(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}
	
	
	@GetMapping("/beanCheck.do")
	public void contextLoads() throws Exception {
		if(applicationContext != null) {
			String[] beans = applicationContext.getBeanDefinitionNames();
		
			for(String bean : beans) {
				System.out.println("bean : " + bean);
			}
		}
	}
	
}
