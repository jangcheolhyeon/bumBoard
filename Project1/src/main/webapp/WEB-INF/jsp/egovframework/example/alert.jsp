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

</body>
<script>
	let msg = "<c:out value='${msg}'/>";
	let url = "<c:out value='${url}'/>";
	
	alert(msg);
	location.href = url;
	
</script>
</html>