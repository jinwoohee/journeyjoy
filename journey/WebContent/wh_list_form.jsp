<%@page import="java.util.List"%>
<%@page import="com.jj.dto.Company"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>workingholiday_list_form</title>
	<link href="css/wh_list_form.css" rel="stylesheet" type="text/css">
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<th width="150px">근무지</th>
			<th width="600px">회사명/공고제목</th>
			<th width="100px">근무시간</th>
			<th width="100px">급여</th>
			<th width="100px">마감날짜</th>
		</tr>
		<%
			List<Company> list = (List<Company>)request.getAttribute("list");
			
			for (Company c : list) {
		%>
		<tr>
			<td><%= c.getCom_country() + " / " + c.getCom_city() %></td>
			<td>
				<a href="workingholiday.jj?page=whlist&com_no=<%= c.getCom_no() %>">
					<p><%= c.getCom_name() %></p>
					<p><%= c.getCom_title() %></p>
				</a>
			</td>
			<td><%= c.getCom_start_time() + ":00~" + c.getCom_end_time() + ":00" %></td>
			<td><%= c.getCom_salary()%>원</td>
			<td><%= c.getCom_term() %></td>
		</tr>
		<% } %>
	</table>
</body>
</html>