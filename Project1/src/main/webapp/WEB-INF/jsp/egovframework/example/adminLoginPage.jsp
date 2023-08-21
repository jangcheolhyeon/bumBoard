<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/admin/adminLoginPage.css"/>"/>
</head>
<body>
	<div class="form_div">
		<form id="form" action="<c:url value="/admin/login.do"/>" method="post" class="form_container">
			<span class="form_header_label">ID</span> <input type="text" name="id" id="id" />
			<span class="form_header_label">PASSWORD</span> <input type="password" name="password" id="password" />
			<div class="form_buttons">
				<button type="submit" class="loginBtn">로그인</button>
			</div>
		</form>	
	</div>
	
</body>
</html>