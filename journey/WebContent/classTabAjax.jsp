<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.jj.dto.Class_list"%>
<%@page import="java.util.ArrayList"%>    
<%
	String u_id = (String)session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" type="text/css" href="css/classList.css">
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<body>
<!-- 리스트 출력 -->
	<%
		ArrayList<Class_list> classList = (ArrayList<Class_list>)request.getAttribute("clist");		
		
		if(classList.size() < 1){
			out.println("<p id='noClass' align='center'>등록된 모임이 없습니다.</p>");
		}
		
		for (Class_list c : classList) {
	%>
	<div id="class_section">
		<!-- 프로필/닉네임 -->
		<div >
			<img class='profile' src="img/profile/d.jpg">
			<p><%= c.getU_nickname() %></p>	
		</div>
		<div>
			<div>
				<img src="img/canada/toronto1.jpg">
			</div>
			<div>
				<img src="img/icon/location.png">
				<p><%= c.getC_city() %></p>
				<div>
					<table>
						<tr>
							<td>모임명</td>
							<td><%= c.getC_title() %></td>
						</tr>
						<tr>
							<td>모임 내용</td>
							<td><%= c.getC_contents() %></td>
						</tr>
						<tr>
							<td>모집 인원</td>
							<td>1/<%= c.getC_volume() %>명</td>
						</tr>
						<tr>
							<td>예상 경비</td>
							<td><%= c.getC_charge() %></td>
						</tr>
						<tr>
							<td>모집 종료</td>
							<td><%= c.getC_end_date() %></td>
						</tr>
					</table>
					<%
						if(c.getA_id() != null){
							if(c.getA_id().equals(u_id) && c.getC_no() == c.getA_no()){%>
								<input type='button' name='del_btn<%=c.getC_no() %>' value='참여취소' onclick='delClass(<%=c.getC_no() %>)'>
							<%}else{%>
								<input type='button' name='join_btn<%=c.getC_no() %>' value='모임참여' onclick='joinClass(<%=c.getC_no() %>)'>
							<%}
						}else{
					%>
					<input type='button' name='join_btn<%=c.getC_no() %>' value='모임참여' onclick='joinClass(<%=c.getC_no() %>)'>
					<%} %>
				</div>
			</div>
		</div>
	</div>
	<% } %>
</body>
</html>