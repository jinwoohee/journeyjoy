<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />

<%
	request.setCharacterEncoding("utf-8"); 
	String list = "a";
	ArrayList<com.jj.dto.Plan_review> reviewList = dao.select_plan_review(list);
	String u_id = (String) session.getAttribute("u_id");
	response.addCookie(new Cookie("u_id", u_id));
%>

<html>
<head>
    <meta charset="utf-8">
	<title>일정리뷰</title>

    <link href="css/plan_review_list.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

    <script>
		$(function(){
			$("img[name='write']").click(function(){
				alert("로그인을 해주세요.");	
			});
			$(".review_div").mouseenter(function(){
	        	$(this).css({'background':'#f1f1f3'});
	        });
			 $(".review_div").mouseleave(function(){
				 $(this).css({'background':'none'});
	        });
		});
    </script>
</head>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>

	<!-- 페이지 섹션 -->
    <div>
        <section>
            <article>
            <form action="plan_review_write.jsp" method='post'>
            <input type="hidden" name="start_date" value="2024-03-12">
						<input type="hidden" name="end_date" value="2024-03-14">
						<input type="hidden" name="city" value="서울">
						<input type="hidden" name="thema" value="힐링">
						<input type="hidden" name="detale_them" value="먹방">
						<input type="hidden" name="detale_them" value="유원지">
						<input type="hidden" name="detale_them" value="관광">
						<input type="hidden" name="with" value="친구와">
						<input type="hidden" name="eat" value="기타">
                   		<input type="hidden" name="page_no" value="write">
                   		<input type="hidden" name="place1" value="장소1" >
                   		<input type="hidden" name="place1" value="장소1" >
                   		<input type="hidden" name="place1" value="장소1" >
                   		<input type="hidden" name="place2" value="장소2" >
                   		<input type="hidden" name="place2" value="장소2" >
                   		<input type="hidden" name="place2" value="장소2" >
                   		<input type="hidden" name="place3" value="장소3" >
                   		<input type="hidden" name="place3" value="장소3" >
				<div id="search_section">
					<div>
		            	
						<select name='nation'>
		                    <option value='-'>국가</option>
		                    <option value='japan'>일본</option>
		                    <option value='canada'>캐나다</option>
		                </select>
	
		                <select name='city'>
		                    <option value='-'>도시</option>
		                    <option value='tokyo'>도쿄</option>
		                    <option value='osaka'>오사카</option>
		                </select>
		                
		                <select name='category'>
		                	<option value='-'>카테고리</option>
		                	<option value='place'>관광지</option>
		                	<option value='restaurant'>음식점</option>
		                </select>
	
		                <div id="search">
							<input type="text" name="searchBox" placeholder="  검색단어 입력">
							<button type='button' name='search'>검색</button>
						</div>
						<div>
					  <%
					  	if(u_id == null){
		                  			 out.println("<img src='img/icon/write.png' name='write'/>");
		                  		}else{
		                			out.println("<a href='plan_review.jj?page=plan_reviewTab'><img src='img/icon/write.png' /></a>");
					  	}
					  %>
						</div>
					</div>
				</div>
			</form>
            </article>
            <article>
           		<div id="list_div">         		
	            	<%
         			            		for(com.jj.dto.Plan_review pr : reviewList){
         			            						out.println("<a href='plan_review_detail.jsp?page_no="+pr.getpr_no()+"'>");
         			            						out.println("<div class='review_div'>");
         			            						out.println("<img src='img/profile/d.jpg' />");
         			            						out.println("<p>"+pr.getu_id()+"</p>");
         			            						out.println("<p class='nation'>여행도시</p>");
         			            						out.println("<img src='img/japan/"+pr.getpr_file()+"' />");
         			            						out.println("<p><div>"+pr.getpr_title()+"</div><div>"+pr.getpr_date()+"</div></p>");
         			            						out.println("<p>"+pr.getpr_contents()+"</p></div></a>");
         			            					}
         			            	%>			
                </div>
            </article>
        </section>
    </div>
    <!--
    <div id="paging"></div>
    -->
<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>