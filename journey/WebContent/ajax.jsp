<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="com.jj.dto.Package_like"%>
<%@page import="com.jj.dto.Package"%>
<%@page import="java.util.List"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" type="text/css" href="css/packageSearch.css">   
</head>
<body>
	<ul>
		<%
			List<Package> pkList = (List<Package>)request.getAttribute("pkList");

			for(Package list : pkList){
				out.println("<li>");
				out.println("<input type='hidden' name='p_no' value='"+list.getP_no()+"'>");
				out.println("<div class='thumnail'>");
				out.println("<a href='packageDetail.jj?page=package_detail&p_no="+list.getP_no()+"'>");
				out.println("<img src='"+list.getP_file()+"'/></a></div>");
				out.println("<div><img src='img/icon/heart2.png'/></div>");
				
				out.println("<div><P class='title'>"+list.getP_title()+"</P></div>");
				out.println("<div><P>"+list.getChild_fee()+"~</P></div>");
				out.println("<div><P>"+list.getU_nickname()+"</P></div>");
				out.println("</li>");
			}
		%>
	</ul>
</body>
</html>