<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="loginOut" value="${sessionScope.id == null || sessionScope.id == '' ? '로그인' : '로그아웃'}"/>
<c:set var="loginOutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login.do' : '/logout.do'}"/>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/user/myPage.css"/>"/>
<link rel="stylesheet" href="<c:url value="/css/egovframework/common/common.css"/>"/>
</head>
<body>
<!-- 
	<nav>
		<ul className="li_container">
			<li className="li_home" id="home_btn"><a href="<c:url value="/home.do"/>">HOME</a></li>
			<li className="li_board" id="board_btn"><a href="<c:url value="/board.do"/>">BOARD</a></li>
			<li className="li_login" id="login_btn"><a href="<c:url value="${loginOutURL}"/>">${loginOut}</a></li>
			<c:if test="${not empty sessionScope.id}">
				<li className="li_login" id="mypage_btn"><a href="<c:url value="/myPage.do" />">mypage</a></li>			
			</c:if>
		</ul>
	</nav>
	
	-->
	<div class="logo_container">
		<a href="<c:url value="/home.do"/>">
			<img src="<c:url value="/images/egovframework/example/bumil.png"/>" class="bumil_logo"/>
		</a>
	</div>
	
	<div class="my_nav">
		<span id="cookieTimer">60분 00초</span>
		<span><img src="<c:url value="/images/egovframework/example/reload.png"/>" class="reload_img" id="resetBtn"/></span>
		<span class="current_user_welcome"><span class="current_user_name">${sessionScope.id}</span>님 환영합니다.</span>
		<button type="button" id="logoutBtn" class="logout_btn">로그아웃</button>
	</div>
	
	<div class="main_div">
	
		<div class="admin_nav">
			<ul>
				<li class="nav_category"><a href="<c:url value="/board.do"/>">게시판</a></li>
			</ul>
		</div>
		
		<div class="main_board_parent">
			
			<div class="main_container">
				<h1>비밀번호를 한번 더 입력해주세요</h1>
				<form id="form" class="form_container">
					<input type="hidden" id="id" name="id"/>
					<input type="password" id="password" name="password" class="check_password_form" />
					<button type="button" id="checkBtn" class="checkBtn">확인</button>
				</form>
				<h4 id="passwordError" class="passwordErrorTag" >비밀번호가 일치하지 않습니다</h4>
			</div>
			
		</div>
	</div>
	
	
</body>
<script>
	const checkBtn = document.querySelector("#checkBtn");
	const form = document.querySelector("#form");
	const passwordError = document.querySelector("#passwordError");
	const error = "${error}";
	console.log("error = " + error);
	
	const checkUser = () => {
		const password = document.querySelector("#password");
		if(password.value.length == 0 || password.value == ""){
			alert("패스워드를 입력해주세요");
		} else{
			form.method = "POST";
			form.action = "<c:url value="/isUserPassword.do"/>";
			form.submit();
		}
	}
	
	if(error == "wrong"){
		passwordError.classList.remove("passwordErrorTag");
	}
	
	checkBtn.addEventListener("click", checkUser);
	
	
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
	
	
	let totalTime = 3599;
	let min = 0;
	let sec = 0;
	let timer;
	
	const timerFun = () => {
		timer = setInterval(() => {
			min = parseInt(totalTime / 60);
			sec = totalTime % 60;
			
			sec = sec < 10 ? "0"+sec : sec;
			document.querySelector("#cookieTimer").innerHTML = min + "분 " + sec + "초";
			totalTime--;
			
			if(totalTime < 0 ){
				clearInterval(timer);
			}
			
		}, 1000)
	}
	timerFun();
	
	document.querySelector("#resetBtn").addEventListener("click", () => {
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value="/cookieReset.do"/>");
		xhr.send();
	
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log("성공");
				if(xhr.response == "reset"){
					console.log("리셋");
					totalTime = 3599;
					clearInterval(timer);
					document.querySelector("#cookieTimer").innerHTML = "60분 00초";
					timerFun();
				}
				
			} else {
				console.log("실패");
			}
		}
		
	})
	
		document.querySelector("#logoutBtn").addEventListener("click", () => {
		location.href = "<c:url value="/logout.do"/>";
	})
	
	
</script>
</html>