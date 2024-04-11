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
		 
		 //검색창 
		 $("input[name='search']").click(function(){
			 $.ajax({ //검색버튼 
         		url : "placeReview_list.jj?page=placeReviewSearch",
         		data : {"txt" : $("input[name='searchBox']").val()},
         		success : function(re){
         			$("#review_section").html(re);
         		}
         	 });
		 });
		 
		 //최신순, 별점순
		 $("#sort_section div").click(function(){
			 $.ajax({
         		url : "placeReview_list.jj?page=placeReviewSearch",
         		data : {"param" : $(this).attr('id')},
         		success : function(re){
         			$("#review_section").html(re);
         		}
         	 });
		 });
		 
		 //도시
		 $('select[name=nation]').change(function() {
			if ($(this).find('option:selected').text() == '국가') {
				$('select[name=city]').find('option').remove();
				$('select[name=city]').append('<option>도시</option>');
			} else if ($(this).find('option:selected').text() == '일본') {
				$('select[name=city]').find('option').remove();
				$('select[name=city]').append('<option>도시</option>');
				$('select[name=city]').append('<option>도쿄</option>');
				$('select[name=city]').append('<option>오사카</option>');
				$('select[name=city]').append('<option>후쿠오카</option>');
				$('select[name=city]').append('<option>교토</option>');
				$('select[name=city]').append('<option>나리타</option>');
			} else if ($(this).find('option:selected').text() == '캐나다') {
				$('select[name=city]').find('option').remove();
				$('select[name=city]').append('<option>도시</option>');
				$('select[name=city]').append('<option>벤쿠버</option>');
				$('select[name=city]').append('<option>토론토</option>');
				$('select[name=city]').append('<option>캘거리</option>');
				$('select[name=city]').append('<option>빅토리아</option>');
				$('select[name=city]').append('<option>몬트리올</option>');
			}
		});
	});
</script>
<body>
<jsp:include page="main_header.jsp" />
	<div>
		<section>
			<!-- 검색구간 -->
			<div id="search_section">
				<div id='sort_section'>
					<div id='recent'><img alt="최신순" src="img/icon/lrIcon-02.png"></div>
					<div id='starRating'><img alt="별점순" src="img/icon/lrIcon-04.png"></div>
				</div>
				<div>
					<select name='nation'>
	                    <option value=''>국가</option>
	                    <option value='japan'>일본</option>
	                    <option value='canada'>캐나다</option>
                	</select>
                	
                	<select name='city'>
	                    <option value=''>도시</option>
                	</select>

				</div>
                <div id="search">
					<input type="text" name="searchBox" placeholder="검색단어 입력">
					<input type='button' name='search' value='검색'>
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
		</section>

        <section>
        	<div id= "review_section">
       			<jsp:useBean id="place" class="com.jj.dao.Review">
       				<%
       					//select
       					ArrayList<Location_review> lrList;
       					int lr_no=0;
       					String search = request.getParameter("searchBox");
       					
       					lrList = place.select_placeReview(lr_no);
       					
       					//검색창select
       					
       					/*if(search != null){
       						lrList = place.search_placeReview(search);
       					}else{
       					//기본select
           					lrList = place.select_placeReview(lr_no);
       					}*/

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