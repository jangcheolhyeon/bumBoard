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
<link rel="stylesheet" href="<c:url value="/css/egovframework/common/common.css"/>"/>
<link rel="stylesheet" href="<c:url value="/css/egovframework/user/board.css"/>"/>
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
					<li class="nav_category"><a href="<c:url value="/board.do"/>" >게시판</a></li>
					<li class="nav_category"><a href="<c:url value="/myPage.do"/>" >내정보</a></li>
				</ul>
			</div>
		
		<div class="main_board_content">
		
			<form id="form" class="board_form">
				<input type="hidden" value="<c:out value="${board.getBno()}"/>" id="bno"/>
				
				<div class="form_header_container">
					<span class="form_header_label form_bno_row">게시글 번호</span>
					<span class="form_header_label form_title_row">제목</span> 
					<span class="form_header_label writer_label form_writer_row">작성자</span>
					<span class="form_header_label date_label form_reg_date_row">등록일</span> 
					<span class="form_header_label view_label form_view_cnt_row">조회수</span>
					<span class="form_header_label form_content_row">내용</span>
					
					<%-- <c:if test="${board.file_name != null || param.mode == 'new'}">
						<span class="form_header_label form_upload_row">첨부파일</span>
					</c:if> --%>
					
					<span class="form_header_label form_upload_row">첨부파일</span>
				</div>
				
				<div class="form_content_container">
				
					<input type="text" id="bno" class="form_bno_row" value="<c:out value="${board.getBno()}"/>" readonly/>
					<input type="text" name="title" id="title" class="form_title_row" value="<c:out value="${board.getTitle()}"/>" readonly/>
					<input type="text" name="writer" id="writer" class="form_writer_row" value="<c:out value="${board.getWriter()}"/>" readonly/>
					<input type="text" name="regDate" id="regDate" class="form_reg_date_row" value="<fmt:formatDate value="${board.reg_date}" pattern="y년 M월 d일"/>" readonly/>
					<input type="text" name="viewCount" id="viewCount" class="form_view_cnt_row" value="<c:out value="${board.getView_cnt()}"/>" readonly/>
					<textarea name="content" id="content" class="content form_content_row" readonly><c:out value="${board.getContent()}"/></textarea>
					
					
				<%-- 	<c:if test="${board.file_name ne null}">
						<!-- 
							<a href="fileDownload.do?fileName=${board.file_name}"><span id="fileUID" class="form_upload_row">${board.file_name}</span></a> 
						-->
						<span id="fileUID" class="form_upload_row"><a href="fileDownload.do?fileName=${board.file_name}">${board.file_name}</a></span>
						<!-- <input type="file" name="uploadFile" id="uploadFile" /> -->
					</c:if> --%>
					
					<c:if test="${param.mode == 'new'}">
						<input type="file" name="uploadFile" id="uploadFile" class="form_upload_row" /> 
						<span id="deleteIcon" class="delete_icon hidden">del</span>
					</c:if>
					
					<c:if test="${param.mode == null || param.mode == '' }">
						<c:if test="${sessionScope.id != board.getWriter()}">
							<span id="fileUID" class="form_upload_row file_uid"><a href="fileDownload.do?fileName=${board.file_name}">${board.file_name}</a></span>
						</c:if>
						
						<c:if test="${sessionScope.id == board.getWriter()}">
						
							<c:if test="${not empty board.getFile_name()}">						
								<div class="file_upload_container">						
									<span id="fileUID" class="form_upload_row file_uid"><a href="fileDownload.do?fileName=${board.file_name}">${board.file_name}</a></span>
									<span id="deleteIcon" class="delete_icon hidden">del</span>
								</div>
							</c:if>
							
							<input type="file" name="uploadFile" id="uploadFile" class="form_upload_row hidden" />
						
						</c:if>
					</c:if>
					<%-- <c:if test="${}">					
						<span id="fileUID" class="form_upload_row"><a href="fileDownload.do?fileName=${board.file_name}">${board.file_name}</a></span>
					</c:if> --%>
					
					<!-- <div class="upload_container hidden">
						<input type="file" name="uploadFile" id="uploadFile" />
					</div> -->
					
				</div>
				
				<!-- 
				<span class="form_header_label">제목</span> <input type="text" name="title" id="title" value="<c:out value="${board.getTitle()}"/>" readonly/><br>
				<span class="form_header_label writer_label">작성자</span> <input type="text" name="writer" id="writer" value="<c:out value="${board.getWriter()}"/>" readonly/><br>
				<span class="form_header_label date_label">등록일</span> <input type="text" name="regDate" id="regDate" value="<fmt:formatDate value="${board.reg_date}" pattern="y년 M월 d일"/>" readonly/><br>
				<span class="form_header_label view_label">조회수</span> <input type="text" name="viewCount" id="viewCount" value="<c:out value="${board.getView_cnt()}"/>" readonly/><br>
				<span class="form_header_label">내용</span> <textarea name="content" id="content" class="content" readonly><c:out value="${board.getContent()}"/></textarea>
				-->
				
				
				<!-- 
				<div class="upload_container non_visible">
					<span>업로드</span>
					<input type="file" name="uploadFile" id="uploadFile" />
				</div>
				-->
				
				
<%-- 				<span>이미지 파일</span>
				<div class="new_image_container">
				
					<c:if test="${board.file_name ne null}">
						<img src="<c:url value="/upload/${board.file_name}"/>" class="board_image board_db_image"  />
					</c:if>
						
					<img src="" id="newImage" class="board_image new_upload_image" />
				
				</div> --%>
				
				
				
				<!--  
				<c:if test="${board.file_name ne null}">
					<span>첨부파일</span>
					<a href="fileDownload.do?fileName=${board.file_name}"><span id="fileUID">${board.file_name}</span></a>
				</c:if>
				-->
				
				<!-- 
				<div class="form_buttons">
					<button type="button" id="writeBtn">작성하기</button>
					<button type="button" id="modifyBtn">수정하기</button>
					<button type="button" id="deleteBtn">삭제하기</button>
					<button type="button" id="boardListBtn">뒤로가기</button>
					<input type="hidden" id="writerCheck" value="${board.writer}"/>
					<input type="hidden" id="currentUser" value="${sessionScope.id}" />
				</div>
				-->
			</form>
			
			<div class="form_buttons">
				<button type="button" id="writeBtn">작성하기</button>
				<button type="button" id="modifyBtn">수정하기</button>
				<button type="button" id="deleteBtn">삭제하기</button>
				<button type="button" id="boardListBtn">뒤로가기</button>
				<input type="hidden" id="writerCheck" value="${board.writer}"/>
				<input type="hidden" id="currentUser" value="${sessionScope.id}" />
			</div>
		
		
			<div class="comment_container">
				
				<div class="comment_write_container">
					<span class="comment_label">댓글</span>
					<textarea class="comment_write_textarea"></textarea>
					<button type="button" id="commentWriteBtn" class="comment_write_btn">작성</button>
				</div>
				
				<div class="comment_list_container">
					
				</div>
				
			</div>
			
		</div>
	</div>

	
</body>

<script>
	const mode = "${param.mode}";
	
	console.log("mode = " + mode);
	const bno = "${bno}";
	
	const title = document.querySelector("#title");
	const content = document.querySelector("#content");
	const form = document.querySelector("#form");
	const writeBtn = document.querySelector("#writeBtn");
	const modifyBtn = document.querySelector("#modifyBtn");
	const deleteBtn = document.querySelector("#deleteBtn");
	const writerCheck = document.querySelector("#writerCheck").value;
	const currentUser = document.querySelector("#currentUser").value;
	const boardListBtn = document.querySelector("#boardListBtn");
	const writer = document.querySelector("#writer");
	const registerDate = document.querySelector("#regDate");
	const viewCount = document.querySelector("#viewCount");
	
	console.log("writerCheck = " + writerCheck);
	console.log("currentUser = " + currentUser);
	if(writerCheck != currentUser){
		modifyBtn.style.display = "none";
		deleteBtn.style.display = "none";
	}
	
	const writeBoard = () => {
		if(title.value == ""){
			alert("제목을 입력하세요");
			title.focus();
		} else if(content.value == ""){
			alert("내용을 입력하세요");
			content.focus();
		} else{
			form.method = "POST";
			form.action = "<c:url value="/boardWrite.do"/>";
			form.enctype="multipart/form-data";
			form.submit();
		}
	}
	
	const modifyBoard = () => {
		const currentState = title.readOnly;
		console.log("click");		

		
		if(currentState){
			modifyBtn.innerHTML = "수정 완료";
			deleteBtn.innerHTML = "취소"; 
			title.readOnly = false;
			content.readOnly = false;
			
			document.querySelector(".comment_write_container").classList.add("hidden");
			document.querySelector(".comment_list_container").classList.add("hidden");
			document.querySelector("#uploadFile").classList.remove("hidden");
			//document.querySelector("#fileUID").classList.add("hidden");
			
			if(document.querySelector("#deleteIcon") != null)
			document.querySelector("#deleteIcon").classList.remove("hidden");
			
		} else{
			console.log("수정 api로 보내기");
			
			let fileUID = "";
			if(document.querySelector("#fileUID") != null){
				fileUID = document.querySelector("#fileUID").innerText;				
			}
			form.method = "POST";
			form.action = "<c:url value="/modifyBoard.do"/>?bno=${param.bno}&fileUID="+fileUID;
			form.enctype="multipart/form-data";
			form.submit();
		}
		
	}
	
	const deleteBoard = () => {
		const currentState = title.readOnly;
		
		if(currentState){
			console.log("삭제 api로 보내기");
			let fileUID = "";
			if(document.querySelector("#fileUID") != null){				
				fileUID = document.querySelector("#fileUID").innerText;
			}
			location.href = "<c:url value="/removeBoard.do"/>?bno=${param.bno}&fileUID="+fileUID;

		} else{
			console.log("취소");
			location.href = "<c:url value="/boardRead.do"/>?bno=${param.bno}";
			
		}
	}
	
	if(mode == "new"){
		title.readOnly = false;
		content.readOnly = false;
		
		modifyBtn.style.display = "none";
		deleteBtn.style.display = "none";
		//writer.style.display = "none";
		registerDate.style.display = "none";
		viewCount.style.display = "none";
		//document.querySelector(".writer_label").style.display = "none";
		document.querySelector("#writer").value = currentUser;
		document.querySelector("#writer").classList.add("readOnlySection");
		document.querySelector(".date_label").style.display = "none";
		document.querySelector(".view_label").style.display = "none";

		//document.querySelector(".form_header_container").innerHTML += "<span class="form_header_label form_upload_row">첨부파일</span>";
		document.querySelectorAll(".form_bno_row").forEach((element) => {
			console.log("form_bno_row element");
			console.log(element);
			element.style.display = 'none';
		});
		
		
		document.querySelector(".comment_container").style.display = "none";
		document.querySelectorAll(".form_bno_row").forEach((e) => {
			e.style.display = "none";
		})
		
		
	} else{
		writeBtn.style.display = "none";
	}
	
	const goBoardList = () => {
		location.href = "<c:url value="/board.do"/>";
	}
	
	
	writeBtn.addEventListener("click", writeBoard);
	modifyBtn.addEventListener("click", modifyBoard);
	deleteBtn.addEventListener("click", deleteBoard);
	boardListBtn.addEventListener("click", goBoardList);
	
	
	
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
	
	
	if(document.querySelector("#uploadFile") != null){
		
		document.querySelector("#uploadFile").addEventListener("change" , (e) => {
	        console.log(e);
	        console.log(e.target);
	        console.log(e.files);
	        console.log(e.target.files);
	        let file = e.target.files[0];
	        if(file != ""){
	            let reader = new FileReader();
	            reader.readAsDataURL(file);
	            reader.onload = (e) => {
	            	if(document.querySelector(".file_upload_container") != null)
	            	document.querySelector(".file_upload_container").classList.add("hidden");
	                console.log("file reader onload");
	                console.log(e.target);
	                console.log(e.target.result);
	               // document.querySelector(".board_db_image").classList.add("hidden");
	                //document.querySelector("#newImage").src = e.target.result;
	//                document.querySelector("#newImage").width = 25px;
	//                document.querySelector("#newImage").height = 25px;
	            }
	        }
	    })
	    
	}
    
    
    
    
    //수정시 처뭅파일에 있는 거 삭제
    if(document.querySelector("#deleteIcon") != null){
    	
	    document.querySelector("#deleteIcon").addEventListener("click", () => {
	    	console.log("click");	
	    	document.querySelector(".file_upload_container").classList.add("hidden");
	    })

    }
    
    
    
    
    
    // 댓글 가져오면 html 만듬 Array로 들어옴
    const makeHTML = (data) => {
    	
    	 let ulTag = "<ul>";
         data.forEach((element) => {
             let change_regDate = new Date(element.reg_date);
             console.log(change_regDate);

             let regDate_Year = change_regDate.getFullYear();
             let regDate_Month = change_regDate.getMonth()+1 < 10 ? "0" + (change_regDate.getMonth()+1) : change_regDate + 1;
             let regDate_Day = change_regDate.getDate() < 10 ? "0" + change_regDate.getDate() : change_regDate.getDate();
             let regDate_Hours = change_regDate.getHours() < 10 ? "0" + change_regDate.getHours() : change_regDate.getHours();
             let regDate_Minutes = change_regDate.getMinutes() < 10 ? "0" + change_regDate.getMinutes() : change_regDate.getMinutes();
             let regDate_Seconds = change_regDate.getSeconds() < 10 ? "0" + change_regDate.getSeconds() : change_regDate.getSeconds();

             let total_regDate = regDate_Year + "." + regDate_Month + "." + regDate_Day + " " + regDate_Hours + ":" + regDate_Minutes + ":" + regDate_Seconds;
             console.log(total_regDate);

             
             
             
			console.log(element.pcno == 0);
			 // if(element.pcno == 0) {   ulTag += "<div class='comment_container'>";  }
             // else {    ulTag += "<div class='reply_container'>";    } 
             
			 
			 if(element.pcno == 0){
				 ulTag += "<li class='li_comment_container li_comment' data-cno=" + element.cno + " data-bno=" + element.bno + " data-pcno=" + element.pcno + ">"
			 } else{
				 ulTag += "<li class='li_comment_container li_reply' data-cno=" + element.cno + " data-bno=" + element.bno + " data-pcno=" + element.pcno + ">"
			 }
			 //ulTag += "<li class='li_comment_container' data-cno=" + element.cno + " data-bno=" + element.bno + " data-pcno=" + element.pcno + ">"

			 
			 //ulTag += element.pcno != 0 ? "      ㄴ" : "";
			 
			 ulTag += "<div class='comment_top''>";
             ulTag += "<span class='commenter'>" + element.commenter + "</span>";
             ulTag += "     <span class='reg_Date'>" + total_regDate + "</span>";
             ulTag += "</div>";
             
             ulTag += "<div class='comment_mid'>"
             ulTag += " <span class='comment'>" + element.comment + "</span>";
             ulTag += "</div>";
             
             ulTag += "<div class='comment_bottom'>";
             ulTag += " <input type='hidden' id='hiddenComment' value='" + element.comment + "'/>";
             // ulTag += "<div class='time_btns'>";
             if(element.commenter == currentUser){            	 
	             ulTag += " <button type='button' class='removeBtn'>삭제</button>";
	             ulTag += " <button type='button' class='commentModifyBtn'>수정</button>";
             }
             if(element.pcno == 0)
             ulTag += " <button type='button' class='commentReplyBtn'>답글</button>" ;
             ulTag += "</div>";
             // ulTag += "</div>";
             // ulTag += " <button type='button' class='commentReplyBtn' onclick='onReplyClick(this)'>답글</button>";
             ulTag += "<div class='reply_form_container'></div>";
             ulTag += "</li>";
             
             
             //ulTag += "</div>";
			
         })

         return ulTag + "</ul>";
    	
    }
    
    
    
    
    // Ajax로 댓글 가져오기
	const getCommentList = () => {
		if("${param.mode}" != 'new'){			
			let xhr = new XMLHttpRequest();
			let bno = document.querySelector("#bno").value;
			console.log("bno : " + bno);
			xhr.open("GET", "<c:url value="/comments/"/>" + bno + ".do");
			xhr.send();
			
			xhr.onload = () => {
				if(xhr.status == 200){
					console.log("200 ok");
					console.log(xhr.response);
					console.log(JSON.parse(xhr.response));
					document.querySelector(".comment_list_container").innerHTML = makeHTML(JSON.parse(xhr.response));
				} else{
					console.log("fail");
				}
			}
		}
		
	}
	
	
	
	
	
	//Ajax로 댓글 작성하기
	document.querySelector("#commentWriteBtn").addEventListener("click", () =>{
		console.log(("commentWriteBtn click"));
		console.log(document.querySelector(".comment_write_textarea").value);
		let bno = document.querySelector("#bno").value;
		
		let xhr = new XMLHttpRequest();
		console.log("bno : " + bno);
		xhr.open("POST", "<c:url value="/comments.do"/>");
		xhr.setRequestHeader("Content-Type", "application/json");
		
		let data = {
			bno : bno,
			pcno : 0,
			comment : document.querySelector(".comment_write_textarea").value,
			commenter : currentUser,
		}
		
		xhr.send(JSON.stringify(data));
		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log("200 post ok");
				getCommentList();
				document.querySelector(".comment_write_textarea").value = "";
			} else{
				console.log("post fail");
			}
		}
		
	});
		
	
    
	const Init = () => {
		getCommentList();
	}
    
	Init();
	
	// 대댓글 작성하기
/* 	const onReplyClick = (e) => {
		console.log(e);
		console.log("click");
	} */
	
	document.querySelector(".comment_list_container").addEventListener("click", (e) => {
/* 		console.log(e);
		console.log(e.target);
		console.log(e.target.parentElement); */
		//let writeUser = e.target.parentElement.parentElement.querySelector(".commenter").innerText;
		
		//답글 눌렀을 때
		if(e.target.innerText == "답글"){
			let currentReplyContainer = e.target.parentElement.parentElement;
			console.log("답글 클릭");	
			console.log(e.target.parentElement.parentElement.parentElement);
			console.log(e.target.parentElement.parentElement);
			
			if(document.querySelector(".reply_form_container1") != undefined){
				console.log("기존 reply_form이 존재 해서 삭제");
				document.querySelector(".reply_form_container1").remove();
			}
			
			//let replyForm = "<div class='reply_form_container1'><input type='text' id='replyFormText' class='reply_form_text'/>" + "<button type='button' id='replyWriteBtn' class='reply_write_btn' onclick='onWriteBtnClick(this)'>작성</button></div>";
			let replyForm = "<div class='reply_form_container1'>";
				replyForm += "<input type='text' id='reply_form_text'/>";
				replyForm += "<button type='button' id='replyWriteBtn' class='reply_write_btn' onclick='onWriteBtnClick(this)'>작성</button>"
				replyForm += "<button type='button' id='replyWriteCancelBtn' class='reply_write_cancel_btn' onclick='onWriteCancelBtnClick(this)'>답글취소</button> "
				replyForm += "</div>";
			
			
			console.log("currentReplyContainer");
			console.log(currentReplyContainer);
			//currentReplyContainer.parentElement.querySelector(".li_comment_container").innerHTML += replyForm;
			currentReplyContainer.querySelector(".reply_form_container").innerHTML += replyForm;
			
		} else if(e.target.innerText == "삭제"){
			console.log("삭제 클릭");
			let cno = e.target.parentElement.parentElement.dataset.cno;
			deleteComment(cno);
			
		} else if(e.target.innerText == "수정"){
			console.log("수정 클릭");
			console.log(e.target.parentElement.parentElement);
			console.log("위가 수정 클릭");
			let commentElement = e.target.parentElement.parentElement.querySelector(".comment");
			let commentText = commentElement.innerText;
	
			
			
/* 			if(document.querySelector("#replyText") != undefined){
				
				
				
				
				
			} */
			commentElement.innerText = "";
			commentElement.innerHTML += "<input type='text' value='" + commentText +  "' id='replyText' />";
			
			
			
			e.target.parentElement.querySelector(".commentModifyBtn").classList.add("text_change");
			e.target.parentElement.querySelector(".commentModifyBtn").innerText = "수정완료";	
			e.target.parentElement.querySelector(".removeBtn").innerText = "취소";
			
			
		} else if(e.target.innerText == "수정완료"){
			console.log("수정 완료");
			let cno = e.target.parentElement.parentElement.dataset.cno;
			console.log(e.target.parentElement.parentElement);
			
			let changeText = e.target.parentElement.parentElement.querySelector("#replyText").value;
			// 작성한 내용 return 받기
			updateComment(cno, changeText);
			
			console.log("changeText = " + changeText);
			
			e.target.parentElement.parentElement.querySelector(".commentModifyBtn").classList.remove("text_change");
			e.target.parentElement.parentElement.querySelector(".comment").innerHTML = changeText;
			e.target.parentElement.parentElement.querySelector(".commentModifyBtn").innerText = "수정";
			e.target.parentElement.parentElement.querySelector(".removeBtn").innerText = "삭제";
			
			
		} else if(e.target.innerText == "취소"){
			console.log("취소");	
			console.log(e.target.parentElement);
			e.target.parentElement.parentElement.querySelector(".comment").innerHTML = e.target.parentElement.parentElement.querySelector("#hiddenComment").value;
			e.target.parentElement.parentElement.querySelector(".commentModifyBtn").innerText = "수정";
			e.target.parentElement.parentElement.querySelector(".removeBtn").innerText = "삭제";
		}
		
		else if(e.target.innerText == "like"){
			console.log("like 클릭");
		}
		
	})
	
	
	//답글 작성 폼
	const onWriteBtnClick = (e) => {
		console.log("click");
		const replyFormText = document.querySelector("#reply_form_text").value;
		console.log("replyFormText = " + replyFormText);
		console.log(e);
		let parentDatas = e.parentElement.parentElement.parentElement;
		let cno = parentDatas.dataset.cno;
		
		
  		let bno = document.querySelector("#bno").value;
		

 		let xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value="/comments.do"/>");
		xhr.setRequestHeader("Content-Type", "application/json");
		
		let data = {
			bno : bno,
			pcno : cno,
			comment : replyFormText,
			commenter : currentUser,
		}
		
		xhr.send(JSON.stringify(data));
		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log("200 post ok");
				getCommentList();
			} else{
				console.log("post fail");
			}
		}  
		
			
	}
	
	
	
	//답글 폼 취소 
	const onWriteCancelBtnClick = (e) => {
		console.log(e);
		console.log(e.parentElement.parentElement);
		e.parentElement.parentElement.querySelector(".reply_form_container1").remove();
	}
	
	
	
	
	// 댓글 삭제
	const deleteComment = (cno) => {
		console.log("delete cno = " + cno);
		
		let xhr = new XMLHttpRequest();
		xhr.open("DELETE", "<c:url value='/comments/'/>" + cno + ".do");
		xhr.send();
		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log(xhr.response);
				getCommentList();
			} else{
				console.log(xhr.response);
			}
		}
		
		
	}
	
	
	
	
	// 댓글 수정
	const updateComment = (cno, changeText) => {
		console.log("cno = " + cno);	
		
		let xhr = new XMLHttpRequest();
		xhr.open("PUT", "<c:url value='/comments/'/>" + cno + ".do");
		xhr.setRequestHeader("Content-Type", "application/json");
		let data = {
			comment : changeText
		}
		xhr.send(JSON.stringify(data));
		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log(xhr.response);
			} else{
				console.log("fail");
			}
		}
		
	}
	
	
	
</script>
</html>