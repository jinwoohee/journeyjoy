<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String u_id = (String) session.getAttribute("u_id");
%>
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

<!-- 차트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">

</head>
<script>
$(function(){
	/*차트그리기*/
	barChartDraw();
	
	/*여행지*/
	$("#nation").click(function(){
		if($("#nation_div_in").css("display") == "none"){
			$("#nation_div_in").css({"display":"block"});
		}else{
			$("#nation_div_in").css({"display":"none"});
		}
	});
	
	$("#nation_table td").click(function(){
		$("#nation").val($(this).text());
		$("#nation_div_in").css({"display":"none"});
	});
	
	/*출발지*/
	$("#departure").click(function(){
		if($("#departure_div_in").css("display") == "none"){
			$("#departure_div_in").css({"display":"block"});
		}else{
			$("#departure_div_in").css({"display":"none"});
		}
	});
	
	$("#departure_table td").click(function(){
		$("#departure").val($(this).text());
		$("#departure_div_in").css({"display":"none"});
	});
	
	
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

/* 차트 */
//가장 많이 견적요청한 나라
function barChartDraw() {
    const ctx = document.getElementById('myChart').getContext('2d');
    
    var nation0 = document.getElementById('nation0').value;
    var nation1 = document.getElementById('nation1').value;
    var nation2 = document.getElementById('nation2').value;
    var nation3 = document.getElementById('nation3').value;
    var nation4 = document.getElementById('nation4').value;
    
    var nation0Cnt = document.getElementById('cnt0').value;
    var nation1Cnt = document.getElementById('cnt1').value;
    var nation2Cnt = document.getElementById('cnt2').value;
    var nation3Cnt = document.getElementById('cnt3').value;
    var nation4Cnt = document.getElementById('cnt4').value;
    
    window.barChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
        	labels:[nation0, nation1, nation2, nation3, nation4],
        	datasets : [{
        		label : "가장 많이 견적 요청한 나라 TOP5",
        		data : [nation0Cnt, nation1Cnt, nation2Cnt, nation3Cnt, nation4Cnt],
        		backgroundColor: ['rgb(255, 99, 132)', 'rgb(255, 159, 64)', 'rgb(255, 205, 86)', 'rgb(75, 192, 192)', 'rgb(54, 162, 235)'],
        		fill : false,
        		barThickness : 45,
        	}]
        },
        options: {
        	legend : {display: false},
        		
        }
    });
};


/* 여행안전 정보 XML */
var xhr = new XMLHttpRequest();
var url = 'http://apis.data.go.kr/1262000/CountrySafetyService/getCountrySafetyList'; /*URL*/
var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'BcOuiLozBFvAa1JfaDYPcaprIZrtOjwBNIZBTzNRvUJ8odWwgzDUsuFyPHQTUwBdBIx03uYH5CjVQY4Qlp4VlA%3D%3D'; /*Service Key*/
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /*한페이지 결과수(필수값)*/
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /*페이지번호(필수값)*/
queryParams += '&' + encodeURIComponent('title') + '=' + encodeURIComponent(''); /*제목(옵션)*/
queryParams += '&' + encodeURIComponent('content') + '=' + encodeURIComponent(''); /*내용(옵션)*/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
    	
    	var xmlDoc;
    	xmlParser = new DOMParser();
    	xmlDoc = xmlParser.parseFromString(this.responseText, "text/xml");
    	
    	var row;
		
	   	for(var i=0; i<xmlDoc.getElementsByTagName("id").length; i++){ //결과값 갯수
	   		row += "<tr>";
				row += "<td class='tb_nation'>"+xmlDoc.getElementsByTagName("countryName")[i].innerHTML+"</td>";
				row += "<td class='tb_title'>"+xmlDoc.getElementsByTagName("title")[i].innerHTML+"</td>";
				row += "<td class='tb_content'>"+xmlDoc.getElementsByTagName("content")[i].innerHTML+"</td>";
				row += "<td class='tb_wrtDt'>"+xmlDoc.getElementsByTagName("wrtDt")[i].innerHTML+"</td>";
			row += "</tr>";
    	}
   	 
    	$("#contents_tb").append(row);
    }
};

xhr.send('');

</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	
	<!-- 여행계획 -->
	<section id="plan">
		<div></div>
		<div>
			<input type="text" id="nation" placeholder="어디로 떠나세요?">
			<div id="nation_div_in">
				<table cellspacing="0" id="nation_table">
    				<tr>
    					<td>일본</td>
    					<td>캐나다</td>	
    					<td>필리핀</td>
    					<td>미국</td>				           
    				</tr>
    				<tr>
    					<td>호주</td>
    					<td>뉴질랜드</td>	
    					<td>중국</td>			           
    				</tr>
    			</table>
   			</div>
			<input type="text" id="departure" placeholder="출발지 선택">
			<div id="departure_div_in">
    			<table cellspacing="0" id="departure_table">
    				<tr>
    					<td>김포</td>
    					<td>인천</td>	
    					<td>부산</td>
    					<td>대구</td>				           
    				</tr>
    				<tr>
    					<td>청주</td>
    					<td>제주</td>	
    					<td>양양</td>
    					<td>김해</td>				           
    				</tr>

    			</table>
   			</div>
			<input type="text" id="startDt" placeholder="여행출발일">
			<input type="text" id="endDt" placeholder="여행도착일">
			<input type="button" value="견적내기" onclick="location.href='planner_main.jsp'">
		</div>
	</section>

	<!-- 패키지여행 -->
	<section id="package">
		<img src="img/travel/main3.jpg">
		<div></div>
		<div>
			<p>휴식이 필요한 순간,</p>
			<p>여유롭게 떠나는 패키지 여행</p>
		</div>
		<input type="button" value="바로가기" onclick="location.href='package_list.jj?page=packageSelect'">
		<div>
			<div>
				<p>※ 국가별 안전정보</p>
				<div id="header">
					<div>국가</div>
					<div>제목</div>
					<div>내용</div>
					<div>작성날짜</div>
				</div>
				<div id="body_contents">
					<table id="contents_tb">
						<!-- openApi -->
					</table>
				</div>
				<div id="chart_div1">
					<img src="img/icon/plane.png">
					<p>가장 많이 견적요청한 나라 TOP5!</p>
					
					<!-- 차트 -->
					<div>
						<jsp:useBean id="estimate" class="com.jj.dao.IndexSql">
							<%
								ArrayList<Estimate> eList;
								eList = estimate.selectEstimateCnt();
								for(int i=0; i<eList.size(); i++){%>
									<input type='hidden' id='nation<%=i%>' value='<%=eList.get(i).gete_destination()%>'>
									<input type='hidden' id='cnt<%=i%>' value=<%=eList.get(i).getCnt() %>>
							<%	}
							%>
						</jsp:useBean>
						<canvas id="myChart" width="1100" height="350"></canvas>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 여행톡 -->
	<section id="talk">
		<img src="img/travel/main4.jpg">
		<div></div>
		<!-- 차트2 -->
		<div>
			
		</div>
		<div>
			<p>현지에 있는 여행자와 함께</p>
			<p>여행톡에서 여행준비</p>
			<input type="button" value="바로가기" onclick="location.href='classList.jj?page=clist&u_id=<%=u_id %>'">
		</div>
		
	</section>

	<!-- 리뷰 -->
	<section id="review">
		<div>
			<img src="img/travel/main1.jpg">
			<img src="img/travel/travel.jpg">
		</div>
		<div></div>
	</section>

	<!-- 워킹홀리데이 -->
	<section id="working_holiday">
		<img src="img/travel/main6.jpg">
		<div></div>
		<div>
			<p>워킹홀리데이</p>
		</div>
		<input type="button" name="whBtn" value="바로가기" onclick="location.href='workingholiday.jj?page=wh'">
	</section>
</body>
</html>