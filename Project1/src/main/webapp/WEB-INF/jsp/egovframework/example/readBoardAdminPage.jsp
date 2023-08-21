<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/admin/adminReadBoard.css"/>" />
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
				<span class="form_header_label">TITLE</span> <input type="text" name="title" id="title" value="<c:out value="${board.getTitle()}"/>" readonly/><br>
				<span class="form_header_label">WRITER</span> <input type="text" name="writer" id="writer" value="<c:out value="${board.getWriter()}"/>" readonly/><br>
				<span class="form_header_label">REGISTER DATE</span> <input type="text" name="regDate" id="regDate" value="<fmt:formatDate value="${board.reg_date}" pattern="y년 M월 d일"/>" readonly/><br>
				<span class="form_header_label">VIEW COUNT</span> <input type="text" name="viewCount" id="viewCount" value="<c:out value="${board.getView_cnt()}"/>" readonly/><br>
				<span class="form_header_label">CONTENT</span> <textarea name="content" id="content" class="content" readonly><c:out value="${board.getContent()}"/></textarea>
				<input type="hidden" name="isadmin" value="<c:url value="${board.getIsadmin()}"/>" />
				<div class="form_buttons">
					<button type="button" class="deleteBtn" id="deleteBtn">삭제하기</button>
					<button type="button" class="updateBtn" id="updateBtn">수정하기</button>
					<button type="button" class="backBtn" id="backBtn">뒤로가기</button>
				</div>
			</form>
			
		</div>
	
	</div>

</body>
<script>
	const bno1 = ${param.bno};

	const clickMenu = (type) => {
		if(type == "board"){
			document.querySelector("#boardMenu").classList.toggle("hidden");
		} else if(type == "user"){
			document.querySelector("#userMenu").classList.toggle("hidden");
		} 
		console.log(type);
	}
	
	document.querySelector("#deleteBtn").addEventListener("click", () => {
		location.href = "<c:url value="/admin/deleteBoard.do?bno="/>" + ${param.bno};
	});
	
	document.querySelector("#backBtn").addEventListener("click", () => {
		location.href = "<c:url value="/admin/board.do"/>";
	});
	
	document.querySelector("#updateBtn").addEventListener("click", () => {
		const isReadOnly = document.querySelector("#title").readOnly;
		
		if(isReadOnly){
			document.querySelector("#title").readOnly = false;
			document.querySelector("#content").readOnly = false;
			document.querySelector("#updateBtn").innerHTML = "수정 완료";
		} else{
			form.method = "POST";
			form.action = "<c:url value="/admin/updateBoard.do"/>?bno=${param.bno}";
			form.submit();
		}
		
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