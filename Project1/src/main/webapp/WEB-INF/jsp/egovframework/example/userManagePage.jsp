<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/admin/userManagePage.css"/>" />
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
		
		<div class="main_board_parent">
		<div class="main_board_content">
			<div class="search_container">
				<form id="form" class="form">
					<select name="condition">
						<option value="A" ${param.condition == "A" ? 'selected' : ''}>아이디 또는 이름</option>
						<option value="R" ${param.condition == "R" ? 'selected' : ''}>가입일</option>
					</select>
					<input type="text" name="keyword" class="keyword" value="${param.keyword}"/>
					<button type="button" id="searchBtn" class="search_btn">검색</button>
				</form>
			</div>
			
			<div class="show_container">
				<table>
					<thead>
						<tr>
							<th class="th table_id">아이디</th>
							<th class="th table_password">비밀번호</th>
							<th class="th table_name">이름</th>
							<th class="th table_email">이메일</th>
							<th class="th table_phone">휴대폰번호</th>
							<th class="th table_reg_date">가입일</th>
							<th class="th table_update_btn">수정</th>
							<th class="th table_delete_btn">삭제</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach items="${userList}" var="userList">
							<tr>
								<td class="table_id">${userList.id}</td>
								<td class="table_password">${userList.password}</td>
								<td class="table_name">${userList.name}</td>
								<td class="table_email">${userList.email}</td>
								<td class="table_phone">${userList.phone}</td>
								<td class="table_reg_date"><fmt:formatDate value="${userList.reg_date}" pattern="y년 M월 d일"/></td>
								<td class="table_update_btn"><button onclick="onUpdateUserBtn('${userList.id}')" class="write_btn">수정</button></td>
								<td class="table_delete_btn"><button onclick="onDeleteUserBtn('${userList.id}')" class="update_btn">삭제</button></td>
								<!-- 
								<td>${userList.reg_date}</td>
								-->
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
				
			
			
			<div class="page_navi_container">
				<c:if test="${pageInfo.showPrev}">
					<span><a class="page_navi" href="<c:url value="/admin/user.do?page=${pageInfo.beginPage-1}&pageSize=${pageInfo.pageSize}&condition=${pageInfo.condition}&keyword=${pageInfo.keyword}"/>">&lt;</a></span>
				</c:if>
				<c:forEach var="i" begin="${pageInfo.beginPage}" end="${pageInfo.endPage}" step="1">
					<c:if test="${i == pageInfo.page || pageInfo.page == null}">
						<span><a class="page_navi current_page" href="<c:url value="/admin/user.do?page=${i}&pageSize=${pageInfo.pageSize}&condition=${pageInfo.condition}&keyword=${pageInfo.keyword}"/>"> ${i} </a></span>	
					</c:if>
					<c:if test="${i != pageInfo.page}">
						<span><a class="page_navi" href="<c:url value="/admin/user.do?page=${i}&pageSize=${pageInfo.pageSize}&condition=${pageInfo.condition}&keyword=${pageInfo.keyword}"/>"> ${i} </a></span>
					</c:if>
				</c:forEach>
				<c:if test="${pageInfo.showNext}">
					<span><a class="page_navi" href="<c:url value="/admin/user.do?page=${pageInfo.endPage+1}&pageSize=${pageInfo.pageSize}&condition=${pageInfo.condition}&keyword=${pageInfo.keyword}"/>">&gt;</a></span>
				</c:if>
			</div>
			
		</div>
	</div>
	</div>
	
</body>
<script>
	const form = document.querySelector("#form");
	const searchBtn = document.querySelector("#searchBtn");
	
	const clickMenu = (type) => {
		if(type == "board"){
			document.querySelector("#boardMenu").classList.toggle("hidden");
		} else if(type == "user"){
			document.querySelector("#userMenu").classList.toggle("hidden");
		} 
		console.log(type);
	}
	
	const onDeleteUserBtn = (userId) => {
		console.log(userId);

		location.href = "<c:url value="/admin/deleteUser.do"/>" + "?userId=" + userId;
	}
	
	const onUpdateUserBtn = (userId) => {
		console.log(userId);
		
		location.href = "<c:url value="/admin/updateUser.do"/>" + "?userId=" + userId;
	}
	
	searchBtn.addEventListener("click", () => {
		console.log("click");
		form.method = "GET";
		form.action = "<c:url value="/admin/user.do"/>";
		form.submit();
	});
	
	document.querySelector("#logoutBtn").addEventListener("click", () => {
		location.href = "<c:url value="/admin/logout.do"/>";
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