<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Schedule"%>
<%@page import="com.jj.dto.Plan_review"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />
<%
	request.setCharacterEncoding("utf-8"); 
	String pr_no = request.getParameter("page_no");
	String list = request.getParameter("e_no"); 
	ArrayList<com.jj.dto.Plan_review> reviewList = dao.select_plan_review(pr_no);
	String u_id = (String) session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link href="css/plan_review_detail.css" rel="stylesheet" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	
<title>Insert title here</title>
</head>
<script>


$(function() {
	  const kindWrap =  document.querySelector('#img_div');
	  const slider = kindWrap.querySelector('.slider');
	  const slideLis = slider.querySelectorAll('li');
	  
	  //ul 넓이 계산해 주기 
	  const liWidth = slideLis[0].clientWidth;
	  const sliderWidth =  liWidth * slideLis.length;
	  slider.style.width = sliderWidth+"px" ;

	  //리스너 설치하기 
	  var currentIdx = 0; // 슬라이드 현재 번호
	  var translate = 0; // 슬라이드 위치 값
	  
	  $("#right").click(function(){   //오른쪽화살표 눌렀을때 슬라이드
		  if (currentIdx !== slideLis.length -1) {
		        translate -= liWidth;
		        slider.style.transform = `translateX(${translate}px)`;
		        currentIdx += 1;
		      }
	  });
	  $("#left").click(function(){  //왼쪽 화살표 눌렀을 때 슬라이드
	        if (currentIdx !== 0) {
	          translate += liWidth;
	          slider.style.transform = `translateX(${translate}px)`;
	          currentIdx -= 1;
	        }
	   });
});

function tab(num){
	var day_plan = "#day_plan"+num;
	var day_sel = "#day_sel"+num;
	var plan = "#plan_sel"+num;
	$("div[id*='day_plan']").hide();
	$(day_plan).show();
	$("p[id*=day_sel]").css({"color":"white"});
	$(day_sel).css({"color":"black"});	
	$("div[id*='plan_sel']").css({"background-color":"#0D112D"});
	$(plan).css({"background-color":"#6C94B8"});
}
	
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>		
		<div id='main_div'>
			<%
				int e_no = Integer.parseInt(list);
				ArrayList<Schedule> scList = (ArrayList<Schedule>)dao.select_planReview_pick(e_no);
				
				for(com.jj.dto.Plan_review pr : reviewList){%>
					
					<table>
						<tr><td class='review_info'><p>작성자</p></td>
						<td class='user_info'><p><%=pr.getU_id() %></p></td></tr>
						<tr><td class='review_info'><p>여행도시</p></td>
						<td class='user_info'><p>여행도시값 불러오기</p></td></tr>
						<tr id='theme'><td class='review_info'><p>여행테마</p></td>
						<td class='user_info'>여행테마값 불러오기</td></tr></table>
						<p><%=pr.getPr_title() %></p>
					
						<div id='img_div'>
							<div id = 'kind_slider'>
								<ul class='slider'>
									<li class='li_sli'><img src='uploadFile/<%= pr.getPr_file()%>'/></li> 
									<li class='li_sli'><img src='uploadFile/<%= pr.getPr_file2()%>'/></li>
									<li class='li_sli'><img src='uploadFile/<%= pr.getPr_file3()%>'/></li>
								</ul>
							</div>
						</div>
					<input type='button' value='left' id='left'><input type='button' value='right' id='right'>
					<div id='content'><%=pr.getPr_contents() %></div>

				<div id='day_select'>
					<%
						for(Schedule sc : scList){%>
							<div id='plan_sel<%= sc.getSche_day()%>'onclick='tab(<%= sc.getSche_day()%>)'>
								<p id='day_sel<%= sc.getSche_day()%>' >Day<%= sc.getSche_day()%></p>
							</div>
					<%}%>
				</div>
				
				<%
					for(Schedule sc : scList){%>
						<div id='day_plan<%= sc.getSche_day()%>'>
							<p class='day'>Day<%= sc.getSche_day()%></p>
							<div class='map'>day<%= sc.getSche_day()%>지도 들어갈 자리</div>
							<div class='day_review'>day<%= sc.getSche_day()%>여행후기</div>
							<div class='pl_eat_div'>
								<%
								String schedule_place = sc.getPlace();
								schedule_place = schedule_place.replaceAll(",", " ");
								String [] place = schedule_place.split(" ");
								
								for(int i = 0; i < place.length ; i ++){%>
									<p class='place'><div class='no'><%=i+1 %></div><%=place[i] %></p>
								<%}%>
							</div>
						</div>
					<%}%>	
				<div id='btn_div'>
					<%
						if(u_id != null && u_id.equals(pr.getU_id())){%>
						<a href='plan_review_write.jsp?page_no=<%=pr.getPr_no()%>&e_no=<%=e_no%>'><input type='button' name='edit' value='수정' /></a>
						<a href='plan_review_delete.jsp?page_no=<%=pr.getPr_no()%>&e_no=<%=e_no%>'><input type='button' name='delete' value='삭제' /></a>	
					<%	}else{%>
						<input type='hidden' name='hidden' />
					<%} %>	
					<a href='plan_review_list.jsp'><input type='button' name='list' value='목록으로'/></a>	
				</div>
			<%}%>
		</div>
	</section>
</body>
</html>