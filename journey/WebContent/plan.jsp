<%@page import="com.jj.dto.Product"%>
<%@page import="com.jj.dto.Ticket"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="com.jj.dto.Schedule"%>
<%@page import="com.jj.dto.Account"%>
<%@page import="com.jj.dto.Plan"%>
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
String paging = (String) request.getAttribute("paging");

int items = (int) Math.ceil((double) (tick.size()+prod.size())/4);
System.out.println("플랜jsp"+paging+items);



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
String aaaa = datecnt+"";
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
	<%
	if(paging != null){
		System.out.println("saas");
		List<Plan> plan = (List<Plan>) request.getAttribute("plan");
		List<Plan> planList = (List<Plan>)request.getAttribute("plan");
		String my_prod = planList.get(0).getPlan_product();
		System.out.println(my_prod);
		System.out.println(aaaa);
		String [] mp = my_prod.split(",");
		List<Account> accList = (List<Account>)request.getAttribute("account");
		%>
		<input type="hidden" name="day" id="day_count" value="<%=aaaa %>">
		<input type="hidden" id="item" value="<%= items%>">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
			<div id="radio_div">
				<label for="plan_btn" id="plan_radio_1" onclick="change_main('1')">여행계획서</label>			
				<label for="gagyebu_btn" id="plan_radio_2" onclick="change_main('2')">가계부</label>
				<label for="checklist_btn" id="plan_radio_3" onclick="change_main('3')">체크리스트</label>
			</div>
			<input type="hidden" name="selected_prod" id="selected_prod" value="<%=my_prod%>">
			<input type="hidden" name="e_no" value="<%=esti.get(0).gete_no()%>">
			<div id="plandiv_1">
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
							<p class="day">Day<%=a %></p>
							<p class="date">00.00(월)</p>
						</div>
						<div class="plan_detail">
						<div class="place_name_div">
							<% 
							int num = a-1;
							String places = sche.get(num).getPlace().replaceAll("-", " ");
							System.out.println("ddd"+places);
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
							<div id="map<%=a%>">				
							</div>
						</div>
						
						<div class="pl_eat_div">
						<%int i = 0;
							int number;
							for(String st : place_arr){
								i++;
								number = a*100+i;
								out.println("<div class='places_"+a+"'><div class='no'>"+i+"</div><div id='plac_name"+number+"'>"+st+"</div></div>");
								out.println("<input type='hidden' name = 'change_value"+a+"' id='change_name"+number+"' value='"+st+"'>");
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
								<td id="product_sub_name">이름</td>
								<td id="product_sub_sort">종류</td>
								<td id="product_sub_price">가격</td>
							</tr>
							<% String [] pr_arr = plan.get(0).getPlan_product().split(",");
								for(Product pr : prod){
									String pr_no = pr.getProd_no()+"";
									for(String my_pr : pr_arr){
										if(pr_no.equals(my_pr)){
											%>
											<tr>
												<td id="product_add_name<%=pr_no%>"><%=pr.getProd_name() %></td>
												<td id="product_add_sort<%=pr_no%>"><%=pr.getProd_sort() %></td>
												<td id="product_add_price<%=pr_no%>"><%=pr.getProd_price() %></td>
											</tr>							
											<% 
										}
									}
								}
							%>
							<% 	for(Ticket ti : tick){
									String ti_no = ti.getTick_no()+"";
									for(String my_pr : pr_arr){
										if(ti_no.equals(my_pr)){
											%>
											<tr>
												<td id="product_add_name<%=ti_no%>"><%=ti.getTick_name()%></td>
												<td id="product_add_sort<%=ti_no%>"><%=ti.getTick_sort() %></td>
												<td id="product_add_price<%=ti_no%>"><%=ti.getTick_price() %></td>
											</tr>							
											<% 
										}
									}
								}
							%>
						</table>
					</div>
				</div>
					<div id="save_btn_div">
						<a href = "plan_page.jsp?paging=edit_my&e_no=<%=esti.get(0).gete_no()%>"><input type="button" name="edit_plan" value="수정"></a>
					</div>	
					</div>
					<div id="plandiv_2">
			<p class="plan_sub">※가계부</p>
			<p><%=e_destination %>여행</p>
				<div id="air_hotel_div">숙박ㆍ항공권</div>
				<% int rs=0;
					for(int a = 1 ; a <= datecnt ; a++){
					%>	<div id="acc_div<%=a%>">Day <%=a %></div>
					<table id="acc_table<%=a%>">
						<tr>
						<td><input type="hidden" name="sort<%=a%>" readOnly="true" value="0">종류</td>
						<td><input type="hidden" name="content<%=a%>" readOnly="true" value="0">내용</td>
						<td><input type="hidden" name="pay_with<%=a%>" readOnly="true" value="0">결제수단</td>
						<td><input type="hidden" name="prices<%=a%>" readOnly="true" value="0">금액</td>					
						<td>삭제</td>
						</tr>
					<%	for(Account acc : accList){
							if(acc.getAcc_day() == a){
				%>	
						<tr>
						<td><input type="text" name="sort<%=a%>" readOnly="true" value="<%=acc.getAcc_category() %>"></td>
						<td><input type="text" name="content<%=a%>" readOnly="true" value="<%=acc.getAcc_contents() %>"></td>
						<td><input type="text" name="pay_with<%=a%>" readOnly="true" value="<%=acc.getAcc_payment() %>"></td>
						<td><input type="text" name="prices<%=a%>" readOnly="true" value="<%=acc.getAcc_amount() %>"></td>
						<td><input type="button" name="del_place" value="삭제" onclick="del_pl(this, <%=acc.getAcc_amount()%>)"></td>
						</tr>
				<%rs += acc.getAcc_amount();}} %>
				</table>
				<div id="pay_one_div<%=a%>">
					<div id="price">
						<input type="text" name="acc_price<%=a%>" id = "acc_price<%=a%>"placeholder="금액입력">
					</div>
					 <select name="pay_with<%=a%>" id= "pay_with<%=a%>" >
					 	<option>결제수단</option>
                        <option>현금</option>
                        <option>카드</option>
                     </select>
                     <input type="text" name="acc_content<%=a%>" id= "acc_content<%=a%>" placeholder="내용을 입력해주세요.">
                     <p>카테고리</p>
                      <select name="acc_sort<%=a%>" id ="acc_sort<%=a%>">
                         <option>숙소</option>
                         <option>항공</option>
                         <option>교통</option>
                         <option>관광</option>
                         <option>식비</option>
                         <option>쇼핑</option>                   
                     </select>
  					<input type="button" name="add_acc_one<%=a%>" value="추가하기" onclick="add_acc(<%=a%>)">
				</div>
				<input type="button" name="add_acc<%=a%>" value="비용 추가" onclick="open_acc_div(<%=a%>)">
				<%} %>
				<input type="hidden" id="result_price" value="<%=rs %>">
				<p id= "result_price_text"><%=rs %></p>
				<input type="submit" name="save_acc" value="저장">
		</div>	
			<%}else{ %>
	<input type="hidden" id="item" value="<%= items%>">
	<input type="hidden" name="day" value="<%=aaaa %>">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
			<div id="radio_div">
				<label for="plan_btn" id="plan_radio_1" onclick="change_main('1')">여행계획서</label>			
				<label for="gagyebu_btn" id="plan_radio_2" onclick="change_main('2')">가계부</label>
				<label for="checklist_btn" id="plan_radio_3" onclick="change_main('3')">체크리스트</label>
			</div>
			<input type="hidden" name="selected_prod" id="selected_prod" value="">
			<input type="hidden" name="e_no" value="<%=esti.get(0).gete_no()%>">
			<div id="plandiv_1">
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
							String places = sche.get(num).getPlace().replaceAll("-", " ");
							String [] place_arr = places.split(",");
							System.out.println("ddd3"+places);
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
							<div id="map<%=a%>">
							</div>
						
						<div class="pl_eat_div">
						<%int i = 0;
							int number;
							for(String st : place_arr){
								i++;
								number = a*100+i;
								out.println("<div class='places_"+a+"'><div class='no'>"+i+"</div><div id='plac_name"+number+"'>"+st+"</div><div class='up_down_btn'><img src='img/icon/arrow_up.png' class='up' onclick='up_pla("+number+")'><img src='img/icon/arrow_down.png' class='down' onclick='down_pla("+number+")'></div></div>");
								out.println("<input type='hidden' name = 'change_value"+a+"' id='change_name"+number+"' value='"+st+"'>");
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
								<td id="product_sub_name">이름</td>
								<td id="product_sub_sort">종류</td>
								<td id="product_sub_price">가격</td>
								<td id="del">삭제</td>
							</tr>
						</table>
					</div>
					<div class="product_add">
						<p class="product_add_sub">※이런 상품은 어떠세요?</p>				
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
										<td colspan='2' name="prod_name" id="product_name<%=ti.getTick_no()%>"><%=ti.getTick_name() %></td>
									</tr>
									<tr>
										<td name="prod_price" id="product_price<%=ti.getTick_no()%>" ><%=ti.getTick_price() %>
										<img src="img/icon/plus.png" onclick="add_prod(<%=ti.getTick_no()%>)"/>
										</td>
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
										<td colspan='2' name="prod_name" id="product_name<%=pro.getProd_no()%>"><%=pro.getProd_name() %></td>
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
				</div>
			<div id="save_btn_div">
					<input type="submit" name="save_plan" value="저장">
					</div>
		</div>
		<div id="plandiv_2">
			<p class="plan_sub">※가계부</p>
			<p><%=e_destination %>여행</p>
				<div id="air_hotel_div">숙박ㆍ항공권</div>
				<% 
					for(int a = 1 ; a <= datecnt ; a++){
						
				%>
				<div id="acc_div<%=a%>">Day <%=a %></div>
				<table id="acc_table<%=a%>">
					<tr>
						<td><input type="hidden" name="sort<%=a%>" readOnly="true" value="0">종류</td>
						<td><input type="hidden" name="content<%=a%>" readOnly="true" value="0">내용</td>
						<td><input type="hidden" name="pay_with<%=a%>" readOnly="true" value="0">결제수단</td>
						<td><input type="hidden" name="prices<%=a%>" readOnly="true" value="0">금액</td>					
						<td>삭제</td>
					</tr>
				</table>
				
				<div id="pay_one_div<%=a%>">
					<div id="price">
						<input type="text" name="acc_price<%=a%>" id = "acc_price<%=a%>"placeholder="금액입력">
					</div>
					 <select name="pay_with<%=a%>" id= "pay_with<%=a%>" >
					 	<option>결제수단</option>
                        <option>현금</option>
                        <option>카드</option>
                     </select>
                     <input type="text" name="acc_content<%=a%>" id= "acc_content<%=a%>" placeholder="내용을 입력해주세요.">
                     <p>카테고리</p>
                      <select name="acc_sort<%=a%>" id ="acc_sort<%=a%>">
                         <option>숙소</option>
                         <option>항공</option>
                         <option>교통</option>
                         <option>관광</option>
                         <option>식비</option>
                         <option>쇼핑</option>                   
                     </select>
  					<input type="button" name="add_acc_one<%=a%>" value="추가하기" onclick="add_acc(<%=a%>)">
				</div>
				<input type="button" name="add_acc<%=a%>" value="비용 추가" onclick="open_acc_div(<%=a%>)">
				<%} %>
				<input type="hidden" id="result_price" value="0">
				<p id= "result_price_text">0</p>
				<div id="save_btn_div">
					<input type="submit" name="save_plan" value="저장">
					</div>
		</div>
		<%} %>
		
		
		<div id="plandiv_3">
			<p>체크리스트</p>
		</div>
		</div>
		</form>
	</section>

	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>