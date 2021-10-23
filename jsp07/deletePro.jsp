<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴 pro</title>
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
	//넘어오는 데이터 : pw
	String id = (String)session.getAttribute("memId");//session에서
	String pw = request.getParameter("pw");		
	System.out.println("deletepro id : " + id);
	System.out.println("deletepro pw : " + pw);
	//form에서 
	//id,pw 체크 -> true면
	//delete from users where id=?
	
	
	MemberDAO dao = new MemberDAO();
	int result = dao.deleteUser(id,pw);
	//result ==1 : 회원탈퇴 처리 성공
	//result ==0 : 비번잘못
	//result ==-1 : 비번 가져오는것 부터 잘못됨. id가 문제일 가능성 높음.
			
	//회원 정보 삭제가 잘 진행되었을때,
	if(result == 1){
		//회원탈퇴시 로그아웃  처리도 함께
		session.invalidate();
		//쿠키가 있으면 쿠키도 삭제
		Cookie[] coos = request.getCookies();
		if(coos != null){
			for(Cookie c: coos){
				if(c.getName().equals("autoId")|| c.getName().equals("autoPw")|| c.getName().equals("autoCh")){
					c.setMaxAge(0);
					response.addCookie(c);
				}

			}
		}
	%>

<body>

			<br/>
			<h1 align = "center"> 회원 정보 수정</h1>
	<table>
		<tr>
			<td>회원 정보가 삭제 되었습니다</td>
		</tr>
		<tr>
			<td><button onclick="window.location='main.jsp'">메인으로 </button></td>
		</tr>
	</table>

	<%}else{%>
		
		<script>
			alert("비밀번호가 맞지 않습니다 .다시 시도해주세요..");
			history.go(-1);
		</script>
	
	
	
	<%}%>
</body>
<%} %>
</html>