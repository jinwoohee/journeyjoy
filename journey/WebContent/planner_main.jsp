<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%	
request.setCharacterEncoding("utf-8"); 

String u_id = (String) session.getAttribute("u_id");

%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy::</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_main.css">
	
	<script type="text/javascript" src="js\planner_main.js"></script>
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
	<!-- 페이지 섹션 -->
	<section>
		<div id="main_full_div">	
			<div id="slide_div" >
				<div id="content">
					<div class="kind_wrap">
  						<div class="kind_slider">
  							<form action="planner_cookie.jsp" method="post" onsubmit="return select_check()">
  							    <ul class="slider">
				        		    <li>
				        			    <article>       
				            			    <div class="main_div">
				                   				 <div class="main_con">
				                    				<p class="main_text"><%if(u_id == null){out.print("고객");}else{out.print(u_id+" ");}%>님,<br>어떤 여행을 꿈꾸시나요?</p>         
				                            		<select name="departure">
				                       		        	<option>출발지</option>
				                                		<option>김포/인천</option>
				                               			<option>부산</option>
				                                		<option>대구</option>
				                                		<option>청주</option>
				                                		<option>제주</option>
				                                		<option>양양</option>
				                            		</select>
						                            <select name="nation">
						                                <option>목적지(국가)</option>
						                                <option>일본</option>
						                                <option>태국</option>
						                            </select>
						                            <select name="city" id="city">
						                                <option value="1">목적지(도시)</option>
						                                <option>도쿄</option>
						                                <option>오사카</option>
						                                <option>후쿠오카</option>
						                            </select>
				                        		    <div id="cal_div">
				                            		    <input type="text" id="startDt" name = "startDt" placeholder="여행출발일" autocomplete="off"/>
				                         		        <img src="img\icon\cal.png" align="right" />
				                          		        <input type="text" id="endDt" name = "endDt" placeholder="여행도착일" autocomplete="off"/>
				                            		    <img src="img\icon\cal.png" align="right" />
				                           			</div>
				                        			<input type="checkbox" name="airplane" id ="air" value="1">
				                        			<br>
				                        			<label for="air" id="airplane">
				                        				<img src="img\icon\airplane_check.png" name="check_img" id="air_check">
				                        				항공권은 있어요
				                        			</label>
				                         			<input type="checkbox" name="hotel" id ="ho" value="1">
				                        			<label for="ho" id="hotel">
				                        				<img src="img\icon\hotel_check.png" name="check_img" id="hotel_check" >
						                        		숙소는 있어요				     
						                        	</label>
						                        	<br><br>
						                        	<% if(u_id == null){%>
						                        	<input type="button" value="테마선택" class="next_login" onclick="login_check()"/>
							                        <%}else{ %>
						                            <input type="button" value="테마선택" class="next" />		
						                            <%} %>    	                
						                		</div>                              
											</div>
				            			</article>
				         			</li>
				           			<li>
						               <article>
						                <div class="main_div">
						                    <div class ="main_con">
						                        <p class="main_text">어떤 스타일의 여행을 원하시나요?</p>
						                        <div id="thema_div">
						                                <input type="radio" name="thema" value="여유롭게힐링" id="thema1" checked>
						                                <label for="thema1" class="thema_check">여유롭게 힐링</label>
						                                <input type="radio" name="thema" value="체험/액티비티" id="thema2">
						                                <label for="thema2" class="thema_check">체험/액티비티</label>
						                                <input type="radio" name="thema" value="자연과함께" id="thema3">
						                                <label for="thema3" class="thema_check">자연과 함께</label>
						                                <input type="radio" name="thema" value="유명관광지는필수" id="thema4">
						                                <label for="thema4" class="thema_check">유명 관광지는 필수</label>
						                                <input type="radio" name="thema" value="관광보단먹방" id="thema5">
						                                <label for="thema5" class="thema_check">관광보단 먹방</label>
						                                <input type="radio" name="thema" value="덕질의성지" id="thema6">  
						                                <label for="thema6" class="thema_check">덕질의 성지</label>         
						                        </div>
						                        <p class="main_text">누구와 함께 여행가시나요?</p>
						                        <div id="with_div">
						                                <input type="radio" name="with" value="혼자" id="with1" checked>
						                                <label for="with1" class="with_check">혼자</label>
						                                <input type="radio" name="with" value="친구와" id="with2">
						                                <label for="with2" class="with_check">친구와</label>
						                                <input type="radio" name="with" value="연인과" id="with3">
						                                <label for="with3" class="with_check">연인과</label>
						                                <input type="radio" name="with" value="아이동반" id="with4">
						                                <label for="with4" class="with_check">아이동반</label>
						                                <input type="radio" name="with" value="가족과" id="with5">
						                                <label for="with5" class="with_check">가족과</label>
						                                <input type="radio" name="with" value="기타" id="with6">
						                                <label for="with6" class="with_check">기타</label>            
						                        </div>
						                        <% if(u_id == null){%>
						                        <input type="button" value="테마선택" class="next_login" onclick="login_check()"/>
						                        <%}else{ %>
				                            	<input type="button" value="다음" class="next" /> 
				                            	<%} %>                      
						                    </div>                              
						                </div>
						            </article>
					            </li>
					            <li>
					        	    <article>
						           		<div class="main_div">
						                    <div class="main_con">
						                        <p class="main_text">어떤 여행지를 가고 싶으신가요?</p>
						                        <div id="place_div">
						                        	<input type="checkbox" name="place" value="놀이공원" id="place1" onchange="checking(this.id)">
					                                <label for="place1" class="place_check">놀이공원</label>
					                                <input type="checkbox" name="place" value="박물관/미술관" id="place2" onchange="checking(this.id)">
					                                <label for="place2" class="place_check">박물관/미술관</label>
					                                <input type="checkbox" name="place" value="쇼핑" id="place3" onchange="checking(this.id)">
					                                <label for="place3" class="place_check">선택불가</label>
					                                <input type="checkbox" name="place" value="휴양림" id="place4" onchange="checking(this.id)">
					                                <label for="place4" class="place_check">휴양림</label>
					                                <input type="checkbox" name="place" value="랜드마크" id="place5" onchange="checking(this.id)">
					                                <label for="place5" class="place_check">랜드마크</label>
					                                <input type="checkbox" name="place" value="덕질" id="place6" onchange="checking(this.id)">
					                                <label for="place6" class="place_check">덕질</label>
					                                <input type="checkbox" name="place" value="맛집" id="place7" onchange="checking(this.id)">			
					                                <label for="place7" class="place_check">맛집</label>		                                		
				                                    <input type="checkbox" name="place" value="문화재" id="place8" onchange="checking(this.id)">
				                                    <label for="place8" class="place_check">문화재</label>
					                                <input type="checkbox" name="place" value="수영장/바다" id="place9" onchange="checking(this.id)">
					                                <label for="place9" class="place_check">수영장/바다</label>
					                                <input type="checkbox" name="place" value="온천/스파" id="place10" onchange="checking(this.id)">
			                                		<label for="place10" class="place_check">온천/스파</label>
					                            </div>
					                            <p class="main_text">음식 취향을 골라주세요.</p>
					                           	<div id="eat_div">
				                                	<input type="checkbox" name="eat" value="한식" id="eat1" onchange="checking(this.id)">
				                                	<label for="eat1" class="eat_check">한식</label>
				                                    <input type="checkbox" name="eat" value="중식" id="eat2" onchange="checking(this.id)">
				                                    <label for="eat2" class="eat_check">중식</label>
				                                    <input type="checkbox" name="eat" value="일식" id="eat3" onchange="checking(this.id)">
				                                    <label for="eat3" class="eat_check">일식</label>
				                                    <input type="checkbox" name="eat" value="양식" id="eat4" onchange="checking(this.id)">
				                                    <label for="eat4" class="eat_check">양식</label>
				                                    <input type="checkbox" name="eat" value="아시아" id="eat5" onchange="checking(this.id)">
				                                    <label for="eat5" class="eat_check">아시아</label>
				                               		<input type="checkbox" name="eat" value="레스토랑" id="eat6" onchange="checking(this.id)">   
				                               		<label for="eat6" class="eat_check">선택불가</label>
				                               		<input type="checkbox" name="eat" value="길거리음식" id="eat7" onchange="checking(this.id)">
				                               		<label for="eat7" class="eat_check">길거리 음식</label>
				                                    <input type="checkbox" name="eat" value="비건" id="eat8" onchange="checking(this.id)">
				                                    <label for="eat8" class="eat_check">비건</label>
				                                    <input type="checkbox" name="eat" value="음식취향" id="eat9" onchange="checking(this.id)"> 
				                                    <label for="eat9" class="eat_check">선택불가</label>
				                                    <input type="checkbox" name="eat" value="음식취향" id="eat10" onchange="checking(this.id)">
				                                    <label for="eat10" class="eat_check">선택불가</label>
				                           		</div>
				                           		<% if(u_id == null){%>
				                           			<input type="button" value="일정만들기" id="save_login" onclick="login_check()"/>
				                           			<%}else{ %>
				                	                <input type="submit" value="일정 만들기" id="save" />
				                	                <%} %>
			            	                               
						    	                </div>                               
							                </div>			       
							            </article>
								    </li>
								</ul>
						     </form> 
						</div>
					</div>
				</div>
				<%if(u_id == null) {%>
				<a id="left_login" onclick="login_check()"><img src="img\icon\arrow_left.png" width="45px" height="45px"/></a><%}else{ %>
				<a id="left" ><img src="img\icon\arrow_left.png" width="45px" height="45px"/></a>
				<%} %>

				<%if(u_id == null) {%>
				<a id="right_login" onclick="login_check()"><img src="img\icon\arrow_right.png" width="45px" height="45px"/></a><%}else{ %>
				<a id="right"><img src="img\icon\arrow_right.png" width="45px" height="45px"/></a>
				<%} %>					
			</div>
			<div id="img_div">
			
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>