<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login</title>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/login.css">
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<script>
	//입력 값 확인
	function login(){
		if(loginForm.u_id.value == ''){
			loginForm.u_id.focus();
			return false;
		}else if(loginForm.u_pw.value == ''){
			loginForm.u_pw.focus();
			return false;
		} 
		
		<%
			String success = request.getParameter("success");
			//out.println(success);
			
			if (success == "no") {
				out.println("ok");
			}
		%>
	}
</script>
<body>
	<section>
		<div>
			<div>
				<p>로그인</p>
				<a href="index.jsp"><img src="img/icon/home.png" /></a>			
				<img src="img/icon/logo.png" />
				<form name="loginForm" action="login_session.jsp" align="center" onsubmit="return login()">
					<input type="text" name="u_id" placeholder="아이디">
					<input type="password" name="u_pw" placeholder="비밀번호">
					<input type="submit" value="로그인">
				</form>
				<div id="serch">
					<div>
						<p><a>아이디찾기</a>ㅣ<a>비밀번호찾기</a></p>
					</div>
					<div>
						<a href="join.jsp"><p>회원가입</p></a>
					</div>
				</div>
				<div id="easy_log">
					<div>
						<p>간편하게<br>로그인하기</p>
					</div>	
					<div>
						<img src="img/icon/easy_log.png" align="right" />
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>