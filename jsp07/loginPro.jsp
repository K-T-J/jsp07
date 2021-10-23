<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인 pro</title>
</head>
<%
	//일곱번째
	request.setCharacterEncoding("UTF-8");
	

	//파라미터 받기	: loginForm 타고 왔을때 처리 (main에서 날라왔으면 아래 변수는 null 상태로 끝남)
	String id = request.getParameter("id");//main 에서 파라미터 값없이 넘어와서 null이다
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");//자동로그인 체크 박스 값 꺼내기
	
	//쿠키 체크 (loginForm을 안타고, main에 바로 날라왔을때는
	// 위 파라미터에서 값을 꺼내도 없기 때문에 다시 쿠키에서 id,pw,auto를 꺼내서 채워주기
	Cookie[] coos = request.getCookies();
	if(coos != null){
		for(Cookie c : coos){
			if(c.getName().equals("autoId"))id=c.getValue(); //다시 값을 저장
			if(c.getName().equals("autoPw"))pw=c.getValue();
			if(c.getName().equals("autoCh"))auto=c.getValue();
		}
	}
	
	System.out.println("id : "+id);
	System.out.println("pw : "+pw);
	System.out.println("auto : "+auto);
	
	
	
	//로그인 체크
	MemberDAO dao = new MemberDAO();
	boolean res =dao.idPwCheck(id,pw);
	
	if(res){//사용자가 입력한 id pw가 맞다 -> 로그인처리
		if(auto != null){//자동로그인 체크하고 로그인했다.
			//쿠키 생성
			Cookie c1 = new Cookie("autoId",id);
			Cookie c2 = new Cookie("autoPw",pw);
			Cookie c3 = new Cookie("autoCh",auto);
			c1.setMaxAge(60*60*24);//24시간 // 쿠키기간 갱신 
			c2.setMaxAge(60*60*24);
			c3.setMaxAge(60*60*24);
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
		}
		
		//if문 안에 들어오면 무조건 실행
		session.setAttribute("memId", id);//세션에 속성 추가!! ==로그인처리함
		response.sendRedirect("main.jsp");
	}else{%>
		<script>
			alert("id 또는 pw가 일치하지 않습니다. 다시 시도해주세요");
			history.go(-1);
		</script>
	
	
	<%}

%>



<body>

</body>
</html>