<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginOut" value="${sessionScope.id == null || sessionScope.id == '' ? 'LOGIN' : 'LOGOUT'}"/>
<c:set var="loginOutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login.do' : '/logout.do'}"/>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/user/myInfoPage.css"/>"/>
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

		<div class="main_board_content">
			<form id="form" class="update_form">
				<span class="form_header_label">ID</span> <input type="text" name="id" id="id" value="<c:out value="${user.getId()}"/>" readonly/><br>
				<span class="form_header_label">PASSWORD</span> <input type="password" name="password" id="password" value="<c:out value="${user.getPassword()}"/>" /><br>
				<span class="form_header_label">NAME</span> <input type="text" name="name" id="name" value="<c:out value="${user.getName()}"/>"/><br>
				<span class="form_header_label">EMAIL</span> <input type="text" name="email" id="email" value="<c:out value="${user.getEmail()}"/>"/><br>
				<span class="form_header_label">PHONE</span> <input type="text" name="phone" id="phoneNumber" value="<c:out value="${user.getPhone()}"/>" maxlength="13"/><br>
				<div class="form_buttons">
					<button type="button" class="updateBtn" id="updateBtn">수정하기</button>
					<button type="button" class="cancelBtn" id="cancelBtn">취소하기</button>
				</div>
			</form>
			
		</div>
	</div>
</body>
<script>
	const updateBtn = document.querySelector("#updateBtn");
	const form = document.querySelector("#form");
	const password = document.querySelector("#password");
	const name = document.querySelector("#name");
	const email = document.querySelector("#email");
	const phoneNumber = document.querySelector("#phoneNumber");
	const cancelBtn = document.querySelector("#cancelBtn");

	
    const regIdPw = /^[a-zA-Z0-9]{4,12}$/;
    // 이름
    const regName = /^[가-힣a-zA-Z]{2,15}$/;
    // 이메일
  	const regMail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	// 휴대폰
	const regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	
	const updateMyInfo = () => {
		if(password.value == "" || !regIdPw.test(password.value) ){
			alert("비밀번호는 4~12자 영문 대소문자, 숫자만 입력하세요");
			password.focus();
		} else if(name.value == "" || !regName.test(name.value)){
			alert("최소 2글자 이상, 한글과 영어만 입력하세요.")
            name.focus();
		} else if(email.value == "" || !regMail.test(email.value)){
			alert("잘못된 이메일 형식입니다.")
            email.focus();
		} else if(phoneNumber.value == "" || !regPhone.test(phoneNumber.value)){
			alert("전화번호를 확인해주세요");
			phoneNumber.focus();
		} else{
			form.method = "POST";
			form.action = "<c:url value="/updateMyInfo.do"/>";
			form.submit();
		}
	}
	
	updateBtn.addEventListener("click", updateMyInfo);

	phoneNumber.addEventListener("keyup", () => {
		phoneNumber.value = phoneNumber.value.replace(/[^0-9]/g, '')
		   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	});
	
	cancelBtn.addEventListener("click", () => {
		location.href = "<c:url value="/home.do"/>"
	})
	
	
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
	
</script>
</html>