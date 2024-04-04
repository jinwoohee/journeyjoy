<%@page import="java.text.DecimalFormat"%>
<%@page import="com.jj.dto.Package_like"%>
<%@page import="com.jj.dto.Package"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" type="text/css" href="css/packageList.css">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<script>
	$(function() {
		$("#write").click(function(){
			$(location).attr('href', 'package_insert.jsp');
		});
		
		$("#noWrite").click(function(){
			alert("로그인 후 이용해주세요.");
			$(location).attr('href', 'login.jsp');	
		});
		
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

        /* 이미지 mouseenter, mouseleave */
        $(".thumnail").mouseenter(function(){
        	$(this).find('img').css({'transform':'scale(1.2)'});
        });
        $(".thumnail").mouseleave(function(){
        	$(this).find('img').css({'transform':'scale(1)'});
        });

        /* 버튼 mouseenter, mouseleave */
        $("input[type='button']").mouseenter(function(){
        	$(this).css({'box-shadow':'inset 5px 5px 10px #000054'});
        });
        $("input[type='button']").mouseleave(function(){
        	$(this).css({'box-shadow':'none'});
        });	
        
        /* 검색버튼 */
        $('#searchBtn').click(function(){
        	// var resultDiv = document.getElementById("packageList_div");
        	 
        	 $.ajax({ //전체, 최신순, 여행테마, 여행도시, 날짜, 단어
        		url : "package_list.jj?page=packageSearch",
        		data : {"param1" : $("select[name='param1']").val(), "param2" : $("select[name='param2']").val(), "param3" : $("select[name='param3']").val(), "param4" : $("select[name='param4']").val(), "date":$("input[name='date']").val(), "txt":$("input[name='searchBox']").val()},
        		success : function(re){
        			$("#packageList_div").html(re);
        		}
        	 });
        });
        

        /* 페이징 */
        /* $("#paging").twbsPagination({
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
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	
	<!-- header(이미지) -->
	<section>
		<div id="top_section">
			<img src="img/travel/travel15.jpg">
			<div>
				<div>
					<p>패키지 여행</p>
					<p>#다함께 #떠나는 #패키지 #여행</p>
				</div>
			</div>
		</div>
	</section>

	<!-- 계획하기 버튼 -->
	<div>
		<%
			if(u_id != null){
				out.println("<input type='button' id='write' value='패키지 기획하기'>");
			}else{
				out.println("<input type='button' id='noWrite' value='패키지 기획하기'>");
			}
		%>
		
	</div>

	<!-- 검색구간 -->
	<section>
		<div id="search_section">
			<div>
				<%-- 
				<select name='param1'>
					<option value="choice">전체</option>
					<option value="progress">진행</option>
					<option value="end">종료</option>
				</select>
				--%>

				<select name='param2'>
					<option value="latest">최신순</option>
					<option value="popularity">인기순</option>
					<option value="deadline">마감순</option>
				</select>
				
				<select name='param3'>
					<option value="choice">여행테마</option>
					<option value="healing">힐링</option>
					<option value="leisure">레저</option>
					<option value="eat">먹방</option>
				</select>

				<select name='param4'>
					<option value="choice">여행국가</option>
					<option value="japan">일본</option>
					<option value="canada">캐나다</option>
					<option value="america">미국</option>
				</select>

				<input type="text" id="datepicker" name='date'>

				<div id="search">
					<input type="text" name="searchBox" placeholder="  검색단어 입력">
					<input type="submit" id='searchBtn' value="검색">
				</div>
			</div>
		</div>
	</section>

	<!-- 리스트 출력 -->
	<section>
		<article>
			<div id='packageList_div'>
				<ul>
					<%
						List<Package> pkList = (List<Package>)request.getAttribute("pkList");
						List<Package_like> likeList = (List<Package_like>)request.getAttribute("likeList");
						
						for(Package list : pkList){
							out.println("<li>");
							out.println("<input type='hidden' name='p_no' value='"+list.getP_no()+"'>");
							out.println("<div class='thumnail'>");
							out.println("<a href='packageDetail.jj?page=package_detail&p_no="+list.getP_no()+"'>");
							out.println("<img src='"+list.getP_file()+"'/></a></div>");
							
							if(likeList.size() > 0 && session.getAttribute("u_id")!= null){ //좋아요한 값이 있는지 없는지
								for(Package_like pl : likeList){
									if(list.getP_no() == pl.getP_no() && pl.getU_id().equals(session.getAttribute("u_id"))){
										out.println("<div class='heart'><img src='img/icon/heart.png'/></div>");
										break;
									}else{
										out.println("<div class='heart'><img src='img/icon/heart2.png'/></div>");
										break;
									}
								}
							}else{
								out.println("<div><img src='img/icon/heart2.png'/></div>");
							}
							out.println("<div><P class='title'>"+list.getP_title()+"</P></div>");
							
							DecimalFormat f = new DecimalFormat("###,###,###");
							out.println("<div><P>"+f.format(list.getChild_fee())+"~</P></div>");
							out.println("<div><P>"+list.getU_nickname()+"</P></div>");
							out.println("</li>");
						}
					%>
				</ul>
			</div>	
		</article>
	</section>
	  <div id="paging"></div>
	<jsp:include page="main_footer.jsp" />
</body>
</html>