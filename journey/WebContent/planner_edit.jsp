<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>

<!DOCTYPE html>
<%	request.setCharacterEncoding("utf-8");
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
	
	List<Eatery> da = (List<Eatery>) request.getAttribute("eat");
	List<Place> pe = (List<Place>) request.getAttribute("place");
	
	String edit0 = request.getParameter("edit_plan0");
	System.out.println(edit0+"0번");
%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_edit.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript" src="js\planner_edit.js"></script>
</head>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner.jj?page=insert" method="post">
		<div id="content">
			<div id="list_text">
				<p id="list_text">여행일정</p>
				<div id="day_div">
					
					<%
						for(int a = 1 ; a <= datecnt ; a++){ 
							out.println("<p id='day"+a+"' onclick='day_select("+a+")'>Day"+a+"</p>");
						}
					%>				
				</div>
			</div>
			
			<div id="thema_div">
				<p id="city"><%=e_destination%></p>
				<p id="thema">여행테마</p>
				<img src="img\icon\arrow_up.png" width="23px" height="23px" id="up"/>			
				<img src="img\icon\arrow_down.png" width="23px" height="23px" id="down"/>
				<div id="detail_div">
					<p class="thema_text"><%=thema%></p>
					<p class="thema_text"><%=volume%></p>
					<p class="sub_thema"><%=e_detail_thema%></p>
					<p class="sub_thema"><%=e_food_taste%></p>
				</div>
				<a href="planner_main.jsp">
					<input type="button" name="edit_thema" value="수정하기" class="button" />
				</a>						
			</div>		
			<div id="plan_list">
			<%
				for(int a = 1 ; a <= datecnt ; a++){
					out.println("<input type='hidden' name='place_name"+a+"' value='empty'>");
					if(edit0 == null){
						String place =request.getParameter("selected"+a);
						String place_list = place.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(",", "_");
						response.addCookie(new Cookie("pla"+a, place_list));
						String [] list_place = place.split(",");
						
						System.out.println("1번"+place_list);
			%>
				<div id="plan_list_day<%=a%>">
				<%	int z= 0;
					for(String st : list_place){
						z++;
				%>
				<div id="list_content<%=a*100+z%>">
					<img src="img\japan\tokyo1.jpg" class="place_pic" />	
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_place" >#<%=st%></p>
							<input type="hidden" name="place_name<%=a%>" value="<%=st %>" />
						</div>
						<div class="list_thema">
						
						</div>	
						<input type="button" name="delete" value="삭제" onclick="del_list(<%=a*100+z %>)" class="button"/>	
					</div>
					<div class="content_detail">
						<p class="list_budget">평균가격<br>약 20,000원 ~</p>
						<input type="button" name="detail" value="상세정보 보기" class="button"/>
					</div>
				</div>
				<% }%>
				</div>		
						
			<%
					}else if(edit0.equals("1")){
						String place = request.getParameter("edit_plan"+a);
						String place_list = place.replaceAll("#", "").replaceAll(" ","_");
						System.out.println("2-1-"+a+"번"+place);
						System.out.println("2-2-"+a+"번"+place_list);
						
						response.addCookie(new Cookie("pla"+a, place_list));
						String [] list_place = place_list.split("_");
			%>
				<div id="plan_list_day<%=a%>">
				<%	int z= 0;
					for(String st : list_place){	
						z++;
						System.out.println(st+z+"5번");
						
				%>
				<div id="list_content<%=a*100+z%>">
					<img src="img\japan\tokyo1.jpg" class="place_pic" />	
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_place" >#<%=st%></p>
							<input type="hidden" name="place_name<%=a%>" value="<%=st %>" />
						</div>
						<div class="list_thema">
						
						</div>	
						<input type="button" name="delete" value="삭제" onclick="del_list(<%=a*100+z %>)" class="button"/>	
					</div>
					<div class="content_detail">
						<p class="list_budget">평균가격<br>약 20,000원 ~</p>
						<input type="button" name="detail" value="상세정보 보기" class="button"/>
					</div>
				</div>
				<% }%>
				</div>
			<%
			}}
			%>
					<input type="submit" name="add_place" value="여행지 추가하기" class="button">
					<input type="submit" name="save_plan" value="저장" class="button"/>
			</div>
			</div>
		<div id="side_menu">
			<p id="side_menu_p" align="center">side menu</p>
			<div id= "side_inner">
				<a href="planner_select.jsp">
					<input type="button" name="plan_sel" value="일정선택&#10;목록으로" class="button">
				</a>
					<input type="submit" name="plan_sel_add" value="여행지&#10;추가하기" class="button">
			</div>
		</div>
		</form>
	</section>
	<footer>
       <jsp:include page="main_footer.jsp" />	
    </footer>
</body>
</html>