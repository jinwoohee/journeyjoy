<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="java.util.List"%>
<%@page import="com.jj.dto.Plan"%>
<%
request.setCharacterEncoding("utf-8");
List<Estimate> esti = (List<Estimate>) request.getAttribute("estimate");
List<Plan> plan = (List<Plan>) request.getAttribute("planList");
System.out.println("셀렉트 완료 이스 : "+esti.size()+"플랜 : "+plan.size());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/planlist.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	<script type="text/javascript" src="js/planlist.js"></script>
	<link rel="stylesheet" type="text/css" href="css/main_header.css"> 
</head>

<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action = "" method="post">
		<div id="content">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
			<a href="planner_main.jsp">
			<input type="button" name="make_plan"value="계획서 만들기" class="button">
			</a>
			<div id="filter">
				<select name="city">
					<option>도시별로 보기</option>
					<option>오사카</option>
					<option>도쿄</option>
					<option>벤쿠버</option>
					<option>오타와</option>
				</select>
				<select name="thema">
					<option>테마별로 보기</option>
					<option>힐링</option>
					<option>관광</option>
					<option>액티비티</option>
					<option>덕질</option>
				</select>
				<select name="date">
					<option>일정별로 보기</option>
					<option>1월</option>
					<option>2월</option> 
					<option>3월</option>
					<option>4월</option>
				</select>
				<input type="checkbox" name="end_plan" id="end" onchange="checking(this.id)">
				<label for="end" id="end_check" >지난 일정 보지않기</label>
			</div>

			<div id="plan_list">
				<%if(plan.size() == 0){ %>
					<div class="plan">
						<div class="plan_content">
							<h2>저장된 계획서가 없습니다.</h2>
						</div>
					</div>
					<%}else{ 
						for(Estimate st : esti){
							for(Plan pl : plan){
								if(st.gete_no() == pl.getE_no()){
					%>
							<a href="plan_page.jsp?paging=detail_my&e_no=<%=st.gete_no() %>">
							<div class="plan">
									<div class="plan_content">
										<h2><%=pl.getPlan_title()%></h2><span><%=pl.getPlan_date() %></span>
										<br>
										<h3>&nbsp;&nbsp;&nbsp;<%=st.gete_destination() %>&nbsp;&nbsp;&nbsp;&nbsp;<%=st.gete_start_date() %> ~ <%=st.gete_end_date() %></h3>
										<br>
										<h4>&nbsp;&nbsp;&nbsp;<%=st.gete_thema()+","+st.gete_detail_thema()%></h4>
										<input type="submit" name="del_plan<%= st.gete_no()%>" value="삭제" class="button" onclick="del_plan(<%=st.gete_no() %>)"/>
										<input type="hidden" name="e_no" value="<%=st.gete_no() %>">								
									</div>
							</div>
						</a>
							
									
					<% 			
								}
							}
						
					%>
				<%}} %>
			</div>
		</div>
		</form>
	</section>

	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>