<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="loginOut" value="${sessionScope.id == null || sessionScope.id == '' ? 'LOGIN' : 'LOGOUT'}"/>
<c:set var="loginOutURL" value="${sessionScope.id == null || sessionScope.id == '' ? '/login.do' : '/logout.do'}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="shortcut icon" type="image⁄x-icon" href="<c:url value = "/images/egovframework/example/bumil.png"/>" >
<link rel="stylesheet" href="<c:url value="/css/egovframework/user/boardList.css"/>"/>
<link rel="stylesheet" href="<c:url value="/css/egovframework/common/common.css"/>"/>
</head>
<body>
	
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
				<li class="nav_category"><a href="<c:url value="/board.do"/>" >게시판</a></li>
				<li class="nav_category"><a href="<c:url value="/myBoard.do"/>" >내글</a></li>
				<li class="nav_category"><a href="<c:url value="/myPage.do"/>" >내정보</a></li>
			</ul>
		</div>
	
	
		<div class="main_board_parent">		
		
			<div class="main_board_content">
				<div class="search_container">
					<form id="form" class="form">
						<select name="condition">
							<option value="A" ${param.condition == "A" ? 'selected' : ''}>제목 + 내용</option>
							<option value="T" ${param.condition == "T" ? 'selected' : ''}>제목</option>
						</select>
						<input type="text" name="keyword" class="keyword" value="${param.keyword}"/>
						<button type="button" id="searchBtn" class="search_btn">검색</button>
					</form>
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
						<c:forEach items="${boardList}" var="board">
							<tr class="table_content_tr">
								<td class="table_bno">
								<c:if test="${board.isadmin == 1}">
									<span>공지사항</span>
									<span id="bno_number" class="hidden">${board.bno}</span>
								</c:if>
								<c:if test="${board.isadmin == 0}">
									<span id="bno_number">${board.bno}</span>
								</c:if>
								</td>
								<td class="table_title"><c:out value="${board.title}" /></td>
								<td class="table_writer">${board.writer}</td>
								<td class="table_reg_date"><fmt:formatDate value="${board.reg_date}" pattern="y년 M월 d일"/></td>
								<td class="table_view_cnt">${board.view_cnt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<br>
			<div class="write_btn_container">
				<button id="writeBtn" class="write_btn">글쓰기</button>
			</div>
			<div class="page_navi_container">
				<c:if test="${pageInfo.showPrev}">
					<span><a class="page_navi" href="<c:url value="/myBoard.do?page=${pageInfo.beginPage-1}&pageSize=${pageInfo.pageSize}&condition=${pageInfo.condition}&keyword=${pageInfo.keyword}"/>">&lt;</a></span>
				</c:if>
				<c:forEach var="i" begin="${pageInfo.beginPage}" end="${pageInfo.endPage}" step="1">
					<c:if test="${i == pageInfo.page || pageInfo.page == null}">
						<span><a class="page_navi current_page"> ${i} </a></span>	
					</c:if>
					<c:if test="${i != pageInfo.page}">
						<span><a class="page_navi" href="<c:url value="/myBoard.do?page=${i}&pageSize=${pageInfo.pageSize}&condition=${pageInfo.condition}&keyword=${pageInfo.keyword}"/>"> ${i} </a></span>
					</c:if>
				</c:forEach>
				<c:if test="${pageInfo.showNext}">
					<span><a class="page_navi" href="<c:url value="/myBoard.do?page=${pageInfo.endPage+1}&pageSize=${pageInfo.pageSize}&condition=${pageInfo.condition}&keyword=${pageInfo.keyword}"/>">&gt;</a></span>
				</c:if>
			</div>
		</div>
		
	</div>
</div>

</body>
<script>
	const searchBtn = document.querySelector("#searchBtn");
	const form = document.querySelector("#form");
	
	//action="<c:url value="board.do"/>"
	
	searchBtn.addEventListener("click", () => {
		console.log("click");
		form.method = "GET";
		form.action = "<c:url value="myBoard.do"/>";
		form.submit();
	});
	


	document.querySelector("#writeBtn").addEventListener("click", () => {
		location.href = "<c:url value="/boardWrite.do"/>?mode=new";
	})
	
	
	document.querySelectorAll(".table_content_tr").forEach((element) => {
		element.addEventListener("mouseenter", (e) => {
			e.currentTarget.classList.add("table-active");
		})
		
		
		element.addEventListener("click", () => {
			console.log(element.querySelector(".table_bno"));
			console.log(element.querySelector(".table_bno").querySelector("#bno_number").innerHTML);
			location.href = "<c:url value="boardRead.do"/>?bno=" + element.querySelector(".table_bno").querySelector("#bno_number").innerHTML;
		})
		
		element.addEventListener("mouseleave", (e) => {
			e.currentTarget.classList.remove("table-active");
		})
		
	})

	document.querySelector("#logoutBtn").addEventListener("click", () => {
		location.href = "<c:url value="/logout.do"/>";
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