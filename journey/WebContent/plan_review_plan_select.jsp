<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8");
List<Estimate> esti = (List<Estimate>) request.getAttribute("estilist");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <link href="css/plan_review_plan_select.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>

<body>
<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
		<div id="content">
			<p>계획서 선택</p>
			<%
				for(Estimate es : esti){%>
				<a href="plan_review_write.jsp?e_no=<%=es.gete_no()%>&e_destination=<%=es.gete_destination()%>&page_no=write&e_start_date=<%=es.gete_start_date() %>&e_end_date=<%=es.gete_end_date() %>">
					<div class="plan_div">
						<p><%=es.gete_destination() %></p>
						<p><%=es.gete_start_date() %> ~ <%=es.gete_end_date() %></p>
						<p><%=es.gete_thema()+es.gete_detail_thema()+es.gete_food_taste()+es.gete_volume() %></p>
					</div>
				</a>
			<%} %>
		</div>
	</section>
		<jsp:include page="main_footer.jsp" />	
</body>
</html>