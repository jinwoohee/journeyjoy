<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 리뷰</title>
<!-- css -->
<link href="css/place_review.css" rel="stylesheet" type="text/css">

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<script>
	$(function(){
		
		//작성버튼
		$("img[name='write']").click(function(){
			$(location).attr('href', 'place_review_write.jsp');
		});
		$("img[name='noWrite']").click(function(){
			alert("로그인 후 이용해주세요.");
			$(location).attr('href', 'login.jsp');
		});
		
		//수정버튼
		$(".modify").click(function(){
			$(location).attr('href', 'place_review_update.jsp?lr_no='+$(this).val());
		});
		
		//삭제버튼
		$(".delete").click(function(){
			alert("삭제하시겠습니까?");
			$(location).attr('href', 'placeReview_delete.jsp?lr_no='+$(this).val());
		});
		
		//mouseenter, leave
		$(".review").mouseenter(function(){
        	$(this).css({'background':'#f1f1f3'});
        });
		 $(".review").mouseleave(function(){
			 $(this).css({'background':'none'});
        });
	});
</script>
<body>
<jsp:include page="main_header.jsp" />
	<div>
		<section>
			<!-- 검색구간 -->
			<form method='post'>
				<div id="search_section">
					<div>
						<select name='filter'>
		                	<option value='latest'>최신순</option>
		                	<option value='high'>별점높은순</option>
		                	<option value='low'>별점낮은순</option>
		            	</select>
		            	
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
							<button type='submit' name='search'>검색</button>
						</div>
						<div>
						<%
						 if(u_id != null){
							 out.println("<img src='img/icon/write.png' name='write'/>");
						 }else{
							 out.println("<img src='img/icon/write.png' name='noWrite'/>");
						 }
						%>
						</div>
					</div>
				</div>
			</form>
		</section>

        <section>
        	<div id= "review_section">
       			<jsp:useBean id="place" class="com.jj.dao.Review">
       				<%
       					//select
       					ArrayList<Location_review> lrList;
       					int lr_no=0;
       					String search = request.getParameter("searchBox");
       					
       					//검색창select
       					if(search != null){
       						lrList = place.search_placeReview(search);
       					}else{
       					//기본select
           					lrList = place.select_placeReview(lr_no);
       					}

       					for(Location_review lr : lrList){
       						out.println("<div class='review'>"); //전체
       						out.println("<div>"); //프로필, 닉네임, 버튼
       						out.println("<img class='profile' src='img/profile/profile.png'/>"); //select한 id의 프로필/닉네임 가져오기
       						out.println("<p>"+lr.getU_nickname()+"</p>");
       						if(u_id !=null && u_id.equals(lr.getU_id())){
       							out.println("<button class='modify' value='"+ lr.getLr_no()+"'>수정</button>");
           						out.println("<button class='delete' value='"+ lr.getLr_no()+"'>삭제</button>");
       						}
       						out.println("</div><div>");
       						out.println("<p>"+lr.getPl_eat_no()+"</p>"); //select한 pl_no의 관광지 이름 가져오기
       						//out.println("<input type='hidden' name='star' value='"+lr.getLr_star()+"'>"); //별점
       						for(int i=1; i<6; i++){
       							if(i<=lr.getLr_star()){
       								out.println("<input type='radio' class='star' value='"+ i +"'><label>★</label>");
       							}else{
       								out.println("<input type='radio' class='star' value='"+ i +"'><label>☆</label>");
       							}
       						}
       						out.println("<textarea disabled>"+lr.getLr_contents()+"</textarea>");
       						out.println("</div><div class='file'>");
       						if(lr.getLr_file2() == null && lr.getLr_file3() == null){
       							out.println("<img src='"+lr.getLr_file1()+"' width=520px height=300px />");
       						}else if(lr.getLr_file3() == null){
       							out.println("<img src='"+lr.getLr_file1()+"' width=255px height=300px />");
       							out.println("<img src='"+lr.getLr_file2()+"' width=255px height=300px />");
       						}else{
       							out.println("<img src='"+lr.getLr_file1()+"' width=330px height=300px />");
       							out.println("<img src='"+lr.getLr_file2()+"' width=180px height=145px />");
           						out.println("<img src='"+lr.getLr_file3()+"' width=180px height=145px/>");
       						}
       						out.println("</div><div>");
       						out.println("<p>"+lr.getLr_date()+"</p>");
       						out.println("</div></div>");
       					}
       				%>
       			</jsp:useBean>
        	</div>
        </section>
    </div>
    <jsp:include page="main_footer.jsp" />
</body>
</html>