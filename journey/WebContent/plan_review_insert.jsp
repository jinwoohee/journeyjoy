<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />
<%
	request.setCharacterEncoding("utf-8");

	dto.setu_id((String) session.getAttribute("u_id")); 
	dto.setpr_title(request.getParameter("title"));
	dto.setpr_contents(request.getParameter("content"));
	//String [] h = (request.getParameterValues("place"));
	//String place = "";
	//for(String st : h){
	//	place+=st+", ";
	//}
	//place = place.substring(0, place.lastIndexOf(","));
	
	dao.insert_plan_review(dto.getu_id(), dto.getpr_title(), dto.getpr_contents());
	response.sendRedirect("plan_review_list.jsp");
%>
<%-- <%
	String start = "2024-03-12";
	String end = "2024-03-15";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(start);
	Date edate = sdf.parse(end);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	for(int day = 1 ; day <= datecnt ; day++){
		String dr = request.getParameter("day_review"+day);
		dao.insert_day_review(day, dr);
}
%> --%>