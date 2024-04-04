<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- <%
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="place" class="com.jj.dao.Review">
		<%
			/* String filter = request.getParameter("filter");
			String nation = request.getParameter("nation");
			String city = request.getParameter("city");
			String category = request.getParameter("category"); //음식점인지 관광지인지 */
			String search = request.getParameter("search");
			
			place.search_placeReview(search);
		%>
	</jsp:useBean>
</body>
</html>