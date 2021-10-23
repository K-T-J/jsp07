<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Main</title>
   <link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%    if(session.getAttribute("memId") == null){ // 세션속성없다 
		// 세션이 없으면 쿠키는 잇니??
		String id = null, pw = null, auto=null;//쿠키가 있으면 꺼내서 값 담아놓을 변수 (쿠키유무 판단용 변수)
		Cookie[] coos = request.getCookies();//쿠키들  모두 꺼내기
		if(coos != null){//쿠키가 있다면
			for(Cookie c : coos){
				if(c.getName().equals("autoId")){id = c.getValue();} // 미리만들어둔 변수에 getValue 저장
				if(c.getName().equals("autoPw")){pw = c.getValue();}
				if(c.getName().equals("autoCh")){auto = c.getValue();}
			}
		}
		//세션은 없지만, 쿠키가 있어서 위코드로 값을 꺼내 담아보고, 
		// 만약에 세변수에 값이 들어있으면 session 만들어주기 위해 loginPro로 바로 이동시키기.
		if(id != null && pw != null && auto != null){
			response.sendRedirect("loginPro.jsp");
		}
%>

<%-- 메인 첫번째 화면 만들기 --%>
<body>
   <br />
   <h1 align="center"> Main </h1>
   <table>
      <tr>
         <td> 로그인 원하시면 버튼을 누르세요 <br />
            <button onclick="window.location='loginForm.jsp'"> 로그인 </button>         
         </td>
      </tr>
      <tr>
         <td> 
            <a href="signupForm.jsp"> 회원가입 </a>      
         </td>
      </tr>
   </table>
   <br /><br />
   <div align="center">
      <img src="imgs/제목 없음.png" width="600" />
   </div>
</body>





<%}else{  // 세션 속성 있다 == 로그인함 %>
<body>
   <br />
   <h1 align="center"> Main </h1>
   
   <table>
      <tr>
         <td> <%= session.getAttribute("memId") %> 님 환영합니다. <br /><br />
            <button onclick="window.location='logout.jsp'"> 로그아웃 </button>         
            <button onclick="window.location='mypage.jsp'"> 마이페이지 </button>         
         </td>
      </tr>
   </table>

   <br /><br />
   <div align="center">
      <img src="imgs/제목 없음.png" width="600" />
   </div>
</body>
<%}%>
</html>