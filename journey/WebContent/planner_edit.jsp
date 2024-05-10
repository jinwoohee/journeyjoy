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
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(e_start_date);
	Date edate = sdf.parse(e_end_date);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	
	List<Eatery> da = (List<Eatery>) request.getAttribute("eat");
	List<Place> pe = (List<Place>) request.getAttribute("place");
	
	List<Plan> planList = (List<Plan>)request.getAttribute("plan");
	request.setAttribute("plan", planList);
	
	String e_no = request.getParameter("e_no");
	
	String edit0 = request.getParameter("edit_plan0");
	System.out.println("edit로 왔다"+e_no+"edit0:"+edit0);
	String pa="";
	if(e_no == null){
		pa = "null";
	}else{
		pa = e_no;
	}
	String day = datecnt+"";
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
	<input type="hidden" name="e_no" value="<%=e_no%>">	
	<input type="hidden" name="day" value="<%=day%>">
		<div id="content">
			<div id="list_text">
				<p id="list_text">| 여행일정</p>
				<div id="day_div">
					
					<%
						for(int a = 1 ; a <= datecnt ; a++){ 
							out.println("<p id='day"+a+"' onclick='day_select("+a+")'>DAY"+a+"</p>");
						}
					%>				
				</div>
			</div>
			<%
			if(edit0 == null){
				
			}else if(edit0.equals("1")){
				
			}
			%>
			<div id="main_content">
			<div id="thema_div">
				<img src="img/icon/point.png">
				<p id="city"><%=e_destination%></p>
				<hr>
				<p id="thema">여행테마</p>
				<img src="img\icon\arrow_up.png" width="23px" height="23px" id="up"/>			
				<img src="img\icon\arrow_down.png" width="23px" height="23px" id="down"/>
				<div id="detail_div">
					<div><p class="thema_text"><%=thema%></p></div>
					<div><p class="thema_text"><%=volume%></p></div>
					<div><p class="sub_thema"><%=e_detail_thema%></p></div>
					<div><p class="sub_thema"><%=e_food_taste%></p></div>
				</div>
				<a href="planner_main.jsp">
					<input type="button" name="edit_thema" value="수정하기" class="button" />
				</a>						
			</div>		
			<div id="plan_list">
			<%
				for(int a = 1 ; a <= datecnt ; a++){
				
					String st_list = "";
					if(edit0 == null){
						String place =request.getParameter("selected"+a);
						String place_list = place.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(",", "_").replaceAll(" ", "-");
						response.addCookie(new Cookie("pla"+a, place_list));
						System.out.println("1번째:"+place_list);
						String [] list_place = place.split(",");
						String id_value = request.getParameter("id_selected"+a);
						String [] list_id = id_value.split(",");
		
			%>
				<div id="plan_list_day<%=a%>">
				<%	int z= 0;
					for(String st : list_place){
						st_list += st+",";
						z++;
				%>
				<div id="list_content<%=a*100+z%>">
					<input type="hidden" name="place_id_src" value="<%=list_id[z-1]%>">
					<img src="img\japan\tokyo1.jpg" class="place_pic" />	
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_place" >#<%=st%></p>				
							<input type="hidden" id="pla_val<%=a*100+z %>" value="<%=st %>">		
						</div>
						<div class="list_thema">
						
						</div>	
						<input type="button" name="delete" value="삭제" onclick="del_list(<%=a*100+z %>)" class="button"/>	
					</div>
					<div class="content_detail">
						<div class="list_budget">
							<p>평균예산</p>
							<p>약 99,000 ~</p>
						</div>
						<input type="button" name="detail" value="상세정보 보기" class="button"/>
					</div>
				</div>
				<% }%>
				<input type="hidden" name="place_name<%=a%>" value="empty<%=st_list %>" id = "place_name<%=a%>" />
				</div>		
						
			<%
					}else if(edit0.equals("1")){
						String place = request.getParameter("edit_plan"+a);
						System.out.println("애드플레이스에서 온 값"+place);
						if(place != ""){
						String place_list = place.replaceAll("#", "").replaceAll(",","_").replaceAll("new", "").replaceAll("\\(", "").replaceAll("\\)", "").replaceAll(" ", "-");
						String place_list_sp = place_list.replaceAll("-", " ").replaceAll("_",",");
						System.out.println("dsadsa"+place_list_sp);
						System.out.println("dsadsa2"+place_list);
						
						response.addCookie(new Cookie("pla"+a, place_list));
						String [] list_place = place_list_sp.split(",");
			%>
				<div id="plan_list_day<%=a%>">
				<%	int z= 0;
				
					for(String st : list_place){	
						st_list += st+",";
						z++;
				%>
				<div id="list_content<%=a*100+z%>">
					<img src="img\japan\tokyo1.jpg" class="place_pic" />	
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_place" >#<%=st%></p>
							<input type="hidden" id="pla_val<%=a*100+z %>" value="<%=st %>">
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
				<input type="hidden" name="place_name<%=a%>" value="empty<%=st_list %>" id = "place_name<%=a%>"/>
				</div>
			<%
					}else{%>
					<div id="plan_list_day<%=a%>">
						<div id="list_content">
							<div class="content_fdiv">
								<div class="list_place">
									<p class="list_place" >일정이 비었습니다.</p>
								</div>
							</div>
						</div>
					</div>
			<% 	
					}							
				}
			}
			%>
					<input type="submit" name="add_place" value="여행지 추가하기" class="button">
			

			</div>
							<%if(pa.equals("null")) {%>
					<input type="submit" name="save_plan" value="저장" class="button"/>		
				<%}else{ %>
					<input type="submit" name="save_plan_edit" value="수정" class="button"/>	 
				<%} %>
			</div>
			</div>
		<div id="side_menu">
			<p id="side_menu_p" align="center">side menu</p>
				<a href="planner_select.jsp">
					<input type="button" name="plan_sel" value="일정선택&#10;목록으로" class="button">
				</a>
					<input type="submit" name="plan_sel_add" value="여행지&#10;추가하기" class="button">
		</div>
		</form>
	</section>
	<footer>
       <jsp:include page="main_footer.jsp" />	
    </footer>
</body>
</html>