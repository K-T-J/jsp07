<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%-- 두번째 --%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="web.jsp07.model.MemberDTO"/> <!-- dto 객체 생성 --> 
<jsp:setProperty property="*" name="dto"/>

<%

	MemberDAO dao = new MemberDAO();
	dao.insertMember(dto);


	// 3개중 선택
	//페이징 처리  #1. 가입처리 직후 바로 메인으로 이동시키기 (사용자는 가입 누르면 바로 main으로)
	response.sendRedirect("main.jsp"); //바로 이동
	
%>
	<%-- 
	<script>
	//페이징 처리#3.
	alert("회원가입이 정상적으로 처리 되었습니다.");
	window.location.href="main.jsp"; //메인 이동
	
	</script>
	--%>


<body>




	<%-- 페이징처리 #2. 가입처리 후 화면에 가입완료 메세지와 버튼 보임
	<h4> 회원가입 완료</h4>
	<button onclick = "window.location='main.jsp'">메인으로 이동</button> --%>
	
	
	
	<%-- 페이징처리 #4. 가입처리 후 화면에 가입완료 메세지 보여주고 5초후 다시 main이동
	<h4 align = "center"> <%= dto.getId()=>님 환영합니다 !!</h4>
	<meta http-equiv="Refresh" content="3;url=main.jsp"/> --%>
	
	
	
</body>
</html>