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
	<h1>hello jsp123</h1>
	<button id="getAjax">getAjax</button>
	
	<form id="form">
		<input type="text" name="id" id="id"/>
		<input type="text" name="password" id="password" />
		<button type="button" id="getSubmit">submit</button>
	</form>
	
	<span>id : <span id="responseId"></span></span>
	<span>id : <span id="responsePassword"></span></span>
	
	
	<br>
	<br>
	<form id="postform">
		<input type="text" name="postId" id="postId"/>
		<input type="text" name="postPassword" id="postPassword" />
		<button type="button" id="postSubmit">submit</button>
	</form>
	
	<span>id : <span id="responsePostId"></span></span>
	<span>pwd : <span id="responsePostPassword"></span></span>
	
</body>
<script>
	const getAjax = document.querySelector("#getAjax");
	
	getAjax.addEventListener("click", () => {
		let xhr = new XMLHttpRequest();
		let word = getAjax.innerHTML;
		xhr.open("get", '<c:url value="/testtest.do"/>?words=' + word, true);
		xhr.send();
		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log(xhr.response);
			} else{
				console.log("fail");
			}
		}
	});
	
	
	const form = document.querySelector("#form");
	
	document.querySelector("#getSubmit").addEventListener("click", () => {
		let id = document.querySelector("#id").value;
		let password = document.querySelector("#password").value;
		
		let xhr = new XMLHttpRequest();
		xhr.open("get", '<c:url value="/objTest.do"/>' + "?id=" + id + "&password=" + password, true);
		//xhr.responseType = "json";
		xhr.send();
		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log(JSON.parse(xhr.response));
				document.querySelector("#responseId").innerHTML = JSON.parse(xhr.response).id;
				document.querySelector("#responsePassword").innerHTML = JSON.parse(xhr.response).password;
			} else{
				console.log("fail");
			}
		}
	});
	
	
	
	document.querySelector("#postSubmit").addEventListener("click", () => {
		console.log("click");
		
		let xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value="/postTest.do"/>");
		xhr.setRequestHeader("Content-Type", "application/json");
		
		let postId = document.querySelector("#postId").value;
		let postPassword = document.querySelector("#postPassword").value;
		console.log("postId : " + postId);
		console.log("postPw : " + postPassword);
		let data = {
			id : postId,
			password : postPassword
		}
		
		xhr.send(JSON.stringify(data));

		
		xhr.onload = () => {
			if(xhr.status == 200){
				console.log(xhr.response);
				let parseResponse = JSON.parse(xhr.response);
				console.log("parse response : " + parseResponse);
				document.querySelector("#responsePostId").innerText = parseResponse.id;
				document.querySelector("#responsePostPassword").innerText = parseResponse.password;
			} else{
				console.log("error");
			}
		}
		
	})
	
	
</script>
	
</html>