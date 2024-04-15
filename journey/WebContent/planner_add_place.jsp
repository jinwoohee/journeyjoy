<%@page import="java.util.Arrays"%>
<%@page import="java.sql.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="com.jj.dto.Plan"%>
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
	
	List<Plan> planList = (List<Plan>)request.getAttribute("plan");
	request.setAttribute("plan", planList);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(e_start_date);
	Date edate = sdf.parse(e_end_date);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	
	
	String e_no = request.getParameter("e_no");
	System.out.println(e_no+" : add플레이스 e_no");
	
	if(e_no == null){
		e_no = "null";	
	}
%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>

	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_add_place.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	<script type="text/javascript" src="js\planner_add_place.js"></script>
	<script defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAN8pqDt8WwrtCF3kkPS7Snko0A-RTUns0&callback=initMap">
	</script>
</head>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner_edit.jsp" method="post">
		<input type="hidden" name="e_no" value=<%=e_no %>>
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
						
				<div id="search">
					<input type="text" name ="search_place" placeholder ="이름, 테마로 검색" />
					<button type="submit" name="search_btn">
					<img src="img/icon/search_btn.png" id="search_btn" />
					</button>
					<div id="search_result">
					<div id="result_list">
					
					<%
					
					List<Place> pla = (List<Place>) request.getAttribute("search_place");
					
					if(pla == null){
						out.println("<input type='radio' name='place_one' id='search_plz'><label for='search_plz' class='pl_label'>검색어를 입력해주세요.</label>");
						out.println("</div>");		
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<input type='button' id='plan_add"+a+"' value='여행지 추가' class='button' />");	
						}		
					}
					else{
						
						int z=0;
						for(Place plalist : pla){
							z++;
											
							out.println("<input type='checkbox' name='place_one' value='"+plalist.getPlac_name()+"' id= 'pone"+z+"' onclick='checking(this.id)'>");
							out.println("<label for='pone"+z+"' class='pl_label'>"+plalist.getPlac_name()+"</label>");									
								System.out.println(plalist.getPlac_name());
						}
						out.println("</div>");		
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<input type='button' id='plan_add"+a+"' value='여행지 추가' class='button' onclick='plan_add_btn("+a+")'/>");	
						}	
					}
					%>
										

				</div>		
				</div>	
							
				<div id="map"></div>
				
				<%
				for(int a = 1 ; a <= datecnt ; a++){ 
					String place_name = request.getParameter("place_name"+a);
					String place_cookie = getCookieValue(cookies, "pla"+a);
					String place_attr = (String) request.getAttribute("planList"+a);
					System.out.println(place_attr+"1번");
					out.println("<div id='places"+a+"'>");
					if(place_name == null ){
						if(place_cookie.equals("")){
							out.println("<p id='places_textb"+a+"'>일정이 비어있습니다.</p>");
							out.println("<p id='places_text"+a+"'></p>");
							out.println("<input type='hidden' name='edit_plan"+a+"' value='1' id='edited"+a+"'>");
						}else if(place_attr != null && !place_cookie.equals("")){
							out.println("<p id='places_text"+a+"'>"+place_attr+"</p>");
							out.println("<input type='hidden' name='edit_plan"+a+"' value='"+place_attr+"' id='edited"+a+"'>");
						}else{
							out.println("<p id='places_text"+a+"'>");
							
							String pa_list ="";						
							String place_edit = place_cookie.replaceAll("empty", "");
							String [] pla_ck = place_edit.split("_");
							for(String pa : pla_ck){
								out.println("#"+pa);
								pa_list += "#"+pa+" ";
							}
						out.println("</p>");
				%>		
				<input type="hidden" name="edit_plan<%=a %>" value="<%=pa_list %>" id="edited<%=a%>">	
				<% 	
						}
					}else if(place_name.equals("empty") || place_cookie.equals("")){
						response.addCookie(new Cookie("pla"+a, ""));
						out.println("<p id='places_textb"+a+"'>일정이 비어있습니다.</p>");
						out.println("<p id='places_text"+a+"'></p>");
						out.println("<input type='hidden' name='edit_plan"+a+"'value='3' id='edited"+a+"'>");
					}
					else{
						String place_ck = place_name.replaceAll(",", "_").replaceAll("empty","");
						String []place = place_ck.split("_");
						String st_list = "";
						out.println("<p id='places_text"+a+"'>");
							for(String st : place){
								out.println("#"+st);
								st_list += "#"+st+" ";
							}
						out.println("</p>");
						String st_list_arr = st_list.replaceAll("#", "").replaceAll(" ", "_");
						response.addCookie(new Cookie("pla"+a, st_list_arr));
				%>	
				<input type="hidden" name="edit_plan<%=a %>" value="<%=st_list %>" id="edited<%=a%>">
				<% 
					}			
					out.println("</div>");
				}
				%>	
				<input type="hidden" name="edit_plan0" value="1">  
				<input type="submit" name="save_plan" value="저장" class="button">		

			</div>
		</div>
		<div id="side_menu">
			<p id="side_menu_p" align="center">side menu</p>
			<div id= "side_inner">
				
				<input type="submit" name="plan_sel" value="뒤로가기" class="button">
				
			</div>
			</div>
			</div>>
		</form>
	</section>
	<footer>
	      <jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>