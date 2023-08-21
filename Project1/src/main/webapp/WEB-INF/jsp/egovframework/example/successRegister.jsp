<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>범일</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/user/successRegister.css'/>"/>
</head>
<body>

	<div class="logo_container">
		<a href="<c:url value="/home.do"/>">
			<img src="<c:url value="/images/egovframework/example/bumil.png"/>" class="bumil_logo"/>
		</a>
	</div>


	<div class="main_div">
		
		<h1 class="registerSuccess">축하합니다 회원가입 되었습니다.</h1>
		<button type="button" class="login_btn">로그인</button>
	</div>
</body>

<script>
	document.querySelector(".login_btn").addEventListener("click", () => {
		location.href = "<c:url value='/login.do'/>";
	})
</script>
</html>