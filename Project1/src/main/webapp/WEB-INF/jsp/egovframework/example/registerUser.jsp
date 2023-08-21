<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/user/registerUser.css'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/common/common.css'/>"/>
</head>
<body>
	<!-- 
	<form id="form" >
		id : <input type="text" name="id" id="idInput"/> <br>
		<button type="button" id="duplicationBtn" onClick="id_check();">중복검사</button> <br>
		<input type="hidden" id="idCheckValue" value="idCheckFalse"/>
		password : <input type="password" name="password" id="password"/> <br>
		checkPassword : <input type="password" id="checkPassword"/> <br>
		name : <input type="text" name="name" id="name"/> <br>
		email : <input type="text" name="email" id="email"/> <br>
		phone : <input type="text" name="phone" id="phoneNumber" maxlength="13"/> <br>
		<button type="button" id="registerBtn">회원가입</button>
	</form>

	<button id="homeBtn">홈으로</button>
	
	-->
	
	<div class="logo_container">
		<a href="<c:url value="/home.do"/>">
			<img src="<c:url value="/images/egovframework/example/bumil.png"/>" class="bumil_logo"/>
		</a>
	</div>
	
	
	<div class="main_div">
	
		<div class="admin_nav">
			<ul>
				<li class="nav_category"><a href="<c:url value="/login.do"/>" >로그인</a></li>
			</ul>
		</div>
		

		<div class="main_board_content">
		
			<form id="form" class="update_form">
				<span class="form_header_label">ID</span> <input type="text" name="id" id="idInput" value="<c:out value="${user.getId()}"/>" /><br>
				<button type="button" id="duplicationBtn" onClick="id_check();" class="duplicationBtn">중복검사</button> <br>
				<span class="form_header_label">PASSWORD</span> <input type="password" name="password" id="password" /><br>
				<span class="form_header_label">CHECK PASSWORD</span> <input type="password" id="checkPassword"/> <br>
				<span class="form_header_label">NAME</span> <input type="text" name="name" id="name" /><br>
				<span class="form_header_label">EMAIL</span> <input type="text" name="email" id="email" /><br>
				<span class="form_header_label">PHONE</span> <input type="text" name="phone" id="phoneNumber" maxlength="13"/><br>
				<div class="form_buttons">
					<button type="button" class="registerBtn" id="registerBtn">회원가입</button>
				</div>
			</form>
			
		</div>
	
	</div>
	
	
	
	
</body>
<script type="text/javascript">
	const idCheck = document.querySelector("#idCheckValue");
	const idInput = document.querySelector("#idInput");
	const form = document.querySelector("#form");
	const registerBtn = document.querySelector("#registerBtn");
	const password = document.querySelector("#password");
	const checkPassword = document.querySelector("#checkPassword");
	const name = document.querySelector("#name");
	const email = document.querySelector("#email");
	const phoneNumber = document.querySelector("#phoneNumber");
	
	
	//regExp
    // id, pw
    const regIdPw = /^[a-zA-Z0-9]{4,12}$/;
    // 이름
    const regName = /^[가-힣a-zA-Z]{2,15}$/;
    // 이메일
  	const regMail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	// 휴대폰
	const regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	
	
	function id_check(){
		const id = document.querySelector("#idInput");
		
		const result = 0;
		if(id.value == "" || id.value.length == 0){
			alert("아이디를 입력해주세요.");
			id.focus();
		} else if(!regIdPw.test(id.value)){
			alert("4~12자 영문 대소문자, 숫자만 입력하세요.");
		} 
		else{	
			window.open("${pageContext.request.contextPath}/loginCheck.do?user_id="+id.value, "", "width=500, height=300");
		}
			
	}
	
	const submitForm = (e) => {
		console.log("submitForm");
		const duplicationBtn = document.querySelector("#duplicationBtn").disabled;
		if(!duplicationBtn){
			alert("id 중복검사 해주세요");
		} else if(password.value == "" || !regIdPw.test(password.value) ){
			alert("비밀번호는 4~12자 영문 대소문자, 숫자만 입력하세요");
			password.focus();
		} else if(password.value !== checkPassword.value){
			alert("비밀번호가 동일하지 않습니다.");
			checkPassword.focus();
		} else if(name.value == "" || !regName.test(name.value)){
			alert("최소 2글자 이상, 한글과 영어만 입력하세요.")
            name.focus();
		} else if(email.value == "" || !regMail.test(email.value)){
			alert("잘못된 이메일 형식입니다.")
            email.focus();
		} else if(phoneNumber.value == "" || !regPhone.test(phoneNumber.value)){
			alert("전화번호를 확인해주세요");
			phoneNumber.focus();
		}
			
			
		else{
			console.log("else");
			form.action = '<c:url value="/regiserSuccess.do"/>';
			form.method = "POST";
			form.submit();
		}
	}
	
	phoneNumber.addEventListener("keyup", () => {
		phoneNumber.value = phoneNumber.value.replace(/[^0-9]/g, '')
		   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	})
	
	
	idInput.addEventListener("keydown", () => {
		const duplicationBtn = document.querySelector("#duplicationBtn").disabled = false;
	});
	
	registerBtn.addEventListener("click", submitForm);
	
	
	document.querySelectorAll(".nav_category").forEach((element) => {
		element.addEventListener("mouseenter", (e) => {
			e.currentTarget.classList.add("nav-active");
		})
		
		element.addEventListener("mouseenter", () => {console.log(element.querySelector("a").href)});
		
		element.addEventListener("click", () => {
			location.href = element.querySelector("a").href;
		})
		
		element.addEventListener("mouseleave", (e) => {
			e.currentTarget.classList.remove("nav-active");
		})
	})
	
	
	
</script>
</html>