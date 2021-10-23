<%@page import="web.jsp07.model.MemberDTO"%>
<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 수정</title>
	<link href="style.css" rel = "stylesheet" type = "text/css">
</head>
<%
	if(session.getAttribute("memId") == null){%>
	<script>
			alert("로그인해주세요")
			window.location = "/web/jsp07/loginForm.jsp"
	</script>
<%}else{ %>

<%
	//회원정보를 가져온다. id로 구분 
	//세션을 스트링으로 만들어서 String에 담는다.
	String id = (String)session.getAttribute("memId");//getAttribute 빨간줄 object 타입
	
	MemberDAO dao = new MemberDAO();
	MemberDTO user = dao.getUser(id);//메서드 없으니 다시 DAO로 이동
	
%>
<body>
	<br/>
	<h1 align = "center"> 회원 정보 수정</h1>


	<form action="modifyPro.jsp" method="post"> <!-- 주소창에 get은 공개 post 비공개 -->
		<table>
			<tr>
				<td>ID *</td>
				<td>
					<%= user.getId()%>
				</td>
			
			</tr>
			<tr>
				<td>Password *</td>
				<td>
					<input type = "password" name="pw" value="<%= user.getPw()%>"/>
				</td>
			
			</tr>
			<tr>
				<td>Password Confirm*</td>
				<td>
					<input type = "password" name="pwch"/>
				</td>
			
			</tr>
			<tr>
				<td>Name *</td>
				<td>
					<%= user.getName() %>
				</td>
			
			</tr>
			<tr>
				<td>Email </td>
				<td>
				<%if(user.getEmail() == null){ %>
					<input type="text" name = "email"/>
					<%}else{%>
					<input type="text" name = "email" value="<%= user.getEmail()%>"/>
					
					<%}%>
				</td>
			
			</tr>
			<tr>
				<td>Date of Birth </td>
				<td>
				<%if(user.getBirth()==null) {%>
					<input type = "text" name="birth" placeholder="YYYYMMDD" maxlength="8"/>
				<%}else{ %>
					<input type = "text" name="birth" maxlength="8" value="<%= user.getBirth()%>"/>
				
				<%} %>
				</td>
			
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value = "수정"/>
					<input type="reset" value = "재작성"/>
					<input type="button" value = "취소" onclick = "window.location='main.jsp'"/>
				</td>
			</tr>

		</table>
	</form>
	
</body>
<%}//else %>
</html>