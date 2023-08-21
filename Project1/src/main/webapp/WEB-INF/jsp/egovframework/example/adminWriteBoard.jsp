<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 작성</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/admin/adminWriteBoard.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/egovframework/common/common.css"/>" />
</head>
<body>

	<div class="logo_container">
		<a href="<c:url value="/admin/home.do"/>">
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
				<li class="nav_category"><a href="<c:url value="/admin/board.do"/>" >게시판관리</a></li>
				<li class="nav_category"><a href="<c:url value="/admin/user.do"/>">회원관리</a></li>
			</ul>
		</div>
		
		<div class="main_board_content">

			
			<form id="form" class="board_form">
				<span class="form_header_label">TITLE</span> <input type="text" name="title" id="title" /><br>
				<span class="form_header_label">CONTENT</span> <textarea name="content" id="content" class="content"></textarea>
				<input type="hidden" name="isadmin" value=1 />
				<div class="form_buttons">
					<button type="button" id="writeBtn">작성하기</button>
				</div>
			</form>
			
		</div>
	</div>
</body>
<script>
const clickMenu = (type) => {
	if(type == "board"){
		document.querySelector("#boardMenu").classList.toggle("hidden");
	} else if(type == "user"){
		document.querySelector("#userMenu").classList.toggle("hidden");
	} 
	console.log(type);
	}
	

const title = document.querySelector("#title");
const content = document.querySelector("#content");
const form = document.querySelector("#form");
const writeBtn = document.querySelector("#writeBtn");


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


const writeBoard = () => {
	if(title.value == ""){
		alert("제목을 입력하세요");
		title.focus();
	} else if(content.value == ""){
		alert("내용을 입력하세요");
		content.focus();
	} else{
		form.method = "POST";
		form.action = "<c:url value="/admin/writeBoard.do"/>";
		form.submit();
	}
}

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




writeBtn.addEventListener("click", writeBoard);
</script>
</html>