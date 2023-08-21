<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="adminAccount" value="${sessionScope.adminId}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>범일</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/admin/adminHome.css"/>" />
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
		<span class="current_user_welcome"><span class="current_user_name">${sessionScope.adminId}</span>님 환영합니다.</span>
		<button type="button" id="logoutBtn" class="logout_btn">로그아웃</button>
	</div>
	
	<div class="main_div">
	
		<div class="admin_nav">
			<ul>
				<li class="nav_category"><a href="<c:url value="/admin/board.do"/>" >게시판관리</a></li>
				<li class="nav_category"><a href="<c:url value="/admin/user.do"/>">회원관리</a></li>
			</ul>
		</div>
		
		
		<div class="admin_page_content">
			<div class="under_content">
			
				<div>
					<span class="content_title">오늘 가입자</span>

				</div>
				
				<c:if test="${empty todayUser}">
					<span>없습니다.</span>
				</c:if>
				
				<c:if test="${not empty todayUser}">
					<div class="show_container">
						<table>
							<thead>
								<tr>
									<th class="th table_id">아이디</th>
									<th class="th table_password">비밀번호</th>
									<th class="th table_name">이름</th>
									<th class="th table_email">이메일</th>
									<th class="th table_phone">휴대폰번호</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach items="${todayUser}" var="todayUser">
									<tr>
										<td class="table_id">${todayUser.id}</td>
										<td class="table_password">${todayUser.password}</td>
										<td class="table_name">${todayUser.name}</td>
										<td class="table_email">${todayUser.email}</td>
										<td class="table_phone">${todayUser.phone}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>	
				</c:if>
				
			</div>
			
			<div class="under_content">
			
				<div>
					<span class="content_title">오늘 작성된 글</span>

				</div>
				
				
				<c:if test="${empty todayBoard}">
					<span>없습니다.</span>
				</c:if>
				
				<c:if test="${not empty todayBoard}">
					<div class="show_container">
						<table>
							<thead>
								<tr>
									<th class="th table_bno" >번호</th>
									<th class="th table_title">제목</th>
									<th class="th table_writer">작성자</th>
									<th class="th table_view_cnt">조회수</th>
								</tr>
							</thead>
							<tbody>	
								<c:forEach items="${todayBoard}" var="todayBoard">
									<tr>
										<td class="table_bno">${todayBoard.bno}</td>
										<td class="table_title"><c:out value="${todayBoard.title}" /></td>
										<td class="table_writer">${todayBoard.writer}</td>
										<td class="table_view_cnt">${todayBoard.view_cnt}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
				
			</div>
			
			<!-- 
			<div>
				<div>
					<span>유저 관리</span>
					<span>더보기</span>
				</div>
				<div>
					<table>
						<tr>
							<th>아이디</th>
							<th>비밀번호</th>
							<th>이름</th>
							<th>이메일</th>
							<th>휴대폰번호</th>
							<th>가입일</th>
						</tr>
						
						<c:forEach items="${AllUserInfo}" var="AllUserInfo">
							<tr>
								<td>${AllUserInfo.id}</td>
								<td>${AllUserInfo.password}</td>
								<td>${AllUserInfo.name}</td>
								<td>${AllUserInfo.email}</td>
								<td>${AllUserInfo.phone}</td>
								<td>${AllUserInfo.reg_date}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			-->
			
			<div class="under_content">
			
				<div>
					<span class="content_title">조회수 많은 글</span>

				</div>
				
				<div class="show_container">
					<table>
						<thead>
							<tr>
								<th class="th table_bno" >번호</th>
								<th class="th table_title">제목</th>
								<th class="th table_writer">작성자</th>
								<th class="th table_reg_date">작성일</th>
								<th class="th table_view_cnt">조회수</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach items="${highViewCntBoard}" var="highViewCntBoard">
								<tr>
									<td class="table_bno">${highViewCntBoard.bno}</td>
									<td class="table_title"><c:out value="${highViewCntBoard.title}" /></td>
									<td class="table_writer">${highViewCntBoard.writer}</td>
									<td class="table_reg_date"><fmt:formatDate value="${highViewCntBoard.reg_date}" pattern="y년 M월 d일"/></td>
									<td class="table_view_cnt">${highViewCntBoard.view_cnt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
			</div>
		</div>
		
	</div>
	
</body>

<script>
	const logoutBtn = document.querySelector("#logoutBtn");
	
	logoutBtn.addEventListener("click", () => {
		location.href = "<c:url value="/admin/logout.do"/>";
	});
	
	
	const clickMenu = (type) => {
		if(type == "board"){
			document.querySelector("#boardMenu").classList.toggle("hidden");
		} else if(type == "user"){
			document.querySelector("#userMenu").classList.toggle("hidden");
		} 
		console.log(type);
	}
	
	
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