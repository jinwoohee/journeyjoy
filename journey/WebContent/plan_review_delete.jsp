<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />
<%
	request.setCharacterEncoding("utf-8");

	dto.setu_id((String) session.getAttribute("u_id"));

	String pr_no = request.getParameter("page_no");
	
	dao.delete_plan_review(pr_no);
	response.sendRedirect("plan_review_list.jsp");
%>
