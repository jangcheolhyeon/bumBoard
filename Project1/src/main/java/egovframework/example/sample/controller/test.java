package egovframework.example.sample.controller;

import java.util.HashMap;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.example.sample.vo.AdminVo;

@Controller
public class test{
	
	@GetMapping("/viewChart.do")
	public String viewChart() {
		
		
		return "chart";
	}
	
	
	@GetMapping("/objTest.do")
	@ResponseBody
	public String getAjax(AdminVo adminVo) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		String adminJson = objectMapper.writeValueAsString(adminVo);
		System.out.println("adminVo : " + adminVo);
		System.out.println("adminJson : " + adminJson);
		return adminJson;
	}
	
	
	
	
	@PostMapping(value = "/postTest.do")
	@ResponseBody 
	public String postAjax(@RequestBody AdminVo adminVo) throws Exception{
		System.out.println("json");
		System.out.println(adminVo.toString());
		
		ObjectMapper objectMapper = new ObjectMapper();
		String adminJson = objectMapper.writeValueAsString(adminVo);
		System.out.println("adminVo : " + adminVo);
		System.out.println("adminJson : " + adminJson);
		
		return adminJson;
	}
	
	
	
	@GetMapping("/testtest.do")
	@ResponseBody
	public String getAjax(String words) {
		
		return words + " hi";
	}
	
	
	
	@GetMapping("/testPage.do")
	public String testPage() {
		
		
		return "test";
	}
	
	
	
	@GetMapping("/getJsonPlace/{number}.do")
	@ResponseBody
	public String getJsonPlaceHolder(@PathVariable(value="number", required = false) int number ) throws Exception{
        System.out.println("number : " + number);
		HashMap<String, Object> result = new HashMap<String, Object>();
        String url = "https://jsonplaceholder.typicode.com/todos" + "/" + number;
        String jsonInString = "";

       
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url).build();

        ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.GET, entity, Object.class);

        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
        ObjectMapper mapper = new ObjectMapper();
        jsonInString = mapper.writeValueAsString(resultMap.getBody());
                  
        System.out.println("jsonString = " + jsonInString);
        return jsonInString;
	}
	
	
}
