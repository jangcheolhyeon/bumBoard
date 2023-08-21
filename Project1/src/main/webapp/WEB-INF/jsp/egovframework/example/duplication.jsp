<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="user_id" value="${param.user_id}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복검사창</title>
</head>
<body>
<b><font size="4" color="gray">ID 중복 확인</font></b>
	<br>
	
	<form name="checkIdForm">
		<input type="text" name="id" id="userId" value="${user_id}" disabled>
			
		<c:choose>
			<c:when test="${sessionScope.result == 1}">
				<p style="color: red">이미 사용 중인 아이디입니다.</p>
				<input type="hidden" name="chResult" id="chResult" value="N"/>
			</c:when>
			<c:when test="${sessionScope.result == 0}">
				<p style="color: red">사용가능한 아이디입니다.</p>
				<input type="hidden" name="chResult" id="chResult" value="Y"/>
			</c:when>
			<c:otherwise>
				<p>오류 발생(-1)</p>
				<input type="hidden" name="chResult" id="chResult" value="N"/>
			</c:otherwise>
		</c:choose>

		<input type="button" onclick="window.close()" value="취소"/><br>
		<input type="button" id="useBtn" value="사용하기"/>
		
	</form>
</body>
<script>
	const useBtn = document.querySelector("#useBtn");
	const chResult = document.querySelector("#chResult");
	const userId = document.querySelector("#userId");
	
	
	const sendCheckValue = () => {
		console.log("click");
		if(chResult.value == "N"){
			alert("다른 아이디를 입력해주세요");
			
		} else{
			console.log("else");
			//window.opener.document.queryselector("#idCheckValue").value = "true";
			opener.document.querySelector("#duplicationBtn").disabled=true;
			window.close();
		}
	}
	
	useBtn.addEventListener("click", sendCheckValue);
	
	
</script>
</html>