<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JOURNEY JOY::여행톡::</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/class.css">

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<script>
	$(function(){
		/* 날짜 */
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

		/* 썸네일 버튼클릭->파일업로드 */
		$("#fileBtn").click(function (e) {
			$('input[type=file]').click();
		});

		$('input[type=button]').mouseleave(function(){
			$(this).css({'box-shadow':'none'});
		});

		/* 썸네일 등록 후 이미지 미리보기 */
		var img = new Image();
		img.src = '';

		$('input[type=file]').change(function(event){
			const file = event.target.files;
			var imgTempUrl = window.URL.createObjectURL(file[0]);

			img.src = imgTempUrl;
			$('#preview').append(img);
		});
		

		/* 삭제버튼 */
		$('#delBtn').click(function() {
			$('#preview').empty();
		});
	});
</script>
<body>
	<jsp:include page="main_header.jsp" />
	
	<section id="main_section">
		<div>
			<form id="classMade">
				<table id="classTable">
					<tr><td>도시</td></tr>
					<tr>
						<td>
							<select name="city" size="1">
					    		<option value="choice">도시</option>
					    		<option value="tokyo">도쿄</option>
					    		<option value="osaka">오사카</option>
					    		<option value="toronto">토론토</option>
					    		<option value="vancouver">벤쿠버</option>
						  	</select>
						</td>
					</tr>
					<tr><td>제목</td></tr>
					<tr>
						<td>
							<input type="text" name="title" size="20" maxlength="50">
						</td>
					</tr>
					<tr><td>내용</td></tr>
					<tr>
						<td>
							<input type="textarea" name="title" size="20">
						</td>
					</tr>
					<tr><td>모집인원</td></tr>
					<tr>
						<td>
							<input type="text" name="volumn" size="20" maxlength="3" placeholder=" (최소 3명이상)">
						</td>
					</tr>
					<tr><td>예산</td></tr>
					<tr>
						<td>
							<input type="text" name="title" size="20" placeholder=" 예산 입력">
						</td>
					</tr>
					<tr><td>모집마감날짜</td></tr>
					<tr>
						<td>
							<input type="text" id="endDt" placeholder=" 여행도착일">
						</td>
					</tr>
					<tr><td>첨부파일</td></tr>
					<tr>
						<td>
							<div id="thumnail">
								<div id="preview"></div>
								<div id="preview"></div>
								<div id="preview"></div>
							</div>
							<div>
								<input type="file" name="file" accept=".jpg, .png, .gif" />
								<input type="button" id="fileBtn" value="추가">
							</div>
						</td>
					</tr>
				</table>
				<div id="buttonArea">
					<input type="submit" value="등록하기">
				</div>
			</form>
		</div>
	</section>
</body>
</html>