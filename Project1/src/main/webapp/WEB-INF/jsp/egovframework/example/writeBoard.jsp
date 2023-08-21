<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>write board</h1>
	<form id="form">
		title : <input type="text" name="title" id="title" /> <br>
		content : <textarea name="content" id="content"></textarea><br>
		<button type="button" id="writeBtn">작성하기</button>
	</form>
</body>
<script>
	const mode = "${mode}";
	
	const title = document.querySelector("#title");
	const content = document.querySelector("#content");
	const form = document.querySelector("#form");
	const writeBtn = document.querySelector("#writeBtn");
	
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
			form.submit();
		}
	}
	
	writeBtn.addEventListener("click", writeBoard);
	
</script>
</html>