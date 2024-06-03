<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Journey Joy</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/index.css">

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>


</head>
<script>
$(function(){
	/* 날짜 */
	$("#startDt").datepicker({
		dateFormat: 'yy-mm-dd' //달력 날짜 형태
		,minDate:0
		,nextText : ">"
		,prevText : "<"
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 - 월 순서
		,changeYear: true //년 선택 가능
        ,changeMonth: true //월 선택 가능
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
        ,minDate : 0 //선택할수있는 최소날짜(0:오늘 이전날짜 선택 불가)
        ,onClose:function(selectedDate){ //startDt 닫힐때 endDt 선택가능한 최소날짜가 시작일로 지정
        	$("#endDt").datepicker("option", "minDate", selectedDate);
        }

	});

	$("#endDt").datepicker({
		dateFormat: 'yy-mm-dd' //달력 날짜 형태
		,minDate:0
		,nextText : ">"
		,prevText : "<"
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 - 월 순서
		,changeYear: true //년 선택 가능
        ,changeMonth: true //월 선택 가능
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	});
});

</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	
	<!-- 여행계획 -->
	<section id="plan">
		<div></div>
		<div>
			<select>
				<option value="choice">어디로떠나세요?</option>
				<option value="japan">일본</option>
				<option value="canada">캐나다</option>
				<option value="thailand">태국</option>
			</select>
			<select>
				<option value="choice">출발지 선택</option>
				<option value="incheon">인천</option>
				<option value="gimpo">김포</option>
			</select>
			<input type="text" id="startDt" placeholder="여행출발일">
			<input type="text" id="endDt" placeholder="여행도착일">
			<input type="button" value="견적내기" onclick="location.href='planner_main.html'">
		</div>
	</section>

	<!-- 패키지여행 -->
	<section id="package">
		<img src="img/travel/travel2.jpg">
		<div></div>
		<div>
			<p>휴식이 필요한 순간,</p>
			<p>여유롭게 떠나는 패키지 여행</p>
		</div>
		<input type="button" value="바로가기" onclick="location.href='packageList.html'">
		<div>
			<div>
				<img src="img/icon/plane.png">
				<p>가장 많이 떠나는 여행지</p>
				<div></div>
			</div>
		</div>
	</section>

	<!-- 여행톡 -->
	<section id="talk">
		<img src="img/travel/travel3.jpg">
		<div></div>
		<div>
			<img src="img/icon/plane.png">
			<p>가장 많이 견적요청한 나라</p>
			<div></div>
		</div>
		<div>
			<p>현지에 있는 여행자와 함께</p>
			<p>여행톡에서 여행준비</p>
			<input type="button" value="바로가기" onclick="location.href='class.html'">
		</div>
		
	</section>

	<!-- 리뷰 -->
	<section id="review">
		<div>
			<img src="img/travel/travel4.jpg">
			<img src="img/travel/travel5.jpg">
		</div>
		<div></div>
	</section>

	<!-- 워킹홀리데이 -->
	<section id="working_holiday">
		<img src="img/travel/travel6.jpg">
		<div></div>
		<div>
			<p>워킹홀리데이</p>
		</div>
		<input type="button" name="whBtn" value="바로가기">
	</section>
</body>
</html>