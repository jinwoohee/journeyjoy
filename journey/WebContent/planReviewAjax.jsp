<%@page import="com.jj.dto.Plan_review"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	List<Plan_review> prList = (List<Plan_review>)request.getAttribute("prList");

    for(com.jj.dto.Plan_review pr : prList){ %>
	<a href='plan_review_detail.jsp?page_no=<%=pr.getPr_no()%>&e_no=<%=pr.getE_no() %>'>
	<div class='review_div'>
		<img src='<%=pr.getU_profile() %>'/>
		<p><%= pr.getU_nickname()%></p>
		<div><%=pr.getPr_date() %></div>
		<img src='uploadFile/<%=pr.getPr_file() %>' />
		<div class='nation_div'>
			<img id="icon" src="img/icon/plane.png">
			<p><%=pr.getE_destination() %></p>
		</div>
		<div><p><%=pr.getPr_title() %></p></div>
		<p><%=pr.getPr_contents() %></p>
	</div>
	</a>
<%	}%>	
</body>
</html>