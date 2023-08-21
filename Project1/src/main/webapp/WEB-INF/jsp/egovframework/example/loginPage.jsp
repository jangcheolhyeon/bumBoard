<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/user/userLoginPage.css"/>"/>
<link rel="stylesheet" href="<c:url value="/css/egovframework/common/common.css"/>"/>
</head>
<body>

	<div class="logo_container">
		<a href="<c:url value="/home.do"/>">
			<img src="<c:url value="/images/egovframework/example/bumil.png"/>" class="bumil_logo"/>
		</a>
	</div>

	<div class="form_div">
		<form action='<c:url value="/login.do"/>' method="post" class="form_container">
			<span class="form_header_label login_error_tag non_visible" id="error_tag">로그인 정보가 일치하지 않습니다.</span>
			<span class="form_header_label">ID</span> <input type="text" name="id" id="id" />
			<span class="form_header_label">PASSWORD</span> <input type="password" name="password" id="password" />
			<div class="form_buttons">
				<!-- <button type="button" id="homeBtn" class="loginBtn">홈으로</button> -->
				<button type="button" id="registerBtn" class="loginBtn">회원가입</button>
				<button type="submit" class="loginBtn">로그인</button>
			</div>
		</form>
	</div>
</body>
<script>
	const registerBtn = document.querySelector("#registerBtn");
	const errorMsg = "${param.msg}";
	
	
	registerBtn.addEventListener("click", () => {
		location.href = "<c:url value="/registerUser.do"/>";
	});
	
	document.querySelector("#homeBtn").addEventListener("click", () => {
		location.href = "<c:url value="/home.do"/>";
	});
	
	if(errorMsg == "error"){
		document.querySelector("#error_tag").classList.remove("non_visible");
	}
	
</script>
</html>