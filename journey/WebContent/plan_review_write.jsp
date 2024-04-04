<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />
<%
	request.setCharacterEncoding("utf-8"); 
	String pr_no = request.getParameter("page_no");
	String u_id = (String) session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<!-- css -->
	<link href="css/plan_review_write.css" rel="stylesheet" type="text/css">

<title>Insert title here</title>
</head>
<script>
	function place_down(a){
		var place_div = "#pl_eat_div"+a;
		var down = "#down"+a;
		var up = "#up"+a;
		$("div[id*='pl_eat']").hide();
		$(place_div).slideDown();
		$("img[id*='down']").css({'display':'block'});
		$("img[id*='up']").css({'display':'none'});
		$(down).css({'display':'none'});
		$(up).css({'display':'block'});
	}
	function place_up(a){
		var place_div = "#pl_eat_div"+a;
		var down = "#down"+a;
		var up = "#up"+a;
		
		$(place_div).slideUp();
		$(down).css({'display':'block'});
		$(up).css({'display':'none'});
	}
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
<section>
		<div id="main_div">
			<%
				String start = "2024-03-12";
					String end = "2024-03-15";
					String city = "서울(한국)";
					String thema = "힐링";
					String with = "친구와";
					String eat = "기타";
					String [] place1 = {"장소장소","장소장소","장소장소","장소장소","장소장소","장소장소","장소장소","장소장소"};
					String [] de_thema = request.getParameterValues("detale_them");
					String [] place2 = request.getParameterValues("place2");
					String [] place3 = request.getParameterValues("place3");
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					
					Date sdate = sdf.parse(start);
					Date edate = sdf.parse(end);
					long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
					
					if(pr_no.equals("write")){						
						out.println("<form action='plan_review_insert.jsp'>");
						out.println("<input type='text' name='title' maxlength='50' placeholder='리뷰 제목(최대50자)' value='"+u_id+"의 서울 여행기'>");
						out.println("<textarea name='content' placeholder='여행 후기'></textarea>");
						out.println("<hr><div id='empty'></div>");
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<div class='day_plan'>");
							out.println("<div class='day_info'>");
							out.println("<p class='day'>Day "+a+"ㅣ2000.00.01</p>");
							out.println("<img src='img/icon/write.png' class='day_write' onclick='place_down("+a+")'>");
							out.println("<p class='place_info'>");
								for(int j = 0 ; j < place1.length ; j++ ){
									out.println("#"+place1[j]+"&nbsp;");
								}
							out.println("</p>");
							out.println("<img src='img/icon/arrow_down.png' id='down"+a+"' onclick='place_down("+a+")'/>");
							out.println("<img src='img/icon/arrow_up.png' id='up"+a+"' onclick='place_up("+a+")'/>");
							out.println("</div>");
							
							out.println("<div id='pl_eat_div"+a+"'>");
							out.println("<div id='day_review"+a+"'>");
							out.println("<textarea name='day_review"+a+"' placeholder='일정후기'></textarea>");
							out.println("</div>");
							for(int i = 0; i < place1.length ; i ++){
								out.println("<p class='place'><div class='no'>"+(i+1)+"</div>"+place1[i]+"</p>");
								out.println("<a href='place_review_write.jsp'><img src='img/icon/write.png' class='place_write'></a>");
							}
							out.println("</div></div>");
						}
						
						out.println("<div id='save_div'>");
						out.println("<input type='submit' name='save' value='등록'></form>");	
						out.println("<a href='plan_review_list.jsp'><input type='button' name='cancel' value='취소'/></a>");
					}
					else{
						ArrayList<com.jj.dto.Plan_review> reviewList = dao.select_plan_review(pr_no);
						for(com.jj.dto.Plan_review pr : reviewList){
							out.println("<form action='plan_review_update.jsp'>");
							out.println("<input type='hidden' name='page_no' value='"+pr_no+"'>");
							out.println("<input type='text' name='title' placeholder='리뷰 제목(최대50자)' value='"+pr.getpr_title()+"'>");
							out.println("<textarea name='content' placeholder='여행 후기'>"+pr.getpr_contents()+"</textarea>");			
							out.println("<hr><div id='empty'></div>");
							for(int a = 1 ; a <= datecnt ; a++){
								out.println("<div class='day_plan'>");
								out.println("<div class='day_info'>");
								out.println("<p class='day'>Day "+a+"ㅣ2000.00.01</p>");
								out.println("<img src='img/icon/write.png' class='day_write' onclick='place_down("+a+")'>");
								out.println("<p class='place_info'>");
									for(int j = 0 ; j < place1.length ; j++ ){
										out.println("#"+place1[j]+"&nbsp;");
									}
								out.println("</p>");
								out.println("<img src='img/icon/arrow_down.png' id='down"+a+"' onclick='place_down("+a+")'/>");
								out.println("<img src='img/icon/arrow_up.png' id='up"+a+"' onclick='place_up("+a+")'/>");
								out.println("</div>");
								
								out.println("<div id='pl_eat_div"+a+"'>");
								out.println("<div id='day_review"+a+"'>");
								out.println("<textarea name='day_review"+a+"' placeholder='일정후기'></textarea>");
								out.println("</div>");
								for(int i = 0; i < place1.length ; i ++){
									out.println("<p class='place'><div class='no'>"+(i+1)+"</div>"+place1[i]+"</p>");
									out.println("<a href='place_review_write.jsp'><img src='img/icon/write.png' class='place_write' /></a>");
								}
								out.println("</div></div>");
							}
							
							out.println("<div id='save_div'>");
							out.println("<input type='submit' name='save' value='수정'></form>");	
							out.println("<a href='plan_review_list.jsp'><input type='button' name='cancel' value='취소'/></a>");
						}
					}
			%>
			
		</div>
	</section>
	<footer>
		<iframe src="main_footer.html" width="100%" height="200px" scrolling="no" frameborder=0 ></iframe>
	</footer>
</body>
</html>