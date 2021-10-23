<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link href="style.css" rel = "stylesheet" type = "text/css">
		<script>
			//유효성 검사
			function check(){
				var inputs = document.inputForm;
				if(!inputs.id.value){//값이 없을때
					alert("아이디를 입력하세요")
					return false;
				}
				if(!inputs.pw.value){//값이 없을때
					alert("비밀번호를 입력하세요")
					return false;
				}
				if(!inputs.pwch.value){//값이 없을때
					alert("비밀번호 확인란을 입력하세요")
					return false;
				}
				if(!inputs.name.value){//값이 없을때
					alert("이름을 입력하세요")
					return false;
				}
				//비밀번호와 비밀번호 확인란 작성값 동일 체크
				if(inputs.pw.value != inputs.pwch.value){
					alert("비밀번호를 동일하게 입력하세요");
					return false;
				}
			}//check
			
			
			//아이디 중복 여부 판단
			function confirmId(inputForm){//inputForm <- this.form 객체 받음
				if(inputForm.id.value =="" || !inputForm.id.value){
					alert("아이디를 입력하세요");
					return; //강제종료
				}
				// 팝업 
				var url = "confirmId.jsp?id=" + inputForm.id.value; //ex)confirmId.jsp?id=pika
				
				open(url, "confirmId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no resizeable=no, width=300, height=200");		
				
			}
			
		</script>
</head>
<body>
	<%-- 맨처음 --%>
	<br/>
	<h1 align = "center"> 회원가입</h1>

																<%--submit을 false로 바꿔 못넘어가게 --%>
	<form action="signupPro.jsp" method="post" name = "inputForm" onsubmit="return check()" > <!-- 주소창에 get은 공개 post 비공개 -->
		<table>
			<tr>
				<td>ID *</td>
				<td>
					<input type = "text" name="id"/>
				</td>
			
			</tr>
			<tr>
				<td>아이디 중복체크</td>
				<td>
					<input type = "button" value="아이디 중복 확인" onclick = "confirmId(this.form)"/>
				</td>
			
			</tr>
			<tr>
				<td>Password *</td>
				<td>
					<input type = "password" name="pw"/>
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
					<input type = "text" name="name"/>
				</td>
			
			</tr>
			<tr>
				<td>Email </td>
				<td>
					<input type = "text" name="email"/>
				</td>
			
			</tr>
			<tr>
				<td>Date of Birth </td>
				<td>
					<input type = "text" name="birth" placeholder="YYYYMMDD" maxlength="8"/>

				</td>
			
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value = "가입"/>
					<input type="reset" value = "재작성"/>
					<input type="button" value = "취소" onclick = "window.location='main.jsp'"/>
				</td>
			</tr>

		</table>
	</form>







</body>
</html>