<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>회원정보수정pro</title>
		<link href="style.css" rel = "stylesheet" type = "text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	if(session.getAttribute("memId") == null){%>
	<script>
			alert("로그인해주세요")
			window.location = "/web/jsp07/loginForm.jsp"
	</script>
<%}else{ %>


<jsp:useBean id="dto" class = "web.jsp07.model.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	//넘어오는 데이터 : birth, email /pw는 따로 하는게 좋다
	//update users set birth=?, email=? where id=?
	//modifyForm에서는 id값이 안 넘어외서 위에 dto에 자동으로 채워 주지 못함
	//그래서 session에서 id 값 거내서 dto에 따로 추기하기
	String id = (String)session.getAttribute("memId");
	dto.setId(id);
	
	
	//DB 접근, 해당 id의 birth와 email 업데이트 해주기.
	MemberDAO dao = new MemberDAO();
	int result = dao.updateUser(dto);
	
	
%>


<body>
	<br/>
	<h1 align = "center"> 회원 정보 수정</h1>
	<%
		if(result == 1){%>
		
			<table>
				<tr>
					<td><b>회원 정보가 수정되었습니다</b></td>
				</tr>
				<tr>
					<td><button onclick = "window.location='main.jsp'">메인으로</button></td>
				</tr>
			</table>
		
		<%}else{%>
			<script>
				alert("회원 정보 수정 실패..");
				history.go(-1);
			</script>
		<% }%>
<%} %>


</body>
</html>