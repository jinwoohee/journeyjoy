<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>

	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\plan.css">
	<link rel="stylesheet" type="text/css" href="css/main_header.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	<script type="text/javascript" src="js\plan.js"></script>
</head>

<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
		<div id="content">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
			<div id="radio_div">
				<input type="radio" name="plan" value="여행계획서" id="plan_btn">
				<label for="plan_btn" class="plan_radio">여행계획서</label>
				<input type="radio" name="plan" value="가계부" id="gagyebu_btn">
				<label for="gagyebu_btn" class="plan_radio">가계부</label>
				<input type="radio" name="plan" value="체크리스트" id="checklist_btn">
				<label for="checklist_btn" class="plan_radio">체크리스트</label>
			</div>
			<div id="plan">
				<form>
					<input type="text" name="plan_subject" placeholder="계획서 제목(최대50자)" maxlength="50" />
				</form>
				<div id="plan_info">
					<p id="city">오사카</p>
					<p id="plan_date">2000.00.00&nbsp;~&nbsp;00.00</p>
					<p class="list_thema">놀이공원</p>						
					<p class="list_thema">랜드마크</p>	
					<p class="list_thema">놀이공원</p>						
					<p class="list_thema">랜드마크</p>	
					<p class="list_thema">놀이공원</p>						
					<p class="list_thema">랜드마크</p>	
				</div>
				<div id="plan_div">
					<p class="plan_sub">※여행일정</p>
					<div class="plan_day">
						<div class="plan_date">
							<p class="day">1일차</p>
							<p class="date">00.00(월)</p>
						</div>
						<div class="plan_detail">
							<p class="place_name">#여행지 #여행지 #여행지 #여행지 #여행지 #여행지 #여행지 #여행지</p>
						<button class="up">
							<img src="img/icon/arrow_up.png" />
							<img src="img/icon/arrow_down.png" />
						</button>
						</div>
					</div>
					<div class="detail_info">
						<div class="map_info">
							<div class="map">					
							</div>
							<div class="place_info">									
							</div>
						</div>
						<div class="place">
							<p class="place_name">#디즈니랜드</p> 
							<p class="place_thema">놀이공원</p>						
							<p class="place_thema">랜드마크</p>	
						</div>
						<div class="place">
							<p class="place_name">#디즈니랜드</p> 
							<p class="place_thema">놀이공원</p>						
							<p class="place_thema">랜드마크</p>	
						</div>
						<div class="place">
							<p class="place_name">#디즈니랜드</p> 
							<p class="place_thema">놀이공원</p>						
							<p class="place_thema">랜드마크</p>	
						</div>
						<div class="place">
							<p class="place_name">#디즈니랜드</p> 
							<p class="place_thema">놀이공원</p>						
							<p class="place_thema">랜드마크</p>	
						</div>
							<br><br>
					</div>
					<div class="plan_day">
						<div class="plan_date">
							<p class="day">1일차</p>
							<p class="date">00.00(월)</p>
						</div>
						<div class="plan_detail">
							<p class="place_name">#여행지 #여행지 #여행지 #여행지 #여행지 #여행지 #여행지 #여행지</p>
						<button class="up">
							<img src="img/icon/arrow_up.png" />
							<img src="img/icon/arrow_down.png" />
						</button>
						</div>
					</div>
					<div class="plan_day">
						<div class="plan_date">
							<p class="day">1일차</p>
							<p class="date">00.00(월)</p>
						</div>
						<div class="plan_detail">
							<p class="place_name">#여행지 #여행지 #여행지 #여행지 #여행지 #여행지 #여행지 #여행지</p>
						<button class="up">
							<img src="img/icon/arrow_up.png" />
							<img src="img/icon/arrow_down.png" />
						</button>
						</div>
					</div>
				<div id="product">
					<div class="product_add">
						<p class="plan_sub">추가상품</p>
						<table id="product">
							<tr>
								<td class="product">이름</td>
								<td class="product">종류</td>
								<td class="product">가격</td>
								<td id="del">삭제</td>
							</tr>
						</table>
					</div>
					<div class="product_add">
						<p class="plan_sub">추천상품</p>
						<iframe src="product_adv.html"></iframe>
					</div>
					
					<p align="right">예상 경비 약 10,000,000 </p>
					<form>
						<a href="planlist.html">
							<input type="button" name="save_plan" value="저장">
						</a>
					</form>
					<br><br><br>	<br><br><br>	<br><br><br>	<br><br><br>	<br><br><br>
				</div>
			</div>
		</div>
	</section>

	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>