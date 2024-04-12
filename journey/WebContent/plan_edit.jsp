<%@page import="com.jj.dto.Estimate"%>
<%@page import="com.jj.dto.Schedule"%>
<%@page import="com.jj.dto.Plan"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="com.jj.dto.Product"%>
<%@page import="com.jj.dto.Ticket"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
String paging = (String) request.getAttribute("paging");
int items = (int) Math.ceil((double) (tick.size()+prod.size())/3);
List<Plan> plan = (List<Plan>) request.getAttribute("plan");
System.out.println("플랜jsp"+paging);


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

	<script async="" defer="" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAN8pqDt8WwrtCF3kkPS7Snko0A-RTUns0&callback=initMap" type="text/javascript"> </script>
</head>

<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner.jj?page=save_plan" method="post">
	<div id="content">
	<input type="hidden" id="item" value="<%= items%>">
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
			<input type="hidden" name="selected_prod" id="selected_prod" value="">
			<input type="hidden" name="e_no" value="<%=esti.get(0).gete_no()%>">
			<div id="plan">
				<input type="text" name="plan_subject" placeholder="계획서 제목(최대50자)" maxlength="50" value="<%=esti.get(0).getu_id()%>의 <%=esti.get(0).gete_destination() %>여행계획서"/>
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
							<div id="map<%=a%>"></div>
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
						<table id="product_table">
							<tr>
								<td id="product_add_name">이름</td>
								<td id="product_add_sort">종류</td>
								<td id="product_add_price">가격</td>
								<td id="del">삭제</td>
							</tr>
							<% String [] pr_arr = plan.get(0).getPlan_product().split(",");
							String products = "";
								for(Product pr : prod){
									String pr_no = pr.getProd_no()+"";
									for(String my_pr : pr_arr){									
										if(pr_no.equals(my_pr)){
											System.out.println("상품1 :"+  my_pr);
											products += pr.getProd_no()+",";
											%>
											<tr>
												<td><p id="product_add_name<%=pr_no%>"><%=pr.getProd_name() %></p>
												<input type="hidden" id="num<%=pr.getProd_no()%>" value="<%=pr.getProd_no()%>">
												</td>
												<td><p id="product_add_sort<%=pr_no%>"><%=pr.getProd_sort() %></p></td>
												<td><p id="product_add_price<%=pr_no%>"><%=pr.getProd_price() %></p></td>
												<td><img src="img/icon/minus.png" onclick="cancel_prod(<%=pr.getProd_no()%>)" id="del<%=pr.getProd_no()%>"/></td>											
											</tr>							
											<% 
										}
									}
								}
							%>
							<% 	String tickets = "";
								for(Ticket ti : tick){
									String ti_no = ti.getTick_no()+"";	
									for(String my_pr : pr_arr){
										if(ti_no.equals(my_pr)){
											System.out.println("티켓1 :"+ my_pr);
										
											tickets += ti.getTick_no()+",";
											%>
											<tr>
												<td><p id="product_add_name<%=ti_no%>"><%=ti.getTick_name()%></p>
												<input type="hidden" id="num<%=ti.getTick_no()%>" value="<%=ti.getTick_no()%>">
												</td>
												<td><p id="product_add_sort<%=ti_no%>"><%=ti.getTick_sort() %></p></td>
												<td><p id="product_add_price<%=ti_no%>"><%=ti.getTick_price() %></p></td>
												<td><img src="img/icon/minus.png" onclick="cancel_prod(<%=ti.getTick_no()%>)" id="del<%=ti.getTick_no()%>" /></td>
											</tr>							
											<% 
									}
										}
									}
								
							%>
						</table>
					</div>
					<input type="hidden" name="selected_prod" id="selected_prod" value="<%=tickets+products%>">
					<div class="product_add">
						<p class="plan_sub">※이런 상품은 어떠세요?</p>				
						<div id="item_div">
						<div id = "slide_div">
						<div class = "kind_slider">
						<ul class="slider">
						<li id="plan_li">							
							<div class="product_adv">
						<%
							for(Ticket ti : tick){	
						%>
							<div id="product_item<%=ti.getTick_no()%>">
								<img src="img\ticket.png" />
								<table id="product_tb<%=ti.getTick_no()%>">
									<tr>
										<td name="prod_name" id="product_name<%=ti.getTick_no()%>"><%=ti.getTick_name() %></td>
									</tr>
									<tr>
										<td name="prod_price" id="product_price<%=ti.getTick_no()%>" ><%=ti.getTick_price() %>																					
									</td>
									<td><img src="img/icon/plus.png" onclick="add_prod(<%=ti.getTick_no()%>)"/></td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=ti.getTick_no()%>" value="<%=ti.getTick_sort()%>">
								<input type="hidden" id="product_no<%=ti.getTick_no()%>" value="<%=ti.getTick_no()%>">	
							</div>
						<%}
						
						for(Product pro : prod){

						%>
							<div id="product_item<%=pro.getProd_no()%>">
								<img src="img\ticket.png" />
								<table id="product_tb<%=pro.getProd_no()%>">
									<tr>
										<td name="prod_name" id="product_name<%=pro.getProd_no()%>"><%=pro.getProd_name() %></td>
									</tr>

									<tr>
										<td name="prod_price" id="product_price<%=pro.getProd_no()%>" ><%=pro.getProd_price() %>
											<img src="img/icon/plus.png" onclick="add_prod(<%=pro.getProd_no()%>)"/>											
									</td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=pro.getProd_no()%>" value="<%=pro.getProd_sort()%>">
								<input type="hidden" id="product_no<%=pro.getProd_no()%>" value="<%=pro.getProd_no()%>">	
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
					<%-- <div class="product_add">
						<p class="plan_sub">※이런 상품은 어떠세요?</p>				
						<div id="item_div">
						<div id = "slide_div">
						<div class = "kind_slider">
						<ul class="slider">
						<li id="plan_li">							
							<div class="product_adv">
						<% 	for(Ticket ti : tick){
								String ti_no = ti.getTick_no()+"";
								System.out.println("티켓이다."+ti_no);					
								for(String my_pr : pr_arr){
									int a = Integer.parseInt(my_pr);
									if(a < 20000){		
										if(ti_no.equals(my_pr)){
											System.out.println("티켓2(같을때) :"+ my_pr);
											%>
							<div id="product_item<%=ti.getTick_no()%>" style="display:none">
							<img src="img\ticket.png" />
								<table id="product_tb<%=ti.getTick_no()%>">
									<tr>
										<td name="prod_name" id="product_name<%=ti.getTick_no()%>"><%=ti.getTick_name() %></td>
									</tr>
									<tr>
										<td name="prod_price" id="product_price<%=ti.getTick_no()%>" ><%=ti.getTick_price() %>																					
									</td>
									<td><img src="img/icon/plus.png" onclick="add_prod(<%=ti.getTick_no()%>)"/></td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=ti.getTick_no()%>" value="<%=ti.getTick_sort()%>">
								<input type="hidden" id="product_no<%=ti.getTick_no()%>" value="<%=ti.getTick_no()%>">	
							</div>
							<%break;
							} else if(!ti_no.equals(my_pr)){System.out.println("티켓3다를때 :"+ my_pr);%>
							
							<div id="product_item<%=ti.getTick_no() %>">
							<img src="img\ticket.png" />
								<table id="product_tb<%=ti.getTick_no()%>">
									<tr>
										<td name="prod_name" id="product_name<%=ti.getTick_no()%>"><%=ti.getTick_name() %></td>
									</tr>
									<tr>
										<td name="prod_price" id="product_price<%=ti.getTick_no()%>" ><%=ti.getTick_price() %>																					
									</td>
									<td><img src="img/icon/plus.png" onclick="add_prod(<%=ti.getTick_no()%>)"/></td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=ti.getTick_no()%>" value="<%=ti.getTick_sort()%>">
								<input type="hidden" id="product_no<%=ti.getTick_no()%>" value="<%=ti.getTick_no()%>">	
							</div>
							<%break;
								}	
							}
						}}
						
						for(Product pro : prod){
							String pr_no = pro.getProd_no()+"";
							System.out.println("상품2이다."+pr_no);		
							for(String my_pr : pr_arr){
								int a = Integer.parseInt(my_pr);
								System.out.println("상품1이다."+my_pr);	
								if(a > 20000){
								if(pr_no.equals(my_pr)){System.out.println("상품2 같을때 :"+  my_pr+"="+pr_no);
										%>
							<div id="product_item<%=pro.getProd_no()%>" style="display:none">
								<img src="img\ticket.png" />
								<table id="product_tb<%=pro.getProd_no()%>">
									<tr>
										<td name="prod_name" id="product_name<%=pro.getProd_no()%>"><%=pro.getProd_name() %></td>
									</tr>
									<tr>
									<td name="prod_price" id="product_price<%=pro.getProd_no()%>" ><%=pro.getProd_price() %>
										<img src="img/icon/plus.png" onclick="add_prod(<%=pro.getProd_no()%>)"/>											
									</td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=pro.getProd_no()%>" value="<%=pro.getProd_sort()%>">
								<input type="hidden" id="product_no<%=pro.getProd_no()%>" value="<%=pro.getProd_no()%>">	
							</div>
								<%
								break;	}else if(!pr_no.equals(my_pr)){System.out.println("상품3 다를때 :"+  my_pr);%>		
							<div id="product_item<%=pro.getProd_no()%>">
								<img src="img\ticket.png" />
								<table id="product_tb<%=pro.getProd_no()%>">
									<tr>
										<td name="prod_name" id="product_name<%=pro.getProd_no()%>"><%=pro.getProd_name() %></td>
									</tr>

									<tr>
										<td name="prod_price" id="product_price<%=pro.getProd_no()%>" ><%=pro.getProd_price() %>
											<img src="img/icon/plus.png" onclick="add_prod(<%=pro.getProd_no()%>)"/>											
									</td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=pro.getProd_no()%>" value="<%=pro.getProd_sort()%>">
								<input type="hidden" id="product_no<%=pro.getProd_no()%>" value="<%=pro.getProd_no()%>">	
							</div>
								<%		
								break;	}	
									} 
								}
						}
							%> 
				
						</div>
						</li>
						</ul>
						</div>
						</div>
							<img src="img/icon/arrows_right_black.png" id="right">
							<img src="img/icon/arrows_left_black.png" id="left">
						</div>	
					</div> --%>
				</div>
						<p align="right">예상 경비 약 10,000,000 </p>
					<div id="save_btn_div">
						<input type="submit" name="save_plan" value="저장">
					</div>
				</div>
			</div>
		</form>
	</section>

	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>