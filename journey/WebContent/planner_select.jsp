<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
	Cookie[] cookies = request.getCookies();
%>
<%!private String getCookieValue(Cookie[] cookies, String name){
		String value = null;
		if(cookies == null)
			return null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}%>
<%
	String e_destination = getCookieValue(cookies, "e_destination");	
	String e_start_date = getCookieValue(cookies, "e_start_date");
	String e_end_date = getCookieValue(cookies, "e_end_date");
	String thema = getCookieValue(cookies, "e_thema");
	String d_thema = getCookieValue(cookies, "e_detail_thema");
	String volume = getCookieValue(cookies, "e_volume");
	String food_st = getCookieValue(cookies, "e_food_taste");
	
	String e_detail_thema = d_thema.replaceAll("_", ", ");
	String e_food_taste = food_st.replaceAll("_", ", ");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(e_start_date);
	Date edate = sdf.parse(e_end_date);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	

	
	List<Eatery> eat = (List<Eatery>) request.getAttribute("eatery");
	List<Place> pla = (List<Place>) request.getAttribute("place");

%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_select.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript" src="js\planner_select.js"></script>	
	<script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB3FQ06J6teP32y6_sqWP8d2sRvB_321Us&callback=initMap&libraries=places&v=weekly"
      defer
    ></script>
</head>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner_edit.jsp" method="post">
		<div id="content">
			<div id="list_text">
				<p id="list_text">여행일정 선택</p>
			</div>
			<div id="main_content" >
			<div id="thema_div">
				<p id="city"><%= e_destination %></p>
				<p id="thema">여행테마</p>
				<img src="img\icon\arrow_up.png" width="23px" height="23px" id="up"/>			
				<img src="img\icon\arrow_down.png" width="23px" height="23px" id="down"/>
				<div id="detail_div">
					<p class="thema_text"><%= thema %></p>
					<p class="thema_text"><%= volume %></p>
					<p class="sub_thema"><%= e_detail_thema %></p>
					<p class="sub_thema"><%= e_food_taste %></p>
				</div>
				<a href="planner_main.jsp">
					<input type="button" name="edit_thema" value="테마수정하기" class="button" />
				</a>						
			</div>		
			
			<div id="plan_list">
				<%
				for(int a = 1 ; a <= datecnt*3 ; a++){
				%>
					<div class="list_content">
					<img src="<%= pla.get(a).getPlac_file1()%>" id="place_pic<%=a %>" />
					<div class="content_fdiv"> 
						<div class="list_place">
							<p class="list_place">
							<%
							for(int b = (a-1)*2 ; b <= (a-1)*2+1 ; b++){
								out.println("#"+pla.get(b).getPlac_name()+"&nbsp;");
								out.println("<input type='hidden' name='select_values"+a+"' value='"+pla.get(b).getPlac_name()+"'>");
							}
							for(int c = (a-1)*3 ; c <= (a-1)*3+2 ; c++){
								out.println("#"+eat.get(c).getEat_name()+"&nbsp;&nbsp");
								out.println("<input type='hidden' name='select_values"+a+"' value='"+eat.get(c).getEat_name()+"'>");
								}				
							%>
							</p>
						</div>
						<div class="list_thema">
						 	<%
							for(int b = (a-1)*2 ; b <= (a-1)*2+1 ; b++){
								out.println("<p class='list_thema'>"+pla.get(b).getPlac_detail_thema()+"</p>");								
							}
							for(int c = (a-1)*3 ; c <= (a-1)*3+2 ; c++){
								out.println("<p class='list_thema'>"+eat.get(c).getEat_food_taste()+"</p>");							
							} 
							%>
						</div>
						<div class="select_btn_div">
							<input type="button" name="select" value="일정추가" class="button" onclick="add_plan(<%=a%>)">
						</div>
					</div>
					<div class="content_detail">
						<p class="list_budget">평균예산<br>약 99,000 ~</p>
						<a href="planner_plan_detail.html">
							<input type="button" name="detail" value="일정 상세보기" class="button" >
						</a>
					</div>
				</div>
				<%						
					}				
				%>
				</div>
				<input type="button" name="finish_btn" value="선택완료" class="button" onclick="check_plan()"/>			
			</div>
		</div>
		<div id="select_div">
			<div id="select_plan_div">
				<div id="sel">
				<%
				for(int a = 1 ; a <= datecnt ; a++){
				%>
					<input type="hidden" id="next_a<%=a %>" value="none">
					<div class="select_plan">
						<p class="day">Day<%=a %></p>
						<img src="img\icon\select_plz.png" id="select_pic<%= a %>" class = "sel_picture"/>
						<input type="button" name="del<%=a %>" value="삭제" class="button" onclick="del_plan(<%=a%>)"/>
						<input type="hidden" name="selected<%=a %>" class= "selected" value="null" >
					</div>
				<%}%>
				</div>
				<input type="button" name="close" value="목록닫기" class="button" />
					<input type="button" name="finish" value="선택완료" class="button" onclick="check_plan()" />			
			</div>
		</div>
			<div id="side_menu">
				<p id="side_menu_p" align="center">side menu</p>
				<div id= "side_inner">
					<input type="button" name="open" value="목록열기" class="button" />
				</div>
			</div>
			</form>
	</section>
		
	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>