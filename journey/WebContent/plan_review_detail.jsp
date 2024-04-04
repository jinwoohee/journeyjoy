<%@page import="com.jj.dto.Plan_review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />
<%
	request.setCharacterEncoding("utf-8"); 
	String list = request.getParameter("page_no");
	ArrayList<com.jj.dto.Plan_review> reviewList = dao.select_plan_review(list);
	String u_id = (String) session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link href="css/plan_review_detail.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script>
	function tab(num){
		var day_plan = "#day_plan"+num;
		var day_sel = "#day_sel"+num;
		var plan = "#plan_sel"+num;
		$("div[id*='day_plan']").hide();
		$(day_plan).show();
		$("p[id*=day_sel]").css({"color":"white"});
		$(day_sel).css({"color":"black"});	
		$("div[id*='plan_sel']").css({"background-color":"#0D112D"});
		$(plan).css({"background-color":"#6C94B8"});
	}
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>		
		<div id='main_div'>
			<%
				for(com.jj.dto.Plan_review pr : reviewList){
						String start = "2024-03-12";
						String end = "2024-03-15";
						String city = "서울(한국)";
						String thema = "힐링";
						String with = "친구와";
						String eat = "기타";
						String [] place1 = {"장소장소","장소장소","장소장소","장소장소","장소장소","장소장소","장소장소","장소장소","장소장소"};
						
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date sdate = sdf.parse(start);
						Date edate = sdf.parse(end);
						long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
					
						out.println("<table>");
						out.println("<tr><td class='review_info'><p>작성자</p></td>");
						out.println("<td class='user_info'><p>"+pr.getu_id()+"</p></td></tr>");
						out.println("<tr><td class='review_info'><p>여행도시</p></td>");
						out.println("<td class='user_info'><p>"+city+"</p></td></tr>");
						out.println("<tr id='theme'><td class='review_info'><p>여행테마</p></td>");
						out.println("<td class='user_info'>"+thema+"</td></tr></table>");
						out.println("<p>"+pr.getpr_title()+"</p>");
						//out.println("<p id='pr_date'>"+pr.getpr_date()+"</p>");
						out.println("<div id='img_div'><img src='img/japan/"+pr.getpr_file()+"'/></div>");
						out.println("<div id='content'>"+pr.getpr_contents()+"</div>");
						out.println("<div id='day_select'>");
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<div id='plan_sel"+a+"' onclick='tab("+a+")'><p id='day_sel"+a+"' >Day"+a+"</p></div>");
							}
						out.println("</div>");
						
						for(int a= 1 ; a <= datecnt ; a++){
							out.println("<div id='day_plan"+a+"'>");
							out.println("<p class='day'>Day "+a+"ㅣ2000.00.01</p>");
							out.println("<div class='map'>day"+a+"지도 들어갈 자리</div>");
							out.println("<div class='day_review'>day"+a+" 여행후기</div>");
							out.println("<div class='pl_eat_div'>");
							for(int i = 0; i < place1.length ; i ++){
								out.println("<p class='place'><div class='no'>"+(i+1)+"</div>"+place1[i]+"</p>");
							}
							out.println("</div></div>");
						}
						out.println("<div id='btn_div'>");
						if(u_id != null && u_id.equals(pr.getu_id())){
							out.println("<a href='plan_review_write.jsp?page_no="+pr.getpr_no()+"'><input type='button' name='edit' value='수정하기' /></a>");
							out.println("<a href='plan_review_delete.jsp?page_no="+pr.getpr_no()+"'><input type='button' name='delete' value='삭제' /></a>");
						}else{
							out.println("<input type='hidden' name='hidden' />");
						}
						out.println("<a href='plan_review_list.jsp'><input type='button' name='list' value='목록으로'/></a>");
						out.println("</div");
					}
			%>
		</div>
	</section>

</body>
</html>