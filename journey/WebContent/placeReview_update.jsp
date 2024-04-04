<%@page import="com.jj.dto.Location_review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
	int lr_no = Integer.parseInt(request.getParameter("lr_no"));
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="place" class="com.jj.dao.Review">
		<%
			//update
			request.setCharacterEncoding("utf-8");
			Location_review lr = new Location_review();
		
			lr.setU_id(u_id);
			lr.setLr_no(lr_no);
			
			//lr.setPl_eat_no(Integer.parseInt(request.getParameter("plac_no")));
			lr.setLr_contents(request.getParameter("contents"));
			lr.setLr_file1("img/canada/toronto1.jpg");
			lr.setLr_file2("img/canada/toronto2.jpg");
			lr.setLr_file3("img/canada/toronto3.jpg");
			lr.setLr_star(Integer.parseInt(request.getParameter("starRating")));
			
			place.update_placeReview(lr.getU_id(), lr.getLr_no(), lr.getLr_contents(), lr.getLr_file1(), lr.getLr_file2(), lr.getLr_file3(), lr.getLr_star());
			
			response.sendRedirect("place_review.jsp");
		%>
	</jsp:useBean>
</body>
</html>