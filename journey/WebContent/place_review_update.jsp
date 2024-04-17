<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
	int lr_no = Integer.parseInt(request.getParameter("lr_no"));
	System.out.println(lr_no);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소리뷰 작성</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/place_review_write.css">

	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
</head>
<script>
	function regist(){
		if(lrForm.starRating.value == ''){
			alert("별점을 선택해주세요.");
			return false;
		}else if(lrForm.contents.value == ''){
			alert("리뷰를 작성해주세요.");
			lrForm.contents.focus();
			return false;
		}else{
			alert("리뷰가 수정되었습니다.");
		}
	}
	
	function cancel(){
		history.back();
	}

</script>
<body>
	<jsp:include page="main_header.jsp" />
	<section>
	<jsp:useBean id="place" class="com.jj.dao.Review">
		<div id="write_div">
			<form name="lrForm" action="placeReview_update.jsp" method="post" onsubmit="return regist()">
			<%
				ArrayList<Location_review> lrList = place.select_placeReview(lr_no);
				for(Location_review lr : lrList){
					
					if(lr.getEat_name() == null){
						out.println("<p>"+lr.getPlac_name()+"</p>");
					}else{
						out.println("<p>"+lr.getEat_name()+"</p>");
					}%>
					
					<div class='star-rating'>
					<p>별점을 선택해주세요!</p>
					
				<%	for(int i=1; i<6; i++){
						out.println("<input type='radio' class='star' name='starRating' value='"+i+"'>");
					}%>
					</div>
					
					<hr>
					
					<div>
						<textarea name='contents' maxlength=1000 cols=70 placeholder='솔직한 리뷰를 남겨주세요. (500자 이내)'><%= lr.getLr_contents() %></textarea>
					</div>
					
					<div id='file'>
						<div>
							<div class='thumnail'><img id="preview" src='<%=lr.getLr_file1()%>'></div>
							<div class='thumnail'><img id="preview" src='<%=lr.getLr_file2()%>'></div>
							<div class='thumnail'><img id="preview" src='<%=lr.getLr_file3()%>'></div>
						</div>
					</div>
					
					<input type='hidden' name='lr_no' value="<%=lr_no%>">
				<%}%>
				<div id="buttonArea">
					<input type='button' value='취소' onclick="cancel()">
					<input type='submit' value='등록'>
				</div>
			</form>
		</div>
	</jsp:useBean>
	</section>		
	<jsp:include page="main_footer.jsp" />
</body>
</html>