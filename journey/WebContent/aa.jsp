<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.jj.dto.Package_schedule"%>
<%
	request.setCharacterEncoding("utf-8");
	int p_period = (int)session.getAttribute("p_period");
	int p_no = (int)session.getAttribute("p_no");
%>
<!DOCTYPE html>
);
		
		map.put(request.getParameterValues("ps_day")[i], ps);
	}
	
	request.setAttribute("map", map);
	RequestDispatcher dispatcher = request.getRequestDispatcher("scheduleInsert.jj?page=package_scheduleInsert");
	dispatcher.forward(request, response);

%>
</body>
</html>