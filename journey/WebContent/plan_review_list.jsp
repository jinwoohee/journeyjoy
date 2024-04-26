<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />

<%
	request.setCharacterEncoding("utf-8"); 
	String list = "a"; 
	ArrayList<com.jj.dto.Plan_review> reviewList = dao.select_plan_review(list);
	String u_id = (String) session.getAttribute("u_id");
	response.addCookie(new Cookie("u_id", u_id));
%>

<html>
<head>
    <meta charset="utf-8">
	<title>일정리뷰</title>

    <link href="css/plan_review_list.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

    <script>
		$(function(){
			$("img[name='write']").click(function(){
				alert("로그인을 해주세요.");	
			});
			$(".review_div").mouseenter(function(){
	        	$(this).css({'background':'#f1f1f3'});
	        });
			 $(".review_div").mouseleave(function(){
				 $(this).css({'background':'white'});
	        });
			 
			 
			 /* 선택한 나라에 따라서 도시선택*/
			$('select[name*=city]').hide();
			
			$('select[name=nation]').change(function(){
				
				var cities = ["japan", "canada", "philippines", "america", "australia", "newzealand", "china"];
				
				for(var i=0; i<cities.length; i++){
					if($('select[name=nation]').val() == cities[i]){
						$('#'+$('select[name=nation]').val()+'').show();
						$('select[name*=city]').not($('#'+$('select[name=nation]').val()+'')).hide();
					}
				}
			}); 
			
			
			/*검색*/
			$('#search img').click(function(){
				var nation = $('select[name=nation]').val();
				var search = $('input[name=searchBox]').val();
				var city = $('select[name=city_'+nation+']').val();

				$.ajax({
					url : "planReview_list.jj?page=planReviewSearch",
	        		data : {"city" : city, "search" : search},
	        		success : function(re){
	        			$("#list_div").html(re);
	        		}
				});
			});
		});
    </script>
</head>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>

	<!-- 페이지 섹션 -->
    <div>
        <section>
            <article>
            	<!-- 검색필터 -->
				<div id="search_section">
					<div>	
						<select name="nation">
				    		<option value="choice">국가</option>
				    		<option value="japan">일본</option>
				    		<option value="canada">캐나다</option>
				    		<option value="philippines">필리핀</option>
				    		<option value="america">미국</option>
				    		<option value="australia">호주</option>
				    		<option value="newzealand">뉴질랜드</option>
				    		<option value="china">중국</option>
					  	</select>

		               <select name="city_japan" id="japan">
				    		<option value="choice">도시</option>
				    		<option value="tokyo">도쿄</option>
				    		<option value="osaka">오사카</option>
				    		<option value="fukuoka">후쿠오카</option>
				    		<option value="sapporo">삿포로</option>
				    		<option value="okinawa">오키나와</option>
				    		<option value="kyoto">교토</option>
					  	</select>
					  	<select name="city_canada" id="canada">
				    		<option value="choice">도시</option>
				    		<option value="vancouver">벤쿠버</option>
				    		<option value="toronto">토론토</option>
				    		<option value="banff">밴프(로키)</option>
				    		<option value="niagara">나이아가라</option>
				    		<option value="quebec">퀘벡</option>
				    		<option value="whitehorse">화이트호스</option>
					  	</select>
					  	<select name="city_philippines" id="philippines">
				    		<option value="choice">도시</option>
				    		<option value="manila">마닐라</option>
				    		<option value="boracay">보라카이</option>
				    		<option value="cebu">세부</option>
				    		<option value="bohol">보홀</option>
				    		<option value="palawan">팔라완</option>
				    		<option value="clark">클락</option>
					  	</select>
					  	<select name="city_america" id="america">
				    		<option value="choice">도시</option>
				    		<option value="hawaii">하와이</option>
				    		<option value="maui">마우이</option>
				    		<option value="bigisland">빅아일랜드(힐로)</option>
				    		<option value="losAngeles">로스앤젤레스</option>
				    		<option value="sanFrancisco">샌프란시스코</option>
				    		<option value="lasVegas">라스베이거스</option>
				    		<option value="guam">괌</option>
					  	</select>
					  	<select name="city_australia" id="australia">
				    		<option value="choice">도시</option>
				    		<option value="sydney">시드니</option>
				    		<option value="melbourne">멜버른</option>
				    		<option value="goldCoast">골드코스트</option>
				    		<option value="brisbane">브리즈번</option>
					  	</select>
					  	<select name="city_newzealand" id="newzealand">
				    		<option value="choice">도시</option>
				    		<option value="auckland">오클랜드</option>
				    		<option value="queenstown">퀸스타운</option>
				    		<option value="christchurch">크라이스트처치</option>
				    		<option value="rotorua">로토루아</option>
					  	</select>
					  	<select name="city_china" id="china">
				    		<option value="choice">도시</option>
				    		<option value="shanghai">상하이</option>
				    		<option value="harbin">하얼빈</option>
				    		<option value="shaman">샤먼</option>
				    		<option value="beijing">북경</option>
				    		<option value="hainan">하이난</option>
				    		<option value="qingdao">칭다오</option>
					  	</select>
					</div>

	                <div id="search">
						<input type="text" name="searchBox" placeholder=" 검색단어 입력">
						<img src='img/icon/search_btn.png'>
					</div>
					<div id="write_div">
					  <%
					  	if(u_id == null){
                  			 out.println("<img src='img/icon/write.png' name='write'/>");
                  		}else{
                			out.println("<a href='plan_review.jj?page=plan_reviewTab'><img src='img/icon/write.png' /></a>");
					  	}
					  %>
					</div>
				</div>
            </article>
            <hr>
            <article>
           		<div id="list_div">         		
	            	<%
		            	for(com.jj.dto.Plan_review pr : reviewList){ %>
    						
    						<div class='review_div'>
    							<a href='plan_review_detail.jsp?page_no=<%=pr.getPr_no()%>&e_no=<%=pr.getE_no() %>'>
	    							<img src='<%=pr.getU_profile() %>'/>
	    							<p><%= pr.getU_nickname()%></p>
	    							<div><%=pr.getPr_date() %></div>
	    							<img src='uploadFile/<%=pr.getPr_file() %>' />
	    							<div class='nation_div'>
		    							<img id="icon" src="img/icon/plane.png">
		    							<p><%=pr.getE_destination() %></p>
	    							</div>
	   								<div><p><%=pr.getPr_title() %></p></div>
	    							<p><%=pr.getPr_contents() %></p>
    							</a>
    						</div>
    				<%	}%>			
                </div>
            </article>
        </section>
    </div>
    <!--
    <div id="paging"></div>
    -->

	<jsp:include page="main_footer.jsp" />	
</body>
</html>