<%@page import="com.jj.dto.Eatery"%>
<%@page import="com.jj.dto.Place"%>
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
<title>장소리뷰 작성</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/place_review_write.css">

	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<script>
	function regist(){
		if(lrForm.place_select.value ==''){
			alert("장소를 선택해주세요.");
			return false;
		}else if(lrForm.starRating.value == ''){
			alert("별점을 선택해주세요.");
			return false;
		}else if(lrForm.contents.value == ''){
			alert("리뷰를 작성해주세요.");
			lrForm.contents.focus();
			return false;
		}else{
			alert("리뷰가 등록되었습니다.");
		}
	}
	
	function cancel(){
		history.back();
	}
	
 	function search(){
		var search = $('input[name=search_place]').val();
		
		$.ajax({
			url : "place_search.jj?page=lr_place_search",
			data :{"search": search},
			success : function(re){
				$(".place_list").html(re);
			}
		});
	}

 	function upload(){
 		$('input[type=file]').click();
 	}
 	
 	function readURL(input){
 		if(input.files && input.files[0]){
 			var reader = new FileReader();
 			reader.onload = function(e){
 				document.getElementById("preview").src = e.target.result;
 			};
 			reader.readAsDataURL(input.files[0]);
 		}else{
 			document.getElementById("preview").src = "";
 		}
 	}
 	
 	function img_del(){
 		$('input[name=file_btn]').val("");
 		document.getElementById("preview").src = "";
 	}
	
</script>
<body>
	<jsp:include page="main_header.jsp" />
	<section>
		<div id="write_div">
			<form name="lrForm" action="placeReview_insert.jsp" method="post" onsubmit="return regist()">
				<div class="place_select">
					<p>어디를 다녀오셨나요?</p>
					<input type="text" name="search_place" placeholder="장소 검색">
					<img src='img/icon/search_btn.png' onclick="search()">
				</div>
				<div class="place_list">
					<jsp:useBean id="selectPlace" class="com.jj.dao.Review">
						<select name='place_select'>
							<option value=''>장소 선택</option>
						<%
							ArrayList<Place> placeList;
							ArrayList<Eatery> eatList;
							
							String search = "";

							placeList = selectPlace.select_place(search);
							eatList = selectPlace.select_eat(search);
							
							for(Place p : placeList){%>
								<option value="<%=p.getPlac_no()%>"><%=p.getPlac_name() %></option>
							<%}
							
							for(Eatery e : eatList){%>
								<option value="<%=e.getEat_no() %>"><%=e.getEat_name() %></option>
							<%}%> 
							</select>
					</jsp:useBean>
				</div>
				<div class ="star_area">
					<p>별점을 선택해주세요!</p>
					<div class="star-rating">
				    <input type="radio" class="star" name="starRating" value="1">
				    <input type="radio" class="star" name="starRating" value="2">
				    <input type="radio" class="star" name="starRating" value="3">
				    <input type="radio" class="star" name="starRating" value="4">
				    <input type="radio" class="star" name="starRating" value="5">
				</div>
				</div>
				
				<hr>
				<div>
					<textarea name="contents" maxlength="1000" cols="70" placeholder="솔직한 리뷰를 남겨주세요. (500자 이내)"></textarea>
				</div>
			
				<div id="file">
					<div>
						<div class='thumnail'>
							<img id="preview">
						</div>
						<div class="btn_area">
							<input type="button" name="upload_btn" value="첨부" onclick="upload()">
							<input type="button" name="upload_del" value="삭제" onclick="img_del()">
							<input type="file" name="file_btn" accept=".jpg, .png, .gif" onchange="readURL(this)">
						</div>
					</div>
				</div>
				
				<div id="buttonArea">
					<input type='button' value='취소' onclick="cancel()">
					<input type='submit' value='등록'>
				</div>
			</form>
		</div>
	</section>
	<jsp:include page="main_footer.jsp" />
</body>
</html>