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
		if(lrForm.starRating.value == ''){
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

	
</script>
<body>
	<jsp:include page="main_header.jsp" />
	<section>
		<div id="write_div">
			<form name="lrForm" action="placeReview_insert.jsp" method="post" onsubmit="return regist()">
				<div class="place_select">
					<p>어디를 다녀오셨나요?</p>
					<select>
						<option value='1'>카시라 다이칸야마점</option>
						<option value='2'>오나리도리</option>
					</select>
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
					<div></div>
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