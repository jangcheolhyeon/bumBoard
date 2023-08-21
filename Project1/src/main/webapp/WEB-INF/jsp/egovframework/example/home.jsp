<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginOut" value="${sessionScope.id == null || sessionScope.id == '' ? 'LOGIN' : 'LOGOUT'}"/>
<c:set var="loginOutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login.do' : '/logout.do'}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>범일</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/user/home.css'/>"/>
<link rel="stylesheet" href="<c:url value="/css/egovframework/common/common.css"/>"/>
</head>
<body>
	<div class="logo_container">
		<a href="<c:url value="/home.do"/>">
			<img src="<c:url value="/images/egovframework/example/bumil.png"/>" class="bumil_logo"/>
		</a>
	</div>
	
	<c:if test="${not empty sessionScope.id}">
		<div class="my_nav">
			<span id="cookieTimer">60분 00초</span>
			<span><img src="<c:url value="/images/egovframework/example/reload.png"/>" class="reload_img" id="resetBtn"/></span>
			<span class="current_user_welcome"><span class="current_user_name">${sessionScope.id}</span>님 환영합니다.</span>
			<button type="button" id="logoutBtn" class="logout_btn">로그아웃</button>
		</div>
	</c:if>
	
	
	<div class="user_home_menu">
		<ul class="li_container">
			<li class="home_nav_category" id="board_btn"><a href="<c:url value="/board.do"/>">BOARD</a></li>
			<li class="home_nav_category" id="login_btn"><a href="<c:url value="${loginOutURL}"/>">${loginOut}</a></li>
			<c:if test="${not empty sessionScope.id}">
				<li class="home_nav_category" id="mypage_btn"><a href="<c:url value="/myPage.do" />">MYPAGE</a></li>			
			</c:if>
		</ul>
	</div>
	
</body>

<script>
	document.querySelectorAll(".home_nav_category").forEach((element) => {
		element.addEventListener("mouseenter", (e) => {
			e.currentTarget.classList.add("home_nav_category_hover");
		});
		
		
		element.addEventListener("mouseleave", (e) => {
			e.currentTarget.classList.remove("home_nav_category_hover");
		})
		
		element.addEventListener("click", () => {
			location.href = element.querySelector("a").href;
		});
		
	});
	

	
	let loginState = "${sessionScope.id}";
	
	if(loginState !== null || loginState !== ""){
		
		document.querySelector("#logoutBtn").addEventListener("click", () => {
			location.href = "<c:url value="/logout.do"/>";
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
		
	}
	
	

	
</script>
</html>