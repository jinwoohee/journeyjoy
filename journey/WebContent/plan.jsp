<%@page import="com.jj.dto.Product"%>
<%@page import="com.jj.dto.Ticket"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="com.jj.dto.Schedule"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%
request.setCharacterEncoding("utf-8");
	Cookie[] cookies = request.getCookies();
%>
<%!
	private String getCookieValue(Cookie[] cookies, String name){
		String value = null;
		if(cookies == null)
			return null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}
%>
<% 
List<Estimate> esti = (List<Estimate>) request.getAttribute("estimate");
List<Schedule> sche = (List<Schedule>) request.getAttribute("schedule");
List<Ticket> tick = (List<Ticket>) request.getAttribute("ticket");
List<Product> prod = (List<Product>) request.getAttribute("product");
int items = (int) Math.ceil((double) (tick.size()+prod.size())/3);



String e_destination = esti.get(0).gete_destination();
String e_start_date = esti.get(0).gete_start_date();
String e_end_date = esti.get(0).gete_end_date();
String thema = esti.get(0).gete_thema();
String d_thema = esti.get(0).gete_detail_thema();
String volume = esti.get(0).gete_volume();
String food_st = esti.get(0).gete_food_taste();

String [] e_detail_thema = d_thema.split(",");
String [] e_food_taste = food_st.split(",");

String sdt = e_start_date.replaceAll("-", ".");
String edt = e_end_date.replaceAll("-", ".");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date sdate = sdf.parse(e_start_date);
Date edate = sdf.parse(e_end_date);
long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>

	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\plan.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	<script type="text/javascript" src="js\plan.js"></script>
</head>

<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<input type="hidden" id="item" value="<%= items%>">
		<div id="content">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
			<div id="radio_div">
				<input type="radio" name="plan" value="여행계획서" id="plan_btn">
				<label for="plan_btn" class="plan_radio">여행계획서</label>
				<input type="radio" name="plan" value="가계부" id="gagyebu_btn">
				<label for="gagyebu_btn" class="plan_radio">가계부</label>
				<input type="radio" name="plan" value="체크리스트" id="checklist_btn">
				<label for="checklist_btn" class="plan_radio">체크리스트</label>
			</div>
			<div id="plan">
				<input type="text" name="plan_subject" placeholder="계획서 제목(최대50자)" maxlength="50" />
				<div id="plan_info">
					<p id="city"><%=e_destination %></p>
					<p id="plan_date"><%=sdt %>&nbsp;~&nbsp;<%=edt %></p>
					<p class="list_thema"><%=thema %></p>	
					<%
						for(String st : e_detail_thema){
							out.println("<p class='list_thema'>"+st+"</p>");
						}
						for(String ft : e_food_taste){
							out.println("<p class='list_thema'>"+ft+"</p>");
						}
					%>
				</div>
				<div id="plan_div">
					<p class="plan_sub">※여행일정</p>
					<% 
					for(int a = 1 ; a <= datecnt ; a++){
						
					%>
					
					<div class="plan_day">
						<div class="plan_date">
							<p class="day"><%=a %>일차</p>
							<p class="date">00.00(월)</p>
						</div>
						<div class="plan_detail">
						<div class="place_name_div">
							<% 
							int num = a-1;
							String places = sche.get(num).getPlace();
							String [] place_arr = places.split(",");	
							out.println("<p class='place_name'>");
							for(String st : place_arr){
								out.println("#"+st+" ");
							}
							out.println("</p>");
							%>
							</div>
							<img src="img/icon/arrow_up.png" onclick="close_div(<%=a%>)" id="close<%=a%>"/>
							<img src="img/icon/arrow_down.png" onclick="open_div(<%=a%>)" id="open<%=a%>"/>
						</div>
					</div>
					
					<div id="detail_info<%=a%>">
						<div class="map_info">
							<div class="map">	
							지도				
							</div>
							<div class="place_info">	
							장소								
							</div>
						</div>
						
						<div class="pl_eat_div">
						<%int i = 0;
							for(String st : place_arr){
								i++;
								out.println("<div class='place'><div class='no'>"+i+"</div>"+st+"</div>");
							}
						%>
						</div>
					</div>
				
					<%
					}
					%>	
				</div>
				<div id="product">
					<div class="product_add">
						<p class="product_sub">※추가상품</p>
						<table id="product">
							<tr>
								<td class="product">이름</td>
								<td class="product">종류</td>
								<td class="product">가격</td>
								<td id="del">삭제</td>
							</tr>
						</table>
					</div>
					<div class="product_add">
						<p class="plan_sub">※추천상품</p>				
						<div id="item_div">
						<div id = "slide_div">
						<div class = "kind_slider">
						<ul class="slider">
						<li>							
							<div class="product_adv">
						<%
							for(Ticket ti : tick){				
						%>
							<div class="product_item">
								<img src="img\ticket.png" />
								<table class="product_tb">
									<tr>
										<td name="prod_name" class="product_item"><%=ti.getTick_name() %></td>
									</tr>
									<tr>
										<td name="prod_price" class="product_item" ><%=ti.getTick_price() %>
										<button class="plus_prod" onclick="asda()">
											<img src="img\plus.png" />
										</button>
									</td>
									</tr>
								</table>	
							</div>
						<%}
						for(Product pro : prod){
						%>
							<div class="product_item">
								<img src="img\ticket.png" />
								<table class="product_tb">
									<tr>
										<td name="prod_name" class="product_item"><%=pro.getProd_name() %></td>
									</tr>

									<tr>
										<td name="prod_price" class="product_item" ><%=pro.getProd_price() %>
										<button class="plus_prod" onclick="asda()">
											<img src="img\plus.png" />
										</button>
									</td>
									</tr>
								</table>	
							</div>
						<%} %> 
							</div>

						</li>
						</ul>
						</div>
						</div>
							<img src="img/icon/arrows_right_black.png" id="right">
							<img src="img/icon/arrows_left_black.png" id="left">
						</div>	
					</div>
				</div>
			<p align="right">예상 경비 약 10,000,000 </p>
			<div id="save_btn_div">
					<input type="button" name="save_plan" value="저장">
					</div>
		</div>
		</div>
	</section>

	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>