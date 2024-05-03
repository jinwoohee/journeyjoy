<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
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
	
	$(function() {
		
	});
</script>
<body>
	<section>
		<div>
			<div>
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
						<%
						//네이버
						String clientId = "lEYwWdovBT_X9ayS_3P9";
					    String redirectURI = "http://localhost:8091/journey/oauth.jj?page=naverLogin";
					    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
					    SecureRandom random = new SecureRandom();
					    String state = new BigInteger(130, random).toString();
					    apiURL += "&client_id=" + clientId;
					    apiURL += "&redirect_uri=" + redirectURI;
					    apiURL += "&state=" + state;
					    session.setAttribute("state", state);
						
						
						//카카오
						String client_id = "97d3d4fdd304333d14ac189994d057ea";
						String redirect_uri = "http://localhost:8091/journey/oauth.jj?page=kakaoLogin";
						String url = "https://kauth.kakao.com/oauth/authorize?client_id=" + client_id + "&redirect_uri=" + redirect_uri + "&response_type=code";
						%>
						<a href="<%= apiURL %>"><img src="img/icon/naver.png"/></a>
						<a href="<%= url %>"><img src="img/icon/kakao.png"/></a>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>