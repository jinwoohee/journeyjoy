<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script>
	$(function(){
		/* 메뉴바 */
		$('.main_menu, #sub_div, #main_menu_div').mouseover(function() { // 메인메뉴(5개짜리) 글자, div ,서브메뉴 에 마우스오버 시 서브메뉴나옴
			$('#sub_div').stop().slideDown(200);
		});
		$('#top_div, #sub_div, #main_menu_div').mouseout(function() { // 최상단 div(로고+메뉴+로그인), 서브메뉴 에스 마우스 오버시 서브메뉴 사라짐
			$('#sub_div').stop().slideUp(200);
		});
		$('.sub_menu_a').mouseover(function() {
			$(this).css({"font-weight":"bold"});
		});
		$('.sub_menu_a').mouseout(function() {
			$(this).css({"font-weight":"normal"});
		});
/*헤더 색상변경*/
		$(window).scroll(function(){   
        var scroll = $(window).scrollTop();
        if (scroll > 1) {
          $("#top_div, #sub_div").css({"background-color":"rgb(0,0,0,0.8"});
          $("li, a").css({"color":"#f1f1f3"});
          $("#logo").attr("src","img/icon/lo_white.png");
          $("#mypage_btn").attr("src","img/icon/mypage_btn_scroll.png");
        }
        else{
          $("#top_div, #sub_div").css({"background-color":"white"});  
          $("li, a").css({"color":"rgb(64,64,64)"});
          $("#logo").attr("src","img/icon/logo.png");
          $("#mypage_btn").attr("src","img/icon/mypage_btn.png");
        }
      });
		
	});

/*마이페이지 가로 슬라이드부분*/
function showMenu(){
	$('#mypage' ).css( { 'display' : 'block' } );
	$('#mypage' ).css( { 'left' : '100%' } );
	$('#mypage' ).animate( { "left": '0px' }, { duration: "200" },{ "animation-timing-function" : "ease"} );
}

function hideMenu(){
	$('#mypage' ).animate( { left: '100%' }, { duration: "200", complete:function(){ $('#mypage' ).css( { 'display' : 'none' } ); } } );
}

</script>
<body>
	<header>
		<!-- 메뉴바 -->
		<div id="top_div">
			<a href="">
				<img src="img/icon/logo.png" id="logo"/>
			</a>
			<div id="main_menu_div">
				<ul>
					<li class="main_menu">여행계획</li>
					<li class="main_menu">패키지여행</li>
					<li class="main_menu">여행톡</li>
					<li class="main_menu">리뷰</li>
					<li class="main_menu">워킹홀리데이</li>
				</ul>
			</div>
			<div id="login">
				<img src="img/icon/mypage_btn.png" onclick="showMenu()" id="mypage_btn"/>
				<a>로그인
				</a>&nbsp;&nbsp;&nbsp;
				<a>회원가입
				</a>
			</div>
		</div>

		<div id="sub_div">
			<div id="sub_menu_div">
				<ul>
					<li><a href="planner_main.jsp" target="_blank" class="sub_menu_a">일정만들기</a></li>
					<li><a href="planlist.html" target="_blank" class="sub_menu_a">여행계획서</a></li>
				</ul>
				<ul>
					<li><a href="packageList.html" target="_blank" class="sub_menu_a">패키지여행</a></li>
				</ul>
				<ul>
					<li><a href="classList.html" target="_blank" target="_blank" class="sub_menu_a">모임</a></li>
					<li><a href="" class="sub_menu_a">자유게시판</a></li>
				</ul>
				<ul>
					<li><a href="schedule_review.html" target="_blank" class="sub_menu_a">일정리뷰</a></li>
					<li><a href="place_review.html" class="sub_menu_a">장소리뷰</a></li>
				</ul>
				<ul>
					<li><a href="workingholiday.html" target="_blank" class="sub_menu_a">워킹홀리데이</a></li>
				</ul>
			</div>
		</div>

		<div id="mypage">
			<img src="img/icon/lo_white.png" id="logo"/>
			<ul id="mypage_ul">
				<li class="mypage_li"><h2>마이페이지</h2></li>
				<li class="mypage_li">회원정보</li>
				<li class="mypage_li">나의 여행계획서</li>
				<li class="mypage_li">패키지여행 목록</li>
				<li class="mypage_li">모임 참여 내역</li>
				<li class="mypage_li">워킹홀리데이 신청목록</li>
			</ul>
			<img src="img/icon/mypage_close.png" onclick="hideMenu()"/>
		</div>
	</header>
	<section>
		<div id="content">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
						<a href="planner_main.html">
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
				<a href="plan.html">
					<div class="plan">
						<div class="plan_content">
							<h2>계획서제목</h2><span>24.01.01(계획서저장날짜)</span>
							<br>
							<h3>&nbsp;&nbsp;&nbsp;국가,도시&nbsp;&nbsp;&nbsp;&nbsp;24.01.01 ~ 24.01.01</h3>
							<br>
							<h4>&nbsp;&nbsp;&nbsp;#테마&nbsp;#테마&nbsp;#테마&nbsp;#테마
							<input type="button" name="del_plan" value="삭제" class="button" />
						</div>
					</div>
				</a>
				<div class="plan">
					<div class="plan_content">
						<h2>계획서제목</h2><span>24.01.01(계획서저장날짜)</span>
						<br>
						<h3>&nbsp;&nbsp;&nbsp;국가,도시&nbsp;&nbsp;&nbsp;&nbsp;24.01.01 ~ 24.01.01</h3>
						<br>
						<h4>&nbsp;&nbsp;&nbsp;#테마&nbsp;#테마&nbsp;#테마&nbsp;#테마
						<input type="button" name="del_plan" value="삭제" class="button"/>
					</div>
				</div>
				<div class="plan">
					<div class="plan_content">
						<h2>계획서제목</h2><span>24.01.01(계획서저장날짜)</span>
						<br>
						<h3>&nbsp;&nbsp;&nbsp;국가,도시&nbsp;&nbsp;&nbsp;&nbsp;24.01.01 ~ 24.01.01</h3>
						<br>
						<h4>&nbsp;&nbsp;&nbsp;#테마&nbsp;#테마&nbsp;#테마&nbsp;#테마
						<input type="button" name="del_plan" value="삭제" class="button"/>
					</div>
				</div>
				<div class="plan">
					<div class="plan_content">
						<h2>계획서제목</h2><span>24.01.01(계획서저장날짜)</span>
						<br>
						<h3>&nbsp;&nbsp;&nbsp;국가,도시&nbsp;&nbsp;&nbsp;&nbsp;24.01.01 ~ 24.01.01</h3>
						<br>
						<h4>&nbsp;&nbsp;&nbsp;#테마&nbsp;#테마&nbsp;#테마&nbsp;#테마
						<input type="button" name="del_plan" value="삭제" class="button"/>
					</div>
				</div>
				<div class="plan">
					<div class="plan_content">
						<h2>계획서제목</h2><span>24.01.01(계획서저장날짜)</span>
						<br>
						<h3>&nbsp;&nbsp;&nbsp;국가,도시&nbsp;&nbsp;&nbsp;&nbsp;24.01.01 ~ 24.01.01</h3>
						<br>
						<h4>&nbsp;&nbsp;&nbsp;#테마&nbsp;#테마&nbsp;#테마&nbsp;#테마
						<input type="button" name="del_plan" value="삭제" class="button"/>
					</div>
				</div>
			</div>
		</div>
	</section>

	<footer>
		<iframe src="main_footer.html" width="100%" height="200px" scrolling="no" frameborder=0 ></iframe>
	</footer>
</body>
</html>