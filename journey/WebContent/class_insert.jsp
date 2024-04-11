<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");	
%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JOURNEY JOY::여행톡::</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/class_insert.css">

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

	<!-- 날짜 -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
			
			$('div[name=preview]').append(img);
		});
		
		//천단위 콤마 
		$("input[name=guide]").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9.]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		});
		
		//숫자입력값 확인
		$("input[name=volumn]").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9.]/g,''));
		});
	});
</script>
<body>
	<jsp:include page="main_header.jsp" />
	<section id="main_section">
		<div>
			<form id="classMade" action='classInsert.jj?page=classInsert' method='post'>
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
							<textarea name="contents" cols="7" maxlength="300"></textarea>
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
							<input type="text" name="charge" size="20" placeholder=" 예산 입력">
						</td>
					</tr>
					<tr><td>모집마감날짜</td></tr>
					<tr>
						<td>
							<input type="text" name='endDt' id="endDt" placeholder="여행도착일">
						</td>
					</tr>
					<tr><td>첨부파일</td></tr>
					<tr>
						<td>
							<div id="thumnail">
								<div name="preview"></div>
							</div>
							<div>
								<input type="file" name="file" accept=".jpg, .png, .gif" />
								<input type="button" id="fileBtn" value="추가">
							</div>
						</td>
					</tr>
				</table>
				<div id="buttonArea">
					<input type="hidden" name="u_id" value="<%=(String)session.getAttribute("u_id")%>">
					<input type="submit" value="등록하기">
				</div>
			</form>
		</div>
	</section>
	<jsp:include page="main_footer.jsp" />
</body>
</html>