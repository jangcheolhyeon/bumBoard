<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="form-group email-form">
	 <label for="email">이메일</label>
	 <div class="input-group">
	<input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" >
	<select class="form-control" name="userEmail2" id="userEmail2" >
	<option>@naver.com</option>
	<option>@daum.net</option>
	<option>@gmail.com</option>
	<option>@hanmail.com</option>
	 <option>@yahoo.co.kr</option>
	</select>
	</div>   
	<div class="input-group-addon">
		<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
	</div>
		<div class="mail-check-box">
	<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
	</div>
		<span id="mail-check-warn"></span>
	</div>
</body>

<script>

	let codeNum = 0;

	document.querySelector("#mail-Check-Btn").addEventListener("click", () => {
		const email = document.querySelector("#userEmail1").value + document.querySelector("#userEmail2").value;
		console.log("완성된 이메일 = " + email);
		
		
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value="/getMailCode.do?email="/>" + email);
		xhr.send();
		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log(xhr.response);
/* 				codeNum = xhr.response;
				document.querySelector(".mail-check-input").disabled = false;
				checkCode(); */
			} else{
				console.log("error");
			}
		}
		
	})
	
	
	
	const checkCode = () => {
		let writeCode = document.querySelector(".mail-check-input").value;
		let warnTag = document.querySelector("#mail-check-warn");
		
		if(writeCode == codeNum){
			warnTag.innerHTML = "인증이 완료되었습니다.";
		} else{
			warnTag.innerHTML = "인증이 잘못되었습니다."
		}
	}
	
	
	
	
	
</script>
</html>