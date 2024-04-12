<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Class_list"%>
<%@page import="java.util.List"%>
<%
	String u_id = (String)session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JOURNEY JOY::여행톡::</title>

	<link rel="stylesheet" type="text/css" href="css/classList.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

	<!-- 페이징 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="js/jquery.twbsPagination.js" type="text/javascript"></script>

</head>
<script>
	$(function(){
		/* 날짜 */
		$("#datepicker").datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
			,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true //년도 - 월 순서
			,changeYear: true //년 선택 가능
            ,changeMonth: true //월 선택 가능
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		});

		//초기값을 오늘 날짜로 설정
        $("#datepicker").datepicker('setDate', 'today');


        //내가만든모임/참여한모임 클릭이벤트
        $("#sector_section > input[type=button]").click(function(){
        	if($(this).attr('name') == 'made'){
        		$("input[name='made']").css({'background': '#0D112D', 'color':'#f1f1f3'});
        		$("input[name='participate']").css({'background': 'white', 'color':'#0D112D'});
        	}else{
        		$("input[name='participate']").css({'background': '#0D112D', 'color':'#f1f1f3'});
        		$("input[name='made']").css({'background': 'white', 'color':'#0D112D'});
        	}
        });

        $(".joinClass").click(function(){
        	if($(this).hasClass("toggleBtn")){
        		$(this).removeClass("toggleBtn");
        	}else{
        		$(this).addClass("toggleBtn");
        	}
        });
        
        /* 모임만들기 버튼 */
        $('.make_btn').click(function(){
        	$(location).attr('href', 'class_insert.jsp');
        })
        
        /* 탭 */
        $('#sector_section > input[type=button]').click(function(){
        	$.ajax({
        		url : "class_list.jj?page=classTab",
        		data : {"tab" : $(this).attr('name'), "u_id" : $("input[name=u_id]").val()},
        		success : function(re){
        			$("#class_div").html(re);
        		}	
        	});
        });
        
        /* 페이징
        $("#paging").twbsPagination({
        	startPage:1,	//시작시 표시되는 현재 페이지
        	totalPages:5,	//총 페이지
        	visiblePages:12, //한페이지당 보여지는 페이지 수
        	first:"<<",
        	last:">>",
        	prev:"<이전",
        	next:"다음>",

        	onPageClick: function(event, page){
        		//클릭이벤트
        	}
        });  */
	});
	
	/* 모임참여 버튼 */
	function joinClass(no){
		$.ajax({
    		url : "class_apply.jj?page=class_apply",
    		data : {"u_id" : $("input[name=u_id]").val(), "c_no" : no},
    		success : function(re){
    			alert("모임에 참여하였습니다.");
    			location.reload();
    		}	
    	});
	}
	
	/* 모임취소 버튼 */
	function delClass(no){
		$.ajax({
    		url : "class_applyDel.jj?page=class_applyDel",
    		data : {"u_id" : $("input[name=u_id]").val(), "c_no" : no},
    		success : function(re){
    			location.reload();
    		}	
    	});
	}
</script>
<body>
	<jsp:include page="main_header.jsp" />

	<!-- header(이미지) -->
	<section>
		<div id="top_section">
			<img src="img/travel/travel16.jpg">
			<div>
				<div>
					<h1>모임만들기</h1>
					<p>#여행지에서 #만드는 #새로운 #인연</p>
				</div>
			</div>
		</div>
	</section>

	<!-- 모임만들기 버튼 -->
	<div>
		<input type='button' class='make_btn' value='모임 만들기'>
	</div>

	<!-- 내가여행중인 국가 -->
	<section>
		<div id="location">
			<img id="icon" src="img/icon/plane.png">
			<p>내가 여행중인 국가</p>
		</div>
	</section>
	
	<!-- 검색구간 -->
	<section>
		<div id="search_section">
			<div>
				<div>
					<input type="checkbox" name="volumn" id="volumnChk">
					<label for="volumnChk">인원 마감</label>
				</div>
				<select>
					<option value="latest">최신순</option>
					<option value="popularity">인기순</option>
					<option value="deadline">마감순</option>
				</select>

				<select>
					<option value="choice">전체</option>
					<option value="progress">진행</option>
					<option value="end">종료</option>
				</select>

				<select>
					<option value="choice">여행도시</option>
					<option value="osaka">오사카</option>
					<option value="tokyo">도쿄</option>
				</select>

				<input type="text" id="datepicker">

				<div id="search">
					<input type="text" name="searchBox" placeholder=" 검색단어 입력">
					<input type="submit" value="검색">
				</div>
			</div>
		</div>
	</section>

	<!-- 버튼 -->
	<section>
		<article>
			<div id="sector_section">
				<input type="hidden" name="u_id" value=<%=u_id %>>
				<input type="button" name="made" value="내가 만든 모임">
				<input type="button" name="participate" value="참여한 모임">
			</div>
		</article>
	</section>

	<!-- 리스트 출력 -->
	<section>
		<article>
			<div id="class_div">
				<%
					ArrayList<Class_list> classList = (ArrayList<Class_list>)request.getAttribute("clist");		
					for (Class_list c : classList) {
				%>
				<div id="class_section">
					<!-- 프로필/닉네임 -->
					<div >
						<img class='profile' src="img/profile/d.jpg">
						<p><%= c.getU_nickname() %></p>		
					</div>
					<div>
						<div>
							<img src="img/canada/toronto1.jpg">
						</div>
						<div>
							<img src="img/icon/location.png">
							<p><%= c.getC_city() %></p>
							<div>
								<table>
									<tr>
										<td>모임명</td>
										<td><%= c.getC_title() %></td>
									</tr>
									<tr>
										<td>모임 내용</td>
										<td><%= c.getC_contents() %></td>
									</tr>
									<tr>
										<td>모집 인원</td>
										<td>1/<%= c.getC_volume() %>명</td>
									</tr>
									<tr>
										<td>예상 경비</td>
										<td><%= c.getC_charge() %></td>
									</tr>
									<tr>
										<td>모집 종료</td>
										<td><%= c.getC_end_date() %></td>
									</tr>
								</table>
								<%
									if(c.getA_id() != null){
										if(c.getA_id().equals(u_id) && c.getC_no() == c.getA_no()){%>
											<input type='button' name='del_btn<%=c.getC_no() %>' value='참여취소' onclick='delClass(<%=c.getC_no() %>)'>
										<%}else{%>
											<input type='button' name='join_btn<%=c.getC_no() %>' value='모임참여' onclick='joinClass(<%=c.getC_no() %>)'>
										<%}
									}else{
								%>
								<input type='button' name='join_btn<%=c.getC_no() %>' value='모임참여' onclick='joinClass(<%=c.getC_no() %>)'>
								<%} %>
							</div>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</article>
	</section>
	
	<%-- 
	<div id="paging">
	</div>
	--%>

	<jsp:include page="main_footer.jsp" />
</body>
</html>